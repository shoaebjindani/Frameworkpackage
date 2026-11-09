package Frameworkpackage;

import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class DBComparatorDaoImpl extends CommonFunctions {

    private static final String[] COLUMN_ATTRS = {
            "COLUMN_TYPE", "IS_NULLABLE", "COLUMN_DEFAULT", "EXTRA",
            "CHARACTER_SET_NAME", "COLLATION_NAME", "COLUMN_COMMENT", "GENERATION_EXPRESSION"
    };

    // ------------------------------------------------------------------
    // Queries
    // ------------------------------------------------------------------

    public List<LinkedHashMap<String, Object>> getSchemaList(Connection con)
            throws ClassNotFoundException, SQLException {

        ArrayList<Object> parameters = new ArrayList<>();
        parameters.add("information_schema");
        parameters.add("mysql");
        parameters.add("performance_schema");
        parameters.add("sys");

        String query = "SELECT SCHEMA_NAME " +
                " FROM information_schema.SCHEMATA " +
                " WHERE SCHEMA_NAME NOT IN (?, ?, ?, ?) " +
                " ORDER BY SCHEMA_NAME ";

        return getListOfLinkedHashHashMap(parameters, query, con);
    }

    public List<LinkedHashMap<String, Object>> getSchemaColumnDetails(
            Connection con, String schemaName)
            throws ClassNotFoundException, SQLException {

        ArrayList<Object> parameters = new ArrayList<>();
        parameters.add(schemaName);

        String query = "SELECT c.TABLE_NAME, c.COLUMN_NAME, c.COLUMN_TYPE, c.IS_NULLABLE, " +
                " c.COLUMN_DEFAULT, c.EXTRA, c.CHARACTER_SET_NAME, c.COLLATION_NAME, " +
                " c.COLUMN_COMMENT, c.GENERATION_EXPRESSION " +
                " FROM information_schema.COLUMNS c " +
                " INNER JOIN information_schema.TABLES t " +
                "     ON t.TABLE_SCHEMA = c.TABLE_SCHEMA AND t.TABLE_NAME = c.TABLE_NAME " +
                " WHERE c.TABLE_SCHEMA = ? " +
                " AND t.TABLE_TYPE = 'BASE TABLE' " +
                " ORDER BY c.TABLE_NAME, c.ORDINAL_POSITION ";

        return getListOfLinkedHashHashMap(parameters, query, con);
    }

    public List<LinkedHashMap<String, Object>> getCreateTableStatement(
            Connection con, String schemaName, String tableName)
            throws ClassNotFoundException, SQLException {

        // identifiers can't be bound as parameters, so escape backticks.
        // schemaName is validated against getAvailableSchemas() in the controller,
        // tableName comes from information_schema.
        String query = "SHOW CREATE TABLE " + bt(schemaName) + "." + bt(tableName);

        return getListOfLinkedHashHashMap(new ArrayList<Object>(), query, con);
    }

    // ------------------------------------------------------------------
    // Public entry points used by the controller
    // ------------------------------------------------------------------

    public List<String> getAvailableSchemas(Connection con)
            throws ClassNotFoundException, SQLException {

        List<String> schemas = new ArrayList<>();
        for (LinkedHashMap<String, Object> row : getSchemaList(con)) {
            schemas.add(str(row.get("SCHEMA_NAME")));
        }
        return schemas;
    }

  

private String str(Object value) {
    return value == null ? "" : value.toString();
}


public Set<String> parseIgnoreTables(String raw) {
    Set<String> ignore = new HashSet<>();
    if (raw == null) return ignore;
    for (String t : raw.split(",")) {
        String name = t.trim().toLowerCase();
        if (!name.isEmpty()) ignore.add(name);
    }
    return ignore;
}

public String bt(String identifier) {
    return "`" + identifier.replace("`", "``") + "`";
}

public String sqlQuote(String value) {
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'";
}

/** table -> (column -> attributes), both maps in ordinal order. Base tables only. */
private LinkedHashMap<String, LinkedHashMap<String, HashMap<String, String>>> getTableColumns(
        Connection con, String schema) throws SQLException {

    LinkedHashMap<String, LinkedHashMap<String, HashMap<String, String>>> tables = new LinkedHashMap<>();

    String sql = "SELECT c.TABLE_NAME, c.COLUMN_NAME, c.COLUMN_TYPE, c.IS_NULLABLE, "
            + "c.COLUMN_DEFAULT, c.EXTRA, c.CHARACTER_SET_NAME, c.COLLATION_NAME, "
            + "c.COLUMN_COMMENT, c.GENERATION_EXPRESSION "
            + "FROM information_schema.COLUMNS c "
            + "JOIN information_schema.TABLES t "
            + "  ON t.TABLE_SCHEMA = c.TABLE_SCHEMA AND t.TABLE_NAME = c.TABLE_NAME "
            + "WHERE c.TABLE_SCHEMA = ? AND t.TABLE_TYPE = 'BASE TABLE' "
            + "ORDER BY c.TABLE_NAME, c.ORDINAL_POSITION";

    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, schema);
        try (ResultSet r = ps.executeQuery()) {
            while (r.next()) {
                String table = r.getString(1);
                String column = r.getString(2);

                HashMap<String, String> col = new HashMap<>();
                col.put("COLUMN_TYPE", r.getString(3));
                col.put("IS_NULLABLE", r.getString(4));
                col.put("COLUMN_DEFAULT", r.getString(5));
                col.put("EXTRA", r.getString(6));
                col.put("CHARACTER_SET_NAME", r.getString(7));
                col.put("COLLATION_NAME", r.getString(8));
                col.put("COLUMN_COMMENT", r.getString(9));
                col.put("GENERATION_EXPRESSION", r.getString(10));

                tables.computeIfAbsent(table, k -> new LinkedHashMap<>()).put(column, col);
            }
        }
    }
    return tables;
}

