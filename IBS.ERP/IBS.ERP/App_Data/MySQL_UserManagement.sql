-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema UserManagement
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema UserManagement
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `UserManagement` DEFAULT CHARACTER SET utf8 ;
USE `UserManagement` ;

-- -----------------------------------------------------
-- Table `UserManagement`.`auto_order_document_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UserManagement`.`auto_order_document_status` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `CompanyCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `DocumentType` VARCHAR(10) CHARACTER SET 'utf8mb4' NOT NULL,
  `SupplierCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `CustomerCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `DocumentNo` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `DocumentDataCreated` TINYINT(1) NULL DEFAULT NULL,
  `DataCreatedDate` DATE NULL DEFAULT NULL,
  `PDFDocumentCreated` TINYINT(1) NULL DEFAULT NULL,
  `PDFDocumentCreatedDate` DATE NULL DEFAULT NULL,
  `LockStatus` INT(11) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `UserManagement`.`companydb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UserManagement`.`companydb` (
  `DBId` INT(11) NOT NULL AUTO_INCREMENT,
  `CompanyCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `DBConnectionString` VARCHAR(2000) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `DBProviderName` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `LockStatus` INT(11) NOT NULL DEFAULT '1',
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `Deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `AppName` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`DBId`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `UserManagement`.`errorlog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UserManagement`.`errorlog` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `Date` DATETIME(6) NULL DEFAULT NULL,
  `Thread` VARCHAR(255) NULL DEFAULT NULL,
  `Level` VARCHAR(50) NULL DEFAULT NULL,
  `Logger` VARCHAR(255) NULL DEFAULT NULL,
  `Message` VARCHAR(4000) NULL DEFAULT NULL,
  `Exception` VARCHAR(4000) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `UserManagement`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UserManagement`.`menus` (
  `ModuleID` INT(11) NOT NULL AUTO_INCREMENT,
  `ModuleName` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ParentID` INT(11) NULL DEFAULT NULL,
  `Description` VARCHAR(250) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ActionName` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ControllerName` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `isEnabled` INT(11) NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATETIME(6) NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATETIME(6) NULL DEFAULT NULL,
  `ShowInDashboard` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`ModuleID`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `UserManagement`.`usermaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `UserManagement`.`usermaster` (
  `UserID` INT(11) NOT NULL AUTO_INCREMENT,
  `UserAccount` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `Password` VARCHAR(150) CHARACTER SET 'utf8mb4' NOT NULL,
  `FirstName` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `LastName` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CompanyCode` VARCHAR(20) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `IsAccountActive` TINYINT(1) NULL DEFAULT NULL,
  `isAccountlocked` TINYINT(1) NULL DEFAULT NULL,
  `RoleId` INT(11) NULL DEFAULT NULL,
  `HintQUestion` VARCHAR(150) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `HintAnswer` VARCHAR(150) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `LockStatus` INT(11) NOT NULL DEFAULT '1',
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `Deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `EmpCode` VARCHAR(20) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  PRIMARY KEY (`UserID`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;

USE `UserManagement` ;

-- -----------------------------------------------------
-- procedure ERP_Get_Menu
-- -----------------------------------------------------

DELIMITER $$
USE `UserManagement`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Get_Menu`( IN UserAccount varchar(50),in RoleID int )
BEGIN
 Select ModuleID, ModuleName,ParentID,Description, ActionName, ControllerName         
 from menus m Where isEnabled=1 ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Get_UserDetail
-- -----------------------------------------------------

DELIMITER $$
USE `UserManagement`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Get_UserDetail`(  
  p_userAccount varchar(50)  
  , p_password varchar(50)
  ,p_appName varchar(50))
BEGIN  
	   IF EXISTS(Select  1  from usermaster um  where UserAccount=p_userAccount and Password=p_password and IsAccountActive=1 and isAccountlocked=0 )  
	   THEN  
		Select '0' as SignInStatus,   um.CompanyCode,DBConnectionString,DBProviderName,RoleId,p_userAccount as UserAccount   
		from usermaster  um   
		INNER Join companydb db on  um.CompanyCode=db.CompanyCode  
		where UserAccount=p_userAccount  and appname=p_appName; 
		 --  0 success User is locked out
		 -- print 'aa'
	   Elseif EXISTS(Select 1  from usermaster um  where UserAccount=p_userAccount and IsAccountActive=0) 
	   THEN  
		 -- print 'bb'
		Select '2' as SignInStatus ,'' as CompanyCode, '' as DBConnectionString,'' as DBProviderName, 0 as RoleId, p_userAccount as UserAccount;   --  1 User is not active
	   Elseif EXISTS(Select 1  from usermaster um  where UserAccount=p_userAccount and IsAccountActive=1 and isAccountlocked=1) 
	   THEN  
	   -- print 'cc'
		Select '1' as SignInStatus ,'' as CompanyCode, '' as DBConnectionString,'' as DBProviderName, 0 as RoleId, p_UserAccount as UserAccount;   --  1 User is locked out
	   ELSE
	   -- print 'dd'
	   Select '3' as SignInStatus ,'' as CompanyCode, '' as DBConnectionString,'' as DBProviderName, 0 as RoleId, p_UserAccount as UserAccount;   --  --3 Sign in failed
		
	   END IF;
   
  END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Save_UserDetail
-- -----------------------------------------------------

DELIMITER $$
USE `UserManagement`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Save_UserDetail`(
  userAccount varchar(50)
  ,password nvarchar(50)
  ,firstName nvarchar(50)
  ,lastName nvarchar(50)
  ,primaryEmail nvarchar(50)
  -- ,@AlternateEmail nvarchar(50)
  -- ,@PrimaryPhoneNo nvarchar(50)
  -- ,@AlternatePhoneNo nvarchar(50)
  -- ,@IsAccountActive bit
  -- ,@isAccountlocked bit
  -- ,@RoleId int
  ,companyCode  nvarchar(50))
BEGIN
  
  
  INSERT INTO UserMaster
           (`UserAccount`
           ,`Password`
           ,`FirstName`
           ,`LastName`
           ,`PrimaryEmail`
           -- ,[AlternateEmail]
           -- ,[PrimaryPhoneNo]
           -- ,[AlternatePhoneNo]
           -- ,[IsAccountActive]
           -- ,[isAccountlocked]
           -- ,[RoleId]
           ,`CompanyCode`
           -- ,[DBConnectionString]
           -- ,[HintQUestion]
           -- ,[HintAnswer]
           -- ,[CreatedBy]
           -- ,[ModifiedBy]
           -- ,[CreatedDate]
           -- ,[ModifiedDate]
           )
     VALUES
           (
           userAccount
           ,password
           ,firstName
           ,lastName
           ,primaryEmail
           -- ,@AlternateEmail
           -- ,@PrimaryPhoneNo
           -- ,@AlternatePhoneNo
           -- ,@IsAccountActive
           -- ,@isAccountlocked
           -- ,@RoleId 
           ,companyCode
           -- ,@DBConnectionString 
           -- ,@HintQUestion 
           -- ,@HintAnswer
           -- ,@CreatedBy
           -- ,@ModifiedBy 
           -- ,GETDATE()
           -- ,GETDATE()
           );

  END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
