using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;
using System.Data.SqlClient;
using System.IO;

namespace POS.UI.Helper
{
    public class DatabaseHelper
    {
        static Server srv;
        static ServerConnection conn;

        public static bool BackupDatabase(string filePath, string connectionString)
        {

            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(connectionString);
            conn = new ServerConnection(builder.DataSource, builder.UserID, builder.Password);
            // conn.ServerInstance = serverName;
            srv = new Server(conn);
            string databaseName = builder.InitialCatalog;
            bool success = false;
            try
            {
                Backup bkp = new Backup();

                bkp.Action = BackupActionType.Database;
                bkp.Database = databaseName;

                bkp.Devices.AddDevice(filePath, DeviceType.File);
                bkp.Incremental = false;

                bkp.SqlBackup(srv);

                conn.Disconnect();
                conn = null;
                srv = null;
                success = true;
            }

            catch (SmoException ex)
            {
                throw new SmoException(ex.Message, ex.InnerException);
            }
            catch (IOException ex)
            {
                throw new IOException(ex.Message, ex.InnerException);
            }

            return success;
        }

        public static bool RestoreDatabase(string databaseName, string filePath, string connectionString)
        {

            SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder(connectionString);
            conn = new ServerConnection(builder.DataSource, builder.UserID, builder.Password);
            srv = new Server(conn);
            bool success = false;
            try
            {
                Restore res = new Restore();
                Database db = new Database(srv, databaseName);
                db.Create();

                res.Devices.AddDevice(filePath, DeviceType.File);

                RelocateFile DataFile = new RelocateFile();
                string MDF = res.ReadFileList(srv).Rows[0][1].ToString();
                DataFile.LogicalFileName = res.ReadFileList(srv).Rows[0][0].ToString();
                DataFile.PhysicalFileName = srv.Databases[databaseName].FileGroups[0].Files[0].FileName;

                RelocateFile LogFile = new RelocateFile();
                string LDF = res.ReadFileList(srv).Rows[1][1].ToString();
                LogFile.LogicalFileName = res.ReadFileList(srv).Rows[1][0].ToString();
                LogFile.PhysicalFileName = srv.Databases[databaseName].LogFiles[0].FileName;

                res.RelocateFiles.Add(DataFile);
                res.RelocateFiles.Add(LogFile);

                res.Database = databaseName;
                res.NoRecovery = false;
                res.ReplaceDatabase = true;
                res.SqlRestore(srv);
                conn.Disconnect();
                success = true;
            }
            catch (SmoException ex)
            {
                throw new SmoException(ex.Message, ex.InnerException);
            }
            catch (IOException ex)
            {
                throw new IOException(ex.Message, ex.InnerException);
            }

            return success;
        }

        public static Server Getdatabases(string serverName)
        {
            conn = new ServerConnection();
            conn.ServerInstance = serverName;

            srv = new Server(conn);
            conn.Disconnect();
            return srv;

        }




    }
}