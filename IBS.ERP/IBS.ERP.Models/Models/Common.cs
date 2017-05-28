using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Data;
using System.Reflection;
using System.Data.SqlClient;

namespace IBS.ERP.Models
{
    public class cCommon
    {
        private Random rd;
        const string UPPERCASE = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        const string LOWERCASE = "abcdefghijklmnopqrstuvwxyz";
        const string NUMBERS = "0123456789";
        const string SYMBOLS = "~!@#$%&_=+?";

        public virtual string NextString(int length)
        {
            return NextString(length, true, true, true, true);
        }

        public virtual string NextString(int length, bool lowerCase, bool upperCase, bool numbers, bool symbols)
        {
            rd = new Random();
            char[] charArray = new char[length];
            string charPool = string.Empty;

            //Build character pool
            if (lowerCase)
                charPool += LOWERCASE;

            if (upperCase)
                charPool += UPPERCASE;

            if (numbers)
                charPool += NUMBERS;

            if (symbols)
                charPool += SYMBOLS;

            //Build the output character array
            for (int i = 0; i < charArray.Length; i++)
            {
                //Pick a random integer in the character pool
                int index = rd.Next(0, charPool.Length);

                //Set it to the output character array
                charArray[i] = charPool[index];
            }

            return new string(charArray);
        }
        public static string GetContentType(string fileExtension)
        {
            switch (fileExtension)
            {
                case ".htm":
                case ".html":
                case ".log":
                    return "text/HTML";
                case ".txt":
                    return "text/plain";
                case ".doc":
                case ".docx":
                    return "application/ms-word";
                case ".tiff":
                case ".tif":
                    return "image/tiff";
                case ".asf":
                    return "video/x-ms-asf";
                case ".avi":
                    return "video/avi";
                case ".zip":
                    return "application/zip";
                case ".xls":
                case ".xlsx":
                case ".csv":
                    return "application/vnd.ms-excel";
                case ".gif":
                    return "image/gif";
                case ".jpg":
                case "jpeg":
                    return "image/jpeg";
                case ".bmp":
                    return "image/bmp";
                case ".wav":
                    return "audio/wav";
                case ".mp3":
                    return "audio/mpeg3";
                case ".mpg":
                case "mpeg":
                    return "video/mpeg";
                case ".rtf":
                    return "application/rtf";
                case ".asp":
                    return "text/asp";
                case ".pdf":
                    return "application/pdf";
                case ".fdf":
                    return "application/vnd.fdf";
                case ".ppt":
                case ".pptx":
                    return "application/mspowerpoint";
                case ".dwg":
                    return "image/vnd.dwg";
                case ".msg":
                    return "application/msoutlook";
                case ".xml":
                case ".sdxl":
                    return "application/xml";
                case ".xdp":
                    return "application/vnd.adobe.xdp+xml";
                default:
                    return "application/octet-stream";
            }
        }


        /// <summary>
        /// Send Mail to Client Confirmation Mail
        /// </summary>
        /// <param name="employeeName"></param>
        /// <param name="email"></param>
        /// <param name="accountID"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        /// 
        #region Convert Reader To List
        public static List<T> GetList<T>(SqlDataReader IDR)
        {

            List<T> objReport = new List<T>();
            List<T> list = new List<T>();
            T obj = default(T);

            while (IDR.Read())
            {
                obj = Activator.CreateInstance<T>();
                foreach (PropertyInfo prop in obj.GetType().GetProperties())
                {
                    if (prop.Name != "HasError" && prop.Name != "Message")
                    {
                        try
                        {
                            if (!object.Equals(IDR[prop.Name], DBNull.Value))
                            {
                                prop.SetValue(obj, IDR[prop.Name], null);
                            }
                        }
                        catch
                        {

                        }
                    }
                }
                list.Add(obj);
            }


            return list;
        }

        public static T GetObject<T>(SqlDataReader IDR)
        {
            T obj = default(T);

            while (IDR.Read())
            {
                obj = Activator.CreateInstance<T>();
                foreach (PropertyInfo prop in obj.GetType().GetProperties())
                {
                    if (prop.Name != "HasError" && prop.Name != "Message")
                    {
                        try
                        {
                            if (!object.Equals(IDR[prop.Name], DBNull.Value))
                            {
                                prop.SetValue(obj, IDR[prop.Name], null);
                            }
                        }
                        catch
                        {

                        }
                    }
                }
            }

            return obj;
        }
        #endregion


    }

}
