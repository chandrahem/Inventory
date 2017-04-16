using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace IBS.ERP.Models
{
    public static class Logger
    {
        //private static log4net.ILog Log { get; set; }
        private static readonly log4net.ILog Log ;
       // private static readonly log4net.ILog LogAudit;

        static Logger()
        {
            //Log = log4net.LogManager.GetLogger(typeof(Logger));
            // to log error in flat file we need to change  "ADONetAppender" to flat file appender
            Log = log4net.LogManager.GetLogger("ADONetAppender");
            //Log = log4net.LogManager.GetLogger("LogFileAppender");
            
           // LogAudit = log4net.LogManager.GetLogger("AdoNetAuditLogAppender");
        }

        public static void Error(object msg)
        {
            Log.Error(msg);
        }

        public static void Error(object msg, Exception ex)
        {
            Log.Error(msg, ex);
        }

        public static void Error(Exception ex)
        {
            try
            {
                //Log.Error(ex.Message, ex);
                Log.Error(ex);
            }
            catch (Exception ex1)
            {
                throw new Exception(ex1.Message);
            }
        }

        public static void Info(object msg)
        {
            Log.Info(msg);
        }

        ///// <summary>
        ///// This method is used to log audit trail in "AuditLog" table
        ///// Configuration of auditlog table is done in log4net.config file
        ///// which we are showing in tabbed admin menu
        ///// </summary>
        ///// <param name="userName"></param>
        ///// <param name="action"></param>
        ///// <param name="assignmentID"></param>
        //public static void WriteAuditLog(string userName, object action,  object assignmentID)
        //{
        //    try
        //    {
        //        log4net.LogicalThreadContext.Properties["UserName"] = userName;
        //        log4net.LogicalThreadContext.Properties["Action"] = action;
        //        log4net.LogicalThreadContext.Properties["AssignmentID"] = assignmentID;
        //        if (userName.Trim().Length > 0)
        //            LogAudit.InfoFormat(userName, action, assignmentID);
        //    }
        //    catch (Exception ex)
        //    {
        //        Log.Error(userName, ex);
        //    }
        //}
    }
}
