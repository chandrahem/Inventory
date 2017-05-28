using System;
using System.Web;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Net.Http;
using System.Configuration;
using Newtonsoft.Json;

namespace IBS.Utility
{
    #region UTILTY FUNCTIONS CLASS

    public class UtilityFuntions
    {

        #region General functions

        public static string GetIP()
        {
            string ipAddress = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(ipAddress))
            {
               /// ipAddress = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                ipAddress = HttpContext.Current.Request.UserHostAddress;
            }
            return ipAddress;
            //string strHostName = "";
            //strHostName = System.Net.Dns.GetHostName();
            //IPHostEntry ipEntry = System.Net.Dns.GetHostEntry(strHostName);
            //IPAddress[] addr = ipEntry.AddressList;
            //return addr[addr.Length - 1].ToString();
        }

        public static string PaymentFrequencyText(int paymentFrequency)
        {
            switch (paymentFrequency)
            {
                case 1:
                    return "Annual";
                case 2:
                    return "Half Yearly";
                case 3:
                    return "Quarterly";
                case 4:
                    return "Monthly";
                default: return "Annual";
            }
        }

        public static int CalculateAgeFromDOB(DateTime dateOfBirth)
        {
            // get the difference in years
            int years = DateTime.Now.Year - dateOfBirth.Year;
            // subtract another year if we're before the
            // birth day in the current year
            if (DateTime.Now.Month < dateOfBirth.Month || (DateTime.Now.Month == dateOfBirth.Month && DateTime.Now.Day < dateOfBirth.Day))
                years--;

            return years;
        }

        public static string PreparePOSTForm(string url, System.Collections.Hashtable data)
        { // post form
            //Set a name for the form
            string formID = "PostForm";
            //Build the form using the specified data to be posted.
            StringBuilder strForm = new StringBuilder();
            strForm.Append("<form id=\"" + formID + "\" name=\"" +
                           formID + "\" action=\"" + url +
                           "\" method=\"POST\">");

            foreach (System.Collections.DictionaryEntry key in data)
            {

                strForm.Append("<input type=\"hidden\" name=\"" + key.Key +
                               "\" value=\"" + key.Value + "\">");
            }

            strForm.Append("</form>");
            //Build the JavaScript which will do the Posting operation.
            StringBuilder strScript = new StringBuilder();
            strScript.Append("<script language='javascript'>");
            strScript.Append("var v" + formID + " = document." +
                             formID + ";");
            strScript.Append("v" + formID + ".submit();");
            strScript.Append("</script>");
            //Return the form and the script concatenated.
            //(The order is important, Form then JavaScript)
            return strForm.ToString() + strScript.ToString();
        }

        public static byte[] StreamToByteArray(System.IO.Stream stream)
        {
            long originalPosition = 0;

            if (stream.CanSeek)
            {
                originalPosition = stream.Position;
                stream.Position = 0;
            }

            try
            {
                byte[] readBuffer = new byte[4096];

                int totalBytesRead = 0;
                int bytesRead;

                while ((bytesRead = stream.Read(readBuffer, totalBytesRead, readBuffer.Length - totalBytesRead)) > 0)
                {
                    totalBytesRead += bytesRead;

                    if (totalBytesRead == readBuffer.Length)
                    {
                        int nextByte = stream.ReadByte();
                        if (nextByte != -1)
                        {
                            byte[] temp = new byte[readBuffer.Length * 2];
                            Buffer.BlockCopy(readBuffer, 0, temp, 0, readBuffer.Length);
                            Buffer.SetByte(temp, totalBytesRead, (byte)nextByte);
                            readBuffer = temp;
                            totalBytesRead++;
                        }
                    }
                }

                byte[] buffer = readBuffer;
                if (readBuffer.Length != totalBytesRead)
                {
                    buffer = new byte[totalBytesRead];
                    Buffer.BlockCopy(readBuffer, 0, buffer, 0, totalBytesRead);
                }
                return buffer;
            }
            finally
            {
                if (stream.CanSeek)
                {
                    stream.Position = originalPosition;
                }
            }
        }


        #endregion General functions

        #region Name (Merging anf spliting functions)

