package Frameworkpackage;

import java.sql.Connection;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

public class DBComparatorServiceImpl extends CommonFunctions {

private static final Set<String> SYSTEM_SCHEMAS = new HashSet<>(
        Arrays.asList("information_schema", "mysql", "performance_schema", "sys"));

DBComparatorDaoImpl lobjComparatorDaoImpl=new DBComparatorDaoImpl();
public CustomResultObject showDBComparator(
        HttpServletRequest request, Connection con) {

    CustomResultObject rs = new CustomResultObject();
    HashMap<String, Object> outputMap = new HashMap<>();

    try {
        outputMap.put("schemaList", lobjComparatorDaoImpl.getAvailableSchemas(con));

        rs.setViewName("CompareDB.jsp");
        rs.setReturnObject(outputMap);

    } catch (Exception e) {
        writeErrorToDB(e);
        rs.setHasError(true);
    }

    return rs;
}

public CustomResultObject compareSchemas(
        HttpServletRequest request, Connection con) {

    CustomResultObject rs = new CustomResultObject();
    HashMap<String, Object> outputMap = new HashMap<>();

    try {
        String sourceSchema = request.getParameter("sourceSchema");
        String destSchema = request.getParameter("destSchema");
        String ignoreTablesRaw = request.getParameter("ignoreTables");

        List<String> schemas = lobjComparatorDaoImpl.getAvailableSchemas(con);
        String errorMessage = null;

        if (sourceSchema == null || destSchema == null
                || !schemas.contains(sourceSchema) || !schemas.contains(destSchema)) {
            errorMessage = "Please select valid source and destination schemas.";
        } else if (sourceSchema.equals(destSchema)) {
            errorMessage = "Source and destination schemas must be different.";
        }

        if (errorMessage == null) {
            Set<String> ignoreTables = lobjComparatorDaoImpl.parseIgnoreTables(ignoreTablesRaw);
            List<String> ddlList = lobjComparatorDaoImpl.buildSyncDDL(con, sourceSchema, destSchema, ignoreTables);

            StringBuilder ddl = new StringBuilder();
            ddl.append("-- Sync DDL: ").append(sourceSchema).append(" (source) -> ")
               .append(destSchema).append(" (destination)\n");

            if (ddlList.isEmpty()) {
                ddl.append("-- Schemas are in sync for the compared tables. Nothing to do.\n");
            } else {
                ddl.append("\n").append(String.join("\n\n", ddlList)).append("\n");
            }

            outputMap.put("ddl", ddl.toString());
            outputMap.put("inSync", ddlList.isEmpty());
        }

        outputMap.put("errorMessage", errorMessage);
        outputMap.put("sourceSchema", sourceSchema);
        outputMap.put("destSchema", destSchema);

        rs.setViewName("CompareDBResult.jsp");
        rs.setReturnObject(outputMap);

    } catch (Exception e) {
        writeErrorToDB(e);
        rs.setHasError(true);
    }

    return rs;
}

 }
