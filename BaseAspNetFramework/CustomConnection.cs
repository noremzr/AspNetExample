using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace BaseAspNetFramework
{
    public static class CustomConnection
    {
        private const string ConnectionName = "SQLSERVER";
        private static string GetSqlConnectionName()
        {
            return ConnectionName;
        }

        public static string GetConnectionString() {

            return System.Configuration.ConfigurationManager.ConnectionStrings[ConnectionName].ConnectionString;
        }


    }
}