        public static string MergeNames(string firstName, string middleName, string lastName)
        {
            string fullName = string.Empty;
            middleName = string.IsNullOrWhiteSpace(middleName) ? string.Empty : string.Format(" {0}", middleName);
            lastName = string.IsNullOrWhiteSpace(lastName) ? string.Empty : string.Format(" {0}", lastName);
            fullName = string.Format("{0}{1}{2}", firstName, middleName, lastName);
            return fullName;

        }

        public static void SplitFullName(string fullName, ref string firstName, ref  string middleName, ref  string lastName)
        {
            string[] names = fullName.Split(' ');
            firstName = middleName = lastName = string.Empty;
            if (names.Length == 1)
            {
                firstName = names[0];
            }
            else if (names.Length == 2)
            {
                firstName = names[0];
                lastName = names[1];
            }
            else
            {
                firstName = names[0];
                for (int i = 1; i < names.Length - 1; i++)
                {
                    middleName = string.IsNullOrWhiteSpace(middleName) ? names[i] : string.Format("{0} {1}", middleName, names[i]);
                }
                lastName = names[names.Length - 1];
            }
        }

        public static void SplitFullName(string fullName, ref string firstName, ref string lastName)
        {
            string[] names = fullName.Split(' ');
            firstName = lastName = string.Empty;
            if (names.Length == 1)
            {
                firstName = names[0];
            }
            else if (names.Length == 2)
            {
                firstName = names[0];
                lastName = names[1];
            }
            else
            {
                firstName = names[0];
                for (int i = 1; i < names.Length; i++)
                {
                    lastName = string.IsNullOrWhiteSpace(lastName) ? names[i] : string.Format("{0} {1}", lastName, names[i]);
                }

            }
        }

        #endregion Name (Merging anf spliting functions)

        #region FILES And Currency related Functions

        public static string WriteByteArrayToPdf(byte[] inPDFByteArrayStream, string dirPath, long leadID)
        {

            string fileName = string.Format("{0}_BI.pdf", leadID);
            return WriteByteArrayToPdf(inPDFByteArrayStream, dirPath, fileName, leadID);

        }

