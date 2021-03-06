USE [master]
GO
/****** Object:  Database [ABCInventory]    Script Date: 06/05/2017 14:30:13 ******/
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
/****** Object:  User [hem]    Script Date: 06/05/2017 14:30:13 ******/
CREATE USER [hem] FOR LOGIN [hem] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Unit_Master NOT IN USE]    Script Date: 06/05/2017 14:30:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Unit_Master NOT IN USE](
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
INSERT [dbo].[Unit_Master NOT IN USE] ([Uom_Code], [Uom_Unit], [Uom_Desc], [CreatedDate], [CreatedBy], [ModifiedBy], [ModifiedDate]) VALUES (N'UM01', N'Piece', N'Product is sold in pieces', CAST(0x0000A76601750580 AS DateTime), N'Hem', NULL, NULL)
INSERT [dbo].[Unit_Master NOT IN USE] ([Uom_Code], [Uom_Unit], [Uom_Desc], [CreatedDate], [CreatedBy], [ModifiedBy], [ModifiedDate]) VALUES (N'UM02', N'Packet', N'Product is sold in packets having many pieces of product', CAST(0x0000A7660175569B AS DateTime), N'Hem', NULL, NULL)
INSERT [dbo].[Unit_Master NOT IN USE] ([Uom_Code], [Uom_Unit], [Uom_Desc], [CreatedDate], [CreatedBy], [ModifiedBy], [ModifiedDate]) VALUES (N'UM03', N'KG', N'Product is sold in weight', CAST(0x0000A76601758969 AS DateTime), N'Hem', NULL, NULL)
INSERT [dbo].[Unit_Master NOT IN USE] ([Uom_Code], [Uom_Unit], [Uom_Desc], [CreatedDate], [CreatedBy], [ModifiedBy], [ModifiedDate]) VALUES (N'UM04', N'Ltr', N'Product is sold in volume', CAST(0x0000A7660175C3B6 AS DateTime), N'Hem', NULL, NULL)
/****** Object:  StoredProcedure [dbo].[SP_CustomerInformation]    Script Date: 06/05/2017 14:30:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Sachin Sachan>  
-- Create date: <16-04-2017>  
-- Description: <Get The Customer Information>  
-- =============================================  
CREATE procedure [dbo].[SP_CustomerInformation]  
  
@StartRowIndex int=1,        
@MaxRows int=5,        
@OrderBy nvarchar(500) = 'CustomerID',        
@Order nvarchar(5)= 'ASC',
@CustomerID int=null,   
@CustomerCode varchar(50)=null,
@CompanyName varchar(40)=null,    
@ContactName1 nvarchar(30)=null, 
@City varchar(15)=null,
@PostalCode nvarchar(10)=null,    
@Country nvarchar(15)=null,    
@Phone nvarchar(24)=null,  
@State int=null,
@FromDate varchar(20) ='', 
@ToDate  varchar(20) =''   
 As  
 begin  
 Declare @Where nvarchar(max)='' 
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
  
  
  if(@CustomerCode!='' and @CustomerCode is not null)
			begin
			if (@Where is not null and @Where<>'')  
				begin
					 Set @Where= @Where +' And  CustomerCode='+@CustomerCode+''   
	            end	
	        else
				begin
					Set @Where= 'CustomerCode=''' +@CustomerCode+''''   
                end
        end
        
        if(@CompanyName!='' and @CompanyName is not null)
			begin
			if (@Where is not null and @Where<>'')  
				begin
					 Set @Where= @Where +' And  CompanyName='+@CompanyName+''   
	            end	
	        else
				begin
					Set @Where= 'CompanyName=''' +@CompanyName+''''   
                end
        end
        
        if(@ContactName1!='' and @ContactName1 is not null)
			begin
			if (@Where is not null and @Where<>'')  
				begin
					 Set @Where= @Where +' And  ContactName='+@ContactName1+''   
	            end	
	        else
				begin
					Set @Where= 'ContactName=''' +@ContactName1+''''   
                end
        end
        
        if(@Phone!='' and @Phone is not null)
			begin
			if (@Where is not null and @Where<>'')  
				begin
					 Set @Where= @Where +' And  Phone='+@Phone+''   
	            end	
	        else
				begin
					Set @Where= 'Phone=''' +@Phone+''''   
                end
        end
        
         if(@PostalCode!='' and @PostalCode is not null)
			begin
			if (@Where is not null and @Where<>'')  
				begin
					 Set @Where= @Where +' And  PostalCode='+@PostalCode+''   
	            end	
	        else
				begin
					Set @Where= 'PostalCode=''' +@PostalCode+''''   
                end
        end
        
        if(@Country!='' and @Country is not null)
			begin
			if (@Where is not null and @Where<>'')  
				begin
					 Set @Where= @Where +' And  Country='+@Country+''   
	            end	
	        else
				begin
					Set @Where= 'Country=''' +@Country+''''   
                end
        end
        
        if(@City!='' and @City is not null)
			begin
			if (@Where is not null and @Where<>'')  
				begin
					 Set @Where= @Where +' And  City='+@City+''   
	            end	
	        else
				begin
					Set @Where= 'City=''' +@City+''''   
                end
        end
        if(@State!='' and @State is not null)
			begin
            if (@Where is not null and @Where<>'')  
				begin
					Set @Where= @Where +' And  State='+Cast(@State as nvarchar(50))   
	            end
	        else
				begin
					Set @Where= 'State='+Cast(@State as nvarchar(50))
                end
            end      
            
            
           IF @FromDate is not null and ltrim(rtrim(@FromDate)) <>''       
    BEGIN        
     if (@Where is not null and @Where<>'')    
		BEGIN     
    SET @Where =@Where + ' AND cast(CreatedDate as date)>=''' + @FromDate + ''''   
    --Set @InnerDate =@InnerDate + ' AND cast(ParsedDate as date)>=''' + @ParsedDateFrom + ''''   
		END             
  else    
   BEGIN        
    SET @Where ='  cast(CreatedDate as date)>=''' + @FromDate + ''''    
    --SET @InnerDate ='cast(ParsedDate as date)>=''' + @ParsedDateFrom + ''''    
   END      
    END 
    
    
    IF @ToDate is not null and ltrim(rtrim(@ToDate)) <>''       
    BEGIN        
		if (@Where is not null and @Where<>'')    
			BEGIN     
		SET @Where =@Where + ' AND cast(CreatedDate as date)<=''' + @ToDate + ''''    
    --SET @InnerDate =@InnerDate + ' AND cast(ParsedDate as date)<=''' + @ParsedDateTo + ''''    
			END             
  else    
	BEGIN        
    SET @Where ='  cast(CreatedDate as date)<=''' + @ToDate + ''''    
    --SET @InnerDate ='cast(ParsedDate as date)<=''' + @ParsedDateTo + ''''    
	END      
  END 
            
            
   if((@CustomerCode='' or  @CustomerCode is  null) and (@CompanyName='' or  @CompanyName is  null)and  (@ContactName1='' or  @ContactName1 is  null)and  (@Phone='' or  @Phone is  null)and  (@PostalCode='' or  @PostalCode is  null)and  (@Country='' or  @Country is  null)and  (@State='' or  @State is  null)and  (@City='' or  @City is  null) and (@FromDate='' or  @FromDate is  null) and (@ToDate='' or  @ToDate is  null))
				begin
					Set @Where= '1=1'
                end
  
  
  Set @Query= 'select CustomerID, CustomerCode,CustomerBarCode, CompanyName, ContactName,ContactTitle, Address, City,  
     Region,RowNum   
              from(  
     select CustomerID, CustomerCode,CustomerBarCode, CompanyName, ContactName,ContactTitle, Address, City,  
     Region,ROW_NUMBER() OVER(ORDER BY '+@OrderBy+' '+@Order+') as RowNum      
     from CustomerMaster where '+@Where+')as  D  
     WHERE  RowNum BETWEEN '+ Cast(@StartID as nvarchar(15)) +' AND ('+ Cast(@EndID as nvarchar(15)) +')'    
  
  
  set @CountQuery = 'Select Count(*) as TotalRows from CustomerMaster where '+@Where+''    
        
  Exec(@Query)      
  Exec(@CountQuery)        
                 
END      
      
Print @Query
GO
/****** Object:  Table [dbo].[Shipping]    Script Date: 06/05/2017 14:30:51 ******/
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
/****** Object:  Table [dbo].[RoleMaster]    Script Date: 06/05/2017 14:30:51 ******/
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
/****** Object:  Table [dbo].[ProductPrice]    Script Date: 06/05/2017 14:30:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPrice](
	[ProductPriceId] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[PriceType] [decimal](10, 2) NULL,
	[Price] [decimal](10, 2) NULL,
	[FixedDiscountOnBuy] [decimal](10, 2) NULL,
	[PercentDiscountOnBuy] [decimal](10, 2) NULL,
	[FixedDiscountForSale] [decimal](10, 2) NULL,
	[PercentDiscountForSale] [decimal](10, 2) NULL,
	[Start_Date] [date] NULL,
	[End_Date] [date] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductPriceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tax_Master]    Script Date: 06/05/2017 14:30:51 ******/
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
/****** Object:  Table [dbo].[Suppliers NOT IN USE]    Script Date: 06/05/2017 14:30:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers NOT IN USE](
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
SET IDENTITY_INSERT [dbo].[Suppliers NOT IN USE] ON
INSERT [dbo].[Suppliers NOT IN USE] ([SupplierID], [SupplierCode], [SupplierName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone1], [Phone2], [Fax], [WebSite], [ContactEmail], [AutoApprovePO], [AutoApprovePOAmount], [AutoSendPO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (2, N'sa', N'AQWSD', N'ASD', N'DAWS', N'ASD', N'ASD', NULL, N'ASD', N'SDCF', N'DSF', N'DSF', N'DSF', N'grfdfg', N'fgddddddddddddd', 0, NULL, 0, N'abc@abc.com', CAST(0xB73C0B00 AS Date), N'abc@abc.com', CAST(0xB73C0B00 AS Date), 1)
INSERT [dbo].[Suppliers NOT IN USE] ([SupplierID], [SupplierCode], [SupplierName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone1], [Phone2], [Fax], [WebSite], [ContactEmail], [AutoApprovePO], [AutoApprovePOAmount], [AutoSendPO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (3, N'S0001', N'ABC', N'Ram', N'Mr.', N'', N'', NULL, N'', N'', N'', N'', N'', N'', N'Ram@abc.com', 0, NULL, 0, N'abc@abc.com', CAST(0xC93C0B00 AS Date), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Suppliers NOT IN USE] OFF
/****** Object:  Table [dbo].[Fin_Year_Master]    Script Date: 06/05/2017 14:30:51 ******/
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
/****** Object:  Table [dbo].[Menus]    Script Date: 06/05/2017 14:30:51 ******/
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
	[ShowInDashboard] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ModuleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Menus] ON
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (1, N'Admin', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (2, N'Purchase', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (3, N'Sale', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (4, N'Manage Category', 1, NULL, N'Index', N'Category', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (5, N'Manage Supplier', 1, NULL, N'Index', N'Supplier', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (6, N'Manage Purchase', 2, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (7, N'Purchase Return', 2, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (8, N'Manage Sale', 3, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (9, N'Sale Return', 3, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (10, N'Reports', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (11, N'Accounts', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (12, N'Sale Reports', 10, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (13, N'Purchase Reports', 10, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (14, N'Profit and Loss', 11, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (15, N'Manage Customer', 1, NULL, N'Index', N'Customer', 1, NULL, CAST(0x0000A75B014DB5F0 AS DateTime), NULL, CAST(0x0000A75B014DB5F0 AS DateTime), NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (16, N'Manage Products', 1, NULL, N'Index', N'Product', 1, NULL, CAST(0x0000A75C006B27D8 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (17, N'Manage Company', 1, NULL, N'Index', N'Company', 1, NULL, CAST(0x0000A75C006B27D8 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (18, N'Manage Company', 1, NULL, N'Index', N'Company', 1, NULL, CAST(0x0000A75C006B27D8 AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[Menus] ([ModuleID], [ModuleName], [ParentID], [Description], [ActionName], [ControllerName], [isEnabled], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [ShowInDashboard]) VALUES (19, N'Manage Stores', 1, NULL, N'Index', N'Stores', 1, NULL, CAST(0x0000A75C006B27D8 AS DateTime), NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Menus] OFF
/****** Object:  Table [dbo].[Lookup]    Script Date: 06/05/2017 14:30:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lookup](
	[LookupId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Text] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[Deleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[LookupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UC_Lookup] UNIQUE NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Lookup] ON
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (1, N'PO', N'Purchase Order', N'OrderType', N'Purchase Order', N'hem', CAST(0xC33C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (2, N'SO', N'Sale Order', N'OrderType', N'Sale Order', N'hem', CAST(0xC33C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (3, N'Quote', N'SO Quote', N'OrderType', N'Sale order Quote. just to provide our rates', N'hem', CAST(0xC33C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (4, N'Estimate', N'PO Estimate', N'OrderType', N'Purchase order. just to get rates from supplier', N'hem', CAST(0xC33C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (5, N'Adjust', N'Adjust Stock', N'OrderType', N'If some items are expired or damaged  and there is no return possible. put entry on scrap', N'hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (6, N'Transfer', N'Transfer From', N'OrderType', N'If some items need to transfer from one store to another store.  Use Transfer order', N'hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (7, N'POReady', N'PO Ready', N'POStatus', N'Purchase order is prepared.', N'hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (8, N'POSent', N'PO Sent', N'POStatus', N'Purchase order is sent to supplier.', N'hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (9, N'ItemReceived', N'Item Received', N'POStatus', N'Purchase order items received from supplier.', N'hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (10, N'ItemReturned', N'Item Returned', N'POStatus', N'Purchase order items returned to supplier.', N'hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (11, N'ItemPosted', N'Item Posted', N'POStatus', N'items posted to inventory. ready for sale.', N'hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (12, N'Billing', N'Billing Address', N'AddressType', N'Billing address', N'Hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (13, N'Shipping', N'Shipping Address', N'AddressType', N'Shipping address', N'Hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (14, N'Corporate', N'Corporate Address', N'AddressType', N'Corporate address', N'Hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (15, N'Customer', N'Customer', N'PartnerType', N'Partner is Customer', N'Hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (16, N'Supplier', N'Supplier', N'PartnerType', N'Partner is Supplier', N'Hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (17, N'CustomerSupplier', N'Customer and Supplier', N'PartnerType', N'Partner is Customer and Supplier', N'Hem', CAST(0xC43C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (18, N'ListPrice', N'MRP', N'PriceType', N'List Price is MRP', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (19, N'CostPrice', N'Cost Price', N'PriceType', N'Cost Price is price company pay to buy', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (20, N'RetailPrice', N'Retail Price', N'PriceType', N'Retail Price is price company sell items customer in retail market', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (21, N'SalePrice', N'Sale Price', N'PriceType', N'Sale Price is price company sell items to customer  in wholesale market', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (22, N'SpecialPrice', N'Special Price', N'PriceType', N'Special Price is price company sell items to customer  in Specialized market', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (23, N'UPC-A', N'UPC-A', N'BarCodeType', N'UPC standard A barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (24, N'UPC-E', N'UPC-E', N'BarCodeType', N'UPC standard E barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (25, N'UPC 2 Digit Ext', N'UPC 2 Digit Ext', N'BarCodeType', N'UPC standard E barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (26, N'UPC 5 Digit Ext', N'UPC 5 Digit Ext', N'BarCodeType', N'UPC standard 5 digit extended barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (27, N'EAN-13', N'EAN-13', N'BarCodeType', N'EAN-13 barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (28, N'JAN-13', N'JAN-13', N'BarCodeType', N'JAN-13 barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (29, N'EAN-8', N'EAN-8', N'BarCodeType', N'EAN-8 barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (30, N'ITF-14', N'ITF-14', N'BarCodeType', N'ITF-14 barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (31, N'Standard 2 of 5', N'Standard 2 of 5', N'BarCodeType', N'Standard 2 of 5 barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (32, N'Codabar', N'Codabar', N'BarCodeType', N'Codabar barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (33, N'Postnet', N'Postnet', N'BarCodeType', N'Postnet barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (34, N'Bookland-ISBN', N'Bookland-ISBN', N'BarCodeType', N'Bookland-ISBN barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (35, N'Code 11', N'Code 11', N'BarCodeType', N'Code 11 barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (36, N'Code 39', N'Code 39', N'BarCodeType', N'Code 39 barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (37, N'Code 39 Extended', N'Code 39 Extended', N'BarCodeType', N'Code 39 Extended barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (38, N'Code 93', N'Code 93', N'BarCodeType', N'Code 93 barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (39, N'Code 128', N'Code 128', N'BarCodeType', N'Code 128 barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (40, N'Code 128-A', N'Code 128-A', N'BarCodeType', N'Code 128-A barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (41, N'Code 128-B', N'Code 128-B', N'BarCodeType', N'Code 128-B barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (42, N'Code 128-C', N'Code 128-C', N'BarCodeType', N'Code 128-C barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (43, N'LOGMARS', N'LOGMARS', N'BarCodeType', N'LOGMARS barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (44, N'MSI', N'MSI', N'BarCodeType', N'MSI barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (45, N'Telepen', N'Telepen', N'BarCodeType', N'Telepen barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (46, N'FIM (Facing Identification Mark)', N'FIM (Facing Identification Mark)', N'BarCodeType', N'FIM (Facing Identification Mark) barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (47, N'Pharmacode', N'Pharmacode', N'BarCodeType', N'Pharmacode barcode', N'Hem', CAST(0xC93C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (48, N'Cash', N'Cash', N'ModeOfPayment', N'Mode of payment', N'Hem', CAST(0xCC3C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (49, N'Cheque', N'Cheque', N'ModeOfPayment', N'Mode of payment', N'Hem', CAST(0xCC3C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (50, N'CreditCard', N'Credit Card', N'ModeOfPayment', N'Mode of payment by credit card', N'Hem', CAST(0xCC3C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (51, N'UM01', N'Piece', N'UOM', N'Product is sold in pieces', N'Hem', CAST(0xCC3C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (52, N'UM02', N'Packet', N'UOM', N'Product is sold in packets having many pieces of product', N'Hem', CAST(0xCC3C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (53, N'UM03', N'KG', N'UOM', N'Product is sold in weight', N'Hem', CAST(0xCC3C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[Lookup] ([LookupId], [Code], [Text], [Type], [Description], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Deleted]) VALUES (54, N'UM04', N'Ltr', N'UOM', N'Product is sold in volume', N'Hem', CAST(0xCC3C0B00 AS Date), NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[Lookup] OFF
/****** Object:  UserDefinedFunction [dbo].[getTableRowCount]    Script Date: 06/05/2017 14:30:55 ******/
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
/****** Object:  Table [dbo].[permission_role_mapping]    Script Date: 06/05/2017 14:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permission_role_mapping](
	[MappingID] [int] IDENTITY(1,1) NOT NULL,
	[RoleID] [int] NOT NULL,
	[PermissionID] [int] NOT NULL,
	[Description] [nvarchar](50) NULL,
	[PermissionGranted] [bit] NULL,
 CONSTRAINT [PK_PermissionRoleMapping] PRIMARY KEY CLUSTERED 
(
	[MappingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[permission_role_mapping] ON
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (1, 1, 1, NULL, 1)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (2, 1, 2, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (4, 1, 3, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (5, 1, 4, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (6, 1, 5, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (7, 1, 6, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (8, 1, 7, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (9, 1, 8, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (10, 1, 9, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (11, 1, 10, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (12, 1, 11, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (13, 1, 12, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (14, 1, 13, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (15, 1, 14, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (16, 1, 15, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (17, 1, 16, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (18, 2, 9, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (19, 2, 10, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (20, 2, 11, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (21, 2, 12, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (22, 3, 13, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (23, 3, 14, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (24, 3, 15, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (25, 3, 16, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (26, 3, 1, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (27, 3, 2, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (28, 3, 3, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (29, 3, 4, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (30, 3, 9, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (31, 3, 10, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (32, 3, 11, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (33, 3, 12, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (34, 1, 17, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (35, 1, 18, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (36, 1, 19, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (37, 1, 20, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (38, 1, 21, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (39, 2, 17, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (40, 2, 1, NULL, NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (41, 1, 22, N'Read customer', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (42, 1, 23, N'UPDATE_CUSTOMER', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (43, 1, 24, N'CREATE_CUSTOMER', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (44, 1, 25, N'DELETE_CUSTOMER', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (45, 1, 26, N'Read product by admin', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (46, 1, 27, N'Create product by admin', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (47, 1, 28, N'update product by admin', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (48, 1, 29, N'delete product by admin', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (50, 1, 30, N'READ COMPANY', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (51, 1, 31, N'CREATE COMPANY', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (52, 1, 32, N'UPDATE COMPANY', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (53, 1, 33, N'READ STORES', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (54, 1, 34, N'READ CREATE', NULL)
INSERT [dbo].[permission_role_mapping] ([MappingID], [RoleID], [PermissionID], [Description], [PermissionGranted]) VALUES (55, 1, 35, N'READ UPDATE', NULL)
SET IDENTITY_INSERT [dbo].[permission_role_mapping] OFF
/****** Object:  Table [dbo].[ProductDetail]    Script Date: 06/05/2017 14:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetail](
	[ProductDetailId] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[AutoPO] [bit] NULL,
	[RePOorderLevel] [int] NULL,
	[RePOorderQuantity] [int] NULL,
	[ReSOorderLevel] [int] NULL,
	[ReSOorderQuantity] [int] NULL,
	[AutoSO] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[Discontinued] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ProductDetail] ON
INSERT [dbo].[ProductDetail] ([ProductDetailId], [ProductID], [StoreID], [AutoPO], [RePOorderLevel], [RePOorderQuantity], [ReSOorderLevel], [ReSOorderQuantity], [AutoSO], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Discontinued]) VALUES (1, 1, 1, 1, 100, 300, NULL, NULL, 0, N'HEM', CAST(0xCD3C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[ProductDetail] ([ProductDetailId], [ProductID], [StoreID], [AutoPO], [RePOorderLevel], [RePOorderQuantity], [ReSOorderLevel], [ReSOorderQuantity], [AutoSO], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Discontinued]) VALUES (2, 2, 1, 1, 100, 300, NULL, NULL, 0, N'HEM', CAST(0xCD3C0B00 AS Date), NULL, NULL, 0)
INSERT [dbo].[ProductDetail] ([ProductDetailId], [ProductID], [StoreID], [AutoPO], [RePOorderLevel], [RePOorderQuantity], [ReSOorderLevel], [ReSOorderQuantity], [AutoSO], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Discontinued]) VALUES (3, 3, 1, 1, 50, 200, NULL, NULL, 0, N'HEM', CAST(0xCD3C0B00 AS Date), N'HEM', CAST(0xCD3C0B00 AS Date), 1)
SET IDENTITY_INSERT [dbo].[ProductDetail] OFF
/****** Object:  Table [dbo].[DocumentMaster]    Script Date: 06/05/2017 14:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentMaster](
	[DocumentID] [smallint] IDENTITY(1,1) NOT NULL,
	[DocumentCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[IsAutoGenerated] [bit] NULL,
	[DocumentStoredPath] [nvarchar](100) NULL,
	[PreFix] [nvarchar](50) NOT NULL,
	[RunningNo] [int] NULL,
	[RunningNoLength] [int] NULL,
	[PaddingCharacter] [nvarchar](1) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
	[LevelOfApproval] [int] NULL,
	[TableName] [nvarchar](50) NULL,
	[CodeColumnName] [nvarchar](50) NULL,
	[DocumentType] [nvarchar](50) NULL,
	[TypeColumnName] [nvarchar](50) NULL,
 CONSTRAINT [PK_DocumentMaster] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_DocumentCode_DocumentMaster] UNIQUE NONCLUSTERED 
(
	[DocumentCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DocumentMaster] ON
INSERT [dbo].[DocumentMaster] ([DocumentID], [DocumentCode], [Description], [IsAutoGenerated], [DocumentStoredPath], [PreFix], [RunningNo], [RunningNoLength], [PaddingCharacter], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [LevelOfApproval], [TableName], [CodeColumnName], [DocumentType], [TypeColumnName]) VALUES (1, N'CategoryCode', N'Categorty', 1, NULL, N'CA', 1, 3, N'0', N'Hem', NULL, CAST(0x0000A76301495F28 AS DateTime), NULL, 1, 0, NULL, N'CategoryMaster', N'CategoryCode', NULL, NULL)
INSERT [dbo].[DocumentMaster] ([DocumentID], [DocumentCode], [Description], [IsAutoGenerated], [DocumentStoredPath], [PreFix], [RunningNo], [RunningNoLength], [PaddingCharacter], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [LevelOfApproval], [TableName], [CodeColumnName], [DocumentType], [TypeColumnName]) VALUES (2, N'POCode', N'Purchase Order', 1, NULL, N'PO', 1, 5, N'X', N'Hem', NULL, CAST(0x0000A763014A792F AS DateTime), NULL, 1, 0, 2, N'[Order]', N'OrderNumber', N'PO', N'OrderType')
INSERT [dbo].[DocumentMaster] ([DocumentID], [DocumentCode], [Description], [IsAutoGenerated], [DocumentStoredPath], [PreFix], [RunningNo], [RunningNoLength], [PaddingCharacter], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [LevelOfApproval], [TableName], [CodeColumnName], [DocumentType], [TypeColumnName]) VALUES (3, N'SOCode', N'Sale Order', 1, NULL, N'SO', 1, 5, N'0', N'Hem', NULL, CAST(0x0000A76D0139E3F3 AS DateTime), NULL, 1, 0, 1, N'[Order]', N'OrderNumber', N'SO', N'OrderType')
INSERT [dbo].[DocumentMaster] ([DocumentID], [DocumentCode], [Description], [IsAutoGenerated], [DocumentStoredPath], [PreFix], [RunningNo], [RunningNoLength], [PaddingCharacter], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [LevelOfApproval], [TableName], [CodeColumnName], [DocumentType], [TypeColumnName]) VALUES (4, N'QuoteCode', N'SO Quote', 1, NULL, N'Q', 1, 5, N'0', N'Hem', NULL, CAST(0x0000A76D013A6793 AS DateTime), NULL, 1, 0, 1, N'[Order]', N'OrderNumber', N'Quote', N'OrderType')
INSERT [dbo].[DocumentMaster] ([DocumentID], [DocumentCode], [Description], [IsAutoGenerated], [DocumentStoredPath], [PreFix], [RunningNo], [RunningNoLength], [PaddingCharacter], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [LevelOfApproval], [TableName], [CodeColumnName], [DocumentType], [TypeColumnName]) VALUES (5, N'EstimateCode', N'PO Estimate', 1, NULL, N'ES', 1, 5, N'0', N'Hem', NULL, CAST(0x0000A76D013AC23B AS DateTime), NULL, 1, 0, 1, N'[Order]', N'OrderNumber', N'Estimate', N'OrderType')
INSERT [dbo].[DocumentMaster] ([DocumentID], [DocumentCode], [Description], [IsAutoGenerated], [DocumentStoredPath], [PreFix], [RunningNo], [RunningNoLength], [PaddingCharacter], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [LevelOfApproval], [TableName], [CodeColumnName], [DocumentType], [TypeColumnName]) VALUES (6, N'AdjustCode', N'Adjust Stock', 1, NULL, N'AD', 1, 5, N'0', N'Hem', NULL, CAST(0x0000A76D013DA0C4 AS DateTime), NULL, 1, 0, 1, N'[Order]', N'OrderNumber', N'Adjust', N'OrderType')
INSERT [dbo].[DocumentMaster] ([DocumentID], [DocumentCode], [Description], [IsAutoGenerated], [DocumentStoredPath], [PreFix], [RunningNo], [RunningNoLength], [PaddingCharacter], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [LevelOfApproval], [TableName], [CodeColumnName], [DocumentType], [TypeColumnName]) VALUES (7, N'TransferCode', N'Transfer From', 1, NULL, N'TR', 1, 5, N'0', N'Hem', NULL, CAST(0x0000A76D013DE99C AS DateTime), NULL, 1, 0, 1, N'[Order]', N'OrderNumber', N'Transfer', N'OrderType')
INSERT [dbo].[DocumentMaster] ([DocumentID], [DocumentCode], [Description], [IsAutoGenerated], [DocumentStoredPath], [PreFix], [RunningNo], [RunningNoLength], [PaddingCharacter], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [LevelOfApproval], [TableName], [CodeColumnName], [DocumentType], [TypeColumnName]) VALUES (8, N'ProductCode', N'Product Code', 1, NULL, N'P', 1, 5, N'0', N'Hem', NULL, CAST(0x0000A76F0074D85D AS DateTime), NULL, 1, 0, NULL, N'ProductMaster', N'ProductCode', NULL, NULL)
INSERT [dbo].[DocumentMaster] ([DocumentID], [DocumentCode], [Description], [IsAutoGenerated], [DocumentStoredPath], [PreFix], [RunningNo], [RunningNoLength], [PaddingCharacter], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [LevelOfApproval], [TableName], [CodeColumnName], [DocumentType], [TypeColumnName]) VALUES (9, N'CustomerCode', N'Customer Code', 1, NULL, N'C', 1, 5, N'0', N'Hem', NULL, CAST(0x0000A76F00777FD8 AS DateTime), NULL, 1, 0, NULL, N'Partners', N'PartnerCode', N'Customer', N'PartnerType')
INSERT [dbo].[DocumentMaster] ([DocumentID], [DocumentCode], [Description], [IsAutoGenerated], [DocumentStoredPath], [PreFix], [RunningNo], [RunningNoLength], [PaddingCharacter], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [LevelOfApproval], [TableName], [CodeColumnName], [DocumentType], [TypeColumnName]) VALUES (10, N'SupplierCode', N'Supplier Code', 1, NULL, N'S', 1, 5, N'0', N'Hem', NULL, CAST(0x0000A76F0077D4A1 AS DateTime), NULL, 1, 0, NULL, N'Partners', N'PartnerCode', N'Supplier', N'PartnerType')
SET IDENTITY_INSERT [dbo].[DocumentMaster] OFF
/****** Object:  Table [dbo].[CustomerMaster NOT IN USE]    Script Date: 06/05/2017 14:30:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerMaster NOT IN USE](
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
	[State] [int] NULL,
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
SET IDENTITY_INSERT [dbo].[CustomerMaster NOT IN USE] ON
INSERT [dbo].[CustomerMaster NOT IN USE] ([CustomerID], [CustomerCode], [CustomerBarCode], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [AutoApproveSO], [AutoApproveSOAmount], [AutoSendSO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus], [Deleted], [State]) VALUES (2, N'424', N'24242', N'HCL', N'Sachin', N'PHP developer', N'Lucknow', N'4', N'Indian', N'76545', N'2', N'65665', N'17887', 1, CAST(1.70 AS Decimal(10, 2)), 1, N'87654', CAST(0x913B0B00 AS Date), N'6676', CAST(0x913B0B00 AS Date), 1, 1, 3)
INSERT [dbo].[CustomerMaster NOT IN USE] ([CustomerID], [CustomerCode], [CustomerBarCode], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [AutoApproveSO], [AutoApproveSOAmount], [AutoSendSO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus], [Deleted], [State]) VALUES (3, N'4546', N'46464', N'Spark', N'Rahul', N'JAVA developer', N'Lucknow', N'4', N'Indian', N'76545', N'2', N'768868', N'17887', 1, CAST(1.70 AS Decimal(10, 2)), 1, N'87654', CAST(0x913B0B00 AS Date), N'6676', CAST(0x913B0B00 AS Date), 1, 1, 2)
INSERT [dbo].[CustomerMaster NOT IN USE] ([CustomerID], [CustomerCode], [CustomerBarCode], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [AutoApproveSO], [AutoApproveSOAmount], [AutoSendSO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus], [Deleted], [State]) VALUES (7, N'338995', N'7567', N'STCSpark', N'RaAmithul', N'DOTNET developer', N'2', N'4', N'Indian', N'76545', N'2', N'242442424', N'17887', 1, CAST(1.70 AS Decimal(10, 2)), 1, N'87654', CAST(0x913B0B00 AS Date), N'6676', CAST(0x913B0B00 AS Date), 1, 1, 2)
INSERT [dbo].[CustomerMaster NOT IN USE] ([CustomerID], [CustomerCode], [CustomerBarCode], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [AutoApproveSO], [AutoApproveSOAmount], [AutoSendSO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus], [Deleted], [State]) VALUES (8, N'4334', N'34355', N'STCSpark', N'RaAmithul', N'DOTNET developer', N'3', N'4', N'Indian', N'76545', N'2', N'242442424', N'17887', 1, CAST(1.70 AS Decimal(10, 2)), 1, N'87654', CAST(0x913B0B00 AS Date), N'6676', CAST(0x913B0B00 AS Date), 1, 1, 2)
INSERT [dbo].[CustomerMaster NOT IN USE] ([CustomerID], [CustomerCode], [CustomerBarCode], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [AutoApproveSO], [AutoApproveSOAmount], [AutoSendSO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus], [Deleted], [State]) VALUES (9, N'47477', N'466', N'STCSpark', N'RaAmithul', N'DOTNET developer', N'4', N'4', N'Indian', N'76545', N'2', N'242442424', N'17887', 1, CAST(1.70 AS Decimal(10, 2)), 1, N'87654', CAST(0x913B0B00 AS Date), N'6676', CAST(0x913B0B00 AS Date), 1, 1, 2)
INSERT [dbo].[CustomerMaster NOT IN USE] ([CustomerID], [CustomerCode], [CustomerBarCode], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [AutoApproveSO], [AutoApproveSOAmount], [AutoSendSO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus], [Deleted], [State]) VALUES (10, N'45454', N'4546', N'TCS', N'Dileep', N'MEjento developer', N'4', N'2', N'Indian', N'76545', N'2', N'242442424', N'17887', 1, CAST(1.70 AS Decimal(10, 2)), 1, N'87654', CAST(0x913B0B00 AS Date), N'6676', CAST(0x913B0B00 AS Date), 1, 1, 3)
INSERT [dbo].[CustomerMaster NOT IN USE] ([CustomerID], [CustomerCode], [CustomerBarCode], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [AutoApproveSO], [AutoApproveSOAmount], [AutoSendSO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus], [Deleted], [State]) VALUES (11, N'3435', N'53535', N'SSS', N'ram', N'MEjento developer', N'4', N'3', N'Indian', N'76545', N'2', N'242442424', N'17887', 1, CAST(1.70 AS Decimal(10, 2)), 1, N'87654', CAST(0x913B0B00 AS Date), N'6676', CAST(0x9A3B0B00 AS Date), 1, 1, 2)
INSERT [dbo].[CustomerMaster NOT IN USE] ([CustomerID], [CustomerCode], [CustomerBarCode], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [AutoApproveSO], [AutoApproveSOAmount], [AutoSendSO], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus], [Deleted], [State]) VALUES (12, N'434', N'343434', N'SSS', N'ram', N'MEjento developer', N'4', N'3', N'Indian', N'76545', N'2', N'68886', N'17887', 1, CAST(1.70 AS Decimal(10, 2)), 1, N'87654', CAST(0xF53B0B00 AS Date), N'6676', CAST(0xB93B0B00 AS Date), 1, 1, 2)
SET IDENTITY_INSERT [dbo].[CustomerMaster NOT IN USE] OFF
/****** Object:  StoredProcedure [dbo].[ERP_Save_Customer]    Script Date: 06/05/2017 14:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sachin Sachan>
-- Create date: <23-04-2017>
-- Description:	<Add New Customer Information>
-- =============================================
create PROCEDURE [dbo].[ERP_Save_Customer]
(
@CustomerCode varchar(50),
@CustomerBarCode varchar(50),
@CompanyName varchar(40),
@ContactName varchar(30),
@ContactTitle varchar(30),
@Address nvarchar(60),
@City varchar(15), 
@Region nvarchar(15),
@PostalCode nvarchar(10),
@Country nvarchar(15),
@Phone nvarchar(24),
@Fax nvarchar(24),
@AutoApproveSO bit, 
@AutoApproveSOAmount decimal(10,2),
@AutoSendSO bit,
@CreatedBy nvarchar(50),
@CreatedDate date,
@ModifiedBy nvarchar(50),
@ModifiedDate date,
@LockStatus smallint,
@Deleted bit
)
As
Begin
Insert into CustomerMaster(CustomerCode,
CustomerBarCode,
CompanyName,
ContactName,
ContactTitle,
Address ,
City , 
Region ,
PostalCode ,
Country,
Phone,
Fax,
AutoApproveSO , 
AutoApproveSOAmount,
AutoSendSO ,
CreatedBy ,
CreatedDate,
ModifiedBy,
ModifiedDate,
LockStatus,
Deleted)
values
(@CustomerCode ,
@CustomerBarCode ,
@CompanyName ,
@ContactName,
@ContactTitle,
@Address,
@City, 
@Region,
@PostalCode,
@Country,
@Phone,
@Fax,
@AutoApproveSO , 
@AutoApproveSOAmount,
@AutoSendSO ,
@CreatedBy,
@CreatedDate,
@ModifiedBy,
@ModifiedDate,
@LockStatus,
@Deleted) 
End
GO
/****** Object:  Table [dbo].[current_document_routing]    Script Date: 06/05/2017 14:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[current_document_routing](
	[CurrentRoutingID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentNO] [nvarchar](50) NULL,
	[UserAccount] [nvarchar](50) NOT NULL,
	[RoutingOrder] [int] NULL,
	[ISCurrentApprover] [bit] NULL,
	[ISApproved] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_CurrentDocumentRouting] PRIMARY KEY CLUSTERED 
(
	[CurrentRoutingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[current_document_routing] ON
INSERT [dbo].[current_document_routing] ([CurrentRoutingID], [DocumentNO], [UserAccount], [RoutingOrder], [ISCurrentApprover], [ISApproved], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate]) VALUES (1, N'PO00001', N'abc@abc.com', 1, 1, NULL, N'Hem', NULL, CAST(0x0000A773008B12B2 AS DateTime), NULL)
INSERT [dbo].[current_document_routing] ([CurrentRoutingID], [DocumentNO], [UserAccount], [RoutingOrder], [ISCurrentApprover], [ISApproved], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate]) VALUES (2, N'PO00002', N'abc@abc.com', 1, 1, NULL, N'Hem', NULL, CAST(0x0000A773008B6BF3 AS DateTime), NULL)
INSERT [dbo].[current_document_routing] ([CurrentRoutingID], [DocumentNO], [UserAccount], [RoutingOrder], [ISCurrentApprover], [ISApproved], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate]) VALUES (3, N'PO00002', N'nih', 2, NULL, NULL, N'Hem', NULL, CAST(0x0000A773008B6BF3 AS DateTime), NULL)
INSERT [dbo].[current_document_routing] ([CurrentRoutingID], [DocumentNO], [UserAccount], [RoutingOrder], [ISCurrentApprover], [ISApproved], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate]) VALUES (4, N'PO00003', N'abc@abc.com', 1, 1, NULL, N'Hem', NULL, CAST(0x0000A773008BC9EC AS DateTime), NULL)
INSERT [dbo].[current_document_routing] ([CurrentRoutingID], [DocumentNO], [UserAccount], [RoutingOrder], [ISCurrentApprover], [ISApproved], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate]) VALUES (5, N'PO00003', N'nih', 2, NULL, NULL, N'Hem', NULL, CAST(0x0000A773008BC9EC AS DateTime), NULL)
INSERT [dbo].[current_document_routing] ([CurrentRoutingID], [DocumentNO], [UserAccount], [RoutingOrder], [ISCurrentApprover], [ISApproved], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate]) VALUES (6, N'PO00003', N'nih', 3, NULL, NULL, N'Hem', NULL, CAST(0x0000A773008BC9EC AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[current_document_routing] OFF
/****** Object:  Table [dbo].[CountryMaster]    Script Date: 06/05/2017 14:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryMaster](
	[CountryID] [int] IDENTITY(1,1) NOT NULL,
	[CountryCode] [nvarchar](50) NOT NULL,
	[CountryName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_CountryMaster] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_CountryCode_CountryMaster] UNIQUE NONCLUSTERED 
(
	[CountryCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CountryMaster] ON
INSERT [dbo].[CountryMaster] ([CountryID], [CountryCode], [CountryName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted]) VALUES (1, N'IND', N'India', NULL, NULL, NULL, CAST(0x0000A7630028CDD4 AS DateTime), CAST(0x0000A7630028CDD4 AS DateTime), 1, 0)
INSERT [dbo].[CountryMaster] ([CountryID], [CountryCode], [CountryName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted]) VALUES (2, N'NEP', N'Nepal', NULL, NULL, NULL, CAST(0x0000A763002902DA AS DateTime), CAST(0x0000A763002902DA AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[CountryMaster] OFF
/****** Object:  Table [dbo].[CompanyMaster]    Script Date: 06/05/2017 14:30:56 ******/
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
SET IDENTITY_INSERT [dbo].[CompanyMaster] ON
INSERT [dbo].[CompanyMaster] ([CompanyID], [CompanyCode], [CompanyName], [RegistrationNo], [Address], [City], [TIN], [Phone1], [Phone2], [website], [ContactEmail], [OwnedBy], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'LCG1', N'LCG Garment store', N'kkkkkkk', N'kjjj', N'lokklll', NULL, NULL, NULL, NULL, NULL, NULL, N'HEM', CAST(0xC93C0B00 AS Date), NULL, NULL)
INSERT [dbo].[CompanyMaster] ([CompanyID], [CompanyCode], [CompanyName], [RegistrationNo], [Address], [City], [TIN], [Phone1], [Phone2], [website], [ContactEmail], [OwnedBy], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, NULL, N'LCG Garment store', N'kkkkkkk', N'puuuta', N'nuuta', N'0978877878', N'9650290539', N'9876567654', N'www.google.com', N'sachin.sachan24@gmail.com', N'Sachin Sachan', N'Rahul Sachan', CAST(0xD93C0B00 AS Date), N'Mohan Kumar', CAST(0xD93C0B00 AS Date))
SET IDENTITY_INSERT [dbo].[CompanyMaster] OFF
/****** Object:  Table [dbo].[CategoryMaster]    Script Date: 06/05/2017 14:30:56 ******/
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
SET IDENTITY_INSERT [dbo].[CategoryMaster] ON
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryCode], [CategoryName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted]) VALUES (5, N'CA0001', N'Health', N'health products', N'abc@abc.com', NULL, CAST(0x0000A76E015D0C6C AS DateTime), NULL, 1, 0)
INSERT [dbo].[CategoryMaster] ([CategoryID], [CategoryCode], [CategoryName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted]) VALUES (6, N'c99', N'Clothes', N'Clothes to wear', N'abc@abc.com', NULL, CAST(0x0000A76E015D2D27 AS DateTime), NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[CategoryMaster] OFF
/****** Object:  Table [dbo].[AuditLog]    Script Date: 06/05/2017 14:30:56 ******/
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
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (30, N'abc@abc.com', N'ALL Product list accessed.', CAST(0x0000A76400BD0ABB AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (31, N'abc@abc.com', N'ALL Product list accessed.', CAST(0x0000A76401048C99 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (32, N'abc@abc.com', N'ALL Product list accessed.', CAST(0x0000A76500EDD153 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (33, N'abc@abc.com', N'ALL Suppliers list accessed.', CAST(0x0000A76601159E8D AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (34, N'abc@abc.com', N'Inserted category named: Health', CAST(0x0000A76E015D0C6C AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (35, N'abc@abc.com', N'Inserted category named: Clothes', CAST(0x0000A76E015D2D28 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (36, N'abc@abc.com', N'ALL Suppliers list accessed.', CAST(0x0000A76E015DD94C AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (37, N'abc@abc.com', N'Inserted Supplier named: ABC', CAST(0x0000A76E015E3306 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (38, N'abc@abc.com', N'ALL Suppliers list accessed.', CAST(0x0000A76E015E3A1E AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (39, N'Hem', N'Inserted Parner named: NIBIB NIH', CAST(0x0000A7710179B4AF AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (40, N'Hem', N'Inserted Parner named: NIBIB NIH', CAST(0x0000A771017F40C6 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (41, N'Hem', N'Inserted Parner named: LCG NIH', CAST(0x0000A772000C3B17 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (42, N'HEM', N'Inserted Product named: Boys T Shirt', CAST(0x0000A7720085E198 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (43, N'HEM', N'Inserted Product named: Girls T Shirt', CAST(0x0000A77200863F4C AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (44, N'HEM', N'Inserted Product named: Kids T Shirt', CAST(0x0000A77200867C21 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (45, N'HEM', N'Updated Product named :Infant T Shirt', CAST(0x0000A7720086DCBD AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (46, N'hem', N'Deleted Product named :Infant T Shirt', CAST(0x0000A77200877A45 AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (47, N'hem', N'ALL Product list accessed.', CAST(0x0000A772008FB82A AS DateTime), 0)
INSERT [dbo].[AuditLog] ([AuditID], [ActionDoneBy], [Description], [CreatedDate], [Deleted]) VALUES (48, N'hem', N'ALL Product list accessed.', CAST(0x0000A77200916C87 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[AuditLog] OFF
/****** Object:  StoredProcedure [dbo].[ERP_Edit_Customer]    Script Date: 06/05/2017 14:30:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Sachin Sachan>  
-- Create date: <25-04-2016>  
-- Description: <Edit Customer>  
-- =============================================  
CREATE PROCEDURE [dbo].[ERP_Edit_Customer]  
(  
@CustomerID int,  
@CustomerCode varchar(50),  
@CustomerBarCode varchar(50),  
@CompanyName varchar(40),  
@ContactName varchar(30),  
@ContactTitle varchar(30),  
@Address nvarchar(60),  
@City varchar(15),   
@Region nvarchar(15),  
@PostalCode nvarchar(10),  
@Country nvarchar(15),  
@Phone nvarchar(24),
@State int  
)  
As  
Begin  
Update CustomerMaster set   
CustomerCode=@CustomerCode,   
CustomerBarCode=@CustomerBarCode,  
CompanyName=@CompanyName,  
ContactName=@ContactName,  
ContactTitle=@ContactTitle,  
Address=@Address,  
City=@City,  
Region=@Region,  
PostalCode=@PostalCode,  
Country=@Country,  
Phone=@Phone,
State=@State where CustomerID= @CustomerID  
End
GO
/****** Object:  StoredProcedure [dbo].[ERP_DeleteCustomer]    Script Date: 06/05/2017 14:30:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sachin Sachan>
-- Create date: <26-04-2017>
-- Description:	<Delete Customer>
-- =============================================
CREATE PROCEDURE [dbo].[ERP_DeleteCustomer]
(
@CustomerID int
)
As
Begin
Delete from CustomerMaster where CustomerID=@CustomerID

End
GO
/****** Object:  Table [dbo].[EmployeeMaster]    Script Date: 06/05/2017 14:30:57 ******/
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
	[PrimaryEmail] [nvarchar](50) NULL,
	[AlternateEmail] [nvarchar](50) NULL,
	[PrimaryPhoneNo] [nvarchar](50) NULL,
	[AlternatePhoneNo] [nvarchar](50) NULL,
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
/****** Object:  StoredProcedure [dbo].[ERP_GetCustomer]    Script Date: 06/05/2017 14:30:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sachin Sachan>
-- Create date: <24-04-2017>
-- Description:	<Get Customer For Edit>
-- =============================================
create PROCEDURE [dbo].[ERP_GetCustomer]
(
@CustomerID int
)
As
    Begin
        Select * from CustomerMaster where CustomerID=@CustomerID
    End
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_CustomerInformation]    Script Date: 06/05/2017 14:30:59 ******/
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
/****** Object:  StoredProcedure [dbo].[ERP_Insert_ErrorLog]    Script Date: 06/05/2017 14:30:59 ******/
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
/****** Object:  StoredProcedure [dbo].[ERP_Insert_AuditLog]    Script Date: 06/05/2017 14:31:00 ******/
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
/****** Object:  StoredProcedure [dbo].[ERP_Get_CompanyByID]    Script Date: 06/05/2017 14:31:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sachin Sachan>
-- Create date: <25-05-2017>
-- Description:	<Get Company Details By ID>
-- =============================================
CREATE PROCEDURE [dbo].[ERP_Get_CompanyByID]
(
@UserAccount varchar(50)=null,
@CompanyID int=null
)
AS
BEGIN
	Select CompanyID, CompanyCode , CompanyName  ,  RegistrationNo, Address ,   City ,  TIN,  Phone1 ,  Phone2 ,   website ,   ContactEmail , OwnedBy    
	 from companymaster where CompanyID=@CompanyID

END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_Companies]    Script Date: 06/05/2017 14:31:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Sachin Sachan>  
-- Create date: <20-05-2017>  
-- Description: <Get Companies>  
-- =============================================  
CREATE PROCEDURE [dbo].[ERP_Get_Companies]  
(
@UserAccount varchar(50)=null
)
As  
 Begin  
          select CompanyID,   CompanyCode ,  CompanyName,  RegistrationNo ,  Address , City ,   TIN ,   Phone1 ,   Phone2 , website ,    ContactEmail , OwnedBy 
          from companymaster  
  
 End
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_CategoryById]    Script Date: 06/05/2017 14:31:01 ******/
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
/****** Object:  StoredProcedure [dbo].[ERP_Get_Categories]    Script Date: 06/05/2017 14:31:02 ******/
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
/****** Object:  StoredProcedure [dbo].[ERP_Get_LookUpData]    Script Date: 06/05/2017 14:31:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Get_LookUpData]
@Type nvarchar(50)
AS
BEGIN

SELECT Code, [Text] FROM Lookup
Where [TYPE]=@Type and Deleted=0

END
GO
/****** Object:  StoredProcedure [dbo].[ERP_GET_NextCode]    Script Date: 06/05/2017 14:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--ERP_GET_NextCode 'SupplierCode'
CREATE Proc [dbo].[ERP_GET_NextCode]
@DocumentCode varchar(50)
AS  
begin  
 DECLARE @TableName nvarchar(50),@CodeColumnName nvarchar(50),@DocumentType nvarchar(50) ,@TypeColumnName nvarchar(50)
 
 Declare @DocumentNo nvarchar(50)='',@RowCount int,@isAutoGenerated  bit,@PreFix varchar(30),@RunningNo int,@RunningNoLength int,@PaddingCharacter varchar(30)  
   
 Select @DocumentType=DocumentType,@CodeColumnName=CodeColumnName,@TableName=TableName,@TypeColumnName=TypeColumnName from DocumentMaster where DocumentCode=@DocumentCode
   
 SElect @isAutoGenerated=isAutoGenerated ,@PreFix=PreFix,@RunningNo=RunningNo,@RunningNoLength=RunningNoLength,@PaddingCharacter=PaddingCharacter  
 from DocumentMaster where DocumentCode=@DocumentCode  
    
    
 -- Document no  
 IF @isAutoGenerated=1  
 BEGIN  
  If  dbo.getTableRowCount(@TableName)>0   
  BEGIN  
   -- take document from table 
   DECLARE @ParmDefinition nvarchar(500);   
   Declare @sql nvarchar(2000)
    Declare @Code nvarchar(50)
    IF LEN(@TypeColumnName)>0  
		SET @sql= N'SELECT top 1 @Code_OUT ='+ @CodeColumnName +' from '+ @TableName +' WHERE '+ @TypeColumnName +' = '''+@DocumentType+'''  order by CreatedDate desc' 
	ELSE
		SET @sql= N'SELECT top 1 @Code_OUT ='+ @CodeColumnName +' from '+ @TableName + '  order by CreatedDate desc' 
   print @sql 
  SET @ParmDefinition = N'@Code_OUT varchar(30) OUTPUT';  
    
  EXECUTE sp_executesql @sql,@ParmDefinition, @Code_OUT=@Code OUTPUT;
    
  -- print @Code  
    
   SET @RunningNo=substring( @Code,Len(@Code)+1-@RunningNoLength,@RunningNoLength)  
  -- print @RunningNo
   SET @RunningNo=@RunningNo+1  
  END  
  select @documentNo= isNULL(@PreFix,'') + ISNULL( stuff(@RunningNo, 1, 0, replicate(@PaddingCharacter, @RunningNoLength - len(@RunningNo))),'')  
  --print @documentNo
 END  
  Select @documentNo  As Code
end
GO
/****** Object:  Table [dbo].[DocumentRouting]    Script Date: 06/05/2017 14:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentRouting](
	[RoutingID] [int] IDENTITY(1,1) NOT NULL,
	[UserAccount] [nvarchar](50) NOT NULL,
	[ApprovalAmount] [decimal](10, 2) NULL,
	[RoutingOrder] [int] NULL,
	[DocumentId] [smallint] NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_DocumentRouting] PRIMARY KEY CLUSTERED 
(
	[RoutingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[DocumentRouting] ON
INSERT [dbo].[DocumentRouting] ([RoutingID], [UserAccount], [ApprovalAmount], [RoutingOrder], [DocumentId], [Description]) VALUES (1, N'abc@abc.com', CAST(50000.00 AS Decimal(10, 2)), 1, 2, N'Approval 2 is required if amount is between  50,000 to 1,00,000')
INSERT [dbo].[DocumentRouting] ([RoutingID], [UserAccount], [ApprovalAmount], [RoutingOrder], [DocumentId], [Description]) VALUES (2, N'nih', CAST(100000.00 AS Decimal(10, 2)), 2, 2, N'Approval 2 is required if amount is between  1,00,000 to 2,00,000')
INSERT [dbo].[DocumentRouting] ([RoutingID], [UserAccount], [ApprovalAmount], [RoutingOrder], [DocumentId], [Description]) VALUES (3, N'nih', CAST(200000.00 AS Decimal(10, 2)), 3, 2, N'Approval 3 is required if amount is above 2,00,000')
SET IDENTITY_INSERT [dbo].[DocumentRouting] OFF
/****** Object:  Table [dbo].[PermissionMaster]    Script Date: 06/05/2017 14:31:03 ******/
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
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (30, N'READ_COMPANY', N'READ_COMPANY', 17)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (31, N'CREATE_COMPANY', N'CREATE COMPANY', 17)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (32, N'UPDATE_COMPANY', N'UPDATE COMPANY', 17)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (33, N'READ_Stores', N'READ_Stores', 19)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (34, N'Create_STORES', N'Create_STORES', 19)
INSERT [dbo].[PermissionMaster] ([PermissionId], [PermissionName], [Description], [ModuleId]) VALUES (35, N'Update_STORES', N'Update_STORES', 19)
SET IDENTITY_INSERT [dbo].[PermissionMaster] OFF
/****** Object:  Table [dbo].[Partners]    Script Date: 06/05/2017 14:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partners](
	[PartnerID] [int] IDENTITY(1,1) NOT NULL,
	[PartnerCode] [nvarchar](20) NULL,
	[PartnerType] [nvarchar](50) NULL,
	[PartnerName] [nvarchar](50) NOT NULL,
	[BarCode] [nvarchar](50) NULL,
	[WebSite] [nvarchar](50) NULL,
	[AutoApproveOrder] [bit] NULL,
	[AutoApproveOrderAmount] [decimal](10, 2) NULL,
	[AutoSendOrder] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
 CONSTRAINT [PK_Partners] PRIMARY KEY CLUSTERED 
(
	[PartnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Partners] ON
INSERT [dbo].[Partners] ([PartnerID], [PartnerCode], [PartnerType], [PartnerName], [BarCode], [WebSite], [AutoApproveOrder], [AutoApproveOrderAmount], [AutoSendOrder], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (1, N'S00001', N'Supplier', N'carters garments', N'9112345678', NULL, 1, CAST(50000.00 AS Decimal(10, 2)), 1, N'Hem', CAST(0xCA3C0B00 AS Date), NULL, NULL, 1)
INSERT [dbo].[Partners] ([PartnerID], [PartnerCode], [PartnerType], [PartnerName], [BarCode], [WebSite], [AutoApproveOrder], [AutoApproveOrderAmount], [AutoSendOrder], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (2, N'C00001', N'Customer', N'Sears garments', N'9112345678', NULL, 1, CAST(50000.00 AS Decimal(10, 2)), 1, N'Hem', CAST(0xCA3C0B00 AS Date), NULL, NULL, 1)
INSERT [dbo].[Partners] ([PartnerID], [PartnerCode], [PartnerType], [PartnerName], [BarCode], [WebSite], [AutoApproveOrder], [AutoApproveOrderAmount], [AutoSendOrder], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (3, N'C00002', N'Customer', N'Macy garments', N'9112345678', NULL, 1, CAST(50000.00 AS Decimal(10, 2)), 1, N'Hem', CAST(0xCA3C0B00 AS Date), NULL, NULL, 1)
INSERT [dbo].[Partners] ([PartnerID], [PartnerCode], [PartnerType], [PartnerName], [BarCode], [WebSite], [AutoApproveOrder], [AutoApproveOrderAmount], [AutoSendOrder], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (4, N'S00002', N'Supplier', N'Coat Factory', N'9112345678', NULL, 1, CAST(50000.00 AS Decimal(10, 2)), 1, N'Hem', CAST(0xCA3C0B00 AS Date), NULL, NULL, 1)
INSERT [dbo].[Partners] ([PartnerID], [PartnerCode], [PartnerType], [PartnerName], [BarCode], [WebSite], [AutoApproveOrder], [AutoApproveOrderAmount], [AutoSendOrder], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (9, N'S00003', N'Supplier', N'NIBIB NIH', NULL, N'nih.com', 0, NULL, 0, N'Hem', CAST(0xCC3C0B00 AS Date), NULL, NULL, 1)
INSERT [dbo].[Partners] ([PartnerID], [PartnerCode], [PartnerType], [PartnerName], [BarCode], [WebSite], [AutoApproveOrder], [AutoApproveOrderAmount], [AutoSendOrder], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (10, N'S00004', N'Supplier', N'LCG NIH', NULL, N'nih.com', 0, NULL, 0, N'Hem', CAST(0xCD3C0B00 AS Date), NULL, NULL, 1)
INSERT [dbo].[Partners] ([PartnerID], [PartnerCode], [PartnerType], [PartnerName], [BarCode], [WebSite], [AutoApproveOrder], [AutoApproveOrderAmount], [AutoSendOrder], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (11, N'S00005', N'Supplier', N'Partners Federal Credit Union', NULL, N'part.com', 0, NULL, 0, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Partners] ([PartnerID], [PartnerCode], [PartnerType], [PartnerName], [BarCode], [WebSite], [AutoApproveOrder], [AutoApproveOrderAmount], [AutoSendOrder], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (12, N'S00006', N'Supplier', N'Partners systems Ltd', NULL, N'part.com', 0, NULL, 0, NULL, NULL, NULL, NULL, 1)
INSERT [dbo].[Partners] ([PartnerID], [PartnerCode], [PartnerType], [PartnerName], [BarCode], [WebSite], [AutoApproveOrder], [AutoApproveOrderAmount], [AutoSendOrder], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [LockStatus]) VALUES (13, N'S00006', N'Supplier', N'Supplier', NULL, N'part.com', 0, NULL, 0, NULL, NULL, NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Partners] OFF
/****** Object:  UserDefinedFunction [dbo].[getDocumentNo]    Script Date: 06/05/2017 14:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getDocumentNo](@DocumentCode nvarchar(50),@TableName nvarchar(50),@CodeColumnName nvarchar(50),@DocumentType nvarchar(50))  
    RETURNS nVARCHAR(30)  
AS  
begin  
  
 Declare @DocumentNo nvarchar(50),@RowCount int,@isAutoGenerated  bit,@PreFix varchar(30),@RunningNo int,@RunningNoLength int,@PaddingCharacter varchar(30)  
   
 SElect @isAutoGenerated=isAutoGenerated ,@PreFix=PreFix,@RunningNo=RunningNo,@RunningNoLength=RunningNoLength,@PaddingCharacter=PaddingCharacter  
 from DocumentMaster where DocumentCode=@DocumentCode  
    
    
 -- Document no  
 IF @isAutoGenerated=1  
 BEGIN  
  If  dbo.getTableRowCount(@TableName)>0   
  BEGIN  
   -- take document from table 
   DECLARE @ParmDefinition nvarchar(500);   
   Declare @sql nvarchar(2000)
    Declare @Code nvarchar(50)  
   SET @sql='SELECT top 1'+ @Code +'='+ @CodeColumnName +' from '+ @TableName +' order by CreatedDate desc' 
  SET @ParmDefinition = N'@Code_OUT varchar(30) OUTPUT';  
  EXECUTE sp_executesql @sql,@ParmDefinition, @Code_OUT=@Code OUTPUT;
   --SElect top 1 @Code=CategoryCode from categoryMaster order by CreatedDate desc 
    
   --print @Code  
   --SElect @RunningNoLength=RunningNoLength from DocumentMaster where DocumentCode='CATEGORY'  
   --print @RunningNoLength  
   SET @RunningNo=substring( @Code,Len(@Code)+1-@RunningNoLength,@RunningNoLength)  
   SET @RunningNo=@RunningNo+1  
   --Print @RunningNo  
  END  
  select @documentNo= isNULL(@PreFix,'') + ISNULL( stuff(@RunningNo, 1, 0, replicate(@PaddingCharacter, @RunningNoLength - len(@RunningNo))),'')  
 END  
  
  
  return @documentNo  
end
GO
/****** Object:  Table [dbo].[Stores]    Script Date: 06/05/2017 14:31:03 ******/
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
SET IDENTITY_INSERT [dbo].[Stores] ON
INSERT [dbo].[Stores] ([StoreID], [StoreName], [Address], [City], [CompanyID], [ManagedBy], [Phone1], [Phone2], [Email], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [LockStatus], [Deleted]) VALUES (1, N'LCG Garment Rockville', NULL, N'ROckville', 1, NULL, NULL, NULL, NULL, N'HEM', CAST(0xC93C0B00 AS Date), NULL, NULL, 1, 0)
INSERT [dbo].[Stores] ([StoreID], [StoreName], [Address], [City], [CompanyID], [ManagedBy], [Phone1], [Phone2], [Email], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [LockStatus], [Deleted]) VALUES (2, N'LCG Garment Bethesda', NULL, N'Bethesda', 1, NULL, NULL, NULL, NULL, N'HEM', CAST(0xC93C0B00 AS Date), NULL, NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[Stores] OFF
/****** Object:  Table [dbo].[StateMaster]    Script Date: 06/05/2017 14:31:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StateMaster](
	[StateID] [int] IDENTITY(1,1) NOT NULL,
	[SateCode] [nvarchar](50) NOT NULL,
	[StateName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
	[CountryID] [int] NULL,
 CONSTRAINT [PK_StateMaster] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_StateCode_StateMaster] UNIQUE NONCLUSTERED 
(
	[SateCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[StateMaster] ON
INSERT [dbo].[StateMaster] ([StateID], [SateCode], [StateName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [CountryID]) VALUES (1, N'UP', N'Uttar Pradesh', NULL, NULL, NULL, CAST(0x0000A76300297AE6 AS DateTime), CAST(0x0000A76300297AE6 AS DateTime), 1, 0, 1)
INSERT [dbo].[StateMaster] ([StateID], [SateCode], [StateName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [CountryID]) VALUES (2, N'MP', N'Madhya Pradesh', NULL, NULL, NULL, CAST(0x0000A76300299436 AS DateTime), CAST(0x0000A76300299436 AS DateTime), 1, 0, 1)
INSERT [dbo].[StateMaster] ([StateID], [SateCode], [StateName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [CountryID]) VALUES (3, N'MH', N'Maharashtra', NULL, NULL, NULL, CAST(0x0000A7630029B335 AS DateTime), CAST(0x0000A7630029B335 AS DateTime), 1, 0, 2)
INSERT [dbo].[StateMaster] ([StateID], [SateCode], [StateName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [CountryID]) VALUES (4, N'RJ', N'Rajasthan', NULL, NULL, NULL, CAST(0x0000A7630029D68B AS DateTime), CAST(0x0000A7630029D68B AS DateTime), 1, 0, 2)
SET IDENTITY_INSERT [dbo].[StateMaster] OFF
/****** Object:  StoredProcedure [dbo].[ERP_Save_DocumentRouting]    Script Date: 06/05/2017 14:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Save_DocumentRouting]
@UserAccount nvarchar(50),
@DocumentNo nVarchar(50),
@Amount decimal(10,2)
AS
BEGIN
 SET NOCount ON
	INSERT INTO [dbo].[CurrentDocumentRouting]
           ([DocumentNO]
           ,[UserAccount]
           ,[RoutingOrder]
           ,[ISCurrentApprover]
           ,[ISApproved]
           ,[CreatedBy]
           ,[CreatedDate]
           )
           
	SELECT @DocumentNo,
			UserAccount,
			RoutingOrder,
			NULL,
			NULL,
			@UserAccount,
			GETDATE()
	FROM [DocumentRouting] 
	WHERE ApprovalAmount <=@Amount
           
    UPDATE [CurrentDocumentRouting]
    SET [ISCurrentApprover]=1
    where [DocumentNO]=@DocumentNo and RoutingOrder=1

END
GO
/****** Object:  Table [dbo].[Scrap]    Script Date: 06/05/2017 14:31:04 ******/
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
/****** Object:  Table [dbo].[TransactionDetail]    Script Date: 06/05/2017 14:31:04 ******/
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
	[StoreID] [int] NOT NULL,
 CONSTRAINT [PK_TransactionDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DAILY]
) ON [DAILY]
GO
/****** Object:  Table [dbo].[Purchase]    Script Date: 06/05/2017 14:31:04 ******/
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
/****** Object:  Table [dbo].[ProductsForSale]    Script Date: 06/05/2017 14:31:04 ******/
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
	[UnitsOnSO] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NOT NULL,
	[UnitsOnPO] [int] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductAvID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DAILY]
) ON [DAILY]
GO
/****** Object:  Table [dbo].[ProductMaster]    Script Date: 06/05/2017 14:31:04 ******/
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
	[UOM] [nvarchar](50) NULL,
	[LockStatus] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[Discontinued] [bit] NOT NULL,
	[PartnerID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ProductMaster] ON
INSERT [dbo].[ProductMaster] ([ProductID], [ProductCode], [ProductName], [BarCode], [categoryId], [UOM], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Discontinued], [PartnerID]) VALUES (1, N'P00001', N'Boys T Shirt', NULL, 6, N'Piece', 1, N'HEM', CAST(0xCD3C0B00 AS Date), NULL, NULL, 0, 1)
INSERT [dbo].[ProductMaster] ([ProductID], [ProductCode], [ProductName], [BarCode], [categoryId], [UOM], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Discontinued], [PartnerID]) VALUES (2, N'P00002', N'Girls T Shirt', NULL, 6, N'Piece', 1, N'HEM', CAST(0xCD3C0B00 AS Date), NULL, NULL, 0, 1)
INSERT [dbo].[ProductMaster] ([ProductID], [ProductCode], [ProductName], [BarCode], [categoryId], [UOM], [LockStatus], [CreatedBy], [Createddate], [ModifiedBy], [ModifiedDate], [Discontinued], [PartnerID]) VALUES (3, N'P00003', N'Infant T Shirt', NULL, 6, N'Piece', 1, N'HEM', CAST(0xCD3C0B00 AS Date), N'HEM', CAST(0xCD3C0B00 AS Date), 1, 1)
SET IDENTITY_INSERT [dbo].[ProductMaster] OFF
/****** Object:  Table [dbo].[sales]    Script Date: 06/05/2017 14:31:04 ******/
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
	[StoreID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Saleid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DAILY]
) ON [DAILY]
GO
/****** Object:  Table [dbo].[Order_Detail]    Script Date: 06/05/2017 14:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Detail](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductCode] [nvarchar](50) NOT NULL,
	[ProductID] [nvarchar](100) NOT NULL,
	[BarCode] [nvarchar](50) NULL,
	[quantity] [int] NOT NULL,
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
	[StoreID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 06/05/2017 14:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NOT NULL,
	[OrderNumber] [nvarchar](50) NOT NULL,
	[SupplierID] [int] NULL,
	[ExpectedDeliveryDate] [datetime] NULL,
	[SubtotalAmount] [decimal](10, 2) NULL,
	[TaxAmount] [decimal](10, 2) NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[Note] [nvarchar](500) NULL,
	[OrderStatus] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[Createddate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
	[FixedDiscount] [decimal](10, 2) NULL,
	[PercentDiscount] [decimal](10, 2) NULL,
	[OrderType] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  StoredProcedure [dbo].[ERP_Save_Company]    Script Date: 06/05/2017 14:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Save_Company]  
(
@CompanyID int=null,  
@UserAccount varchar(50)=null,  
@CompanyCode varchar(50)=null,    
@CompanyName nvarchar(50)=null,    
@RegistrationNo nvarchar(50)=null,   
@Address nvarchar(500)=null,    
@City nvarchar(50)=null,   
@TIN nvarchar(50)='0978877878',   
@Phone1 nvarchar(50) ='9650290539',  
@Phone2 nvarchar(50) ='9876567654',  
@website nvarchar(50) ='www.google.com',  
@ContactEmail nvarchar(50) ='sachin.sachan24@gmail.com',  
@OwnedBy nvarchar(50) ='Sachin Sachan',  
@CreatedBy nvarchar(50) ='Rahul Sachan',  
@CreatedDate datetime =null,   
@ModifiedBy nvarchar(50) ='Mohan Kumar',   
@ModifiedDate datetime =null,
@Flag varchar(10)=null , 
@ReturnValue int output 
)  
as    
BEGIN 
Declare @txt nvarchar(100)
DECLARE @DetailedErrorDesc nvarchar(500)
BEGIN TRY
if(@Flag='I')
	Begin
	IF NOT Exists(Select CompanyID from companymaster where CompanyID=@CompanyID)  
	  BEGIN  
	   IF NOT Exists(Select CompanyCode from companymaster where CompanyCode=@CompanyCode)  
		  BEGIN    
			insert into companymaster  
			(  
			CompanyCode,    
			CompanyName,    
			RegistrationNo,    
			Address,    
			City,    
			TIN,   
			Phone1,  
			Phone2,  
			website,  
			ContactEmail,  
			OwnedBy ,  
			CreatedBy,  
			CreatedDate,   
			ModifiedBy,   
			ModifiedDate)  
			values  
			(  
			@CompanyCode,    
			@CompanyName,    
			@RegistrationNo,    
			@Address,    
			@City,    
			@TIN,   
			@Phone1,  
			@Phone2,  
			@website,  
			@ContactEmail,  
			@OwnedBy,  
			@CreatedBy,  
			getdate(),   
			@ModifiedBy,   
			getdate()) 
			
			 SET @ReturnValue=@@IDENTITY
			 SET @txt='Inserted Company named: '+ @CompanyName
			 EXEC ERP_Insert_AuditLog @UserAccount, @txt
		 End
		ELSE
		BEGIN
			-- Code already exist
			SET @ReturnValue=-99;
		END
	end 
	else
	Begin
		
		UPDATE companymaster
	   SET [CompanyCode] = @CompanyCode  
		  ,[CompanyName] = @CompanyName
		  ,[RegistrationNo] = @RegistrationNo
		  ,[Address] =@Address
		  ,[City] = @City
		  ,[TIN] = @TIN
		  ,[Phone1] = @Phone1
		  ,[Phone2] = @Phone2
		  ,[website] = @website
		  ,[ContactEmail] = @ContactEmail
		  ,[OwnedBy] = @OwnedBy
		  ,[ModifiedBy] = @ModifiedBy
		  ,[ModifiedDate] = getdate()
	 WHERE CompanyID=@CompanyID
	 
		SET @ReturnValue=@CompanyName 
		SET @txt='Updated Company named :'+ @CompanyName
		EXEC ERP_Insert_AuditLog @UserAccount, @txt
		
	End
end

	

if(@Flag='D')
	Begin
	    delete from companymaster where CompanyID=@CompanyID
	    SET @ReturnValue=@CompanyName 
		SET @txt='Deleted Company named :'+ @CompanyName
		EXEC ERP_Insert_AuditLog @UserAccount, @txt
	End
	
END TRY
BEGIN CATCH
	SET @ReturnValue= -9
	SELECT @DetailedErrorDesc =         
	CAST(ERROR_NUMBER() AS VARCHAR) + ' : '+
	--CAST(ERROR_SEVERITY() AS VARCHAR) + ' : ' +
	--CAST(ERROR_STATE() AS VARCHAR) + ' : ' +
	ERROR_PROCEDURE() + ' : ' +
	ERROR_MESSAGE() + ' : ' +
	CAST(ERROR_LINE() AS VARCHAR);
	EXEC [ERP_Insert_ErrorLog] @UserAccount,'[ERP_Save_Company]', @DetailedErrorDesc
END CATCH;	
	
	
	
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Save_Category]    Script Date: 06/05/2017 14:31:05 ******/
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
	DECLARE @DetailedErrorDesc VARCHAR(5000)
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
	SELECT @DetailedErrorDesc =         
	CAST(ERROR_NUMBER() AS VARCHAR) + ' : '+
	--CAST(ERROR_SEVERITY() AS VARCHAR) + ' : ' +
	--CAST(ERROR_STATE() AS VARCHAR) + ' : ' +
	ERROR_PROCEDURE() + ' : ' +
	ERROR_MESSAGE() + ' : ' +
	CAST(ERROR_LINE() AS VARCHAR);
	EXEC [ERP_Insert_ErrorLog] @UserAccount,'[ERP_Save_Category]', @DetailedErrorDesc
END CATCH;
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Is_Role_HasPermission]    Script Date: 06/05/2017 14:31:05 ******/
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
	IF EXISTS( SELECT 1 FROM PermissionMaster PM INNER JOIN permission_role_mapping RM on PM.PermissionId=RM.PermissionID 
	WHERE RoleID=@RoleId and PermissionName=@PermissionName)
		SET @PermissionExists=1
	ELSE
		SET @PermissionExists=0
	
 SELECT @PermissionExists AS IsPermissionExists
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_SAVE_Suppliers]    Script Date: 06/05/2017 14:31:06 ******/
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
/****** Object:  Table [dbo].[CityMaster]    Script Date: 06/05/2017 14:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CityMaster](
	[CityID] [int] IDENTITY(1,1) NOT NULL,
	[CityCode] [nvarchar](50) NOT NULL,
	[CityName] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
	[LockStatus] [smallint] NULL,
	[Deleted] [bit] NULL,
	[StateID] [int] NULL,
 CONSTRAINT [PK_CityMaster] PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [Unique_CityCode_CityMaster] UNIQUE NONCLUSTERED 
(
	[CityCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[CityMaster] ON
INSERT [dbo].[CityMaster] ([CityID], [CityCode], [CityName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [StateID]) VALUES (1, N'CNB', N'Kanpur', NULL, NULL, NULL, CAST(0x0000A763002A9748 AS DateTime), CAST(0x0000A763002A9748 AS DateTime), 1, 0, 1)
INSERT [dbo].[CityMaster] ([CityID], [CityCode], [CityName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [StateID]) VALUES (2, N'LKO', N'Lucknow', NULL, NULL, NULL, CAST(0x0000A763002B13DF AS DateTime), CAST(0x0000A763002B13DF AS DateTime), 1, 0, 3)
INSERT [dbo].[CityMaster] ([CityID], [CityCode], [CityName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [StateID]) VALUES (3, N'BPL', N'Bhopal', NULL, NULL, NULL, CAST(0x0000A763002B73D6 AS DateTime), CAST(0x0000A763002B73D6 AS DateTime), 1, 0, 2)
INSERT [dbo].[CityMaster] ([CityID], [CityCode], [CityName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [StateID]) VALUES (4, N'JBP', N'Jabalpur', NULL, NULL, NULL, CAST(0x0000A763002BAA79 AS DateTime), CAST(0x0000A763002BAA79 AS DateTime), 1, 0, 4)
INSERT [dbo].[CityMaster] ([CityID], [CityCode], [CityName], [Description], [CreatedBy], [ModifiedBy], [CreatedDate], [ModifiedDate], [LockStatus], [Deleted], [StateID]) VALUES (5, N'PUNE', N'Pune', NULL, NULL, NULL, CAST(0x0000A763002BDA2D AS DateTime), CAST(0x0000A763002BDA2D AS DateTime), 1, 0, 4)
SET IDENTITY_INSERT [dbo].[CityMaster] OFF
/****** Object:  Table [dbo].[Address]    Script Date: 06/05/2017 14:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[PartnerID] [int] NOT NULL,
	[ContactName] [nvarchar](50) NULL,
	[ContactTitle] [nvarchar](50) NULL,
	[AddressType] [nvarchar](50) NULL,
	[StreetAddress] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](24) NULL,
	[Country] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[Phone1] [nvarchar](24) NULL,
	[Phone2] [nvarchar](24) NULL,
	[Fax] [nvarchar](24) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[ModifiedDate] [date] NULL,
	[State] [nvarchar](50) NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Address] ON
INSERT [dbo].[Address] ([AddressID], [PartnerID], [ContactName], [ContactTitle], [AddressType], [StreetAddress], [City], [Region], [PostalCode], [Country], [Email], [Phone1], [Phone2], [Fax], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [State]) VALUES (2, 9, N'LISA', N'Ms', N'Billing', N'6707 Democracy Blvd', N'Bethesda', NULL, N'20851', N'USA', N'abc@nih.com', N'7034620545', N'', N'', N'Hem', CAST(0xCC3C0B00 AS Date), NULL, NULL, NULL)
INSERT [dbo].[Address] ([AddressID], [PartnerID], [ContactName], [ContactTitle], [AddressType], [StreetAddress], [City], [Region], [PostalCode], [Country], [Email], [Phone1], [Phone2], [Fax], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [State]) VALUES (3, 10, N'LISA', N'Ms', N'Billing', N'6707 Democracy Blvd', N'Bethesda', NULL, N'20851', N'USA', N'abc@nih.com', N'7034620545', N'', N'', N'Hem', CAST(0xCD3C0B00 AS Date), NULL, NULL, NULL)
INSERT [dbo].[Address] ([AddressID], [PartnerID], [ContactName], [ContactTitle], [AddressType], [StreetAddress], [City], [Region], [PostalCode], [Country], [Email], [Phone1], [Phone2], [Fax], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [State]) VALUES (4, 13, N'Sarika sachan', N'ms', N'Billing', N'govind', N'Lucknow', NULL, N'209206', N'India', N'Sarika@nih.gov', N'123456789', N'34567890', N'6666666', NULL, NULL, NULL, NULL, N'UP')
INSERT [dbo].[Address] ([AddressID], [PartnerID], [ContactName], [ContactTitle], [AddressType], [StreetAddress], [City], [Region], [PostalCode], [Country], [Email], [Phone1], [Phone2], [Fax], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [State]) VALUES (5, 13, N'sachin sachan', N'Mr.', N'Corporate', N'vihar', N'Ghaziabad', NULL, N'206085', N'india', N'sachin@nih.gov', N'12345678', N'67890000', N'4444444444', NULL, NULL, NULL, NULL, N'UP')
INSERT [dbo].[Address] ([AddressID], [PartnerID], [ContactName], [ContactTitle], [AddressType], [StreetAddress], [City], [Region], [PostalCode], [Country], [Email], [Phone1], [Phone2], [Fax], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [State]) VALUES (6, 13, N'Abhi sachan', N'Mr.', N'Shipping', N'3455', N'Gurgoan NCR', NULL, N'2456789', N'India', N'Abhi@nih.gov', N'345656778', N'658768768', N'789000', NULL, NULL, NULL, NULL, N'Haryana')
SET IDENTITY_INSERT [dbo].[Address] OFF
/****** Object:  StoredProcedure [dbo].[ERP_Delete_Partners]    Script Date: 06/05/2017 14:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[ERP_Delete_Partners]
	@UserAccount nvarchar(50),
	@PartnerId int,
	@PartnerCode nvarchar(50)='',
	@ReturnValue int output 
AS
BEGIN
SET NOCOUNT ON
DECLARE @DetailedErrorDesc VARCHAR(5000)
DECLARE @txt nVarchar(500)

BEGIN TRY

	if @PartnerId>0
	BEGIN
		SELECT @PartnerCode=PartnerCode FROM Partners where PartnerID=@PartnerId
		Delete Partners where PartnerID=@PartnerId
	END
	Else if @PartnerCode>0
	BEGIN
		Delete Partners where PartnerCode=@PartnerCode
	END
	
	SET @PartnerCode='Partner Code deleted: '+ @PartnerCode
	EXEC ERP_Insert_AuditLog @UserAccount, @PartnerCode
	SET @ReturnValue=@PartnerId
	 
END TRY

BEGIN CATCH
	SET @ReturnValue= -9
	SELECT @DetailedErrorDesc =         
	CAST(ERROR_NUMBER() AS VARCHAR) + ' : '+
	--CAST(ERROR_SEVERITY() AS VARCHAR) + ' : ' +
	--CAST(ERROR_STATE() AS VARCHAR) + ' : ' +
	ERROR_PROCEDURE() + ' : ' +
	ERROR_MESSAGE() + ' : ' +
	CAST(ERROR_LINE() AS VARCHAR);
	EXEC [ERP_Insert_ErrorLog] @UserAccount,'[ERP_Delete_Partners]', @DetailedErrorDesc
END CATCH;


END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Delete_Category]    Script Date: 06/05/2017 14:31:07 ******/
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
/****** Object:  StoredProcedure [dbo].[ERP_Delete_Supplier]    Script Date: 06/05/2017 14:31:08 ******/
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
/****** Object:  StoredProcedure [dbo].[ERP_Get_Menu]    Script Date: 06/05/2017 14:31:08 ******/
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
 Inner join permission_role_mapping rm on rm.PermissionID=pm.PermissionId and RoleID=@RoleID
 )
 and isEnabled=1 
 
END

--select * from PermissionRoleMapping
--select * from PermissionMaster
--select * from Menus

--[dbo].[ERP_Get_Menu] 'abc',2
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_SuppliersList]    Script Date: 06/05/2017 14:31:09 ******/
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
/****** Object:  StoredProcedure [dbo].[ERP_Get_SupplierById]    Script Date: 06/05/2017 14:31:09 ******/
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
/****** Object:  StoredProcedure [dbo].[ERP_Get_Stores]    Script Date: 06/05/2017 14:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Sachin Sachan>
-- Create date: <03-06-2017>
-- Description:	<Get Stores Information>
-- =============================================
CREATE PROCEDURE [dbo].[ERP_Get_Stores]
(
@UserAccount varchar(50)=null
)
As
select * from Stores
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_PermissionByRole]    Script Date: 06/05/2017 14:31:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Select * from permission_role_mapping
/* This stored procedure is used  to show all the modules  */ 
CREATE Proc [dbo].[ERP_Get_PermissionByRole]
@RoleId int
AS
BEGIN

Create Table #Permission
(
	ModuleID int,
	ModuleName nvarchar(100),
	ReadPermissionId int,
	ReadPermission nvarchar(50),
	CreatePermission nvarchar(50),
	CreatePermissionId int,
	UpdatePermission nvarchar(50),
	UpdatePermissionId int,
	DeletePermission nvarchar(50),
	DeletePermissionId int
)

Insert into #Permission(ModuleID,ModuleName)
Select ModuleID,ModuleName
FROM Menus where isEnabled=1 and ParentID > 0

Update #Permission
SET ReadPermission= ISNULL(rm.PermissionGranted,0) , ReadPermissionId=rm.PermissionId
From #Permission p
inner join permissionmaster pm on p.ModuleID=pm.ModuleId and pm.PermissionName LIKE 'READ_%'
left Join permission_role_mapping rm on pm.PermissionId=rm.PermissionID --and RoleID=@RoleId
--where RoleID=@RoleId

Update #Permission
SET CreatePermission= ISNULL(rm.PermissionGranted,0), CreatePermissionId=pm.PermissionId
From #Permission p
inner join permissionmaster pm on p.ModuleID=pm.ModuleId and pm.PermissionName LIKE 'CREATE_%'
left Join permission_role_mapping rm on rm.PermissionID=pm.PermissionId
where RoleID=@RoleId

Update #Permission
SET UpdatePermission= ISNULL(rm.PermissionGranted,0) , UpdatePermissionId=pm.PermissionId
From #Permission p
inner join permissionmaster pm on p.ModuleID=pm.ModuleId and pm.PermissionName LIKE 'UPDATE_%'
left Join permission_role_mapping rm on rm.PermissionID=pm.PermissionId
where RoleID=@RoleId

Update #Permission
SET DeletePermission= ISNULL(rm.PermissionGranted,0), DeletePermissionId=pm.PermissionId
From #Permission p
inner join permissionmaster pm on p.ModuleID=pm.ModuleId and pm.PermissionName LIKE 'DELETE_%'
left Join permission_role_mapping rm on rm.PermissionID=pm.PermissionId
where RoleID=@RoleId

Select * from #Permission



END
GO
/****** Object:  StoredProcedure [dbo].[ERP_GetCountries]    Script Date: 06/05/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  <Sachin Sachan>  
-- Create date: <29-04-2017>  
-- Description: <Get Countries>  
-- =============================================  
CREATE PROCEDURE [dbo].[ERP_GetCountries]  
(  
@Flag varchar(10)=null,  
@CountryID int=null,  
@StateID int=null  
)  
As  
    Begin  
    if(@Flag='C')  
    Begin  
              Select * from CountryMaster  
    End  
    else  
     if(@Flag='S')  
    Begin  
              Select * from StateMaster where CountryID =@CountryID  
    End  
    else  
     if(@Flag='Ci')  
    Begin  
              Select * from CityMaster where StateID =@StateID  
    End  
    End
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_Partners]    Script Date: 06/05/2017 14:31:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Get_Partners]
	@UserAccount nvarchar(50),
	@PartnerId int=0,
	@PartnerType nvarchar(50),
	@PartnerCode nvarchar(50)=''
AS
BEGIN
SET NOCOUNT ON
DECLARE @DetailedErrorDesc VARCHAR(5000)
DECLARE @txt nVarchar(500)

BEGIN TRY

IF @PartnerId >0 OR Len(@PartnerCode)>0
BEGIN
	SELECT P.PartnerID,PartnerCode,PartnerType,PartnerName,BarCode,WebSite
	FROM Partners P 
	where (P.PartnerID=@PartnerId OR PartnerCode=@PartnerCode) and (PartnerType=@PartnerType)

	SELECT A.PartnerID,AddressID ,ContactName ,ContactTitle   , AddressType, StreetAddress,  City, PostalCode, Country, Email, Phone1,Phone2,Fax,[State]
	FROM Partners P INNER JOIN Address A on P.PartnerID=A.PartnerID
	where (P.PartnerID=@PartnerId OR PartnerCode=@PartnerCode) and (PartnerType=@PartnerType)
END
ELSE
BEGIN
	 SELECT P.PartnerID,PartnerCode,PartnerType,PartnerName,BarCode,WebSite
	 FROM Partners P 
	 where PartnerType=@PartnerType
	 
	 SELECT A.PartnerID,AddressID ,ContactName ,ContactTitle   , AddressType, StreetAddress,  City, PostalCode, Country, Email, Phone1,Phone2,Fax,[State]
	 FROM Partners P INNER JOIN Address A on P.PartnerID=A.PartnerID
	 where PartnerType=@PartnerType
END

END TRY

BEGIN CATCH
	--SET @ReturnValue= -9
	SELECT @DetailedErrorDesc =         
	CAST(ERROR_NUMBER() AS VARCHAR) + ' : '+
	--CAST(ERROR_SEVERITY() AS VARCHAR) + ' : ' +
	--CAST(ERROR_STATE() AS VARCHAR) + ' : ' +
	ERROR_PROCEDURE() + ' : ' +
	ERROR_MESSAGE() + ' : ' +
	CAST(ERROR_LINE() AS VARCHAR);
	EXEC [ERP_Insert_ErrorLog] @UserAccount,'[ERP_Get_Partners]', @DetailedErrorDesc
END CATCH;


END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Get_ProductList]    Script Date: 06/05/2017 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Proc [dbo].[ERP_Get_ProductList]
@UserAccount varchar(50),
@StoreId Int,
@ProductID int
AS
BEGIN
	DECLARE @txt nvarchar(500)
 IF @ProductID=0   --- All product
	 BEGIN
		SELECT pm.[ProductID]
		  ,[ProductCode]
		  ,[ProductName]
		  ,Pm.[BarCode]
		  ,[CategoryName]
		  ,[PartnerName] AS SupplierName
		  ,[UOM]
		  ,AutoPO
		  ,AutoSO
		  ,[RePOorderLevel]
		  ,[RePOorderQuantity]
	  FROM [dbo].[ProductMaster] pm
	  INNER Join ProductDetail PD on pd.ProductID=pm.ProductID and Pd.StoreID=@StoreId and Pd.Discontinued=0
	  INNER JOIN CategoryMaster cm on cm.CategoryID=pm.categoryId
	  INNER JOIN Partners sm on sm.PartnerID =pm.PartnerID and sm.PartnerType='Supplier'
	  END
ELSE
BEGIN
	SELECT pm.[ProductID]  -- Selected product
		  ,[ProductCode]
		  ,[ProductName]
		  ,Pm.[BarCode]
		  ,[CategoryName]
		  ,[PartnerName] AS SupplierName
		  ,[UOM]
		  ,AutoPO
		  ,AutoSO
		  ,[RePOorderLevel]
		  ,[RePOorderQuantity]
	  FROM [dbo].[ProductMaster] pm
	  INNER Join ProductDetail PD on pd.ProductID=pm.ProductID and Pd.StoreID=@StoreId and Pd.Discontinued=0
	  INNER JOIN CategoryMaster cm on cm.CategoryID=pm.categoryId
	  INNER JOIN Partners sm on sm.PartnerID =pm.PartnerID and sm.PartnerType='Supplier'
	  WHERE pm.PartnerID=@ProductID
END  

 
	SET @txt='ALL Product list accessed.'
	EXEC ERP_Insert_AuditLog @UserAccount, @txt
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Delete_Product]    Script Date: 06/05/2017 14:31:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_Delete_Product]
@UserAccount nvarchar(50),
@ProductId integer,
@StoreID int,
@ReturnValue int output
as
BEGIN
	SET NOCOUNT ON
	DECLARE @DetailedErrorDesc VARCHAR(5000)
	DECLARE @txt nVarchar(500)
	DECLARE @ProductName nvarchar(50)
	BEGIN TRY
		  Select @ProductName=ProductName from ProductMaster where ProductID=@ProductId
		  
		   UPDATE [dbo].[ProductDetail]
		   SET Discontinued=1
		   WHERE ProductID=@ProductId and [StoreID] = @StoreID
			
			IF NOT Exists(Select 1 from [ProductDetail] where ProductID=@ProductId  and Discontinued=0)
			BEGIN
				UPDATE ProductMaster Set Discontinued=1 where ProductID=@ProductId
			END
			
			SET @ReturnValue=@ProductId
			SET @txt='Deleted Product named :'+ @ProductName
			EXEC ERP_Insert_AuditLog @UserAccount, @txt
	 
	 
	END TRY
BEGIN CATCH
	SET @ReturnValue= -9
	SELECT @DetailedErrorDesc =         
	CAST(ERROR_NUMBER() AS VARCHAR) + ' : '+
	--CAST(ERROR_SEVERITY() AS VARCHAR) + ' : ' +
	--CAST(ERROR_STATE() AS VARCHAR) + ' : ' +
	ERROR_PROCEDURE() + ' : ' +
	ERROR_MESSAGE() + ' : ' +
	CAST(ERROR_LINE() AS VARCHAR);
	EXEC [ERP_Insert_ErrorLog] @UserAccount,'[ERP_Delete_Product]', @DetailedErrorDesc
END CATCH;
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Save_Product]    Script Date: 06/05/2017 14:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---- get product list
--EXEC [dbo].ERP_Get_ProductList 'hem',1, 0
-----------------deleting---------------------------------
--Declare @ReturnValue int
--EXEC [dbo].[ERP_Delete_Product] 'hem',3, 1, @ReturnValue output
-----------------saving ------------------------------------------
--Declare @ReturnValue int
--EXEC [dbo].[ERP_Save_Product]
--'HEM',
--3 ,
--'P00003',
--'Infant T Shirt',
--'Piece',
--NULL,
--6,
--1,
--1,
--50,
--200,
--1,
--0,
--@ReturnValue output



CREATE Proc [dbo].[ERP_Save_Product]
@UserAccount nvarchar(50),
@ProductId integer,
@ProductCode nvarchar(50),
@ProductName nvarchar(50),
@UOM nvarchar(50),
@barcode nvarchar(25),
@CategoryId int,
@PartnerId int,
@AutoPO bit,
@RePOorderLevel int,
@RePOorderQuantity int,
@StoreID int,
@AutoSO bit,
@ReturnValue int output

as
BEGIN
	SET NOCOUNT ON
	DECLARE @DetailedErrorDesc VARCHAR(5000)
	DECLARE @txt nVarchar(500)
	BEGIN TRY
	 IF NOT Exists(Select 1 from ProductMaster where ProductID=@ProductID )
	 BEGIN
		IF NOT Exists(Select 1 from ProductMaster where ProductCode=@ProductCode)
		BEGIN
			INSERT INTO [dbo].[ProductMaster]
           ([ProductCode]
           ,[ProductName]
           ,[BarCode]
           ,[categoryId]
           ,[UOM]
           ,[CreatedBy]
           ,[Createddate]
           ,PartnerId
           )
		VALUES
           (@ProductCode
           ,@ProductName
           ,@barcode
           ,@CategoryId
           ,@UOM
           ,@UserAccount
           ,GETDATE()
           ,@PartnerId
          )
		SET @ReturnValue=@@IDENTITY
		
		INSERT INTO [dbo].[ProductDetail]
           ([ProductID]
           ,[StoreID]
           ,[AutoPO]
           ,[RePOorderLevel]
           ,[RePOorderQuantity]
           ,[AutoSO]
           ,[CreatedBy]
           ,[Createddate]
           ,[ModifiedBy]
           ,[ModifiedDate])
     VALUES
           (
            @ReturnValue
           ,@StoreID
           ,@AutoPO
           ,@RePOorderLevel
           ,@RePOorderQuantity
           ,@AutoSO
           ,@UserAccount
           ,getdate()
           ,NULL
           ,NULL)
			 
			 SET @txt='Inserted Product named: '+ @ProductName
			 EXEC ERP_Insert_AuditLog @UserAccount, @txt
		  END
		ELSE
		BEGIN
		SET @ReturnValue= -99 -- code exists
			
	   END
	 END
	 ELSE
	 BEGIN
			UPDATE [dbo].[ProductMaster]
			SET 
			[ProductName] = @ProductName
			,BarCode = @barcode
			,CategoryId=@CategoryId
			,PartnerId=@PartnerId
			,UOM=@UOM
			,ModifiedBy=@UserAccount
			,ModifiedDate=GETDATE()
			WHERE ProductID=@ProductId and ProductCode=@ProductCode
			
		   UPDATE [dbo].[ProductDetail]
		   SET
			  [AutoPO] = @AutoPO
			  ,[RePOorderLevel] = @RePOorderLevel
			  ,[RePOorderQuantity] = @RePOorderQuantity
			  ,[AutoSO] = @AutoSO
			  ,[ModifiedBy] = @UserAccount
			  ,[ModifiedDate] = GETDATE()
		  WHERE ProductID=@ProductId and [StoreID] = @StoreID
			
			SET @ReturnValue=@ProductId
			SET @txt='Updated Product named :'+ @ProductName
			EXEC ERP_Insert_AuditLog @UserAccount, @txt
	 
	 END
	END TRY
BEGIN CATCH
	SET @ReturnValue= -9
	SELECT @DetailedErrorDesc =         
	CAST(ERROR_NUMBER() AS VARCHAR) + ' : '+
	--CAST(ERROR_SEVERITY() AS VARCHAR) + ' : ' +
	--CAST(ERROR_STATE() AS VARCHAR) + ' : ' +
	ERROR_PROCEDURE() + ' : ' +
	ERROR_MESSAGE() + ' : ' +
	CAST(ERROR_LINE() AS VARCHAR);
	EXEC [ERP_Insert_ErrorLog] @UserAccount,'[ERP_Save_Product]', @DetailedErrorDesc
END CATCH;
END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Save_Partners_XML]    Script Date: 06/05/2017 14:31:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [dbo].[ERP_Save_Partners_XML]

--'<Partner>
--<PartnerId>13</PartnerId>
--<PartnerCode>S00007</PartnerCode>
--<BarCode>123456789</BarCode>
--<PartnerName>Policy Bazar</PartnerName>
--<PartnerType>Supplier</PartnerType>
--<Website>part.com</Website>

--<Addresses>
--	<Address>
--		<ContactName>Sarika sachan</ContactName>
--		<ContactTitle>ms</ContactTitle>
--		<AddressType>Billing</AddressType>
--		<AddressId>4</AddressId>
--		<StreetAddress>govind</StreetAddress>
--		<City>Lucknow</City>
--		<State>UP</State>
--		<Country>India</Country>
--		<PostalCode>209206</PostalCode>
--		<Phone1>123456789</Phone1>
--		<Phone2>34567890</Phone2>
--		<Fax>6666666</Fax>
--		<Email>Sarika@nih.gov</Email>
--	</Address>
--	<Address>
--		<ContactName>sachin sachan</ContactName>
--		<ContactTitle>Mr.</ContactTitle>
--		<AddressType>Corporate</AddressType>
--		<AddressId>5</AddressId>
--		<StreetAddress>vihar</StreetAddress>
--		<City>Ghaziabad</City>
--		<State>UP</State>
--		<Country>india</Country>
--		<PostalCode>206085</PostalCode>
--		<Phone1>12345678</Phone1>
--		<Phone2>67890000</Phone2>
--		<Fax>4444444444</Fax>
--		<Email>sachin@nih.gov</Email>
--	</Address> 
--	<Address>
--		<ContactName>Abhi sachan</ContactName>
--		<ContactTitle>Mr.</ContactTitle>
--		<AddressType>Shipping</AddressType>
--		<AddressId>6</AddressId>
--		<StreetAddress>3455</StreetAddress>
--		<City>Gurgoan NCR</City>
--		<State>Haryana</State>
--		<Country>India</Country>
--		<PostalCode>2456789</PostalCode>
--		<Phone1>345656778</Phone1>
--		<Phone2>658768768</Phone2>
--		<Fax>789000</Fax>
--		<Email>Abhi@nih.gov</Email>
--	 </Address>
-- </Addresses>
-- </Partner>'

CREATE Procedure [dbo].[ERP_Save_Partners_XML]

@PartnerXML XML

AS

BEGIN

	

 SET NOCOUNT ON;  

   
-------------------Partner
 

 Create Table #Partner  
 (  

	PartnerId int,
	PartnerCode nvarchar(50),
	PartnerName nvarchar(50),
	PartnerType nvarchar(50),
	Website nvarchar(50),
 );  


	

	

	WITH CTE AS

	(

		SELECT

			PartnerId = XTbl.value('(PartnerId)[1]', 'int'),

			PartnerCode = XTbl.value('(PartnerCode)[1]', 'nvarchar(50)'),

			PartnerName = XTbl.value('(PartnerName)[1]', 'nvarchar(50)'),
			PartnerType = XTbl.value('(PartnerType)[1]', 'nvarchar(50)'),
			Website = XTbl.value('(Website)[1]', 'nvarchar(50)')

		FROM 

			@PartnerXML.nodes('/Partner') AS XD(XTbl)

	)

	INSERT INTO 

    #Partner(PartnerId ,PartnerCode ,PartnerName,PartnerType,Website)

    SELECT 

		 PartnerId,

         PartnerCode,

         PartnerName,
         PartnerType,
		 Website
    FROM CTE

    






	--- update existing comments
	UPDATE P  SET
		 PartnerName= temp.PartnerName
		,PartnerType=temp.PartnerType
		,Website=temp.Website
	FROM Partners as P

	INNER JOIN #Partner as temp on

	 temp.PartnerId=p.PartnerId 

    WHERE

    EXISTS (SELECT 1 FROM PartnerS WHERE PartnerId = temp.PartnerId)



	--insert new comments

	INSERT INTO 

    Partners(PartnerCode ,PartnerName,PartnerType,Website)

    SELECT 

         temp.PartnerCode,

          temp.PartnerName,

          temp.PartnerType,

         temp.Website

    FROM #Partner as temp

   -- INNER Join StudySection_GrantDetails GD ON GD.GRANT_NUM_ID= temp.GRANT_num_ID

	WHERE NOT EXISTS (SELECT * FROM partners WHERE PartnerId = temp.PartnerId)

 DECLARE @PartnerID int 
Select @PartnerID=PartnerID From Partners   where PartnerCode= (Select PartnerCode from #Partner)
   

-------------- Address--------------------------------------------------------------------
 Create Table #Address 
 (  
	AddressId int,
	ContactName nvarchar(50),
	ContactTitle nvarchar(50),
	AddressType nvarchar(50),
	StreetAddress nvarchar(50),
	City nvarchar(50),
	PostalCode nvarchar(24),
	Country nvarchar(50),
	Phone1 nvarchar(24),
	Phone2 nvarchar(24),
	Fax nvarchar(24),
	Email nvarchar(24),
	State nvarchar(50)
 );  	




	WITH CTE AS

	(

		SELECT

			AddressId = XTbl.value('(AddressId)[1]', 'int'),

			ContactName = XTbl.value('(ContactName)[1]', 'nvarchar(50)'),

			ContactTitle = XTbl.value('(ContactTitle)[1]', 'nvarchar(50)'),
			AddressType = XTbl.value('(AddressType)[1]', 'nvarchar(50)'),
			StreetAddress = XTbl.value('(StreetAddress)[1]', 'nvarchar(50)'),
			City = XTbl.value('(City)[1]', 'nvarchar(50)'),
			PostalCode = XTbl.value('(PostalCode)[1]', 'nvarchar(50)'),
			Country = XTbl.value('(Country)[1]', 'nvarchar(50)'),
			Phone1 = XTbl.value('(Phone1)[1]', 'nvarchar(50)'),
			Phone2 = XTbl.value('(Phone2)[1]', 'nvarchar(50)'),
			Fax = XTbl.value('(Fax)[1]', 'nvarchar(50)'),
			Email = XTbl.value('(Email)[1]', 'nvarchar(50)'),
			[State] = XTbl.value('(State)[1]', 'nvarchar(50)')
		FROM 

			@PartnerXML.nodes('/Partner/Addresses/Address') AS XD(XTbl)
			

	)

	INSERT INTO 
    #Address(
    AddressId,
	ContactName ,
	ContactTitle ,
	AddressType ,
	StreetAddress ,
	City ,
	PostalCode,
	Country ,
	Phone1 ,
	Phone2 ,
	Fax ,
	Email,
	State)

    SELECT 
    AddressId,
	ContactName ,
	ContactTitle ,
	AddressType ,
	StreetAddress ,
	City ,
	PostalCode,
	Country ,
	Phone1 ,
	Phone2 ,
	Fax ,
	Email,
	[State]
    FROM CTE


-- logic to insert or update


	--- update existing Address
	UPDATE A  SET
		 ContactName= temp.ContactName
		,ContactTitle=temp.ContactTitle
		,AddressType=temp.AddressType
		,StreetAddress=temp.StreetAddress
		,City=temp.City
		,PostalCode=temp.PostalCode
		,Country=temp.Country
		,Phone1=temp.Phone1
		,Phone2=temp.Phone2
		,Fax=temp.Fax
		,Email=temp.Email
		,State=temp.State
		
	FROM [Address] as A

	INNER JOIN #Address as temp on  temp.AddressId=A.AddressId 

    WHERE

    EXISTS (SELECT 1 FROM [Address] WHERE AddressId = temp.AddressId)



	--insert new Address

	INSERT INTO 

    Address( 
    PartnerId,
	ContactName ,
	ContactTitle ,
	AddressType ,
	StreetAddress ,
	City ,
	PostalCode,
	Country ,
	Phone1 ,
	Phone2 ,
	Fax ,
	Email,
	State)

    SELECT 
		 @PartnerID,
         temp.ContactName,

          temp.ContactTitle,

          temp.AddressType,

         temp.StreetAddress,
         temp.City,
         temp.PostalCode,
         temp.Country,
         temp.Phone1,
         temp.Phone2,
         temp.Fax,
         temp.Email,
		temp.State
    FROM #Address as temp
	WHERE NOT EXISTS (SELECT AddressId FROM Address WHERE AddressId = temp.AddressId)


Drop table #Partner
Drop table #Address

END
GO
/****** Object:  StoredProcedure [dbo].[ERP_SAVE_Partners]    Script Date: 06/05/2017 14:31:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[ERP_SAVE_Partners]
	@UserAccount nvarchar(50),
	@PartnerId int,
	@PartnerCode nvarchar(50),
	@PartnerName nvarchar(50),
	@PartnerType nvarchar(50),
	@ContactName nvarchar(50),
	@ContactTitle nvarchar(50),
	@AddressType nvarchar(50),
	@AddressId int,
	@StreetAddress nvarchar(50),
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
 DECLARE @DetailedErrorDesc VARCHAR(5000)
DECLARE @txt nVarchar(500)
BEGIN TRY
IF Exists ( Select 1 from Partners where PartnerID=@PartnerId)
	BEGIN
	 Update Partners Set
	 PartnerName=@PartnerName,
	 PartnerType =@PartnerType ,
	 Website=@Website,
	 ModifiedBy=@UserAccount,
	 Modifieddate=getdate()
	 WHERE PartnerID=@PartnerId and PartnerCode=@PartnerCode
	
	 IF Exists ( Select 1 from [Address] where AddressID=@AddressId)
	 BEGIN
		Update [Address] Set
		 ContactName=@ContactName,
		 ContactTitle=@ContactTitle,
		 AddressType=@AddressType,
		 StreetAddress=@StreetAddress,
		 City=@City,
		 PostalCode=@PostalCode,
		 Country=@Country,
		 Phone1=@Phone1,
		 Phone2=@Phone2,
		 Fax=@Fax,
		 Email=@ContactEmail,
		 ModifiedBy=@UserAccount,
		 Modifieddate=getdate()
		 WHERE PartnerID=@PartnerId and AddressID=@AddressId
		--Select * from Partners
	 END
	 
	 
	 SET @ReturnValue=@PartnerId

	SET @txt='Updated Supplier named :'+ @PartnerName
	EXEC ERP_Insert_AuditLog @UserAccount, @txt

END
ELSE
	BEGIN
	 --Insert
	 IF NOT Exists(Select 1 from Partners where PartnerCode=@PartnerCode)
	BEGIN
		INSERT INTO [dbo].[Partners]
           ([PartnerCode]
           ,[PartnerName]
           ,PartnerType
           ,[WebSite]
           ,[CreatedBy]
           ,[CreatedDate]
           )
     VALUES
           (
           @PartnerCode
           ,@PartnerName
           ,@PartnerType
           ,@Website
           ,@UserAccount
           ,GETDATE()
           )
           
	 SET @ReturnValue=@@IDENTITY
	 
	 INSERT INTO [dbo].[Address]
           ([PartnerID]
           ,[ContactName]
           ,[ContactTitle]
           ,[AddressType]
           ,[StreetAddress]
           ,[City]
          
           ,[PostalCode]
           ,[Country]
           ,[Email]
           ,[Phone1]
           ,[Phone2]
           ,[Fax]
           ,[CreatedBy]
           ,[CreatedDate]
          )
     VALUES
           (
           @ReturnValue
           ,@ContactName
           ,@ContactTitle
           ,@AddressType
           ,@StreetAddress
           ,@City
           
           ,@PostalCode
           ,@Country
           ,@ContactEmail
           ,@Phone1
           ,@Phone2
           ,@Fax
           ,@UserAccount
           ,GETDATE()
           )
	 
		 SET @txt='Inserted Parner named: '+ @PartnerName
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
	SELECT @DetailedErrorDesc =         
	CAST(ERROR_NUMBER() AS VARCHAR) + ' : '+
	--CAST(ERROR_SEVERITY() AS VARCHAR) + ' : ' +
	--CAST(ERROR_STATE() AS VARCHAR) + ' : ' +
	ERROR_PROCEDURE() + ' : ' +
	ERROR_MESSAGE() + ' : ' +
	CAST(ERROR_LINE() AS VARCHAR);
	EXEC [ERP_Insert_ErrorLog] @UserAccount,'ERP_SAVE_Partners', @DetailedErrorDesc
END CATCH;


END
GO
/****** Object:  Table [dbo].[purchase_return]    Script Date: 06/05/2017 14:31:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchase_return](
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
/****** Object:  Table [dbo].[purchase_details]    Script Date: 06/05/2017 14:31:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[purchase_details](
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
	[StoreID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[Sales_Return]    Script Date: 06/05/2017 14:31:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales_Return](
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
	[StoreID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesReturnId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[Sales_Details]    Script Date: 06/05/2017 14:31:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales_Details](
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
	[StoreID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DAILY]
) ON [DAILY]
GO
/****** Object:  Table [dbo].[Sales_Return_Details]    Script Date: 06/05/2017 14:31:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales_Return_Details](
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
	[StoreID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesReturnDetailId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  Table [dbo].[Purchase_Return_Details]    Script Date: 06/05/2017 14:31:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Purchase_Return_Details](
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
	[StoreID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [WEEKLY]
) ON [WEEKLY]
GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 06/05/2017 14:31:17 ******/
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
/****** Object:  Default [DF__ProductPr__LockS__2BC97F7C]    Script Date: 06/05/2017 14:30:51 ******/
ALTER TABLE [dbo].[ProductPrice] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__ProductPr__Delet__2CBDA3B5]    Script Date: 06/05/2017 14:30:51 ******/
ALTER TABLE [dbo].[ProductPrice] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__Suppliers__AutoA__19DFD96B]    Script Date: 06/05/2017 14:30:51 ******/
ALTER TABLE [dbo].[Suppliers NOT IN USE] ADD  DEFAULT ((0)) FOR [AutoApprovePO]
GO
/****** Object:  Default [DF__Suppliers__AutoS__1AD3FDA4]    Script Date: 06/05/2017 14:30:51 ******/
ALTER TABLE [dbo].[Suppliers NOT IN USE] ADD  DEFAULT ((0)) FOR [AutoSendPO]
GO
/****** Object:  Default [DF__Suppliers__LockS__1BC821DD]    Script Date: 06/05/2017 14:30:51 ******/
ALTER TABLE [dbo].[Suppliers NOT IN USE] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__Menus__ShowInDas__41B8C09B]    Script Date: 06/05/2017 14:30:51 ******/
ALTER TABLE [dbo].[Menus] ADD  DEFAULT ((0)) FOR [ShowInDashboard]
GO
/****** Object:  Default [DF__Lookup__Deleted__11158940]    Script Date: 06/05/2017 14:30:51 ******/
ALTER TABLE [dbo].[Lookup] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__ProductDe__AutoP__04AFB25B]    Script Date: 06/05/2017 14:30:55 ******/
ALTER TABLE [dbo].[ProductDetail] ADD  DEFAULT ((0)) FOR [AutoPO]
GO
/****** Object:  Default [DF__ProductDe__AutoS__05A3D694]    Script Date: 06/05/2017 14:30:55 ******/
ALTER TABLE [dbo].[ProductDetail] ADD  DEFAULT ((0)) FOR [AutoSO]
GO
/****** Object:  Default [DF__ProductDe__Disco__3EDC53F0]    Script Date: 06/05/2017 14:30:55 ******/
ALTER TABLE [dbo].[ProductDetail] ADD  DEFAULT ('0') FOR [Discontinued]
GO
/****** Object:  Default [DF__DocumentM__IsAut__6CD828CA]    Script Date: 06/05/2017 14:30:55 ******/
ALTER TABLE [dbo].[DocumentMaster] ADD  DEFAULT ((1)) FOR [IsAutoGenerated]
GO
/****** Object:  Default [DF__DocumentM__LockS__6AEFE058]    Script Date: 06/05/2017 14:30:55 ******/
ALTER TABLE [dbo].[DocumentMaster] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__DocumentM__Delet__6BE40491]    Script Date: 06/05/2017 14:30:55 ******/
ALTER TABLE [dbo].[DocumentMaster] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__CustomerM__AutoA__797309D9]    Script Date: 06/05/2017 14:30:55 ******/
ALTER TABLE [dbo].[CustomerMaster NOT IN USE] ADD  DEFAULT ((0)) FOR [AutoApproveSO]
GO
/****** Object:  Default [DF__CustomerM__AutoS__7A672E12]    Script Date: 06/05/2017 14:30:55 ******/
ALTER TABLE [dbo].[CustomerMaster NOT IN USE] ADD  DEFAULT ((0)) FOR [AutoSendSO]
GO
/****** Object:  Default [DF__CustomerM__LockS__7B5B524B]    Script Date: 06/05/2017 14:30:55 ******/
ALTER TABLE [dbo].[CustomerMaster NOT IN USE] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__CustomerM__Delet__7C4F7684]    Script Date: 06/05/2017 14:30:55 ******/
ALTER TABLE [dbo].[CustomerMaster NOT IN USE] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_CountryMaster_LockStatus]    Script Date: 06/05/2017 14:30:56 ******/
ALTER TABLE [dbo].[CountryMaster] ADD  CONSTRAINT [DF_CountryMaster_LockStatus]  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF_CountryMaster_Deleted]    Script Date: 06/05/2017 14:30:56 ******/
ALTER TABLE [dbo].[CountryMaster] ADD  CONSTRAINT [DF_CountryMaster_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Categories_LockStatus]    Script Date: 06/05/2017 14:30:56 ******/
ALTER TABLE [dbo].[CategoryMaster] ADD  CONSTRAINT [DF_Categories_LockStatus]  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF_Categories_Deleted]    Script Date: 06/05/2017 14:30:56 ******/
ALTER TABLE [dbo].[CategoryMaster] ADD  CONSTRAINT [DF_Categories_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_AuditLog_Deleted]    Script Date: 06/05/2017 14:30:56 ******/
ALTER TABLE [dbo].[AuditLog] ADD  CONSTRAINT [DF_AuditLog_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__Partners__AutoAp__0880433F]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[Partners] ADD  DEFAULT ((0)) FOR [AutoApproveOrder]
GO
/****** Object:  Default [DF__Partners__AutoSe__09746778]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[Partners] ADD  DEFAULT ((0)) FOR [AutoSendOrder]
GO
/****** Object:  Default [DF__Partners__LockSt__0A688BB1]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[Partners] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__Stores__LockStat__17F790F9]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[Stores] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__Stores__Deleted__18EBB532]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[Stores] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_State_LockStatus]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[StateMaster] ADD  CONSTRAINT [DF_State_LockStatus]  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF_State_Deleted]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[StateMaster] ADD  CONSTRAINT [DF_State_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__Purchase__LockSt__08B54D69]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Purchase] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__Purchase__Delete__09A971A2]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Purchase] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__ProductsF__Delet__07C12930]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[ProductsForSale] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__ProductMa__LockS__05D8E0BE]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[ProductMaster] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__ProductMa__Disco__39237A9A]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[ProductMaster] ADD  DEFAULT ((0)) FOR [Discontinued]
GO
/****** Object:  Default [DF__sales__LockStatu__10566F31]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[sales] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__sales__Deleted__114A936A]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[sales] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__PO_Detail__LockS__00200768]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Order_Detail] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__PO_Detail__Delet__01142BA1]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Order_Detail] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__Order__LockStatu__17C286CF]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Order] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__Order__Deleted__18B6AB08]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Order] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_CityMaster_LockStatus]    Script Date: 06/05/2017 14:31:06 ******/
ALTER TABLE [dbo].[CityMaster] ADD  CONSTRAINT [DF_CityMaster_LockStatus]  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF_CityMaster_Deleted]    Script Date: 06/05/2017 14:31:06 ******/
ALTER TABLE [dbo].[CityMaster] ADD  CONSTRAINT [DF_CityMaster_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__PurchaseR__LockS__0C85DE4D]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[purchase_return] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__PurchaseR__Delet__0D7A0286]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[purchase_return] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__PurchaseD__LockS__0A9D95DB]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[purchase_details] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__PurchaseD__Delet__0B91BA14]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[purchase_details] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__SalesRetu__LockS__14270015]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Return] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__SalesRetu__Delet__151B244E]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Return] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__SalesDeta__LockS__123EB7A3]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Details] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__SalesDeta__Delet__1332DBDC]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Details] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__SalesRetu__LockS__160F4887]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Return_Details] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__SalesRetu__Delet__17036CC0]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Return_Details] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF__PurchaseR__LockS__0E6E26BF]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Purchase_Return_Details] ADD  DEFAULT ((1)) FOR [LockStatus]
GO
/****** Object:  Default [DF__PurchaseR__Delet__0F624AF8]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Purchase_Return_Details] ADD  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Check [CK_Birthdate]    Script Date: 06/05/2017 14:30:57 ******/
ALTER TABLE [dbo].[EmployeeMaster]  WITH NOCHECK ADD  CONSTRAINT [CK_Birthdate] CHECK  (([BirthDate]<getdate()))
GO
ALTER TABLE [dbo].[EmployeeMaster] CHECK CONSTRAINT [CK_Birthdate]
GO
/****** Object:  ForeignKey [FK_Employees_Employees]    Script Date: 06/05/2017 14:30:57 ******/
ALTER TABLE [dbo].[EmployeeMaster]  WITH NOCHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([ReportsTo])
REFERENCES [dbo].[EmployeeMaster] ([EmployeeID])
GO
ALTER TABLE [dbo].[EmployeeMaster] CHECK CONSTRAINT [FK_Employees_Employees]
GO
/****** Object:  ForeignKey [FK_DocumentRouting_DocumentMaster]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[DocumentRouting]  WITH NOCHECK ADD  CONSTRAINT [FK_DocumentRouting_DocumentMaster] FOREIGN KEY([DocumentId])
REFERENCES [dbo].[DocumentMaster] ([DocumentID])
GO
ALTER TABLE [dbo].[DocumentRouting] CHECK CONSTRAINT [FK_DocumentRouting_DocumentMaster]
GO
/****** Object:  ForeignKey [FK__Permissio__Modul__1DB06A4F]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[PermissionMaster]  WITH CHECK ADD FOREIGN KEY([ModuleId])
REFERENCES [dbo].[Menus] ([ModuleID])
GO
/****** Object:  ForeignKey [FK__Permissio__Modul__3E1D39E1]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[PermissionMaster]  WITH CHECK ADD FOREIGN KEY([ModuleId])
REFERENCES [dbo].[Menus] ([ModuleID])
GO
/****** Object:  ForeignKey [Lookup_PartnerType_FK]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[Partners]  WITH CHECK ADD  CONSTRAINT [Lookup_PartnerType_FK] FOREIGN KEY([PartnerType])
REFERENCES [dbo].[Lookup] ([Code])
GO
ALTER TABLE [dbo].[Partners] CHECK CONSTRAINT [Lookup_PartnerType_FK]
GO
/****** Object:  ForeignKey [Stores_CompanyID_FK]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[Stores]  WITH CHECK ADD  CONSTRAINT [Stores_CompanyID_FK] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[CompanyMaster] ([CompanyID])
GO
ALTER TABLE [dbo].[Stores] CHECK CONSTRAINT [Stores_CompanyID_FK]
GO
/****** Object:  ForeignKey [FK_StateMaster_CountryMaster]    Script Date: 06/05/2017 14:31:03 ******/
ALTER TABLE [dbo].[StateMaster]  WITH CHECK ADD  CONSTRAINT [FK_StateMaster_CountryMaster] FOREIGN KEY([CountryID])
REFERENCES [dbo].[CountryMaster] ([CountryID])
GO
ALTER TABLE [dbo].[StateMaster] CHECK CONSTRAINT [FK_StateMaster_CountryMaster]
GO
/****** Object:  ForeignKey [FK_sales_Scrap]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Scrap]  WITH CHECK ADD  CONSTRAINT [FK_sales_Scrap] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[Scrap] CHECK CONSTRAINT [FK_sales_Scrap]
GO
/****** Object:  ForeignKey [Scrap_categoryId_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Scrap]  WITH CHECK ADD  CONSTRAINT [Scrap_categoryId_FK] FOREIGN KEY([categoryId])
REFERENCES [dbo].[CategoryMaster] ([CategoryID])
GO
ALTER TABLE [dbo].[Scrap] CHECK CONSTRAINT [Scrap_categoryId_FK]
GO
/****** Object:  ForeignKey [Scrap_SupplierID_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Scrap]  WITH CHECK ADD  CONSTRAINT [Scrap_SupplierID_FK] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers NOT IN USE] ([SupplierID])
GO
ALTER TABLE [dbo].[Scrap] CHECK CONSTRAINT [Scrap_SupplierID_FK]
GO
/****** Object:  ForeignKey [TransactionDetail_StoreID_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[TransactionDetail]  WITH CHECK ADD  CONSTRAINT [TransactionDetail_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[TransactionDetail] CHECK CONSTRAINT [TransactionDetail_StoreID_FK]
GO
/****** Object:  ForeignKey [Purchase_StoreID_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD  CONSTRAINT [Purchase_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[Purchase] CHECK CONSTRAINT [Purchase_StoreID_FK]
GO
/****** Object:  ForeignKey [Purchase_SupplierID_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Purchase]  WITH CHECK ADD  CONSTRAINT [Purchase_SupplierID_FK] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers NOT IN USE] ([SupplierID])
GO
ALTER TABLE [dbo].[Purchase] CHECK CONSTRAINT [Purchase_SupplierID_FK]
GO
/****** Object:  ForeignKey [FK_Stores_ProductsForSale]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[ProductsForSale]  WITH CHECK ADD  CONSTRAINT [FK_Stores_ProductsForSale] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[ProductsForSale] CHECK CONSTRAINT [FK_Stores_ProductsForSale]
GO
/****** Object:  ForeignKey [FK_CateryMaster_ProductMaster]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[ProductMaster]  WITH CHECK ADD  CONSTRAINT [FK_CateryMaster_ProductMaster] FOREIGN KEY([categoryId])
REFERENCES [dbo].[CategoryMaster] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductMaster] CHECK CONSTRAINT [FK_CateryMaster_ProductMaster]
GO
/****** Object:  ForeignKey [productmaster_Partners_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[ProductMaster]  WITH CHECK ADD  CONSTRAINT [productmaster_Partners_FK] FOREIGN KEY([PartnerID])
REFERENCES [dbo].[Partners] ([PartnerID])
GO
ALTER TABLE [dbo].[ProductMaster] CHECK CONSTRAINT [productmaster_Partners_FK]
GO
/****** Object:  ForeignKey [sales_StoreID_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[sales]  WITH CHECK ADD  CONSTRAINT [sales_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[sales] CHECK CONSTRAINT [sales_StoreID_FK]
GO
/****** Object:  ForeignKey [Order_Detail_StoreID_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Order_Detail]  WITH CHECK ADD  CONSTRAINT [Order_Detail_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[Order_Detail] CHECK CONSTRAINT [Order_Detail_StoreID_FK]
GO
/****** Object:  ForeignKey [Lookup_OrderStatus_Like_POStatus_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [Lookup_OrderStatus_Like_POStatus_FK] FOREIGN KEY([OrderStatus])
REFERENCES [dbo].[Lookup] ([Code])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [Lookup_OrderStatus_Like_POStatus_FK]
GO
/****** Object:  ForeignKey [Order_Lookup_OrderType_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [Order_Lookup_OrderType_FK] FOREIGN KEY([OrderType])
REFERENCES [dbo].[Lookup] ([Code])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [Order_Lookup_OrderType_FK]
GO
/****** Object:  ForeignKey [PO_HEAD_StoreID_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [PO_HEAD_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [PO_HEAD_StoreID_FK]
GO
/****** Object:  ForeignKey [PO_HEAD_SupplierID_FK]    Script Date: 06/05/2017 14:31:04 ******/
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [PO_HEAD_SupplierID_FK] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers NOT IN USE] ([SupplierID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [PO_HEAD_SupplierID_FK]
GO
/****** Object:  ForeignKey [FK_CityMaster_StateMaster]    Script Date: 06/05/2017 14:31:06 ******/
ALTER TABLE [dbo].[CityMaster]  WITH CHECK ADD  CONSTRAINT [FK_CityMaster_StateMaster] FOREIGN KEY([StateID])
REFERENCES [dbo].[StateMaster] ([StateID])
GO
ALTER TABLE [dbo].[CityMaster] CHECK CONSTRAINT [FK_CityMaster_StateMaster]
GO
/****** Object:  ForeignKey [FK_Partner_Address_Cascade]    Script Date: 06/05/2017 14:31:06 ******/
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Partner_Address_Cascade] FOREIGN KEY([PartnerID])
REFERENCES [dbo].[Partners] ([PartnerID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Partner_Address_Cascade]
GO
/****** Object:  ForeignKey [Lookup_AddressType_FK]    Script Date: 06/05/2017 14:31:06 ******/
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [Lookup_AddressType_FK] FOREIGN KEY([AddressType])
REFERENCES [dbo].[Lookup] ([Code])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [Lookup_AddressType_FK]
GO
/****** Object:  ForeignKey [FK_Stores_PurchaseReturn]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[purchase_return]  WITH CHECK ADD  CONSTRAINT [FK_Stores_PurchaseReturn] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[purchase_return] CHECK CONSTRAINT [FK_Stores_PurchaseReturn]
GO
/****** Object:  ForeignKey [PurchaseReturn_Stock_Id_FK]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[purchase_return]  WITH CHECK ADD  CONSTRAINT [PurchaseReturn_Stock_Id_FK] FOREIGN KEY([Stock_Id])
REFERENCES [dbo].[Purchase] ([Stock_Id])
GO
ALTER TABLE [dbo].[purchase_return] CHECK CONSTRAINT [PurchaseReturn_Stock_Id_FK]
GO
/****** Object:  ForeignKey [FK_Purchase_PurchaseDetails]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[purchase_details]  WITH CHECK ADD  CONSTRAINT [FK_Purchase_PurchaseDetails] FOREIGN KEY([Stock_Id])
REFERENCES [dbo].[Purchase] ([Stock_Id])
GO
ALTER TABLE [dbo].[purchase_details] CHECK CONSTRAINT [FK_Purchase_PurchaseDetails]
GO
/****** Object:  ForeignKey [PurchaseDetails_StoreID_FK]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[purchase_details]  WITH CHECK ADD  CONSTRAINT [PurchaseDetails_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[purchase_details] CHECK CONSTRAINT [PurchaseDetails_StoreID_FK]
GO
/****** Object:  ForeignKey [fk_SalesReturn]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Return]  WITH CHECK ADD  CONSTRAINT [fk_SalesReturn] FOREIGN KEY([SaleId])
REFERENCES [dbo].[sales] ([Saleid])
GO
ALTER TABLE [dbo].[Sales_Return] CHECK CONSTRAINT [fk_SalesReturn]
GO
/****** Object:  ForeignKey [SalesReturn_StoreID_FK]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Return]  WITH CHECK ADD  CONSTRAINT [SalesReturn_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[Sales_Return] CHECK CONSTRAINT [SalesReturn_StoreID_FK]
GO
/****** Object:  ForeignKey [FK_sales_SalesDetail]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Details]  WITH CHECK ADD  CONSTRAINT [FK_sales_SalesDetail] FOREIGN KEY([Saleid])
REFERENCES [dbo].[sales] ([Saleid])
GO
ALTER TABLE [dbo].[Sales_Details] CHECK CONSTRAINT [FK_sales_SalesDetail]
GO
/****** Object:  ForeignKey [SalesDetail_StoreID_FK]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Details]  WITH CHECK ADD  CONSTRAINT [SalesDetail_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[Sales_Details] CHECK CONSTRAINT [SalesDetail_StoreID_FK]
GO
/****** Object:  ForeignKey [fk_SalesReturnDetail]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Return_Details]  WITH CHECK ADD  CONSTRAINT [fk_SalesReturnDetail] FOREIGN KEY([SalesReturnId])
REFERENCES [dbo].[Sales_Return] ([SalesReturnId])
GO
ALTER TABLE [dbo].[Sales_Return_Details] CHECK CONSTRAINT [fk_SalesReturnDetail]
GO
/****** Object:  ForeignKey [SalesReturnDetail_StoreID_FK]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Sales_Return_Details]  WITH CHECK ADD  CONSTRAINT [SalesReturnDetail_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[Sales_Return_Details] CHECK CONSTRAINT [SalesReturnDetail_StoreID_FK]
GO
/****** Object:  ForeignKey [PurchaseReturnDetail_PurchaseReturnID_FK]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Purchase_Return_Details]  WITH CHECK ADD  CONSTRAINT [PurchaseReturnDetail_PurchaseReturnID_FK] FOREIGN KEY([PurchaseReturnID])
REFERENCES [dbo].[purchase_return] ([PurchaseReturnID])
GO
ALTER TABLE [dbo].[Purchase_Return_Details] CHECK CONSTRAINT [PurchaseReturnDetail_PurchaseReturnID_FK]
GO
/****** Object:  ForeignKey [PurchaseReturnDetail_StoreID_FK]    Script Date: 06/05/2017 14:31:14 ******/
ALTER TABLE [dbo].[Purchase_Return_Details]  WITH CHECK ADD  CONSTRAINT [PurchaseReturnDetail_StoreID_FK] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Stores] ([StoreID])
GO
ALTER TABLE [dbo].[Purchase_Return_Details] CHECK CONSTRAINT [PurchaseReturnDetail_StoreID_FK]
GO
/****** Object:  DdlTrigger [rds_deny_backups_trigger]    Script Date: 06/05/2017 14:31:17 ******/
Enable Trigger [rds_deny_backups_trigger] ON Database
GO
