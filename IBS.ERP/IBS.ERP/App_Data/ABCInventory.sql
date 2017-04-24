USE [master]
GO
/****** Object:  Database [ABCInventory]    Script Date: 04/24/2017 12:48:08 ******/
CREATE DATABASE [ABCInventory] ON  PRIMARY 
( NAME = N'ABCInventory', FILENAME = N'D:\RDSDBDATA\DATA\ABCInventory.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%), 
 FILEGROUP [DAILY] 
( NAME = N'ABCInventory_Daily', FILENAME = N'D:\RDSDBDATA\DATA\ABCInventory_Daily.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%), 
 FILEGROUP [WEEKLY] 
( NAME = N'ABCInventory_Weekly', FILENAME = N'D:\RDSDBDATA\DATA\ABCInventory_Weekly.ndf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'ABCInventory_log', FILENAME = N'D:\RDSDBDATA\DATA\ABCInventory_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ABCInventory].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ABCInventory] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [ABCInventory] SET ANSI_NULLS OFF
GO
ALTER DATABASE [ABCInventory] SET ANSI_PADDING OFF
GO
ALTER DATABASE [ABCInventory] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [ABCInventory] SET ARITHABORT OFF
GO
ALTER DATABASE [ABCInventory] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [ABCInventory] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [ABCInventory] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [ABCInventory] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [ABCInventory] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [ABCInventory] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [ABCInventory] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [ABCInventory] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [ABCInventory] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [ABCInventory] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [ABCInventory] SET  DISABLE_BROKER
GO
ALTER DATABASE [ABCInventory] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [ABCInventory] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [ABCInventory] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [ABCInventory] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [ABCInventory] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [ABCInventory] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [ABCInventory] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [ABCInventory] SET  READ_WRITE
GO
ALTER DATABASE [ABCInventory] SET RECOVERY SIMPLE
GO
ALTER DATABASE [ABCInventory] SET  MULTI_USER
GO
ALTER DATABASE [ABCInventory] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [ABCInventory] SET DB_CHAINING OFF
GO
USE [ABCInventory]
GO
/****** Object:  User [hem]    Script Date: 04/24/2017 12:48:09 ******/
CREATE USER [hem] FOR LOGIN [hem] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Shipping]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipping](
	[ShippingId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[SupplierID] [int] NULL,
	[ShipTo] [nvarchar](50) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
	[Email] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
	[ShippingMode] [nvarchar](50) NULL,
 CONSTRAINT [PK_Shipping] PRIMARY KEY CLUSTERED 
(
	[ShippingId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unit_Master]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Unit_Master](
	[Uom_Code] [varchar](50) NOT NULL,
	[Uom_Unit] [varchar](50) NULL,
	[Uom_Desc] [varchar](max) NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_Uom_Master] PRIMARY KEY CLUSTERED 
(
	[Uom_Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TransactionDetail]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[InvoiceType] [nvarchar](50) NULL,
	[TransactionAmount] [decimal](10, 2) NULL,
	[ModeOfPayment] [nvarchar](150) NULL,
	[TransactionDate] [datetime] NULL,
	[TransactionID] [nvarchar](50) NULL,
	[BankName] [nvarchar](50) NULL,
	[ChequeNo] [nvarchar](50) NULL,
	[ChequeDate] [datetime] NULL,
	[ChequeAmount] [decimal](10, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
 CONSTRAINT [PK_TransactionDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DAILY]
) ON [DAILY]
GO
/****** Object:  Table [dbo].[Tax_Master]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tax_Master](
	[TaxId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [varchar](50) NULL,
	[FixedTaxValue] [decimal](18, 2) NULL,
	[PercentTaxValue] [decimal](18, 2) NULL,
	[Description] [varchar](max) NULL,
	[Form_Type] [varchar](50) NULL,
	[Id_Fin_year] [int] NULL,
 CONSTRAINT [PK_Tax_Master] PRIMARY KEY CLUSTERED 
(
	[TaxId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierCode] [nvarchar](20) NULL,
	[SupplierName] [nvarchar](50) NOT NULL,
	[ContactName] [nvarchar](50) NULL,
	[ContactTitle] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](24) NULL,
	[Country] [nvarchar](50) NULL,
	[Phone1] [nvarchar](24) NULL,
	[Phone2] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
	[WebSite] [nvarchar](50) NULL,
	[ContactEmail] [nvarchar](100) NULL,
	[AutoApprovePO] [bit] NULL,
	[AutoApprovePOAmount] [decimal](10, 2) NULL,
	[AutoSendPO] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Suppliers] ON
INSERT [dbo].[Suppliers] ([SupplierID], [SupplierCode], [SupplierName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone1], [Phone2], [Fax], [WebSite], [ContactEmail], [AutoApprovePO], [AutoApprovePOAmount], [AutoSendPO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (2, N'sa', N'AQWSD', N'ASD', N'DAWS', N'ASD', N'ASD', NULL, N'ASD', N'SDCF', N'DSF', N'DSF', N'DSF', N'grfdfg', N'fgddddddddddddd', 0, NULL, 0, N'abc@abc.com', CAST(0xB73C0B00 AS Date), N'abc@abc.com', CAST(0xB73C0B00 AS Date), 1)
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
/****** Object:  Table [dbo].[EmployeeMaster]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeMaster](
	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
	[EmpCode] [nvarchar](20) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Extension] [nvarchar](4) NULL,
	[Photo] [image] NULL,
	[Notes] [ntext] NULL,
	[ReportsTo] [int] NULL,
	[PhotoPath] [nvarchar](255) NULL,
	[StoreId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifedBy] [varchar](50) NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UC_EmployeeMaster] UNIQUE NONCLUSTERED 
(
	[EmpCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DocumentStatus]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentStatus](
	[ID] [smallint] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](50) NULL,
	[StatusText] [nvarchar](50) NULL,
	[Description] [ntext] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_POStatus] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentNoSetting]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentNoSetting](
	[DocumentID] [smallint] IDENTITY(1,1) NOT NULL,
	[DocumentType] [nvarchar](50) NOT NULL,
	[PreFix] [nvarchar](50) NOT NULL,
	[RunningNo] [int] NULL,
	[Description] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
	[IsAutoGenerated] [bit] NULL,
	[RunningNoLength] [int] NULL,
	[PaddingCharacter] [nvarchar](1) NULL,
 CONSTRAINT [PK_DocumentRunningNo] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_DocumentType_DocumentRunningNo] UNIQUE NONCLUSTERED 
(
	[DocumentType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DocumentNoSetting] ON
INSERT [dbo].[DocumentNoSetting] ([DocumentID], [DocumentType], [PreFix], [RunningNo], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [IsAutoGenerated], [RunningNoLength], [PaddingCharacter]) VALUES (1, N'CATEGORY', N'CA', 1, N'Category code', NULL, NULL, CAST(0x0000A75E016BF381 AS DateTime), CAST(0x0000A75E016BF381 AS DateTime), 1, 0, 1, 3, N'0')
SET IDENTITY_INSERT [dbo].[DocumentNoSetting] OFF
/****** Object:  Table [dbo].[CustomerMaster]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerMaster](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerCode] [nvarchar](50) NOT NULL,
	[CustomerBarCode] [nvarchar](50) NULL,
	[CompanyName] [nvarchar](40) NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
	[AutoApproveSO] [bit] NULL,
	[AutoApproveSOAmount] [decimal](10, 2) NULL,
	[AutoSendSO] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_CustomerCode_CustomerMaster] UNIQUE NONCLUSTERED 
(
	[CustomerCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CompanyMaster]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyMaster](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyCode] [nvarchar](20) NULL,
	[CompanyName] [nvarchar](100) NOT NULL,
	[RegistrationNo] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[TIN] [nvarchar](50) NULL,
	[Phone1] [nvarchar](50) NULL,
	[Phone2] [nvarchar](50) NULL,
	[website] [nvarchar](50) NULL,
	[ContactEmail] [nvarchar](100) NULL,
	[OwnedBy] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_CompanyCode_CompanyMaster] UNIQUE NONCLUSTERED 
(
	[CompanyCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoryMaster]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryMaster](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryCode] [nvarchar](50) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_CategoryCode_CategoryMaster] UNIQUE NONCLUSTERED 
(
	[CategoryCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLog]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLog](
	[AuditID] [int] IDENTITY(1,1) NOT NULL,
	[ActionDoneBy] [nvarchar](50) NULL,
	[Description] [nvarchar](4000) NULL,
	[CreatedDate] [datetime] NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_AuditLog] PRIMARY KEY CLUSTERED 
(
	[AuditID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
SET IDENTITY_INSERT [dbo].[AuditLog] ON
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (1, N'abc@abc.com', N'Inserted category named: Clothes', CAST(0x0000A75B006E5B19 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (2, N'abc@abc.com', N'Category deleted: Clothes', CAST(0x0000A75B006E8408 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (3, N'abc@abc.com', N'Inserted category named: Clothes', CAST(0x0000A75B006EA468 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (4, N'abc@abc.com', N'Inserted category named: sachin', CAST(0x0000A75B007570BB AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (5, N'abc@abc.com', N'Updated category named :Clothes', CAST(0x0000A75B0123D6BA AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (6, N'abc@abc.com', N'Category deleted: sachin', CAST(0x0000A75B0123E221 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (7, N'abc@abc.com', N'Category deleted: Clothes', CAST(0x0000A75B0124EB8B AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (8, N'abc@abc.com', N'Inserted category named: health', CAST(0x0000A75B01251208 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (9, N'abc@abc.com', N'Updated category named :Clothes', CAST(0x0000A75B0127B949 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (10, N'abc@abc.com', N'Updated category named :Clothes', CAST(0x0000A75C000B825D AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (11, N'abc@abc.com', N'ALL Suppliers list accessed.', CAST(0x0000A75C00634D0E AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (12, N'abc@abc.com', N'Inserted Supplier named: Supplier Name', CAST(0x0000A75C0063C332 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (13, N'abc@abc.com', N'ALL Suppliers list accessed.', CAST(0x0000A75C0063C3F5 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (14, N'abc@abc.com', N' Supplier accessed:1', CAST(0x0000A75C0063CA7E AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (15, N'abc@abc.com', N'ALL Suppliers list accessed.', CAST(0x0000A75C0063E747 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (16, N'abc@abc.com', N'Supplier deleted: Supplier Name', CAST(0x0000A75C0063ED8A AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (17, N'abc@abc.com', N'ALL Suppliers list accessed.', CAST(0x0000A75C0063EE4D AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (18, N'abc@abc.com', N'Inserted Supplier named: AQWSD', CAST(0x0000A75C00640A3B AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (19, N'abc@abc.com', N'ALL Suppliers list accessed.', CAST(0x0000A75C00640AFD AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (20, N'abc@abc.com', N' Supplier accessed:2', CAST(0x0000A75C00641348 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (21, N'abc@abc.com', N'Updated Supplier named :AQWSD', CAST(0x0000A75C0069C636 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (22, N'abc@abc.com', N'ALL Suppliers list accessed.', CAST(0x0000A75C0069C6EF AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (23, N'abc@abc.com', N' Supplier accessed:2', CAST(0x0000A75C0069D1B2 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (24, N'abc@abc.com', N'Updated Supplier named :AQWSD', CAST(0x0000A75C0069E149 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (25, N'abc@abc.com', N'ALL Suppliers list accessed.', CAST(0x0000A75C0069E201 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (26, N'abc@abc.com', N'ALL Product list accessed.', CAST(0x0000A75C006E7CE6 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (27, N'abc@abc.com', N'ALL Product list accessed.', CAST(0x0000A75C006F833C AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (28, N'abc@abc.com', N'Updated category named :Clothes', CAST(0x0000A75C017C10F5 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (29, N'abc@abc.com', N'ALL Product list accessed.', CAST(0x0000A75C017CF38C AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[AuditLog] OFF
/****** Object:  Table [dbo].[Fin_Year_Master]    Script Date: 04/24/2017 12:48:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fin_Year_Master](
	[Id_Fin_year] [int] IDENTITY(1,1) NOT NULL,
	[From_date] [datetime] NULL,
	[To_date] [datetime] NULL,
	[Fin_year] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
 CONSTRAINT [PK_Fin_Year_Master] PRIMARY KEY CLUSTERED 
(
	[Id_Fin_year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_CustomerInformation]    Script Date: 04/24/2017 12:48:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sachin Sachan>
-- Create date: <16-04-2017>
-- Description:	<Get The Customer Information>
-- =============================================
CREATE procedure [dbo].[ERP_Get_CustomerInformation]

 @StartRowIndex int=1,      
 @MaxRows int=5,      
 @OrderBy nvarchar(500) = 'CustomerID',      
 @Order nvarchar(5)= 'ASC'
 As
 begin
 Declare @Query Nvarchar(MAX);        
      
 Declare @CountQuery Nvarchar(MAX);      
 DECLARE @AllRecord NVARCHAR(MAX)      
 Declare  @StartID int      
 Declare @EndID int    
if(@StartRowIndex=0)      
  BEGIN      
  set @StartRowIndex=1;            
  SET  @StartID = (@StartRowIndex-1) * @MaxRows + 1      
  SEt @EndID = (@StartRowIndex) * @MaxRows      
  END      
  ELSE      
  BEGIN      
   SET  @StartID = (@StartRowIndex-1) * @MaxRows + 1      
  SEt @EndID = (@StartRowIndex) * @MaxRows      
  END  
Set @Query= 'select CustomerID, CustomerCode,CustomerBarCode, CompanyName, ContactName,ContactTitle, Address, City,
					Region,RowNum 
              from(
					select CustomerID, CustomerCode,CustomerBarCode, CompanyName, ContactName,ContactTitle, Address, City,
					Region,ROW_NUMBER() OVER(ORDER BY '+@OrderBy+' '+@Order+') as RowNum    
					from CustomerMaster)as  D
					WHERE  RowNum BETWEEN '+ Cast(@StartID as nvarchar(15)) +' AND ('+ Cast(@EndID as nvarchar(15)) +')'  


  set @CountQuery = 'Select Count(*) as TotalRows from CustomerMaster'  
      
  Exec(@Query)    
  Exec(@CountQuery)      
               
END    
    
Print @Query
GO
/****** Object:  Table [dbo].[Menus]    Script Date: 04/24/2017 12:48:54 ******/
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
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Purchase', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Sale', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Manage Category', 1, NULL, N'Index', N'Category', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Manage Supplier', 1, NULL, N'Index', N'Supplier', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Manage Purchase', 2, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Purchase Return', 2, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'Manage Sale', 3, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Sale Return', 3, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, N'Reports', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'Accounts', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'Sale Reports', 10, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'Purchase Reports', 10, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'Profit and Loss', 11, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'Manage Customer', 1, NULL, N'Index', N'Customer', 1, NULL, CAST(0x0000A75B014DB5F0 AS DateTime), NULL, CAST(0x0000A75B014DB5F0 AS DateTime))
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, N'Manage Products', 1, NULL, N'Index', N'Product', 1, NULL, CAST(0x0000A75C006B27D8 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Menus] OFF
/****** Object:  UserDefinedFunction [dbo].[getTableRowCount]    Script Date: 04/24/2017 12:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getTableRowCount](@TableName nvarchar(50))
    RETURNS int
AS
begin
 DEclare @RowCount int
	SELECT @RowCount=SUM(PART.rows) 
	FROM sys.tables TBL
	INNER JOIN sys.partitions PART ON TBL.object_id = PART.object_id
	INNER JOIN sys.indexes IDX ON PART.object_id = IDX.object_id
	AND PART.index_id = IDX.index_id
	WHERE TBL.name = @TableName
	AND IDX.index_id < 2
	GROUP BY TBL.object_id, TBL.name;
	
	Return @RowCount
end
GO
/****** Object:  Table [dbo].[PO_Detail]    Script Date: 04/24/2017 12:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PO_Detail](
	[PODetailId] [int] IDENTITY(1,1) NOT NULL,
	[PO_Id] [int] NOT NULL,
	[ProductCode] [nvarchar](50) NOT NULL,
	[ProductID] [nvarchar](100) NOT NULL,
	[BarCode] [nvarchar](50) NULL,
	[quantity] [int] NOT NULL,
	[Expiredate] [date] NULL,
	[UOM] [nvarchar](50) NULL,
	[company_price] [decimal](10, 2) NOT NULL,
	[SubtotalAmount] [decimal](10, 2) NOT NULL,
	[TaxAmount] [decimal](10, 2) NOT NULL,
	[TotalAmount] [decimal](10, 2) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PODetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[PermissionRoleMapping]    Script Date: 04/24/2017 12:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionRoleMapping](
	[MappingID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[PermissionID] [int] NOT NULL,
	[Description] [nvarchar](50) NULL,
 CONSTRAINT [PK_PermissionRoleMapping] PRIMARY KEY CLUSTERED 
(
	[MappingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[PermissionRoleMapping] ON
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (1, 1, 1, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (2, 1, 2, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (4, 1, 3, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (5, 1, 4, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (6, 1, 5, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (7, 1, 6, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (8, 1, 7, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (9, 1, 8, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (10, 1, 9, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (11, 1, 10, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (12, 1, 11, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (13, 1, 12, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (14, 1, 13, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (15, 1, 14, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (16, 1, 15, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (17, 1, 16, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (18, 2, 9, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (19, 2, 10, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (20, 2, 11, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (21, 2, 12, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (22, 3, 13, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (23, 3, 14, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (24, 3, 15, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (25, 3, 16, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (26, 3, 1, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (27, 3, 2, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (28, 3, 3, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (29, 3, 4, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (30, 3, 9, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (31, 3, 10, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (32, 3, 11, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (33, 3, 12, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (34, 1, 17, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (35, 1, 18, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (36, 1, 19, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (37, 1, 20, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (38, 1, 21, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (39, 2, 17, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (40, 2, 1, NULL)
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (41, 1, 22, N'Read customer')
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (42, 1, 23, N'UPDATE_CUSTOMER')
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (43, 1, 24, N'CREATE_CUSTOMER')
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (44, 1, 25, N'DELETE_CUSTOMER')
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (45, 1, 26, N'Read product by admin')
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (46, 1, 27, N'Create product by admin')
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (47, 1, 28, N'update product by admin')
INSERT [dbo].[PermissionRoleMapping] ([MappingID], [RoleID], [PermissionID], [Description]) VALUES (48, 1, 29, N'delete product by admin')
SET IDENTITY_INSERT [dbo].[PermissionRoleMapping] OFF
/****** Object:  Table [dbo].[sales]    Script Date: 04/24/2017 12:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales](
	[Saleid] [int] IDENTITY(1,1) NOT NULL,
	[BillNumber] [nvarchar](50) NOT NULL,
	[DateofSale] [datetime] NOT NULL,
	[CustomerCode] [nvarchar](50) NULL,
	[CustomerBarCode] [nvarchar](120) NULL,
	[SubTotal] [decimal](10, 2) NULL,
	[TaxAmount] [decimal](10, 2) NULL,
	[TotalAmount] [decimal](10, 2) NOT NULL,
	[BalanceAmount] [decimal](10, 2) NULL,
	[PaymentDueOn] [datetime] NULL,
	[Comment] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Saleid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DAILY]
) ON [DAILY]
GO
/****** Object:  Table [dbo].[RoleMaster]    Script Date: 04/24/2017 12:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMaster](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[RoleDescription] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
 CONSTRAINT [PK_RoleMaster] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[RoleMaster] ON
INSERT [dbo].[RoleMaster] ([RoleId], [RoleName], [RoleDescription], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (1, N'Admin', N'admin', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[RoleMaster] ([RoleId], [RoleName], [RoleDescription], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (2, N'Clerk', N'Basic role', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[RoleMaster] ([RoleId], [RoleName], [RoleDescription], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (3, N'AdminClerk', N' Custom role', NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[RoleMaster] OFF
/****** Object:  Table [dbo].[SalesReturn]    Script Date: 04/24/2017 12:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesReturn](
	[SalesReturnId] [int] IDENTITY(1,1) NOT NULL,
	[SaleId] [int] NOT NULL,
	[DateofReturn] [datetime] NOT NULL,
	[CustomerBarCode] [nvarchar](120) NULL,
	[SubTotal] [decimal](10, 2) NULL,
	[Total] [decimal](10, 2) NOT NULL,
	[BalanceAmount] [decimal](10, 2) NULL,
	[PaymentDueOn] [datetime] NULL,
	[Comment] [nvarchar](500) NULL,
	[BillNumber] [nvarchar](120) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesReturnId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[SalesDetail]    Script Date: 04/24/2017 12:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesDetail](
	[SalesDetailId] [int] IDENTITY(1,1) NOT NULL,
	[Saleid] [int] NULL,
	[ProductCode] [nvarchar](200) NOT NULL,
	[BarCode] [nvarchar](200) NOT NULL,
	[selling_price] [decimal](10, 2) NOT NULL,
	[quantity] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DAILY]
) ON [DAILY]
GO
/****** Object:  Table [dbo].[ProductMaster]    Script Date: 04/24/2017 12:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductMaster](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [nvarchar](50) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[BarCode] [nvarchar](50) NULL,
	[categoryId] [int] NULL,
	[SupplierId] [int] NULL,
	[Expiredate] [date] NULL,
	[UOM] [nvarchar](50) NULL,
	[company_price] [decimal](10, 2) NOT NULL,
	[AutoPO] [bit] NULL,
	[RePOorderLevel] [int] NULL,
	[RePOorderQuantity] [int] NULL,
	[ReSOorderLevel] [int] NULL,
	[ReSOorderQuantity] [int] NULL,
	[AutoSO] [bit] NULL,
	[LockStatus] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[Discontinued] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PermissionMaster]    Script Date: 04/24/2017 12:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionMaster](
	[PermissionId] [int] IDENTITY(1,1) NOT NULL,
	[PermissionName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](150) NULL,
	[ModuleId] [int] NULL,
 CONSTRAINT [PK_PermissionMaster] PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[PermissionMaster] ON
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (1, N'READ_CATEGORY', N'Category', 4)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (2, N'CREATE_CATEGORY', N'Category', 4)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (3, N'UPDATE_CATEGORY', NULL, 4)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (4, N'DELETE_CATEGORY', NULL, 4)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (5, N'READ_SUPPLIER', N'Supplier', 5)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (6, N'CREATE_SUPPLIER', NULL, 5)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (7, N'UPDATE_SUPPLIER', NULL, 5)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (8, N'DELETE_SUPPLIER', NULL, 5)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (9, N'READ_PURCHASE', NULL, 6)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (10, N'CREATE_PURCHASE', NULL, 6)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (11, N'UPDATE_PURCHASE', NULL, 6)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (12, N'READ_PURCHASE', NULL, 6)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (13, N'READ_SALE_REPORT', NULL, 12)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (14, N'CREATE_SALE_REPORT', NULL, 12)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (15, N'UPDATE_SALE_REPORT', NULL, 12)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (16, N'DELETE_SALE_REPORT', NULL, 12)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (17, N'Admin', N'Admin Module', 1)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (18, N'Purchase', N'Purchase Module', 2)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (19, N'Sale', N'Sale Module', 3)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (20, N'Reports', N'Reports Module', 10)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (21, N'Accounts', N'Accounts Module', 11)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (22, N'READ_CUSTOMER', N'READ_CUSTOMER', 15)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (23, N'UPDATE_CUSTOMER', N'UPDATE_CUSTOMER', 15)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (24, N'CREATE_CUSTOMER', N'CREATE_CUSTOMER', 15)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (25, N'DELETE_CUSTOMER', N'DELETE_CUSTOMER', 15)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (26, N'READ_PRODUCT', N'read permission', 16)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (27, N'CREATE_PRODUCT', N'create permission', 16)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (28, N'UPDATE_PRODUCT', N'update PRODUCT permission', 16)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (29, N'DELETE_PRODUCT', N'delete PRODUCT permission', 16)
SET IDENTITY_INSERT [dbo].[PermissionMaster] OFF
/****** Object:  UserDefinedFunction [dbo].[getDocumentNo]    Script Date: 04/24/2017 12:49:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getDocumentNo](@DocumentType nvarchar(50),@TableName nvarchar(50))
    RETURNS nVARCHAR(30)
AS
begin

	Declare @DocumentNo nvarchar(50),@RowCount int,@isAutoGenerated  bit,@PreFix varchar(30),@RunningNo int,@RunningNoLength int,@PaddingCharacter varchar(30)
	
	SElect @isAutoGenerated=isAutoGenerated ,@PreFix=PreFix,@RunningNo=RunningNo,@RunningNoLength=RunningNoLength,@PaddingCharacter=PaddingCharacter
	from DocumentNoSetting where DocumentType=@DocumentType
		
		
	-- Document no
	IF @isAutoGenerated=1
	BEGIN
		If  dbo.getTableRowCount(@TableName)>0 
		BEGIN
			-- take document from table
			Declare @CategoryCode nvarchar(50)
			SElect top 1 @CategoryCode=CategoryCode from categoryMaster order by CreatedDate desc
			--print @CategoryCode
			--SElect @RunningNoLength=RunningNoLength from documentnosetting where DocumentType='CATEGORY'
			--print @RunningNoLength
			SET @RunningNo=substring( @CategoryCode,Len(@CategoryCode)+1-@RunningNoLength,@RunningNoLength)
			SET @RunningNo=@RunningNo+1
			--Print @RunningNo
		END
		select @documentNo= isNULL(@PreFix,'') + ISNULL( stuff(@RunningNo, 1, 0, replicate(@PaddingCharacter, @RunningNoLength - len(@RunningNo))),'')
	END


  return @documentNo
end 

--select * from CategoryMaster
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_CategoryById]    Script Date: 04/24/2017 12:49:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Get_CategoryById]
@UserAccount nvarchar(50)
,@CategoryId integer
as
BEGIN
Declare @txt nvarchar(500)
SELECT  CategoryID,CategoryCode,  CategoryName,    Description,LockStatus  
FROM CategoryMaster where CategoryID=@CategoryId 
--SET @txt=' Categories accessed.' + CAST(@CategoryId as nvarchar(50))
--	EXEC ERP_Insert_AuditLog @UserAccount, @txt
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_Categories]    Script Date: 04/24/2017 12:49:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Get_Categories]
@UserAccount varchar(50)
AS
BEGIN

	--Declare @NextCategoryCode nvarchar(50)
	--SELECT  @NextCategoryCode=  [dbo].[getDocumentNo]('Category','CategoryMaster')
	--print @NextCategoryCode
	
	SELECT  CategoryID,CategoryCode,  CategoryName,  Description,LockStatus 
	FROM CategoryMaster 
	--SET @NextCategoryCode=isnull(@NextCategoryCode,'') 

	--SET @txt='ALL Categories accessed.'
	--EXEC ERP_Insert_AuditLog @UserAccount, @txt
END

--exec [ERP_Get_Categories] 'cc'

--SELECT  CategoryID,CategoryCode,  CategoryName,  Description
--	FROM CategoryMaster
GO
/****** Object:  StoredProcedure [dbo].[ERP_Insert_ErrorLog]    Script Date: 04/24/2017 12:49:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Insert_ErrorLog]  
@userAccount nvarchar(50) 
,@procedureName nvarchar(50) 
,@Exception nvarchar(4000)  
AS  
BEGIN  
  Declare @Message nvarchar(100)
  SET @Message ='Error occured in Stored Procedure: '+@procedureName
INSERT INTO [UserManagement].[dbo].[ErrorLog]  
           ([Date]  
           ,[Thread]  
           ,[Level]  
           ,[Logger]  
           ,[Message]  
           ,[Exception])  
     VALUES  
           (  
            GETDATE()  
           ,'user: ' + @userAccount  
           ,'Error in Database'  
           ,null
           ,@Message  
           ,@Exception
           )  
  
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Insert_AuditLog]    Script Date: 04/24/2017 12:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Insert_AuditLog]
@userAccount nvarchar(50)
,@ActionDetail nvarchar(50)
AS
BEGIN


INSERT INTO [dbo].[AuditLog]
           ([ActionDoneBy]
           ,[Description]
           ,[CreatedDate]
           ,[Deleted])
     VALUES
           (@userAccount
           ,@ActionDetail
           ,GETDATE()
           ,0)

END
GO
/****** Object:  Table [dbo].[Stores]    Script Date: 04/24/2017 12:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stores](
	[StoreID] [int] IDENTITY(1,1) NOT NULL,
	[StoreName] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[CompanyID] [int] NULL,
	[ManagedBy] [nvarchar](50) NULL,
	[Phone1] [nvarchar](50) NULL,
	[Phone2] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Stores] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Scrap]    Script Date: 04/24/2017 12:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Scrap](
	[ScrapId] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NOT NULL,
	[Lot] [nvarchar](50) NOT NULL,
	[ProductCode] [nvarchar](50) NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[BarCode] [nvarchar](50) NULL,
	[SupplierID] [int] NULL,
	[categoryId] [int] NULL,
	[quantity] [int] NOT NULL,
	[Expiredate] [date] NULL,
	[UOM] [nvarchar](50) NULL,
	[company_price] [decimal](10, 2) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ScrapId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[SalesReturnDetail]    Script Date: 04/24/2017 12:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesReturnDetail](
	[SalesReturnDetailId] [int] IDENTITY(1,1) NOT NULL,
	[SalesReturnId] [int] NULL,
	[ProductCode] [nvarchar](200) NOT NULL,
	[selling_price] [decimal](10, 2) NOT NULL,
	[quantity] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesReturnDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_SuppliersList]    Script Date: 04/24/2017 12:49:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[ERP_Get_SuppliersList]
@UserAccount varchar(50)
AS
BEGIN
	DECLARE @txt nvarchar(500)
	SELECT [SupplierID]
      ,[SupplierCode]
      ,[SupplierName]
      ,[ContactName]
      ,[ContactTitle]
      ,[Address]
      ,[City]
      ,[Region]
      ,[PostalCode]
      ,[Country]
      ,[Phone1]
      ,[Phone2]
      ,[Fax]
      ,[WebSite]
      ,[ContactEmail]
  FROM [dbo].[Suppliers]

	SET @txt='ALL Suppliers list accessed.'
	EXEC ERP_Insert_AuditLog @UserAccount, @txt
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_SupplierById]    Script Date: 04/24/2017 12:49:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[ERP_Get_SupplierById]
@UserAccount nvarchar(50)
,@SupplierId integer
as
BEGIN
Declare @txt nvarchar(500)
SELECT [SupplierID]
      ,[SupplierCode]
      ,[SupplierName]
      ,[ContactName]
      ,[ContactTitle]
      ,[Address]
      ,[City]
      ,[PostalCode]
      ,[Country]
      ,[Phone1]
      ,[Phone2]
      ,[Fax]
      ,[WebSite]
      ,[ContactEmail]
FROM Suppliers
where SupplierId =@SupplierId 
SET @txt=' Supplier accessed:' + CAST(@SupplierId as nvarchar(50))
	EXEC ERP_Insert_AuditLog @UserAccount, @txt
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_ProductList]    Script Date: 04/24/2017 12:49:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Proc [dbo].[ERP_Get_ProductList]
@UserAccount varchar(50)
AS
BEGIN
	DECLARE @txt nvarchar(500)
	
	SELECT [ProductID]
      ,[ProductCode]
      ,[ProductName]
      ,[BarCode]
      ,[CategoryName]
      ,[SupplierName]
      ,pm.[UOM]
      ,[company_price]
      ,[RePOorderLevel]
      ,[RePOorderQuantity]
      ,[ReSOorderLevel]
      ,[ReSOorderQuantity]
  FROM [dbo].[ProductMaster] pm
  INNER JOIN CategoryMaster cm on cm.CategoryID=pm.categoryId
  INNER JOIN Suppliers sm on sm.SupplierID =pm.SupplierId
  Left Join Unit_Master um on um.uom_code =pm.UOM
	SET @txt='ALL Product list accessed.'
	EXEC ERP_Insert_AuditLog @UserAccount, @txt
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_Menu]    Script Date: 04/24/2017 12:49:05 ******/
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
 from menus m Where ModuleID in(
 Select ModuleID from  PermissionMaster pm
 Inner join PermissionRoleMapping rm on rm.PermissionID=pm.PermissionId and RoleID=@RoleID
 )
 and isEnabled=1 
 
END

--select * from PermissionRoleMapping
--select * from PermissionMaster
--select * from Menus

--[dbo].[ERP_Get_Menu] 'abc',2
GO
/****** Object:  StoredProcedure [dbo].[ERP_SAVE_Suppliers]    Script Date: 04/24/2017 12:49:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_SAVE_Suppliers]
	@UserAccount nvarchar(50),
	@SupplierId int,
	@SupplierCode nvarchar(50),
	@SupplierName nvarchar(50),
	@ContactName nvarchar(50),
	@ContactTitle nvarchar(50),
	@Address nvarchar(50),
	@City nvarchar(50),
	@PostalCode nvarchar(24),
	@Country nvarchar(50),
	@Phone1 nvarchar(24),
	@Phone2 nvarchar(24),
	@Fax nvarchar(24),
	@Website nvarchar(50),
	@ContactEmail nvarchar(24),
	@ReturnValue int output 
AS
BEGIN
 SET NOCOUNT ON
DECLARE @txt nVarchar(500)
BEGIN TRY
IF Exists ( Select 1 from Suppliers where SupplierID=@SupplierId)
	BEGIN
	 Update Suppliers Set
	 SupplierName=@SupplierName,
	 ContactName=@ContactName,
	 ContactTitle=@ContactTitle,
	 Address=@Address,
	 City=@City,
	 PostalCode=@PostalCode,
	 Country=@Country,
	 Phone1=@Phone1,
	 Phone2=@Phone2,
	 Fax=@Fax,
	 Website=@Website,
	 ContactEmail=@ContactEmail,
	 ModifiedBy=@UserAccount,
	 Modifieddate=getdate()
	 WHERE SupplierID=@SupplierId and SupplierCode=@SupplierCode
	 
	 SET @ReturnValue=@SupplierId

	SET @txt='Updated Supplier named :'+ @SupplierName
	EXEC ERP_Insert_AuditLog @UserAccount, @txt

	END
ELSE
	BEGIN
	 --Insert
	 IF NOT Exists(Select 1 from Suppliers where SupplierCode=@SupplierCode)
	BEGIN
		INSERT INTO [dbo].[Suppliers]
           ([SupplierCode]
           ,[SupplierName]
           ,[ContactName]
           ,[ContactTitle]
           ,[Address]
           ,[City]
           ,[PostalCode]
           ,[Country]
           ,[Phone1]
           ,[Phone2]
           ,[Fax]
           ,[WebSite]
           ,[ContactEmail]
           ,[CreatedBy]
           ,[CreatedDate]
           )
     VALUES
           (
           @SupplierCode
           ,@SupplierName
           ,@ContactName
           ,@ContactTitle
           ,@Address
           ,@City
           ,@PostalCode
           ,@Country
           ,@Phone1
           ,@Phone2
           ,@Fax
           ,@Website
           ,@ContactEmail
           ,@UserAccount
           ,GETDATE()
           )
	 
	 SET @ReturnValue=@@IDENTITY
	 SET @txt='Inserted Supplier named: '+ @SupplierName
	 EXEC ERP_Insert_AuditLog @UserAccount, @txt
	 END
	 ELSE
	 BEGIN
	 
	   SET @ReturnValue= -99 -- code exists
	 
	 END
  END


END TRY

BEGIN CATCH
	SET @ReturnValue= -9
	EXEC [ERP_Insert_ErrorLog] @UserAccount, Error_Message
END CATCH;


END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Save_Product]    Script Date: 04/24/2017 12:49:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Save_Product]
@UserAccount nvarchar(50),
@ProductId integer,
@ProductCode nvarchar(50),
@ProductName nvarchar(50),
@UOM nvarchar(50),
@barcode nvarchar(25),
@CategoryId int,
@SupplierId int,
@CompanyPrice decimal,
@RePOorderLevel int,
@RePOorderQuantity int,
@ReturnValue int output

as
BEGIN
	SET NOCOUNT ON
	DECLARE @txt nVarchar(500)
	BEGIN TRY
	 IF NOT Exists(Select 1 from ProductMaster where ProductCode=@ProductCode)
	 BEGIN
		IF NOT Exists(Select 1 from ProductMaster where ProductID=@ProductID)
		BEGIN
			INSERT INTO [dbo].[ProductMaster]
           ([ProductCode]
           ,[ProductName]
           ,[BarCode]
           ,[categoryId]
           ,[SupplierId]
          
           ,[UOM]
           ,[company_price]
         
           ,[RePOorderLevel]
           ,[RePOorderQuantity]
           --,[ReSOorderLevel]
           --,[ReSOorderQuantity]
        
           ,[CreatedBy]
           ,[Createddate]
           )
     VALUES
           (@ProductCode
           ,@ProductName
           ,@barcode
           ,@CategoryId
           ,@SupplierId
           ,@UOM
           ,@companyprice
           ,@RePOorderLevel
           ,@RePOorderQuantity
           --,@ReSOorderLevel, int,>
           --,@ReSOorderQuantity, int,>
        
           ,@UserAccount
           ,GETDATE()
          )
			 SET @ReturnValue=@@IDENTITY
			 SET @txt='Inserted Product named: '+ @ProductName
			 EXEC ERP_Insert_AuditLog @UserAccount, @txt
		  END
		ELSE
		BEGIN
			UPDATE [dbo].[ProductMaster]
			SET 
			[ProductName] = @ProductName
			,BarCode = @barcode
			,CategoryId=@CategoryId
			,SupplierId=@SupplierId
			,company_price=@CompanyPrice
			,RePOorderLevel=@RePOorderLevel
			,RePOorderQuantity=@RePOorderQuantity
			--,ReSOorderQuantity=@ReSOorderQuantity
			,UOM=@UOM
			,ModifiedBy=@UserAccount
			,ModifiedDate=GETDATE()
			WHERE ProductID=@ProductId and ProductCode=@ProductCode

			SET @ReturnValue=@ProductId

			SET @txt='Updated Product named :'+ @ProductName
			EXEC ERP_Insert_AuditLog @UserAccount, @txt
	 
	   END
	 END
	 ELSE
	 BEGIN
		SET @ReturnValue= -99 -- code exists
	 END
	END TRY
BEGIN CATCH
	SET @ReturnValue= -9
	EXEC [ERP_Insert_ErrorLog] @UserAccount, Error_Message
END CATCH;
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Save_Category]    Script Date: 04/24/2017 12:49:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Save_Category]
@CategoryId integer,
@CategoryCode nvarchar(50),
@CategoryName nvarchar(50),
@Description nvarchar(500),
@UserAccount nvarchar(50),
@ReturnValue int output

as
BEGIN
	SET NOCOUNT ON
	DECLARE @txt nVarchar(500)
	BEGIN TRY
	IF NOT Exists(Select 1 from CategoryMaster where CategoryID=@CategoryId)
		BEGIN
		 IF NOT Exists(Select 1 from CategoryMaster where CategoryCode=@CategoryCode)
	     BEGIN
			INSERT INTO [dbo].CategoryMaster
					   ([CategoryCode]
					   ,[CategoryName]
					   ,[Description]
					   ,[CreatedBy]
					   ,[CreatedDate]
					   
					   )
				 VALUES
					   (
					   @CategoryCode,
					   @CategoryName,
					   @Description
					   ,@UserAccount
					   ,GETDATE()
					   )
			 SET @ReturnValue=@@IDENTITY
			 SET @txt='Inserted category named: '+ @CategoryName
			 EXEC ERP_Insert_AuditLog @UserAccount, @txt
		   END
	     ELSE
		 BEGIN
			SET @ReturnValue= -99 -- code exists
		 END
	   END
		ELSE
		BEGIN
			UPDATE [dbo].CategoryMaster
			SET 
			[CategoryName] = @CategoryName
			,[Description] = @Description
			,ModifiedBy=@UserAccount
			,ModifiedDate=GETDATE()
			WHERE CategoryID=@CategoryId and CategoryCode=@CategoryCode

			SET @ReturnValue=@CategoryId 

			SET @txt='Updated category named :'+ @CategoryName
			EXEC ERP_Insert_AuditLog @UserAccount, @txt
	 
	   END
	
	
	
	END TRY
BEGIN CATCH
	SET @ReturnValue= -9
	EXEC [ERP_Insert_ErrorLog] @UserAccount, Error_Message
END CATCH;
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Is_Role_HasPermission]    Script Date: 04/24/2017 12:49:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[ERP_Is_Role_HasPermission]
@UserAccount nvarchar(50)
,@RoleId int
,@PermissionName nvarchar(100)
AS
BEGIN
	DECLARE @PermissionExists bit
	IF EXISTS( SELECT 1 FROM PermissionMaster PM INNER JOIN PermissionRoleMapping RM on PM.PermissionId=RM.PermissionID 
	WHERE RoleID=@RoleId and PermissionName=@PermissionName)
		SET @PermissionExists=1
	ELSE
		SET @PermissionExists=0
	
 SELECT @PermissionExists AS IsPermissionExists
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Delete_Supplier]    Script Date: 04/24/2017 12:49:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[ERP_Delete_Supplier]
@UserAccount varchar(50)
,@SupplierId integer
,@ReturnValue int output
as
BEGIN
Declare @SupplierName nvarchar(50)
BEGIN TRY
	SElect @SupplierName=SupplierName  From Suppliers where SupplierID=@SupplierId 
	 
	 DELETE Suppliers where SupplierID=@SupplierId 
	 
	 SET @SupplierName='Supplier deleted: '+ @SupplierName
	 
	 EXEC ERP_Insert_AuditLog @UserAccount, @SupplierName
	 SET @ReturnValue=@SupplierId
END TRY
BEGIN CATCH
	SET @ReturnValue= -9
	Declare @ErrorMessage nvarchar(4000)
	SET @ErrorMessage='Error No: '+ Cast(@@Error as Varchar(50))+ ' Error Message: ' + Error_Message()
	EXEC [ERP_Insert_ErrorLog] @UserAccount,'ERP_Delete_Supplier', @ErrorMessage 
END CATCH;
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Delete_Category]    Script Date: 04/24/2017 12:49:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Delete_Category]
@UserAccount varchar(50)
,@CategoryId integer
,@ReturnValue int output
as
BEGIN
Declare @CategoryName nvarchar(50)
BEGIN TRY
	SElect @CategoryName=CategoryName  From CategoryMaster where CategoryId=@CategoryId 
	 
	 DELETE CategoryMaster where CategoryID=@CategoryId
	 
	 SET @CategoryName='Category deleted: '+ @CategoryName
	 
	 EXEC ERP_Insert_AuditLog @UserAccount, @CategoryName
	 SET @ReturnValue=@CategoryId
END TRY
BEGIN CATCH
	SET @ReturnValue= -9
	Declare @ErrorMessage nvarchar(4000)
	SET @ErrorMessage='Error No: '+ Cast(@@Error as Varchar(50))+ ' Error Message: ' + Error_Message()
	EXEC [ERP_Insert_ErrorLog] @UserAccount,'ERP_Delete_Category', @ErrorMessage 
END CATCH;
END
GO
/****** Object:  Table [dbo].[Purchase]    Script Date: 04/24/2017 12:49:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchase](
	[Stock_Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NOT NULL,
	[POInvoiceNo] [nvarchar](50) NOT NULL,
	[InvoiceDate] [datetime] NULL,
	[Lot] [nvarchar](50) NULL,
	[PONumber] [nvarchar](50) NOT NULL,
	[SupplierID] [int] NULL,
	[ReceivedDate] [datetime] NULL,
	[StockAcceptedBy] [nvarchar](50) NULL,
	[SubtotalAmount] [decimal](10, 2) NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[PaymentDueDate] [datetime] NULL,
	[BalanceAmount] [decimal](10, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[POStatus] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
	[TaxAmount] [decimal](10, 2) NULL,
	[PercentDiscount] [decimal](10, 2) NULL,
	[FixedDiscount] [decimal](10, 2) NULL,
	[DeliveryCharges] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Stock_Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY],
 CONSTRAINT [Purchase_StoreID_Lot_Unique] UNIQUE NONCLUSTERED 
(
	[StoreID] ASC,
	[Lot] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[ProductsForSale]    Script Date: 04/24/2017 12:49:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductsForSale](
	[ProductAvID] [int] IDENTITY(1,1) NOT NULL,
	[ProductCode] [nvarchar](50) NOT NULL,
	[BarCode] [nvarchar](50) NULL,
	[StoreID] [int] NOT NULL,
	[UnitsInStock] [int] NULL,
	[selling_price] [decimal](10, 2) NULL,
	[UnitsOnSO] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NOT NULL,
	[FixedDiscount] [decimal](10, 2) NULL,
	[PercentDiscount] [decimal](10, 2) NULL,
	[Lot] [nvarchar](50) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductAvID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DAILY]
) ON [DAILY]
GO
/****** Object:  Table [dbo].[PO_HEAD]    Script Date: 04/24/2017 12:49:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PO_HEAD](
	[PO_Id] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NOT NULL,
	[PONumber] [nvarchar](50) NOT NULL,
	[SupplierID] [int] NULL,
	[ExpectedDeliveryDate] [datetime] NULL,
	[SubtotalAmount] [decimal](10, 2) NULL,
	[TaxAmount] [decimal](10, 2) NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[POStatus] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
	[DeliveryCharges] [decimal](10, 2) NULL,
	[FixedDiscount] [decimal](10, 2) NULL,
	[PercentDiscount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[PO_Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[PurchaseReturn]    Script Date: 04/24/2017 12:49:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseReturn](
	[PurchaseReturnID] [int] IDENTITY(1,1) NOT NULL,
	[Stock_Id] [int] NOT NULL,
	[StoreID] [int] NULL,
	[Lot] [nvarchar](50) NULL,
	[DebitInvoiceNumber] [nvarchar](50) NOT NULL,
	[SubtotalAmount] [decimal](10, 2) NULL,
	[TaxAmount] [decimal](10, 2) NULL,
	[TotalAmount] [decimal](10, 2) NOT NULL,
	[PaymentReceiveDueDate] [datetime] NULL,
	[PaymentDueDate] [datetime] NULL,
	[BalanceAmount] [decimal](10, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseReturnID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY],
 CONSTRAINT [PurchaseReturn_StoreID_Lot_Unique] UNIQUE NONCLUSTERED 
(
	[StoreID] ASC,
	[Lot] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[PurchaseDetails]    Script Date: 04/24/2017 12:49:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseDetails](
	[PurchaseDetailId] [int] IDENTITY(1,1) NOT NULL,
	[Stock_Id] [int] NOT NULL,
	[Lot] [nvarchar](50) NULL,
	[ProductCode] [nvarchar](50) NOT NULL,
	[ProductID] [nvarchar](100) NOT NULL,
	[BarCode] [nvarchar](50) NULL,
	[OriginalQuantityReceived] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[Expiredate] [date] NULL,
	[UOM] [nvarchar](50) NULL,
	[company_price] [decimal](10, 2) NOT NULL,
	[opening_stock] [int] NOT NULL,
	[closing_stock] [int] NOT NULL,
	[SubtotalAmount] [decimal](10, 2) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
	[TotalAmount] [decimal](10, 2) NOT NULL,
	[TaxAmount] [decimal](10, 2) NULL,
	[PercentDiscount] [decimal](10, 2) NULL,
	[FixedDiscount] [decimal](10, 2) NULL,
	[DeliveryCharges] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[PurchaseReturnDetail]    Script Date: 04/24/2017 12:49:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseReturnDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseReturnID] [int] NOT NULL,
	[ProductCode] [nvarchar](50) NOT NULL,
	[BarCode] [nvarchar](50) NULL,
	[quantity] [int] NOT NULL,
	[SubtotalAmount] [decimal](10, 2) NULL,
	[TaxAmount] [decimal](10, 2) NULL,
	[TotalAmount] [decimal](10, 2) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 04/24/2017 12:49:13 ******/
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
/****** Object:  Default [DF__Suppliers__AutoA__19DFD96B]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[Suppliers] ADD  DEFAULT ((0)) FOR [AutoApprovePO]
GO
/****** Object:  Default [DF__Suppliers__AutoS__1AD3FDA4]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[Suppliers] ADD  DEFAULT ((0)) FOR [AutoSendPO]
GO
/****** Object:  Default [DF__Suppliers__LockS__1BC821DD]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[Suppliers] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__DocumentR__LockS__7D439ABD]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[DocumentNoSetting] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__DocumentR__Delet__7E37BEF6]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[DocumentNoSetting] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__DocumentR__IsAut__7F2BE32F]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[DocumentNoSetting] ADD  DEFAULT ((1)) FOR [IsAutoGenerated]
GO
/****** Object:  Default [DF__CustomerM__AutoA__797309D9]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[CustomerMaster] ADD  DEFAULT ((0)) FOR [AutoApproveSO]
GO
/****** Object:  Default [DF__CustomerM__AutoS__7A672E12]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[CustomerMaster] ADD  DEFAULT ((0)) FOR [AutoSendSO]
GO
/****** Object:  Default [DF__CustomerM__LockS__7B5B524B]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[CustomerMaster] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__CustomerM__Delet__7C4F7684]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[CustomerMaster] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Categories_LockStatus]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[CategoryMaster] ADD  CONSTRAINT [DF_Categories_LockStatus]  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF_Categories_Deleted]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[CategoryMaster] ADD  CONSTRAINT [DF_Categories_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_AuditLog_Deleted]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[AuditLog] ADD  CONSTRAINT [DF_AuditLog_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__PO_Detail__LockS__00200768]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[PO_Detail] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__PO_Detail__Delet__01142BA1]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[PO_Detail] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__sales__LockStatu__10566F31]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[sales] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__sales__Deleted__114A936A]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[sales] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__SalesRetu__LockS__14270015]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[SalesReturn] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__SalesRetu__Delet__151B244E]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[SalesReturn] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__SalesDeta__LockS__123EB7A3]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[SalesDetail] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__SalesDeta__Delet__1332DBDC]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[SalesDetail] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__ProductMa__AutoP__03F0984C]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[ProductMaster] ADD  DEFAULT ((0)) FOR [AutoPO]
GO
/****** Object:  Default [DF__ProductMa__AutoS__04E4BC85]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[ProductMaster] ADD  DEFAULT ((0)) FOR [AutoSO]
GO
/****** Object:  Default [DF__ProductMa__LockS__05D8E0BE]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[ProductMaster] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__ProductMa__Disco__06CD04F7]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[ProductMaster] ADD  DEFAULT ((0)) FOR [Discontinued]
GO
/****** Object:  Default [DF__Stores__LockStat__17F790F9]    Script Date: 04/24/2017 12:49:03 ******/
ALTER TABLE [dbo].[Stores] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__Stores__Deleted__18EBB532]    Script Date: 04/24/2017 12:49:03 ******/
ALTER TABLE [dbo].[Stores] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__SalesRetu__LockS__160F4887]    Script Date: 04/24/2017 12:49:03 ******/
ALTER TABLE [dbo].[SalesReturnDetail] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__SalesRetu__Delet__17036CC0]    Script Date: 04/24/2017 12:49:03 ******/
ALTER TABLE [dbo].[SalesReturnDetail] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__Purchase__LockSt__08B54D69]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[Purchase] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__Purchase__Delete__09A971A2]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[Purchase] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__ProductsF__Delet__07C12930]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[ProductsForSale] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__PO_HEAD__LockSta__02084FDA]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PO_HEAD] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__PO_HEAD__Deleted__02FC7413]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PO_HEAD] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__PurchaseR__LockS__0C85DE4D]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PurchaseReturn] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__PurchaseR__Delet__0D7A0286]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PurchaseReturn] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__PurchaseD__LockS__0A9D95DB]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PurchaseDetails] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__PurchaseD__Delet__0B91BA14]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PurchaseDetails] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__PurchaseR__LockS__0E6E26BF]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PurchaseReturnDetail] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__PurchaseR__Delet__0F624AF8]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PurchaseReturnDetail] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Check [CK_Birthdate]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[EmployeeMaster]  WITH NOCHECK ADD  CONSTRAINT [CK_Birthdate] CHECK  (([BirthDate]<getdate()))
GO
ALTER TABLE [dbo].[EmployeeMaster] CHECK CONSTRAINT [CK_Birthdate]
GO
/****** Object:  ForeignKey [FK_Employees_Employees]    Script Date: 04/24/2017 12:48:18 ******/
ALTER TABLE [dbo].[EmployeeMaster]  WITH NOCHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([ReportsTo])
REFERENCES [dbo].[EmployeeMaster] ([EmployeeID])
GO
ALTER TABLE [dbo].[EmployeeMaster] CHECK CONSTRAINT [FK_Employees_Employees]
GO
/****** Object:  ForeignKey [fk_SalesReturn]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[SalesReturn]  WITH CHECK ADD  CONSTRAINT [fk_SalesReturn] FOREIGN KEY([SaleId])
REFERENCES [dbo].[sales] ([Saleid])
GO
ALTER TABLE [dbo].[SalesReturn] CHECK CONSTRAINT [fk_SalesReturn]
GO
/****** Object:  ForeignKey [FK_sales_SalesDetail]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[SalesDetail]  WITH CHECK ADD  CONSTRAINT [FK_sales_SalesDetail] FOREIGN KEY([Saleid])
REFERENCES [dbo].[sales] ([Saleid])
GO
ALTER TABLE [dbo].[SalesDetail] CHECK CONSTRAINT [FK_sales_SalesDetail]
GO
/****** Object:  ForeignKey [FK_CateryMaster_ProductMaster]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[ProductMaster]  WITH CHECK ADD  CONSTRAINT [FK_CateryMaster_ProductMaster] FOREIGN KEY([categoryId])
REFERENCES [dbo].[CategoryMaster] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductMaster] CHECK CONSTRAINT [FK_CateryMaster_ProductMaster]
GO
/****** Object:  ForeignKey [FK_Supplier_ProductMaster]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[ProductMaster]  WITH CHECK ADD  CONSTRAINT [FK_Supplier_ProductMaster] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[ProductMaster] CHECK CONSTRAINT [FK_Supplier_ProductMaster]
GO
/****** Object:  ForeignKey [FK__Permissio__Modul__1DB06A4F]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[PermissionMaster]  WITH CHECK ADD FOREIGN KEY([ModuleId])
REFERENCES [dbo].[Menus] ([ModuleID])
GO
/****** Object:  ForeignKey [FK__Permissio__Modul__3E1D39E1]    Script Date: 04/24/2017 12:49:00 ******/
ALTER TABLE [dbo].[PermissionMaster]  WITH CHECK ADD FOREIGN KEY([ModuleId])
REFERENCES [dbo].[Menus] ([ModuleID])
GO
/****** Object:  ForeignKey [Stores_CompanyID_FK]    Script Date: 04/24/2017 12:49:03 ******/
ALTER TABLE [dbo].[Stores]  WITH CHECK ADD  CONSTRAINT [Stores_CompanyID_FK] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[CompanyMaster] ([CompanyID])
GO
ALTER TABLE [dbo].[Stores] CHECK CONSTRAINT [Stores_CompanyID_FK]
GO
/****** Object:  ForeignKey [FK_sales_Scrap]    Script Date: 04/24/2017 12:49:03 ******/
ALTER TABLE [dbo].[Scrap]  WITH CHECK ADD  CONSTRAINT [FK_sales_Scrap] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[Scrap] CHECK CONSTRAINT [FK_sales_Scrap]
GO
/****** Object:  ForeignKey [Scrap_categoryId_FK]    Script Date: 04/24/2017 12:49:03 ******/
ALTER TABLE [dbo].[Scrap]  WITH CHECK ADD  CONSTRAINT [Scrap_categoryId_FK] FOREIGN KEY([categoryId])
REFERENCES [dbo].[CategoryMaster] ([CategoryID])
GO
ALTER TABLE [dbo].[Scrap] CHECK CONSTRAINT [Scrap_categoryId_FK]
GO
/****** Object:  ForeignKey [Scrap_SupplierID_FK]    Script Date: 04/24/2017 12:49:03 ******/
ALTER TABLE [dbo].[Scrap]  WITH CHECK ADD  CONSTRAINT [Scrap_SupplierID_FK] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Scrap] CHECK CONSTRAINT [Scrap_SupplierID_FK]
GO
/****** Object:  ForeignKey [fk_SalesReturnDetail]    Script Date: 04/24/2017 12:49:03 ******/
ALTER TABLE [dbo].[SalesReturnDetail]  WITH CHECK ADD  CONSTRAINT [fk_SalesReturnDetail] FOREIGN KEY([SalesReturnId])
REFERENCES [dbo].[SalesReturn] ([SalesReturnId])
GO
ALTER TABLE [dbo].[SalesReturnDetail] CHECK CONSTRAINT [fk_SalesReturnDetail]
GO
/****** Object:  ForeignKey [Purchase_StoreID_FK]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD  CONSTRAINT [Purchase_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[Purchase] CHECK CONSTRAINT [Purchase_StoreID_FK]
GO
/****** Object:  ForeignKey [Purchase_SupplierID_FK]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD  CONSTRAINT [Purchase_SupplierID_FK] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Purchase] CHECK CONSTRAINT [Purchase_SupplierID_FK]
GO
/****** Object:  ForeignKey [FK_Stores_ProductsForSale]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[ProductsForSale]  WITH CHECK ADD  CONSTRAINT [FK_Stores_ProductsForSale] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[ProductsForSale] CHECK CONSTRAINT [FK_Stores_ProductsForSale]
GO
/****** Object:  ForeignKey [PO_HEAD_StoreID_FK]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PO_HEAD]  WITH CHECK ADD  CONSTRAINT [PO_HEAD_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[PO_HEAD] CHECK CONSTRAINT [PO_HEAD_StoreID_FK]
GO
/****** Object:  ForeignKey [PO_HEAD_SupplierID_FK]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PO_HEAD]  WITH CHECK ADD  CONSTRAINT [PO_HEAD_SupplierID_FK] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[PO_HEAD] CHECK CONSTRAINT [PO_HEAD_SupplierID_FK]
GO
/****** Object:  ForeignKey [FK_Stores_PurchaseReturn]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PurchaseReturn]  WITH CHECK ADD  CONSTRAINT [FK_Stores_PurchaseReturn] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[PurchaseReturn] CHECK CONSTRAINT [FK_Stores_PurchaseReturn]
GO
/****** Object:  ForeignKey [PurchaseReturn_Stock_Id_FK]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PurchaseReturn]  WITH CHECK ADD  CONSTRAINT [PurchaseReturn_Stock_Id_FK] FOREIGN KEY([Stock_Id])
REFERENCES [dbo].[Purchase] ([Stock_Id])
GO
ALTER TABLE [dbo].[PurchaseReturn] CHECK CONSTRAINT [PurchaseReturn_Stock_Id_FK]
GO
/****** Object:  ForeignKey [FK_Purchase_PurchaseDetails]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PurchaseDetails]  WITH CHECK ADD  CONSTRAINT [FK_Purchase_PurchaseDetails] FOREIGN KEY([Stock_Id])
REFERENCES [dbo].[Purchase] ([Stock_Id])
GO
ALTER TABLE [dbo].[PurchaseDetails] CHECK CONSTRAINT [FK_Purchase_PurchaseDetails]
GO
/****** Object:  ForeignKey [PurchaseReturnDetail_PurchaseReturnID_FK]    Script Date: 04/24/2017 12:49:09 ******/
ALTER TABLE [dbo].[PurchaseReturnDetail]  WITH CHECK ADD  CONSTRAINT [PurchaseReturnDetail_PurchaseReturnID_FK] FOREIGN KEY([PurchaseReturnID])
REFERENCES [dbo].[PurchaseReturn] ([PurchaseReturnID])
GO
ALTER TABLE [dbo].[PurchaseReturnDetail] CHECK CONSTRAINT [PurchaseReturnDetail_PurchaseReturnID_FK]
GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 04/24/2017 12:49:13 ******/
Enable Trigger [rds_deny_backups_trigger] ON Database
GO