/** Builds the part after the column name, e.g. "varchar(100) CHARACTER SET utf8mb4 ... NOT NULL DEFAULT 'x'" */
private String buildColumnDefinition(HashMap<String, String> col) {
    StringBuilder sb = new StringBuilder(col.get("COLUMN_TYPE"));

    String extra = col.get("EXTRA") == null ? "" : col.get("EXTRA");
    String genExpr = col.get("GENERATION_EXPRESSION");
    boolean generated = genExpr != null && !genExpr.isEmpty();

    if (col.get("CHARACTER_SET_NAME") != null) {
        sb.append(" CHARACTER SET ").append(col.get("CHARACTER_SET_NAME"))
          .append(" COLLATE ").append(col.get("COLLATION_NAME"));
    }

    if (generated) {
        sb.append(" GENERATED ALWAYS AS (").append(genExpr).append(")")
          .append(extra.toUpperCase().contains("STORED") ? " STORED" : " VIRTUAL");
    }

    sb.append("YES".equals(col.get("IS_NULLABLE")) ? " NULL" : " NOT NULL");

    String def = col.get("COLUMN_DEFAULT");
    if (!generated && def != null) {
        if (extra.contains("DEFAULT_GENERATED")) {
            // expression default; CURRENT_TIMESTAMP is the only one allowed without parentheses
            sb.append(def.toUpperCase().startsWith("CURRENT_TIMESTAMP")
                    ? " DEFAULT " + def
                    : " DEFAULT (" + def + ")");
        } else {
            sb.append(" DEFAULT ").append(sqlQuote(def));
        }
    }

    String extraClean = extra.replace("DEFAULT_GENERATED", "")
            .replace("VIRTUAL GENERATED", "")
            .replace("STORED GENERATED", "")
            .trim();
    if (!extraClean.isEmpty()) sb.append(" ").append(extraClean);

    String comment = col.get("COLUMN_COMMENT");
    if (comment != null && !comment.isEmpty()) {
        sb.append(" COMMENT ").append(sqlQuote(comment));
    }
    return sb.toString();
}

private String getCreateTableDDL(Connection con, String schema, String table, String destSchema)
        throws SQLException {

    String create = null;
    String sql = "SHOW CREATE TABLE " + bt(schema) + "." + bt(table);
    try (Statement st = con.createStatement(); ResultSet r = st.executeQuery(sql)) {
        if (r.next()) create = r.getString(2);
    }
    if (create == null) return "-- Could not read CREATE TABLE for " + bt(table);

    // drop the AUTO_INCREMENT=<n> table option
    create = create.replaceAll("\\s+AUTO_INCREMENT=\\d+", "");

    // skip foreign keys for now
    List<String> kept = new ArrayList<>();
    for (String line : create.split("\n")) {
        String t = line.trim();
        if (t.startsWith("CONSTRAINT") && t.contains("FOREIGN KEY")) continue;
        kept.add(line);
    }
    for (int i = 1; i < kept.size(); i++) {
        if (kept.get(i).startsWith(")") && kept.get(i - 1).endsWith(",")) {
            String prev = kept.get(i - 1);
            kept.set(i - 1, prev.substring(0, prev.length() - 1));
        }
    }
    create = String.join("\n", kept);

    // qualify with the destination schema
    String prefix = "CREATE TABLE " + bt(table);
    if (create.startsWith(prefix)) {
        create = "CREATE TABLE " + bt(destSchema) + "." + bt(table)
                + create.substring(prefix.length());
    }
    return create + ";";
}

