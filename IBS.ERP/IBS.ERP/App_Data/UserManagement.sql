USE [master]
GO
/****** Object:  Database [UserManagement]    Script Date: 04/24/2017 12:45:57 ******/
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
/****** Object:  User [hem]    Script Date: 04/24/2017 12:45:57 ******/
CREATE USER [hem] FOR LOGIN [hem] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[CompanyDB]    Script Date: 04/24/2017 12:46:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyDB](
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
 CONSTRAINT [DBId] PRIMARY KEY CLUSTERED 
(
	[DBId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CompanyDB] ON
INSERT [dbo].[CompanyDB] ([DBId], [CompanyCode], [DBConnectionString], [DBProviderName], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (1, N'LCG', N'Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=ABCInventory;User ID=hem;Password=hemchandra', N'System.Data.SqlClient', 1, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[CompanyDB] ([DBId], [CompanyCode], [DBConnectionString], [DBProviderName], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (2, N'NIBIB', N'Data Source=NIBIBDWH\NIBIBTEAKDWH; Initial Catalog=ABCInventory;User ID=EA_user;Password=NIH@12345678', N'System.Data.SqlClient', 1, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[CompanyDB] ([DBId], [CompanyCode], [DBConnectionString], [DBProviderName], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (3, N'IBS', N'Data Source=ibsmssqlserver.cezeuiz2wro3.ap-south-1.rds.amazonaws.com,1433; Initial Catalog=UserManagement;User ID=hem;Password=hemchandra', N'System.Data.SqlClient', 1, N'Hem', CAST(0xBA3C0B00 AS Date), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[CompanyDB] OFF
/****** Object:  Table [dbo].[AutoOrderDocumentStatus]    Script Date: 04/24/2017 12:46:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutoOrderDocumentStatus](
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
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 04/24/2017 12:46:06 ******/
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
SET IDENTITY_INSERT [dbo].[ErrorLog] OFF
/****** Object:  Table [dbo].[UserMaster]    Script Date: 04/24/2017 12:46:06 ******/
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
	[PrimaryEmail] [nvarchar](50) NULL,
	[AlternateEmail] [nvarchar](50) NULL,
	[PrimaryPhoneNo] [nvarchar](50) NULL,
	[AlternatePhoneNo] [nvarchar](50) NULL,
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
 CONSTRAINT [PK_UserID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[UserMaster] ON
INSERT [dbo].[UserMaster] ([UserID], [UserAccount], [Password], [FirstName], [LastName], [CompanyCode], [PrimaryEmail], [AlternateEmail], [PrimaryPhoneNo], [AlternatePhoneNo], [IsAccountActive], [isAccountlocked], [RoleId], [HintQUestion], [HintAnswer], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (1, N'abc@abc.com', N'abc', N'abc', N'lmn', N'LCG', N'abc@abc.com', NULL, N'7034620545', NULL, 1, 0, 1, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[UserMaster] ([UserID], [UserAccount], [Password], [FirstName], [LastName], [CompanyCode], [PrimaryEmail], [AlternateEmail], [PrimaryPhoneNo], [AlternatePhoneNo], [IsAccountActive], [isAccountlocked], [RoleId], [HintQUestion], [HintAnswer], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (2, N'nih', N'nih', N'nih', N'nih', N'LCG', N'nih@nih.gov', NULL, NULL, NULL, 1, 0, 2, NULL, NULL, 1, NULL, NULL, NULL, NULL, 0)
INSERT [dbo].[UserMaster] ([UserID], [UserAccount], [Password], [FirstName], [LastName], [CompanyCode], [PrimaryEmail], [AlternateEmail], [PrimaryPhoneNo], [AlternatePhoneNo], [IsAccountActive], [isAccountlocked], [RoleId], [HintQUestion], [HintAnswer], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (3, N'CreateDB', N'DB', N'CreateDB', N'CreateDB', N'IBS', NULL, NULL, NULL, NULL, 1, 0, 1, NULL, NULL, 1, NULL, CAST(0xBA3C0B00 AS Date), NULL, CAST(0xBA3C0B00 AS Date), 0)
SET IDENTITY_INSERT [dbo].[UserMaster] OFF
/****** Object:  Table [dbo].[Menus]    Script Date: 04/24/2017 12:46:06 ******/
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
/****** Object:  StoredProcedure [dbo].[GetUserDetail]    Script Date: 04/24/2017 12:46:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[GetUserDetail]  
  @UserAccount varchar(50)  
  , @Password varchar(50)
  
  AS  
  BEGIN  
	   IF EXISTS(Select  1  from [UserMaster] um  where UserAccount=@UserAccount and Password=@Password and IsAccountActive=1 and isAccountlocked=0 )  
	   BEGIN  
		Select '0' as SignInStatus,   um.[CompanyCode],DBConnectionString,DBProviderName,RoleId,UserAccount   
		from [UserMaster] um   
		INNER Join CompanyDB db on  um.CompanyCode=db.CompanyCode  
		where UserAccount=@UserAccount  
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
      
      --[dbo].[GetUserDetail]  'createDB','DB'
GO
/****** Object:  StoredProcedure [dbo].[SaveUserDetail]    Script Date: 04/24/2017 12:46:22 ******/
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
/****** Object:  StoredProcedure [dbo].[ERP_Get_Menu]    Script Date: 04/24/2017 12:46:23 ******/
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
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 04/24/2017 12:46:26 ******/
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
/****** Object:  Default [DF__CompanyDB__LockS__3A81B327]    Script Date: 04/24/2017 12:46:06 ******/
ALTER TABLE [dbo].[CompanyDB] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__CompanyDB__Delet__3B75D760]    Script Date: 04/24/2017 12:46:06 ******/
ALTER TABLE [dbo].[CompanyDB] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__AutoOrder__LockS__412EB0B6]    Script Date: 04/24/2017 12:46:06 ******/
ALTER TABLE [dbo].[AutoOrderDocumentStatus] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__AutoOrder__Delet__4222D4EF]    Script Date: 04/24/2017 12:46:06 ******/
ALTER TABLE [dbo].[AutoOrderDocumentStatus] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__UserMaste__LockS__3F466844]    Script Date: 04/24/2017 12:46:06 ******/
ALTER TABLE [dbo].[UserMaster] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__UserMaste__Delet__403A8C7D]    Script Date: 04/24/2017 12:46:06 ******/
ALTER TABLE [dbo].[UserMaster] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 04/24/2017 12:46:26 ******/
Enable Trigger [rds_deny_backups_trigger] ON Database
GO
