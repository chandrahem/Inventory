USE [master]
GO
/****** Object:  Database [UserManagement]    Script Date: 06/05/2017 15:23:03 ******/
CREATE DATABASE [UserManagement] ON  PRIMARY 
( NAME = N'UserManagement', FILENAME = N'D:\RDSDBDATA\DATA\UserManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%), 
 FILEGROUP [DAILY] 
( NAME = N'UserManagement_Daily', FILENAME = N'D:\RDSDBDATA\DATA\UserManagement_Daily.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%), 
 FILEGROUP [WEEKLY] 
( NAME = N'UserManagement_Weekly', FILENAME = N'D:\RDSDBDATA\DATA\UserManagement_Weekly.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'UserManagement_log', FILENAME = N'D:\RDSDBDATA\DATA\UserManagement_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [UserManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [UserManagement] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [UserManagement] SET ANSI_NULLS OFF
GO
ALTER DATABASE [UserManagement] SET ANSI_PADDING OFF
GO
ALTER DATABASE [UserManagement] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [UserManagement] SET ARITHABORT OFF
GO
ALTER DATABASE [UserManagement] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [UserManagement] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [UserManagement] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [UserManagement] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [UserManagement] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [UserManagement] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [UserManagement] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [UserManagement] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [UserManagement] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [UserManagement] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [UserManagement] SET  DISABLE_BROKER
GO
ALTER DATABASE [UserManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [UserManagement] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [UserManagement] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [UserManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [UserManagement] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [UserManagement] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [UserManagement] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [UserManagement] SET  READ_WRITE
GO
ALTER DATABASE [UserManagement] SET RECOVERY SIMPLE
GO
ALTER DATABASE [UserManagement] SET  MULTI_USER
GO
ALTER DATABASE [UserManagement] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [UserManagement] SET DB_CHAINING OFF
GO
USE [UserManagement]
GO
/****** Object:  User [hem]    Script Date: 06/05/2017 15:23:04 ******/
CREATE USER [hem] FOR LOGIN [hem] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[companydb]    Script Date: 06/05/2017 15:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[companydb](
	[DBId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyCode] [nvarchar](50) NOT NULL,
	[DBConnectionString] [nvarchar](2000) NULL,
	[DBProviderName] [nvarchar](100) NULL,
	[LockStatus] [int] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[Deleted] [bit] NOT NULL,
	[AppName] [nvarchar](50) NULL,
 CONSTRAINT [DBId] PRIMARY KEY CLUSTERED 
(
	[DBId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[companydb] ON
INSERT [dbo].[companydb] ([DBId], [CompanyCode], [DBConnectionString], [DBProviderName], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted], [AppName]) VALUES (1, N'LCG', N'Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=ABCInventory;User ID=hem;Password=hemchandra', N'System.Data.SqlClient', 1, NULL, NULL, NULL, NULL, 0, N'Inventory')
INSERT [dbo].[companydb] ([DBId], [CompanyCode], [DBConnectionString], [DBProviderName], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted], [AppName]) VALUES (2, N'NIBIB', N'Data Source=NIBIBDWH\NIBIBTEAKDWH; Initial Catalog=ABCInventory;User ID=EA_user;Password=NIH@12345678', N'System.Data.SqlClient', 1, NULL, NULL, NULL, NULL, 0, N'Inventory')
INSERT [dbo].[companydb] ([DBId], [CompanyCode], [DBConnectionString], [DBProviderName], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted], [AppName]) VALUES (3, N'IBS', N'Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=UserManagement;User ID=hem;Password=hemchandra', N'System.Data.SqlClient', 1, N'Hem', CAST(0xBA3C0B00 AS Date), NULL, NULL, 0, N'Inventory')
SET IDENTITY_INSERT [dbo].[companydb] OFF
/****** Object:  Table [dbo].[auto_order_document_status]    Script Date: 06/05/2017 15:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auto_order_document_status](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyCode] [nvarchar](50) NOT NULL,
	[DocumentType] [nvarchar](10) NOT NULL,
	[SupplierCode] [nvarchar](50) NOT NULL,
	[CustomerCode] [nvarchar](50) NOT NULL,
	[DocumentNo] [nvarchar](50) NOT NULL,
	[DocumentDataCreated] [bit] NULL,
	[DataCreatedDate] [date] NULL,
	[PDFDocumentCreated] [bit] NULL,
	[PDFDocumentCreatedDate] [date] NULL,
	[LockStatus] [int] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DAILY]
) ON [DAILY]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 06/05/2017 15:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[Thread] [varchar](255) NULL,
	[Level] [varchar](50) NULL,
	[Logger] [varchar](255) NULL,
	[Message] [varchar](4000) NULL,
	[Exception] [varchar](4000) NULL
) ON [WEEKLY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ErrorLog] ON
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1, CAST(0x0000A75B0089D0CA AS DateTime), N'7', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): Procedure or function ''ERP_Save_Category'' expects parameter ''@CategoryCode'', which was not supplied.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in e:\My Projects\IBS.ERP_Github\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 119
ClientConnectionId:98c65e4c-e5e0-4951-9977-94e42c4cface')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (2, CAST(0x0000A75E016F4DD3 AS DateTime), N'6', N'ERROR', N'ADONetAppender', N'CategoriesDAL.objCategories(abc@abc.com,LCG)', N'System.IndexOutOfRangeException: Cannot find table 0.
   at System.Data.DataTableCollection.get_Item(Int32 index)
   at IBS.ERP.DataAccess.CategoriesDAL.GetCategories() in e:\My Projects\IBS.ERP_Github\Inventory\IBS.ERP\IBS.ERP.DataAccess\CategoriesDAL.cs:line 45')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (3, CAST(0x0000A75E016F7D3D AS DateTime), N'6', N'ERROR', N'ADONetAppender', N'CategoriesDAL.objCategories(abc@abc.com,LCG)', N'System.IndexOutOfRangeException: Cannot find table 0.
   at System.Data.DataTableCollection.get_Item(Int32 index)
   at IBS.ERP.DataAccess.CategoriesDAL.GetCategories() in e:\My Projects\IBS.ERP_Github\Inventory\IBS.ERP\IBS.ERP.DataAccess\CategoriesDAL.cs:line 45')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (4, CAST(0x0000A76E00C0B931 AS DateTime), N'6', N'ERROR', N'ADONetAppender', N'ProductDAL.GetProductList(abc@abc.com,LCG)', N'System.IndexOutOfRangeException: Cannot find table 0.
   at System.Data.DataTableCollection.get_Item(Int32 index)
   at IBS.ERP.DataAccess.ProductDAL.GetProductList() in e:\My Projects\IBS.ERP_Github\Inventory\IBS.ERP\IBS.DataAccess\ProductDAL.cs:line 34')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (5, CAST(0x0000A76E00C13EA2 AS DateTime), N'5', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): Procedure or function ''ERP_Save_Product'' expects parameter ''@ProductName'', which was not supplied.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in e:\My Projects\IBS.ERP_Github\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 132
ClientConnectionId:0f006a1f-3158-48f8-9a7b-3f23c0383408')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (6, CAST(0x0000A76E00C1C707 AS DateTime), N'5', N'ERROR', N'ADONetAppender', N'ProductDAL.GetProductList(abc@abc.com,LCG)', N'System.IndexOutOfRangeException: Cannot find table 0.
   at System.Data.DataTableCollection.get_Item(Int32 index)
   at IBS.ERP.DataAccess.ProductDAL.GetProductList() in e:\My Projects\IBS.ERP_Github\Inventory\IBS.ERP\IBS.DataAccess\ProductDAL.cs:line 34')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (7, CAST(0x0000A771014675C7 AS DateTime), N'user: Hem', N'Error in Database', NULL, N'Error occured in Stored Procedure: ERP_SAVE_Partners', N'Error_Message')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (8, CAST(0x0000A77101773BF9 AS DateTime), N'user: Hem', N'Error in Database', NULL, N'Error occured in Stored Procedure: ERP_SAVE_Partners', N'515 : 16 : 2 : ERP_SAVE_Partners : Cannot insert the value NULL into column ''BarCode'', table ''ABCInventory.dbo.Partners''; column does not allow nulls. INSERT fails. : 69')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (11, CAST(0x0000A77C013A650F AS DateTime), N'10', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.FormatException: Input string was not in a correct format.
   at System.Number.StringToNumber(String str, NumberStyles options, NumberBuffer& number, NumberFormatInfo info, Boolean parseDecimal)
   at System.Number.ParseInt32(String s, NumberStyles style, NumberFormatInfo info)
   at System.String.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 121')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1003, CAST(0x0000A77E00EFE5AE AS DateTime), N'user: abc@abc.com', N'Error in Database', NULL, N'Error occured in Stored Procedure: ERP_Delete_Category', N'Error No: 0 Error Message: The DELETE statement conflicted with the REFERENCE constraint "FK_CateryMaster_ProductMaster". The conflict occurred in database "ABCInventory", table "dbo.ProductMaster", column ''categoryId''.')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (9, CAST(0x0000A77B013A76F0 AS DateTime), N'10', N'ERROR', N'ADONetAppender', N'CategoriesDAL.objCategories(abc@abc.com,LCG)', N'System.IndexOutOfRangeException: Cannot find table 0.
   at System.Data.DataTableCollection.get_Item(Int32 index)
   at IBS.ERP.DataAccess.CompanyDAL.GetCompanies() in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\CompanyDAL.cs:line 36')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (10, CAST(0x0000A77B01826F0D AS DateTime), N'10', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): Error converting data type nvarchar to int.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 119
ClientConnectionId:d1852dee-33f2-48d4-99ba-b4440ab65b60
Error Number:8114,State:5,Class:16')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (12, CAST(0x0000A77D015B8F85 AS DateTime), N'8', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): Procedure or function ''ERP_Delete_Category'' expects parameter ''@CategoryId'', which was not supplied.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 119
ClientConnectionId:a35f4cc7-b787-414f-8f86-41673c533f06
Error Number:201,State:4,Class:16')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (16, CAST(0x0000A77D015E808D AS DateTime), N'8', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.FormatException: Input string was not in a correct format.
   at System.Number.StringToNumber(String str, NumberStyles options, NumberBuffer& number, NumberFormatInfo info, Boolean parseDecimal)
   at System.Number.ParseInt32(String s, NumberStyles style, NumberFormatInfo info)
   at System.String.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 121')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1005, CAST(0x0000A77E0105C142 AS DateTime), N'15', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.FormatException: Input string was not in a correct format.
   at System.Number.StringToNumber(String str, NumberStyles options, NumberBuffer& number, NumberFormatInfo info, Boolean parseDecimal)
   at System.Number.ParseInt32(String s, NumberStyles style, NumberFormatInfo info)
   at System.String.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 121')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (13, CAST(0x0000A77D015C5E8C AS DateTime), N'10', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): Procedure or function ''ERP_Save_Company'' expects parameter ''@CompanyCode'', which was not supplied.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 119
ClientConnectionId:918200db-87eb-4558-8ee3-d3db9eec0157
Error Number:201,State:4,Class:16')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (14, CAST(0x0000A77D015C8396 AS DateTime), N'10', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): Procedure or function ''ERP_Save_Company'' expects parameter ''@CompanyCode'', which was not supplied.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 119
ClientConnectionId:918200db-87eb-4558-8ee3-d3db9eec0157
Error Number:201,State:4,Class:16')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (15, CAST(0x0000A77D015D9D40 AS DateTime), N'7', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): Procedure or function ''ERP_Save_Company'' expects parameter ''@Address'', which was not supplied.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 119
ClientConnectionId:e5810ec8-0015-4adf-9498-5e35755a59c9
Error Number:201,State:4,Class:16')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1009, CAST(0x0000A77E012FCF5B AS DateTime), N'7', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.FormatException: Input string was not in a correct format.
   at System.Number.StringToNumber(String str, NumberStyles options, NumberBuffer& number, NumberFormatInfo info, Boolean parseDecimal)
   at System.Number.ParseInt32(String s, NumberStyles style, NumberFormatInfo info)
   at System.String.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 121')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1002, CAST(0x0000A77E00ED18B2 AS DateTime), N'14', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): The DELETE statement conflicted with the REFERENCE constraint "Stores_CompanyID_FK". The conflict occurred in database "ABCInventory", table "dbo.Stores", column ''CompanyID''.
The statement has been terminated.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 119
ClientConnectionId:32907240-7a89-40c5-a193-094077ac8e70
Error Number:547,State:0,Class:16')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1004, CAST(0x0000A77E00F8235D AS DateTime), N'5', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.FormatException: Input string was not in a correct format.
   at System.Number.StringToNumber(String str, NumberStyles options, NumberBuffer& number, NumberFormatInfo info, Boolean parseDecimal)
   at System.Number.ParseInt32(String s, NumberStyles style, NumberFormatInfo info)
   at System.String.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 121')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1006, CAST(0x0000A77E010845E5 AS DateTime), N'6', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): Violation of UNIQUE KEY constraint ''Unique_CompanyCode_CompanyMaster''. Cannot insert duplicate key in object ''dbo.CompanyMaster''. The duplicate key value is (<NULL>).
The statement has been terminated.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 119
ClientConnectionId:573a9aaf-6a9e-498a-8573-09f5147289d9
Error Number:2627,State:1,Class:14')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1010, CAST(0x0000A77E01352F9B AS DateTime), N'10', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.FormatException: Input string was not in a correct format.
   at System.Number.StringToNumber(String str, NumberStyles options, NumberBuffer& number, NumberFormatInfo info, Boolean parseDecimal)
   at System.Number.ParseInt32(String s, NumberStyles style, NumberFormatInfo info)
   at System.String.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 121')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1011, CAST(0x0000A77E0135AB14 AS DateTime), N'7', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.FormatException: Input string was not in a correct format.
   at System.Number.StringToNumber(String str, NumberStyles options, NumberBuffer& number, NumberFormatInfo info, Boolean parseDecimal)
   at System.Number.ParseInt32(String s, NumberStyles style, NumberFormatInfo info)
   at System.String.System.IConvertible.ToInt32(IFormatProvider provider)
   at System.Convert.ToInt32(Object value)
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 121')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1007, CAST(0x0000A77E0108F4EA AS DateTime), N'9', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): Violation of UNIQUE KEY constraint ''Unique_CompanyCode_CompanyMaster''. Cannot insert duplicate key in object ''dbo.CompanyMaster''. The duplicate key value is (<NULL>).
The statement has been terminated.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 119
ClientConnectionId:573a9aaf-6a9e-498a-8573-09f5147289d9
Error Number:2627,State:1,Class:14')
INSERT [dbo].[ErrorLog] ([Id], [Date], [Thread], [Level], [Logger], [Message], [Exception]) VALUES (1008, CAST(0x0000A77E012C6973 AS DateTime), N'7', N'ERROR', N'ADONetAppender', N'baseDAL.ExecuteSqlNonQuery(abc@abc.com,LCG)', N'System.Data.SqlClient.SqlException (0x80131904): Violation of UNIQUE KEY constraint ''Unique_CompanyCode_CompanyMaster''. Cannot insert duplicate key in object ''dbo.CompanyMaster''. The duplicate key value is (<NULL>).
The statement has been terminated.
   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection, Action`1 wrapCloseInAction)
   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj, Boolean callerHasConnectionLock, Boolean asyncClose)
   at System.Data.SqlClient.TdsParser.TryRun(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj, Boolean& dataReady)
   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async, Int32 timeout, Task& task, Boolean asyncWrite, SqlDataReader ds)
   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, TaskCompletionSource`1 completion, Int32 timeout, Task& task, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(TaskCompletionSource`1 completion, String methodName, Boolean sendToPipe, Int32 timeout, Boolean asyncWrite)
   at System.Data.SqlClient.SqlCommand.ExecuteNonQuery()
   at IBS.ERP.DataAccess.baseDAL.ExecuteSqlNonQuery(String SPName, List`1 parameters) in d:\InventoryManagementSystem_GitHub\Inventory\IBS.ERP\IBS.DataAccess\baseDAL.cs:line 119
ClientConnectionId:ad3ec54a-7e5d-4ae4-923e-94e4d6ae359a
Error Number:2627,State:1,Class:14')
SET IDENTITY_INSERT [dbo].[ErrorLog] OFF
/****** Object:  Table [dbo].[UserMaster]    Script Date: 06/05/2017 15:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMaster](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserAccount] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](150) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[CompanyCode] [nvarchar](20) NULL,
	[IsAccountActive] [bit] NULL,
	[isAccountlocked] [bit] NULL,
	[RoleId] [int] NULL,
	[HintQUestion] [nvarchar](150) NULL,
	[HintAnswer] [nvarchar](150) NULL,
	[LockStatus] [int] NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[Deleted] [bit] NOT NULL,
	[EmpCode] [nvarchar](20) NULL,
 CONSTRAINT [PK_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[UserMaster] ON
INSERT [dbo].[UserMaster] ([UserID], [UserAccount], [Password], [FirstName], [LastName], [CompanyCode], [IsAccountActive], [isAccountlocked], [RoleId], [HintQUestion], [HintAnswer], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted], [EmpCode]) VALUES (1, N'abc@abc.com', N'abc', N'abc', N'lmn', N'LCG', 1, 0, 1, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[UserMaster] ([UserID], [UserAccount], [Password], [FirstName], [LastName], [CompanyCode], [IsAccountActive], [isAccountlocked], [RoleId], [HintQUestion], [HintAnswer], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted], [EmpCode]) VALUES (2, N'nih', N'nih', N'nih', N'nih', N'LCG', 1, 0, 1, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0, NULL)
INSERT [dbo].[UserMaster] ([UserID], [UserAccount], [Password], [FirstName], [LastName], [CompanyCode], [IsAccountActive], [isAccountlocked], [RoleId], [HintQUestion], [HintAnswer], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted], [EmpCode]) VALUES (3, N'CreateDB', N'DB', N'CreateDB', N'CreateDB', N'IBS', 1, 0, 1, NULL, NULL, 1, NULL, CAST(0xBA3C0B00 AS Date), NULL, CAST(0xBA3C0B00 AS Date), 0, NULL)
SET IDENTITY_INSERT [dbo].[UserMaster] OFF
/****** Object:  Table [dbo].[Menus]    Script Date: 06/05/2017 15:23:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menus](
	[ModuleID] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [nvarchar](50) NULL,
	[ParentID] [int] NULL,
	[Description] [nvarchar](250) NULL,
	[ActionName] [nvarchar](50) NULL,
	[ControllerName] [nvarchar](50) NULL,
	[isEnabled] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Menus] ON
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Admin', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Create Database', 1, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'Create User', 1, NULL, NULL, NULL, 1, NULL, CAST(0x0000A75B014DB5F0 AS DateTime), NULL, CAST(0x0000A75B014DB5F0 AS DateTime))
SET IDENTITY_INSERT [dbo].[Menus] OFF
/****** Object:  StoredProcedure [dbo].[GetUserDetail]    Script Date: 06/05/2017 15:23:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[GetUserDetail]  
  @UserAccount varchar(50)  
  , @Password varchar(50)
  ,@AppName varchar(50)='Inventory'
  AS  
  BEGIN  
	   IF EXISTS(Select  1  from [UserMaster] um  where UserAccount=@UserAccount and Password=@Password and IsAccountActive=1 and isAccountlocked=0 )  
	   BEGIN  
		Select '0' as SignInStatus,   um.[CompanyCode],DBConnectionString,DBProviderName,RoleId,UserAccount   
		from [UserMaster] um   
		INNER Join CompanyDB db on  um.CompanyCode=db.CompanyCode  
		where UserAccount=@UserAccount  and appname=@AppName 
		 --  0 success User is locked out
		 --print 'aa'
	   END  
	   Else IF EXISTS(Select 1  from [UserMaster] um  where UserAccount=@UserAccount and IsAccountActive=0) 
	   BEGIN  
		 --print 'bb'
		Select '2' as SignInStatus ,'' as [CompanyCode], '' as DBConnectionString,'' as DBProviderName, 0 as RoleId, @UserAccount as UserAccount   --  1 User is not active
	   END  
	   Else IF EXISTS(Select 1  from [UserMaster] um  where UserAccount=@UserAccount and IsAccountActive=1 and isAccountlocked=1) 
	   BEGIN  
	   -- print 'cc'
		Select '1' as SignInStatus ,'' as [CompanyCode], '' as DBConnectionString,'' as DBProviderName, 0 as RoleId, @UserAccount as UserAccount   --  1 User is locked out
	   END  
	   ELSE
	   BEGIN
	   -- print 'dd'
	   Select '3' as SignInStatus ,'' as[CompanyCode], '' as DBConnectionString,'' as DBProviderName, 0 as RoleId, @UserAccount as UserAccount   --  --3 Sign in failed
		
	   END 
  END
GO
/****** Object:  StoredProcedure [dbo].[SaveUserDetail]    Script Date: 06/05/2017 15:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[SaveUserDetail]
  @UserAccount varchar(50)
  ,@Password nvarchar(50)
  ,@FirstName nvarchar(50)
  ,@LastName nvarchar(50)
  ,@PrimaryEmail nvarchar(50)
  --,@AlternateEmail nvarchar(50)
  --,@PrimaryPhoneNo nvarchar(50)
  --,@AlternatePhoneNo nvarchar(50)
  --,@IsAccountActive bit
  --,@isAccountlocked bit
  --,@RoleId int
  ,@CompanyCode  nvarchar(50)
  --,@DBConnectionString nvarchar(1000)
  --,@HintQUestion nvarchar(150)
  --,@HintAnswer nvarchar(150)
  --,@CreatedBy nvarchar(50)
  --,@ModifiedBy nvarchar(50)
  --,@CreatedDate datetime
  --,@ModifiedDate datetime
  AS
  BEGIN
  
  
  INSERT INTO [dbo].[UserMaster]
           ([UserAccount]
           ,[Password]
           ,[FirstName]
           ,[LastName]
           ,[PrimaryEmail]
           --,[AlternateEmail]
           --,[PrimaryPhoneNo]
           --,[AlternatePhoneNo]
           --,[IsAccountActive]
           --,[isAccountlocked]
           --,[RoleId]
           ,[CompanyCode]
           --,[DBConnectionString]
           --,[HintQUestion]
           --,[HintAnswer]
           --,[CreatedBy]
           --,[ModifiedBy]
           --,[CreatedDate]
           --,[ModifiedDate]
           )
     VALUES
           (
           @UserAccount
           ,@Password
           ,@FirstName
           ,@LastName
           ,@PrimaryEmail
           --,@AlternateEmail
           --,@PrimaryPhoneNo
           --,@AlternatePhoneNo
           --,@IsAccountActive
           --,@isAccountlocked
           --,@RoleId 
           ,@CompanyCode
           --,@DBConnectionString 
           --,@HintQUestion 
           --,@HintAnswer
           --,@CreatedBy
           --,@ModifiedBy 
           --,GETDATE()
           --,GETDATE()
           )

  END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_Menu]    Script Date: 06/05/2017 15:23:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Get_Menu] 
@UserAccount varchar(50)
,@RoleID int
as
BEGIN
 Select ModuleID, ModuleName,ParentID,Description, ActionName, ControllerName         
 from menus m Where isEnabled=1 
END
GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 06/05/2017 15:23:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [rds_deny_backups_trigger] ON DATABASE WITH EXECUTE AS 'dbo' FOR
 ADD_ROLE_MEMBER, GRANT_DATABASE AS BEGIN
   SET NOCOUNT ON;
   SET ANSI_PADDING ON;
 
   DECLARE @data xml;
   DECLARE @user sysname;
   DECLARE @role sysname;
   DECLARE @type sysname;
   DECLARE @sql NVARCHAR(MAX);
   DECLARE @permissions TABLE(name sysname PRIMARY KEY);
   
   SELECT @data = EVENTDATA();
   SELECT @type = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'sysname');
    
   IF @type = 'ADD_ROLE_MEMBER' BEGIN
      SELECT @user = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'sysname'),
       @role = @data.value('(/EVENT_INSTANCE/RoleName)[1]', 'sysname');

      IF @role IN ('db_owner', 'db_backupoperator') BEGIN
         SELECT @sql = 'DENY BACKUP DATABASE, BACKUP LOG TO ' + QUOTENAME(@user);
         EXEC(@sql);
      END
   END ELSE IF @type = 'GRANT_DATABASE' BEGIN
      INSERT INTO @permissions(name)
      SELECT Permission.value('(text())[1]', 'sysname') FROM
       @data.nodes('/EVENT_INSTANCE/Permissions/Permission')
      AS DatabasePermissions(Permission);
      
      IF EXISTS (SELECT * FROM @permissions WHERE name IN ('BACKUP DATABASE',
       'BACKUP LOG'))
         RAISERROR('Cannot grant backup database or backup log', 15, 1) WITH LOG;       
   END
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
DISABLE TRIGGER [rds_deny_backups_trigger] ON DATABASE
GO
/****** Object:  Default [DF__CompanyDB__LockS__3A81B327]    Script Date: 06/05/2017 15:23:11 ******/
ALTER TABLE [dbo].[companydb] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__CompanyDB__Delet__3B75D760]    Script Date: 06/05/2017 15:23:11 ******/
ALTER TABLE [dbo].[companydb] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__AutoOrder__LockS__412EB0B6]    Script Date: 06/05/2017 15:23:11 ******/
ALTER TABLE [dbo].[auto_order_document_status] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__AutoOrder__Delet__4222D4EF]    Script Date: 06/05/2017 15:23:11 ******/
ALTER TABLE [dbo].[auto_order_document_status] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__UserMaste__LockS__3F466844]    Script Date: 06/05/2017 15:23:11 ******/
ALTER TABLE [dbo].[UserMaster] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__UserMaste__Delet__403A8C7D]    Script Date: 06/05/2017 15:23:11 ******/
ALTER TABLE [dbo].[UserMaster] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 06/05/2017 15:23:52 ******/
Enable Trigger [rds_deny_backups_trigger] ON Database
GO