public List<String> buildSyncDDL(Connection con, String sourceSchema, String destSchema,
        Set<String> ignoreTables) throws SQLException {

    List<String> ddl = new ArrayList<>();

    LinkedHashMap<String, LinkedHashMap<String, HashMap<String, String>>> srcTables =
            getTableColumns(con, sourceSchema);
    LinkedHashMap<String, LinkedHashMap<String, HashMap<String, String>>> dstTables =
            getTableColumns(con, destSchema);

    for (Map.Entry<String, LinkedHashMap<String, HashMap<String, String>>> te : srcTables.entrySet()) {
        String table = te.getKey();
        if (ignoreTables.contains(table.toLowerCase())) continue;

        LinkedHashMap<String, HashMap<String, String>> srcCols = te.getValue();
        LinkedHashMap<String, HashMap<String, String>> dstCols = dstTables.get(table);

        // 1. table missing in destination
        if (dstCols == null) {
            ddl.add("-- " + table + " present in source but not in destination, adding CREATE\n"
                    + getCreateTableDDL(con, sourceSchema, table, destSchema));
            continue;
        }

        // 2. column level (add / modify / reorder)
        List<String> dstOrder = new ArrayList<>(dstCols.keySet()); // simulated destination order
        List<String> clauses = new ArrayList<>();
        List<String> notes = new ArrayList<>();
        String prev = null;

        for (Map.Entry<String, HashMap<String, String>> ce : srcCols.entrySet()) {
            String colName = ce.getKey();
            String srcDef = buildColumnDefinition(ce.getValue());
            String position = (prev == null) ? " FIRST" : " AFTER " + bt(prev);

            if (!dstCols.containsKey(colName)) {
                clauses.add("ADD COLUMN " + bt(colName) + " " + srcDef + position);
                notes.add("-- " + table + "." + colName + " present in source but not in destination, adding column");
                dstOrder.add(prev == null ? 0 : dstOrder.indexOf(prev) + 1, colName);
            } else {
                String dstDef = buildColumnDefinition(dstCols.get(colName));
                boolean defDiffers = !srcDef.equals(dstDef);
                boolean misplaced = !isPlacedAfter(dstOrder, colName, prev, srcCols);

                if (defDiffers || misplaced) {
                    clauses.add("MODIFY COLUMN " + bt(colName) + " " + srcDef
                            + (misplaced ? position : ""));
                    if (defDiffers) {
                        notes.add("-- " + table + "." + colName + " definition differs: "
                                + dstDef + "  =>  " + srcDef);
                    }
                    if (misplaced) {
                        notes.add("-- " + table + "." + colName + " position differs, moving"
                                + (prev == null ? " to FIRST" : " after " + prev));
                        dstOrder.remove(colName);
                        dstOrder.add(prev == null ? 0 : dstOrder.indexOf(prev) + 1, colName);
                    }
                }
            }
            prev = colName;
        }

        if (!clauses.isEmpty()) {
            ddl.add(String.join("\n", notes) + "\n"
                    + "ALTER TABLE " + bt(destSchema) + "." + bt(table) + "\n  "
                    + String.join(",\n  ", clauses) + ";");
        }
    }
    return ddl;
}

/**
 * True when, ignoring destination-only columns, the nearest preceding source-known
 * column of colName in the (simulated) destination order is the expected previous one.
 */
private boolean isPlacedAfter(List<String> dstOrder, String colName, String expectedPrev,
        Map<String, HashMap<String, String>> srcCols) {
    for (int i = dstOrder.indexOf(colName) - 1; i >= 0; i--) {
        String n = dstOrder.get(i);
        if (srcCols.containsKey(n)) return n.equals(expectedPrev);
    }
    return expectedPrev == null;
}


}