        public static string WriteByteArrayToPdf(byte[] inPDFByteArrayStream, string dirPath, string fileName, long leadID)
        {

            //string fileName = string.Format("{0}_BI.pdf", personalInfo.UserInfoId);
            string pdflocation = HttpContext.Current.Server.MapPath(string.Format("~/{0}", dirPath));
            string biURL = string.Empty;
            if (!Directory.Exists(pdflocation)) { Directory.CreateDirectory(pdflocation); }
            if (Directory.Exists(pdflocation))
            {
                pdflocation = pdflocation + fileName;
                using (FileStream Writer = new System.IO.FileStream(pdflocation, FileMode.Create, FileAccess.Write))
                {
                    try
                    {
                        Writer.Write(inPDFByteArrayStream, 0, inPDFByteArrayStream.Length);
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                }
                return string.Format("{0}{1}", dirPath, fileName);
            }
            else
            {
                throw new System.Exception("PDF Shared Location not found");
            }

        }

        public static string ConvertToIndianCurrency(string amount)
        {
            string formatedAmount = amount;
            try
            {
                System.Globalization.CultureInfo hindiCulture = new System.Globalization.CultureInfo("en-IN");
                formatedAmount = Convert.ToDecimal(amount).ToString("##,##,###", hindiCulture);
            }
            catch { }
            return formatedAmount;
        }

        public static string ConvertMoneyToWords(int inputMoney)
        {
            int inputNo = inputMoney;

            if (inputNo == 0)
                return "Zero";

            int[] numbers = new int[4];
            int first = 0;
            int u, h, t;
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            if (inputNo < 0)
            {
                sb.Append("Minus ");
                inputNo = -inputNo;
            }

            string[] words0 = {"" ,"One ", "Two ", "Three ", "Four ",
            "Five " ,"Six ", "Seven ", "Eight ", "Nine "};
            string[] words1 = {"Ten ", "Eleven ", "Twelve ", "Thirteen ", "Fourteen ",
            "Fifteen ","Sixteen ","Seventeen ","Eighteen ", "Nineteen "};
            string[] words2 = {"Twenty ", "Thirty ", "Forty ", "Fifty ", "Sixty ",
            "Seventy ","Eighty ", "Ninety "};
            string[] words3 = { "Thousand ", "Lakh ", "Crore " };

            numbers[0] = inputNo % 1000; // units
            numbers[1] = inputNo / 1000;
            numbers[2] = inputNo / 100000;
            numbers[1] = numbers[1] - 100 * numbers[2]; // thousands
            numbers[3] = inputNo / 10000000; // crores
            numbers[2] = numbers[2] - 100 * numbers[3]; // lakhs

            for (int i = 3; i > 0; i--)
            {
                if (numbers[i] != 0)
                {
                    first = i;
                    break;
                }
            }
            for (int i = first; i >= 0; i--)
            {
                if (numbers[i] == 0) continue;
                u = numbers[i] % 10; // ones
                t = numbers[i] / 10;
                h = numbers[i] / 100; // hundreds
                t = t - 10 * h; // tens
                if (h > 0) sb.Append(words0[h] + "Hundred ");
                if (u > 0 || t > 0)
                {
                    if (h > 0 || i == 0) sb.Append("and ");
                    if (t == 0)
                        sb.Append(words0[u]);
                    else if (t == 1)
                        sb.Append(words1[u]);
                    else
                        sb.Append(words2[t - 2] + words0[u]);
                }
                if (i != 0) sb.Append(words3[i - 1]);
            }
            return sb.ToString().TrimEnd();
        }

        public static void CreateLog(string Message)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(Message)) { return; }
                string LogPath = HttpContext.Current.Server.MapPath("~\\Logs\\");
                string filename = "Log_" + DateTime.Now.ToString("dd-MM-yyyy") + ".txt";
                string filepath = LogPath + filename;
                if (System.IO.File.Exists(filepath))
                {
                    using (StreamWriter writer = new StreamWriter(filepath, true))
                    {
                        writer.WriteLine(Message);
                    }
                }
                else
                {
                    StreamWriter writer = File.CreateText(filepath);
                    writer.WriteLine(Message);
                    writer.Close();
                }
            }
            catch
            {
                // Eat This 
            }
        }

        #endregion FILES And Currency related Functions

        #region API / JSON Related Functions

        public static dynamic GetParsedJSONObject(ref dynamic jsonSchema, string stringJSON)
        {
            if (string.IsNullOrWhiteSpace(stringJSON)) { return null; }
            var json = stringJSON;
            var jsonSerializer = new Newtonsoft.Json.JsonSerializer();
            dynamic jsonObject = jsonSerializer.Deserialize(new StringReader(json), jsonSchema.GetType());
            return jsonObject;
        }

        public static dynamic GetParsedJSONObjectCollection(ref List<dynamic> jsonSchema, string stringJSON)
        {
            if (string.IsNullOrWhiteSpace(stringJSON)) { return null; }
            var json = stringJSON;
            var jsonSerializer = new Newtonsoft.Json.JsonSerializer();
            dynamic jsonObject = jsonSerializer.Deserialize(new StringReader(json), jsonSchema.GetType());
            return jsonObject;
        }

        public static string ExecuteJSONAPI(string FunctionURL, object InputObject)
        {
            HttpClient objHttpClient = null;
            try
            {
                objHttpClient = new HttpClient();
                HttpResponseMessage objResponse = objHttpClient.PostAsJsonAsync(FunctionURL, InputObject).Result;
                return objResponse.Content.ReadAsStringAsync().Result;
            }
            catch
            {
                throw;
            }
        }

        ///* Convert data to json */
        //public static System.Web.Mvc.JsonResult ConvertToJsonResult(Object data)
        //{
        //    var jsonRes = new System.Web.Mvc.JsonResult();
        //    jsonRes.Data = data;
        //    jsonRes.JsonRequestBehavior = System.Web.Mvc.JsonRequestBehavior.AllowGet;
        //    return jsonRes;
        //}

        public static string HttpPostToAPI(string URI, string Parameters)
        {
            return HttpPostToAPI(URI, Parameters, string.Empty, string.Empty);
        }

        public static string HttpPostToAPI(string URI, string Parameters, string headerKey, string headerValue)
        {
            System.Net.WebRequest req = System.Net.WebRequest.Create(URI);

            if (!string.IsNullOrEmpty(headerKey) && !string.IsNullOrEmpty(headerValue))
            {
                req.Headers.Add(headerKey, headerValue);
            }

            req.ContentType = "application/Json";
            req.Method = "POST";

            byte[] bytes = System.Text.Encoding.ASCII.GetBytes(Parameters);
            req.ContentLength = bytes.Length;
            System.IO.Stream os = req.GetRequestStream();
            os.Write(bytes, 0, bytes.Length); //Push it out there
            os.Close();
            System.Net.WebResponse resp = req.GetResponse();
            if (resp == null) return null;
            System.IO.StreamReader sr = new System.IO.StreamReader(resp.GetResponseStream());
            return sr.ReadToEnd().Trim();
        }

        public static string HttpGetFromAPI(string uri)
        {
            return HttpGetFromAPI(uri, string.Empty, string.Empty);
        }

        public static string HttpGetFromAPI(string uri, string headerKey, string headerValue)
        {
            System.Net.WebRequest req = System.Net.WebRequest.Create(uri);
            if (!string.IsNullOrEmpty(headerKey) && !string.IsNullOrEmpty(headerValue))
            {
                req.Headers.Add(headerKey, headerValue);
            }
            //req.ContentType = "application/Json";
            req.Method = "GET";
            System.Net.WebResponse resp = req.GetResponse();
            System.IO.StreamReader sr = new System.IO.StreamReader(resp.GetResponseStream());
            return sr.ReadToEnd().Trim();
        }

        public static long GetUnixDate(DateTime dateTime)
        {
            return dateTime.ToUnixTime();
        }

        #endregion API / JSON Related Functions

        #region Basic Encryption / Deryption

        public static string EncryptBase64(string Input)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(Input);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        public static String DecryptBase64(String Input)
        {
            var base64EncodedBytes = System.Convert.FromBase64String(Input);
            return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
        }


        public static string EncryptMessage(string plainMessage)
        {
            int iLength = 4;
            int iZero;
            int iNine;
            int iA;
            int iZ;
            int iCount = 0;
            int iRandNum;
            string sRandomString = "";
            string sRandomString1 = "";
            Random rRandom = new Random(System.DateTime.Now.Millisecond);
            iZero = Convert.ToInt32('0');
            iNine = Convert.ToInt32('9');
            iA = Convert.ToInt32('A');
            iZ = Convert.ToInt32('Z');

            while ((iCount < iLength))
            {
                iRandNum = rRandom.Next(iZero, iZ);
                if (((iRandNum >= iZero) && (iRandNum <= iNine)) || ((iRandNum >= iA) && (iRandNum <= iZ)))
                {
                    sRandomString = sRandomString + Convert.ToChar(iRandNum);
                    iCount = iCount + 1;
                }
            }
            iCount = 0;
            while ((iCount < iLength))
            {
                iRandNum = rRandom.Next(iZero, iZ);
                if (((iRandNum >= iZero) && (iRandNum <= iNine)) || ((iRandNum >= iA) && (iRandNum <= iZ)))
                {
                    sRandomString1 = sRandomString1 + Convert.ToChar(iRandNum);
                    iCount = iCount + 1;
                }
            }
            plainMessage = plainMessage.Replace("1", "11").Replace("2", "22").Replace("3", "33").Replace("4", "44").Replace("5", "55").Replace("6", "66").Replace("7", "77").Replace("8", "88").Replace("9", "99").Replace("0", "00");
            plainMessage = sRandomString + plainMessage + sRandomString1;
            return plainMessage;
        }

        public static string DecryptMessage(string EncryptMessage)
        {
            try
            {
                return EncryptMessage.Substring(4, EncryptMessage.Length - 8).Replace("11", "1").Replace("22", "2").Replace("33", "3").Replace("44", "4").Replace("55", "5").Replace("66", "6").Replace("77", "7").Replace("88", "8").Replace("99", "9").Replace("00", "0");
            }
            catch (Exception ex)
            {
                return EncryptMessage;
            }
        }


        #endregion Basic Encryption / Deryption
    }

    #endregion UTILTY FUNCTIONS CLASS

    #region Date Time Extened Class

    public static class DateTimeExtensions
    {

        private static readonly DateTime UnixEpoch = new DateTime(1970, 1, 1);

        public static long ToUnixTime(this DateTime dateTime)
        {
            return (dateTime - UnixEpoch).Ticks / TimeSpan.TicksPerMillisecond;
        }

    }


    #endregion Date Time Extened Class

}
