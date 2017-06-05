-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ABCInventory
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ABCInventory
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ABCInventory` DEFAULT CHARACTER SET utf8 ;
USE `ABCInventory` ;

-- -----------------------------------------------------
-- Table `ABCInventory`.`lookup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`lookup` (
  `LookupId` INT(11) NOT NULL AUTO_INCREMENT,
  `Code` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Text` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Type` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Description` VARCHAR(500) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`LookupId`),
  UNIQUE INDEX `UC_Lookup` (`Code` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 55
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`partners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`partners` (
  `PartnerID` INT(11) NOT NULL AUTO_INCREMENT,
  `PartnerCode` VARCHAR(20) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `PartnerType` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `PartnerName` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `BarCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `WebSite` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `AutoApproveOrder` TINYINT(1) NULL DEFAULT '0',
  `AutoApproveOrderAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `AutoSendOrder` TINYINT(1) NULL DEFAULT '0',
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  PRIMARY KEY (`PartnerID`),
  INDEX `Lookup_PartnerType_FK` (`PartnerType` ASC),
  CONSTRAINT `Lookup_PartnerType_FK`
    FOREIGN KEY (`PartnerType`)
    REFERENCES `ABCInventory`.`lookup` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`address` (
  `AddressID` INT(11) NOT NULL AUTO_INCREMENT,
  `PartnerID` INT(11) NOT NULL,
  `ContactName` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ContactTitle` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `AddressType` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `StreetAddress` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `City` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Region` VARCHAR(15) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `PostalCode` VARCHAR(24) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Country` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Email` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Phone1` VARCHAR(24) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Phone2` VARCHAR(24) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Fax` VARCHAR(24) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `State` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  PRIMARY KEY (`AddressID`),
  INDEX `FK_Partner_Address_Cascade` (`PartnerID` ASC),
  INDEX `Lookup_AddressType_FK` (`AddressType` ASC),
  CONSTRAINT `FK_Partner_Address_Cascade`
    FOREIGN KEY (`PartnerID`)
    REFERENCES `ABCInventory`.`partners` (`PartnerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Lookup_AddressType_FK`
    FOREIGN KEY (`AddressType`)
    REFERENCES `ABCInventory`.`lookup` (`Code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`auditlog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`auditlog` (
  `AuditID` INT(11) NOT NULL AUTO_INCREMENT,
  `ActionDoneBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Description` VARCHAR(4000) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATETIME(6) NULL DEFAULT NULL,
  `Deleted` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`AuditID`))
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`categorymaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`categorymaster` (
  `CategoryID` INT(11) NOT NULL AUTO_INCREMENT,
  `CategoryCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `CategoryName` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `Description` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATETIME(6) NULL DEFAULT NULL,
  `ModifiedDate` DATETIME(6) NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`CategoryID`),
  UNIQUE INDEX `Unique_CategoryCode_CategoryMaster` (`CategoryCode` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`countrymaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`countrymaster` (
  `CountryID` INT(11) NOT NULL AUTO_INCREMENT,
  `CountryCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `CountryName` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `Description` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATETIME(6) NULL DEFAULT NULL,
  `ModifiedDate` DATETIME(6) NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`CountryID`),
  UNIQUE INDEX `Unique_CountryCode_CountryMaster` (`CountryCode` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`statemaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`statemaster` (
  `StateID` INT(11) NOT NULL AUTO_INCREMENT,
  `SateCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `StateName` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `Description` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATETIME(6) NULL DEFAULT NULL,
  `ModifiedDate` DATETIME(6) NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `CountryID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`StateID`),
  UNIQUE INDEX `Unique_StateCode_StateMaster` (`SateCode` ASC),
  INDEX `FK_StateMaster_CountryMaster` (`CountryID` ASC),
  CONSTRAINT `FK_StateMaster_CountryMaster`
    FOREIGN KEY (`CountryID`)
    REFERENCES `ABCInventory`.`countrymaster` (`CountryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`citymaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`citymaster` (
  `CityID` INT(11) NOT NULL AUTO_INCREMENT,
  `CityCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `CityName` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `Description` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATETIME(6) NULL DEFAULT NULL,
  `ModifiedDate` DATETIME(6) NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `StateID` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`CityID`),
  UNIQUE INDEX `Unique_CityCode_CityMaster` (`CityCode` ASC),
  INDEX `FK_CityMaster_StateMaster` (`StateID` ASC),
  CONSTRAINT `FK_CityMaster_StateMaster`
    FOREIGN KEY (`StateID`)
    REFERENCES `ABCInventory`.`statemaster` (`StateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`companymaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`companymaster` (
  `CompanyID` INT(11) NOT NULL AUTO_INCREMENT,
  `CompanyCode` VARCHAR(20) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CompanyName` VARCHAR(100) CHARACTER SET 'utf8mb4' NOT NULL,
  `RegistrationNo` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Address` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `City` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `TIN` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Phone1` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Phone2` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `website` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ContactEmail` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `OwnedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`CompanyID`),
  UNIQUE INDEX `Unique_CompanyCode_CompanyMaster` (`CompanyCode` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`current_document_routing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`current_document_routing` (
  `CurrentRoutingID` INT(11) NOT NULL AUTO_INCREMENT,
  `DocumentNO` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `UserAccount` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `RoutingOrder` INT(11) NULL DEFAULT NULL,
  `ISCurrentApprover` TINYINT(1) NULL DEFAULT NULL,
  `ISApproved` TINYINT(1) NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATETIME(6) NULL DEFAULT NULL,
  `ModifiedDate` DATETIME(6) NULL DEFAULT NULL,
  PRIMARY KEY (`CurrentRoutingID`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`documentmaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`documentmaster` (
  `DocumentID` SMALLINT(6) NOT NULL AUTO_INCREMENT,
  `DocumentCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `Description` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `IsAutoGenerated` TINYINT(1) NULL DEFAULT '1',
  `DocumentStoredPath` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `PreFix` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `RunningNo` INT(11) NULL DEFAULT NULL,
  `RunningNoLength` INT(11) NULL DEFAULT NULL,
  `PaddingCharacter` VARCHAR(1) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATETIME(6) NULL DEFAULT NULL,
  `ModifiedDate` DATETIME(6) NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `LevelOfApproval` INT(11) NULL DEFAULT NULL,
  `TableName` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CodeColumnName` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `DocumentType` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `TypeColumnName` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  PRIMARY KEY (`DocumentID`),
  UNIQUE INDEX `Unique_DocumentCode_DocumentMaster` (`DocumentCode` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`documentrouting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`documentrouting` (
  `RoutingID` INT(11) NOT NULL AUTO_INCREMENT,
  `UserAccount` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `ApprovalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `RoutingOrder` INT(11) NULL DEFAULT NULL,
  `DocumentId` SMALLINT(6) NULL DEFAULT NULL,
  `Description` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  PRIMARY KEY (`RoutingID`),
  INDEX `FK_DocumentRouting_DocumentMaster` (`DocumentId` ASC),
  CONSTRAINT `FK_DocumentRouting_DocumentMaster`
    FOREIGN KEY (`DocumentId`)
    REFERENCES `ABCInventory`.`documentmaster` (`DocumentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`employeemaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`employeemaster` (
  `EmployeeID` INT(11) NOT NULL AUTO_INCREMENT,
  `EmpCode` VARCHAR(20) CHARACTER SET 'utf8mb4' NOT NULL,
  `LastName` VARCHAR(20) CHARACTER SET 'utf8mb4' NOT NULL,
  `FirstName` VARCHAR(10) CHARACTER SET 'utf8mb4' NOT NULL,
  `Title` VARCHAR(30) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `TitleOfCourtesy` VARCHAR(25) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `BirthDate` DATETIME(6) NULL DEFAULT NULL,
  `HireDate` DATETIME(6) NULL DEFAULT NULL,
  `Address` VARCHAR(60) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `City` VARCHAR(15) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Region` VARCHAR(15) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `PostalCode` VARCHAR(10) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Country` VARCHAR(15) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `HomePhone` VARCHAR(24) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Extension` VARCHAR(4) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Photo` LONGBLOB NULL DEFAULT NULL,
  `Notes` LONGTEXT NULL DEFAULT NULL,
  `ReportsTo` INT(11) NULL DEFAULT NULL,
  `PhotoPath` VARCHAR(255) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `StoreId` INT(11) NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATE NULL DEFAULT NULL,
  `ModifedBy` VARCHAR(50) NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `PrimaryEmail` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `AlternateEmail` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `PrimaryPhoneNo` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `AlternatePhoneNo` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `UC_EmployeeMaster` (`EmpCode` ASC),
  INDEX `FK_Employees_Employees` (`ReportsTo` ASC),
  CONSTRAINT `FK_Employees_Employees`
    FOREIGN KEY (`ReportsTo`)
    REFERENCES `ABCInventory`.`employeemaster` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`fin_year_master`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`fin_year_master` (
  `Id_Fin_year` INT(11) NOT NULL AUTO_INCREMENT,
  `From_date` DATETIME(6) NULL DEFAULT NULL,
  `To_date` DATETIME(6) NULL DEFAULT NULL,
  `Fin_year` VARCHAR(50) NULL DEFAULT NULL,
  `Description` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`Id_Fin_year`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`menus` (
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
  PRIMARY KEY (`ModuleID`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`stores` (
  `StoreID` INT(11) NOT NULL AUTO_INCREMENT,
  `StoreName` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Address` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `City` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CompanyID` INT(11) NULL DEFAULT NULL,
  `ManagedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Phone1` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Phone2` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Email` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`StoreID`),
  INDEX `Stores_CompanyID_FK` (`CompanyID` ASC),
  CONSTRAINT `Stores_CompanyID_FK`
    FOREIGN KEY (`CompanyID`)
    REFERENCES `ABCInventory`.`companymaster` (`CompanyID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`order_details` (
  `OrderDetailId` INT(11) NOT NULL AUTO_INCREMENT,
  `OrderId` INT(11) NOT NULL,
  `ProductCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `ProductID` VARCHAR(100) CHARACTER SET 'utf8mb4' NOT NULL,
  `BarCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `quantity` INT(11) NOT NULL,
  `UOM` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `company_price` DECIMAL(10,2) NOT NULL,
  `SubtotalAmount` DECIMAL(10,2) NOT NULL,
  `TaxAmount` DECIMAL(10,2) NOT NULL,
  `TotalAmount` DECIMAL(10,2) NOT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `StoreID` INT(11) NOT NULL,
  PRIMARY KEY (`OrderDetailId`),
  INDEX `Order_Details_StoreID_FK` (`StoreID` ASC),
  CONSTRAINT `Order_Details_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`orders` (
  `OrderId` INT(11) NOT NULL AUTO_INCREMENT,
  `StoreID` INT(11) NOT NULL,
  `OrderNumber` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `OrderType` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `PartnerID` INT(11) NULL DEFAULT NULL,
  `ExpectedDeliveryDate` DATETIME(6) NULL DEFAULT NULL,
  `SubtotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TaxAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `Note` VARCHAR(500) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `OrderStatus` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `FixedDiscount` DECIMAL(10,2) NULL DEFAULT NULL,
  `PercentDiscount` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`OrderId`),
  INDEX `Lookup_OrderStatus_Like_POStatus_FK` (`OrderStatus` ASC),
  INDEX `Order_Lookup_OrderType_FK` (`OrderType` ASC),
  INDEX `Order_StoreID_FK` (`StoreID` ASC),
  INDEX `Order_PartnerID_FK` (`PartnerID` ASC),
  CONSTRAINT `Lookup_OrderStatus_Like_POStatus_FK`
    FOREIGN KEY (`OrderStatus`)
    REFERENCES `ABCInventory`.`lookup` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Order_Lookup_OrderType_FK`
    FOREIGN KEY (`OrderType`)
    REFERENCES `ABCInventory`.`lookup` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Order_PartnerID_FK`
    FOREIGN KEY (`PartnerID`)
    REFERENCES `ABCInventory`.`partners` (`PartnerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Order_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`permission_role_mapping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`permission_role_mapping` (
  `MappingID` INT(11) NOT NULL AUTO_INCREMENT,
  `RoleID` INT(11) NOT NULL,
  `PermissionID` INT(11) NOT NULL,
  `Description` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `PermissionGranted` BIT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`MappingID`))
ENGINE = InnoDB
AUTO_INCREMENT = 49
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`permissionmaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`permissionmaster` (
  `PermissionId` INT(11) NOT NULL AUTO_INCREMENT,
  `PermissionName` VARCHAR(100) CHARACTER SET 'utf8mb4' NOT NULL,
  `Description` VARCHAR(150) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModuleId` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`PermissionId`),
  INDEX `FK__Permissio__Modul__489AC854` (`ModuleId` ASC),
  CONSTRAINT `FK__Permissio__Modul__47A6A41B`
    FOREIGN KEY (`ModuleId`)
    REFERENCES `ABCInventory`.`menus` (`ModuleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK__Permissio__Modul__489AC854`
    FOREIGN KEY (`ModuleId`)
    REFERENCES `ABCInventory`.`menus` (`ModuleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 30
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`productdetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`productdetail` (
  `ProductDetailId` INT(11) NOT NULL AUTO_INCREMENT,
  `ProductID` INT(11) NOT NULL,
  `StoreID` INT(11) NOT NULL,
  `AutoPO` TINYINT(1) NULL DEFAULT '0',
  `RePOorderLevel` INT(11) NULL DEFAULT NULL,
  `RePOorderQuantity` INT(11) NULL DEFAULT NULL,
  `ReSOorderLevel` INT(11) NULL DEFAULT NULL,
  `ReSOorderQuantity` INT(11) NULL DEFAULT NULL,
  `AutoSO` TINYINT(1) NULL DEFAULT '0',
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `Discontinued` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`ProductDetailId`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`productmaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`productmaster` (
  `ProductID` INT(11) NOT NULL AUTO_INCREMENT,
  `ProductCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `ProductName` VARCHAR(100) CHARACTER SET 'utf8mb4' NOT NULL,
  `BarCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `categoryId` INT(11) NULL DEFAULT NULL,
  `UOM` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `LockStatus` INT(11) NULL DEFAULT '1',
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `Discontinued` TINYINT(1) NOT NULL DEFAULT '0',
  `PartnerID` INT(11) NOT NULL,
  PRIMARY KEY (`ProductID`),
  INDEX `FK_CateryMaster_ProductMaster` (`categoryId` ASC),
  INDEX `productmaster_Partners_FK` (`PartnerID` ASC),
  CONSTRAINT `FK_CateryMaster_ProductMaster`
    FOREIGN KEY (`categoryId`)
    REFERENCES `ABCInventory`.`categorymaster` (`CategoryID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `productmaster_Partners_FK`
    FOREIGN KEY (`PartnerID`)
    REFERENCES `ABCInventory`.`partners` (`PartnerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`productprice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`productprice` (
  `ProductPriceId` INT(11) NOT NULL AUTO_INCREMENT,
  `ProductID` INT(11) NOT NULL,
  `StoreID` INT(11) NOT NULL,
  `PriceType` DECIMAL(10,2) NULL DEFAULT NULL,
  `Price` DECIMAL(10,2) NULL DEFAULT NULL,
  `FixedDiscountOnBuy` DECIMAL(10,2) NULL DEFAULT NULL,
  `PercentDiscountOnBuy` DECIMAL(10,2) NULL DEFAULT NULL,
  `FixedDiscountForSale` DECIMAL(10,2) NULL DEFAULT NULL,
  `PercentDiscountForSale` DECIMAL(10,2) NULL DEFAULT NULL,
  `Start_Date` DATE NULL DEFAULT NULL,
  `End_Date` DATE NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`ProductPriceId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`productsforsale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`productsforsale` (
  `ProductAvID` INT(11) NOT NULL AUTO_INCREMENT,
  `ProductCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `BarCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `StoreID` INT(11) NOT NULL,
  `UnitsInStock` INT(11) NULL DEFAULT NULL,
  `UnitsOnSO` INT(11) NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATETIME(6) NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATETIME(6) NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT NULL,
  `Deleted` TINYINT(1) NOT NULL DEFAULT '0',
  `UnitsOnPO` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ProductAvID`),
  INDEX `FK_Stores_ProductsForSale` (`StoreID` ASC),
  CONSTRAINT `FK_Stores_ProductsForSale`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`purchase` (
  `Stock_Id` INT(11) NOT NULL AUTO_INCREMENT,
  `StoreID` INT(11) NOT NULL,
  `POInvoiceNo` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `InvoiceDate` DATETIME(6) NULL DEFAULT NULL,
  `Lot` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `PONumber` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `PartnerID` INT(11) NULL DEFAULT NULL,
  `ReceivedDate` DATETIME(6) NULL DEFAULT NULL,
  `StockAcceptedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `SubtotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `PaymentDueDate` DATETIME(6) NULL DEFAULT NULL,
  `BalanceAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `Note` VARCHAR(500) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `POStatus` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `TaxAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `PercentDiscount` DECIMAL(10,2) NULL DEFAULT NULL,
  `FixedDiscount` DECIMAL(10,2) NULL DEFAULT NULL,
  `DeliveryCharges` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`Stock_Id`),
  UNIQUE INDEX `Purchase_StoreID_Lot_Unique` (`StoreID` ASC, `Lot` ASC),
  INDEX `Purchase_PartnerID_FK` (`PartnerID` ASC),
  CONSTRAINT `Purchase_PartnerID_FK`
    FOREIGN KEY (`PartnerID`)
    REFERENCES `ABCInventory`.`partners` (`PartnerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Purchase_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`purchase_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`purchase_details` (
  `PurchaseDetailId` INT(11) NOT NULL AUTO_INCREMENT,
  `Stock_Id` INT(11) NOT NULL,
  `Lot` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ProductCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `ProductID` VARCHAR(100) CHARACTER SET 'utf8mb4' NOT NULL,
  `BarCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `OriginalQuantityReceived` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `Expiredate` DATE NULL DEFAULT NULL,
  `UOM` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `company_price` DECIMAL(10,2) NOT NULL,
  `opening_stock` INT(11) NOT NULL,
  `closing_stock` INT(11) NOT NULL,
  `SubtotalAmount` DECIMAL(10,2) NOT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `TotalAmount` DECIMAL(10,2) NOT NULL,
  `TaxAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `PercentDiscount` DECIMAL(10,2) NULL DEFAULT NULL,
  `FixedDiscount` DECIMAL(10,2) NULL DEFAULT NULL,
  `StoreID` INT(11) NOT NULL,
  PRIMARY KEY (`PurchaseDetailId`),
  INDEX `FK_Purchase_PurchaseDetails` (`Stock_Id` ASC),
  INDEX `PurchaseDetails_StoreID_FK` (`StoreID` ASC),
  CONSTRAINT `FK_Purchase_PurchaseDetails`
    FOREIGN KEY (`Stock_Id`)
    REFERENCES `ABCInventory`.`purchase` (`Stock_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PurchaseDetails_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`purchase_return`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`purchase_return` (
  `PurchaseReturnID` INT(11) NOT NULL AUTO_INCREMENT,
  `Stock_Id` INT(11) NOT NULL,
  `StoreID` INT(11) NULL DEFAULT NULL,
  `Lot` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `DebitInvoiceNumber` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `SubtotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TaxAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TotalAmount` DECIMAL(10,2) NOT NULL,
  `PaymentReceiveDueDate` DATETIME(6) NULL DEFAULT NULL,
  `PaymentDueDate` DATETIME(6) NULL DEFAULT NULL,
  `BalanceAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `Note` VARCHAR(500) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`PurchaseReturnID`),
  UNIQUE INDEX `PurchaseReturn_StoreID_Lot_Unique` (`StoreID` ASC, `Lot` ASC),
  INDEX `PurchaseReturn_Stock_Id_FK` (`Stock_Id` ASC),
  CONSTRAINT `FK_Stores_PurchaseReturn`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PurchaseReturn_Stock_Id_FK`
    FOREIGN KEY (`Stock_Id`)
    REFERENCES `ABCInventory`.`purchase` (`Stock_Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`purchase_return_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`purchase_return_details` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `PurchaseReturnID` INT(11) NOT NULL,
  `ProductCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `BarCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `quantity` INT(11) NOT NULL,
  `SubtotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TaxAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TotalAmount` DECIMAL(10,2) NOT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `StoreID` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `PurchaseReturnDetail_PurchaseReturnID_FK` (`PurchaseReturnID` ASC),
  INDEX `PurchaseReturnDetail_StoreID_FK` (`StoreID` ASC),
  CONSTRAINT `PurchaseReturnDetail_PurchaseReturnID_FK`
    FOREIGN KEY (`PurchaseReturnID`)
    REFERENCES `ABCInventory`.`purchase_return` (`PurchaseReturnID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PurchaseReturnDetail_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`rolemaster`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`rolemaster` (
  `RoleId` INT(11) NOT NULL AUTO_INCREMENT,
  `RoleName` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `RoleDescription` VARCHAR(100) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT NULL,
  PRIMARY KEY (`RoleId`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`sales` (
  `Saleid` INT(11) NOT NULL AUTO_INCREMENT,
  `BillNumber` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `DateofSale` DATETIME(6) NOT NULL,
  `CustomerCode` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CustomerBarCode` VARCHAR(120) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `SubTotal` DECIMAL(10,2) NULL DEFAULT NULL,
  `TaxAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TotalAmount` DECIMAL(10,2) NOT NULL,
  `BalanceAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `PaymentDueOn` DATETIME(6) NULL DEFAULT NULL,
  `Comment` VARCHAR(500) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `StoreID` INT(11) NOT NULL,
  PRIMARY KEY (`Saleid`),
  INDEX `sales_StoreID_FK` (`StoreID` ASC),
  CONSTRAINT `sales_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`sales_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`sales_details` (
  `SalesDetailId` INT(11) NOT NULL AUTO_INCREMENT,
  `Saleid` INT(11) NULL DEFAULT NULL,
  `ProductCode` VARCHAR(200) CHARACTER SET 'utf8mb4' NOT NULL,
  `BarCode` VARCHAR(200) CHARACTER SET 'utf8mb4' NOT NULL,
  `selling_price` DECIMAL(10,2) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `StoreID` INT(11) NOT NULL,
  PRIMARY KEY (`SalesDetailId`),
  INDEX `FK_sales_SalesDetail` (`Saleid` ASC),
  INDEX `SalesDetail_StoreID_FK` (`StoreID` ASC),
  CONSTRAINT `FK_sales_SalesDetail`
    FOREIGN KEY (`Saleid`)
    REFERENCES `ABCInventory`.`sales` (`Saleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `SalesDetail_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`sales_return`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`sales_return` (
  `SalesReturnId` INT(11) NOT NULL AUTO_INCREMENT,
  `SaleId` INT(11) NOT NULL,
  `DateofReturn` DATETIME(6) NOT NULL,
  `CustomerBarCode` VARCHAR(120) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `SubTotal` DECIMAL(10,2) NULL DEFAULT NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  `BalanceAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `PaymentDueOn` DATETIME(6) NULL DEFAULT NULL,
  `Comment` VARCHAR(500) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `BillNumber` VARCHAR(120) CHARACTER SET 'utf8mb4' NOT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `StoreID` INT(11) NOT NULL,
  PRIMARY KEY (`SalesReturnId`),
  INDEX `fk_SalesReturn` (`SaleId` ASC),
  INDEX `SalesReturn_StoreID_FK` (`StoreID` ASC),
  CONSTRAINT `SalesReturn_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SalesReturn`
    FOREIGN KEY (`SaleId`)
    REFERENCES `ABCInventory`.`sales` (`Saleid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`sales_return_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`sales_return_details` (
  `SalesReturnDetailId` INT(11) NOT NULL AUTO_INCREMENT,
  `SalesReturnId` INT(11) NULL DEFAULT NULL,
  `ProductCode` VARCHAR(200) CHARACTER SET 'utf8mb4' NOT NULL,
  `selling_price` DECIMAL(10,2) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedDate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  `StoreID` INT(11) NOT NULL,
  PRIMARY KEY (`SalesReturnDetailId`),
  INDEX `fk_SalesReturnDetail` (`SalesReturnId` ASC),
  INDEX `SalesReturnDetail_StoreID_FK` (`StoreID` ASC),
  CONSTRAINT `SalesReturnDetail_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SalesReturnDetail`
    FOREIGN KEY (`SalesReturnId`)
    REFERENCES `ABCInventory`.`sales_return` (`SalesReturnId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`scrap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`scrap` (
  `ScrapId` INT(11) NOT NULL AUTO_INCREMENT,
  `StoreID` INT(11) NOT NULL,
  `OrderNumber` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `OrderType` VARCHAR(50) CHARACTER SET 'utf8mb4' NOT NULL,
  `SubtotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TaxAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `Note` VARCHAR(500) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`ScrapId`),
  INDEX `scrap_Lookup_OrderType_FK` (`OrderType` ASC),
  INDEX `scrap_StoreID_FK` (`StoreID` ASC),
  CONSTRAINT `scrap_Lookup_OrderType_FK`
    FOREIGN KEY (`OrderType`)
    REFERENCES `ABCInventory`.`lookup` (`Code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `scrap_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`scrap_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`scrap_details` (
  `ScrapDetailId` INT(11) NOT NULL AUTO_INCREMENT,
  `ScrapId` INT(11) NOT NULL,
  `StoreID` INT(11) NOT NULL,
  `ProductID` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `UOM` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `company_price` DECIMAL(10,2) NULL DEFAULT NULL,
  `SubtotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TaxAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `TotalAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT '1',
  `Deleted` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`ScrapDetailId`),
  INDEX `scrap_details_StoreID_FK` (`StoreID` ASC),
  INDEX `scrap_details_ProductID_FK` (`ProductID` ASC),
  INDEX `scrap_details_ScrapId_FK` (`ScrapId` ASC),
  CONSTRAINT `scrap_details_ProductID_FK`
    FOREIGN KEY (`ProductID`)
    REFERENCES `ABCInventory`.`productmaster` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `scrap_details_ScrapId_FK`
    FOREIGN KEY (`ScrapId`)
    REFERENCES `ABCInventory`.`scrap` (`ScrapId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `scrap_details_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`tax_master`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`tax_master` (
  `TaxId` INT(11) NOT NULL AUTO_INCREMENT,
  `CategoryId` VARCHAR(50) NULL DEFAULT NULL,
  `FixedTaxValue` DECIMAL(18,2) NULL DEFAULT NULL,
  `PercentTaxValue` DECIMAL(18,2) NULL DEFAULT NULL,
  `Description` LONGTEXT NULL DEFAULT NULL,
  `Form_Type` VARCHAR(50) NULL DEFAULT NULL,
  `Id_Fin_year` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`TaxId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `ABCInventory`.`transactiondetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ABCInventory`.`transactiondetail` (
  `ID` INT(11) NOT NULL AUTO_INCREMENT,
  `InvoiceNo` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `InvoiceType` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `TransactionAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `ModeOfPayment` VARCHAR(150) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `TransactionDate` DATETIME(6) NULL DEFAULT NULL,
  `TransactionID` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `BankName` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ChequeNo` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ChequeDate` DATETIME(6) NULL DEFAULT NULL,
  `ChequeAmount` DECIMAL(10,2) NULL DEFAULT NULL,
  `CreatedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `Createddate` DATE NULL DEFAULT NULL,
  `ModifiedBy` VARCHAR(50) CHARACTER SET 'utf8mb4' NULL DEFAULT NULL,
  `ModifiedDate` DATE NULL DEFAULT NULL,
  `LockStatus` SMALLINT(6) NULL DEFAULT NULL,
  `StoreID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `TransactionDetail_StoreID_FK` (`StoreID` ASC),
  CONSTRAINT `TransactionDetail_StoreID_FK`
    FOREIGN KEY (`StoreID`)
    REFERENCES `ABCInventory`.`stores` (`StoreID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `ABCInventory` ;

-- -----------------------------------------------------
-- procedure ERP_Delete_Category
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Delete_Category`(
p_UserAccount varchar(50)
,p_CategoryId integer
,out p_ReturnValue int )
BEGIN

Declare v_CategoryName nvarchar(50);

/*  start catch block */
DECLARE exit handler for sqlexception
BEGIN
	rollback;
    
	GET DIAGNOSTICS CONDITION 1 @p2 = MESSAGE_TEXT; /* use @p2 as output parameter otherwise it will not work */
	CALL ERP_Insert_ErrorLog ( p_UserAccount,'ERP_Delete_Category', @p2 );
	SET p_ReturnValue=-9;
END;
/* End Catch block */

/* start Main block */
START TRANSACTION;
 
	 SELECT CategoryName INTO v_CategoryName  From categorymaster where CategoryId=p_CategoryId; 
	 
	 DELETE FROM categorymaster where CategoryID=p_CategoryId;
	 
	 SET v_CategoryName=CONCAT('Deleted Category:', v_CategoryName);
     
	 CALL ERP_Insert_AuditLog( p_UserAccount, v_CategoryName);
	 SET p_ReturnValue=p_CategoryId;
 
COMMIT;
/* end  main block */
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Delete_Partners
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Delete_Partners`(
	userAccount nvarchar(50),
	p_partnerId int,
	p_partnerCode nvarchar(50),
	returnValue int)
BEGIN
	IF p_partnerId>0 THEN
		SELECT partnername=partnername From partners where partnerid=p_partnerId;
		DELETE FROM  partners WHERE  PartnerID=p_partnerId;
   ELSEIF LENGth(p_partnerCode)>0 then
		SELECT partnername=partnername From partners where partnerCode=p_partnerCode;
		DELETE FROM  partners WHERE  PartnerID=p_partnerId;
   END if;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Get_Categories
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Get_Categories`(
p_UserAccount varchar(50))
BEGIN

	-- Declare @NextCategoryCode nvarchar(50)
	-- SELECT  @NextCategoryCode=  [dbo].[getDocumentNo]('Category','CategoryMaster')
	-- print @NextCategoryCode
	
	SELECT  CategoryID,CategoryCode,  CategoryName,  Description,LockStatus 
	FROM categorymaster; 
	-- SET @NextCategoryCode=isnull(@NextCategoryCode,'') 

	-- SET @txt='ALL Categories accessed.'
	-- EXEC ERP_Insert_AuditLog @UserAccount, @txt
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Get_CategoryById
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Get_CategoryById`(
p_UserAccount nvarchar(50)
,p_CategoryId integer)
BEGIN
SELECT  CategoryID,CategoryCode,  CategoryName,    Description,LockStatus  
FROM categorymaster where CategoryID=p_CategoryId; 
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Get_Companies
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Get_Companies`(
p_UserAccount varchar(50)
)
Begin  
          select CompanyID,   CompanyCode ,  CompanyName,  RegistrationNo ,  Address , City ,   TIN ,   Phone1 ,   Phone2 , website ,    ContactEmail , OwnedBy 
          from companymaster;  
  
 End$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Get_CompanyByID
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Get_CompanyByID`(
p_UserAccount varchar(50)/* =null */,
p_CompanyID int/* =null */
)
BEGIN
	Select CompanyID, CompanyCode , CompanyName  ,  RegistrationNo, Address ,   City ,  TIN,  Phone1 ,  Phone2 ,   website ,   ContactEmail , OwnedBy    
	 from companymaster where CompanyID=p_CompanyID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Get_LookUpData
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Get_LookUpData`(
lookupType nvarchar(50))
BEGIN

SELECT Code, `Text` FROM lookup
Where `TYPE`=lookupType and Deleted=0;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Get_Menu
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Get_Menu`( 
p_UserAccount varchar(50)
,p_RoleID int)
BEGIN
 Select ModuleID, ModuleName,ParentID,Description, ActionName, ControllerName         
 from menus m Where ModuleID in(
 Select ModuleID from  permissionmaster pm
 Inner join permission_role_mapping rm on rm.PermissionID=pm.PermissionId and RoleID=p_RoleID
 )
 and isEnabled=1; 
 
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Insert_AuditLog
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Insert_AuditLog`(
userAccount nvarchar(50)
,actionDetail nvarchar(500))
BEGIN


INSERT INTO auditlog
           (`ActionDoneBy`
           ,`Description`
           ,`CreatedDate`
           ,`Deleted`)
     VALUES
           (userAccount
           ,actionDetail
           ,NOW()
           ,0);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Insert_ErrorLog
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Insert_ErrorLog`(  
userAccount nvarchar(50) 
,procedureName nvarchar(50) 
,exception nvarchar(4000))
BEGIN  
  Declare v_Message nvarchar(100);
  SET v_Message =CONCAT('Error occured in Stored Procedure: ',procedureName);
INSERT INTO `UserManagement`.errorlog   
           (`Date`  
           ,`Thread`  
           ,`Level`  
           ,`Logger`  
           ,`Message`  
           ,`Exception`)  
     VALUES  
           (  
            NOW()  
           ,Concat('user: ' , userAccount)  
           ,'Error in Database'  
           ,null
           ,v_Message  
           ,exception
           ) ; 
  
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Is_Role_HasPermission
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Is_Role_HasPermission`(
p_UserAccount nvarchar(50)
,p_RoleId int
,p_PermissionName nvarchar(100))
BEGIN
	DECLARE v_PermissionExists tinyint;
	IF EXISTS( SELECT 1 FROM permissionmaster PM INNER JOIN permission_role_mapping RM on PM.PermissionId=RM.PermissionID 
	WHERE RoleID=p_RoleId and PermissionName=p_PermissionName) THEN
		SET v_PermissionExists=1;
	ELSE
		SET v_PermissionExists=0;
	END IF;
	
 SELECT v_PermissionExists AS IsPermissionExists;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ERP_Save_Category
-- -----------------------------------------------------

DELIMITER $$
USE `ABCInventory`$$
CREATE DEFINER=`root`@`%` PROCEDURE `ERP_Save_Category`(
p_UserAccount nvarchar(50),
p_CategoryId integer,
p_CategoryCode nvarchar(50),
p_CategoryName nvarchar(50),
p_Description nvarchar(500),
out p_ReturnValue int )
BEGIN
	DECLARE v_DetailedErrorDesc VARCHAR(5000);
	DECLARE v_txt nVarchar(500);
    
	/*  start catch block */
	DECLARE exit handler for sqlexception
	BEGIN
		rollback;
		
		GET DIAGNOSTICS CONDITION 1 @p2 = MESSAGE_TEXT; /* use @p2 as output parameter otherwise it will not work */
		CALL ERP_Insert_ErrorLog ( p_UserAccount,'ERP_Save_Category', @p2 );
		SET p_ReturnValue=-9;
	END;
	/* End Catch block */

	/* start Main block */
	START TRANSACTION;
	 
		IF NOT Exists(Select 1 from categorymaster where CategoryID=p_CategoryId)
		THEN
		 IF NOT Exists(Select 1 from categorymaster where CategoryCode=p_CategoryCode)
	     THEN
			INSERT INTO categorymaster
					   (`CategoryCode`
					   ,`CategoryName`
					   ,`Description`
					   ,`CreatedBy`
					   ,`CreatedDate`
					   
					   )
				 VALUES
					   (
					   p_CategoryCode,
					   p_CategoryName,
					   p_Description
					   ,p_UserAccount
					   ,NOW()
					   );
                       
			 SET p_ReturnValue=LAST_INSERT_ID();
			 SET v_txt=CONCAT('Inserted category named: ', p_CategoryName);
			 CALL ERP_Insert_AuditLog(p_UserAccount, v_txt);
	     ELSE
			SET p_ReturnValue= -99; -- code exists
		 END IF;
		ELSE
			UPDATE categorymaster
			SET 
			`CategoryName` = p_CategoryName
			,`Description` = p_Description
			,ModifiedBy=p_UserAccount
			,ModifiedDate=NOW()
			WHERE CategoryID=p_CategoryId and CategoryCode=p_CategoryCode;

			SET p_ReturnValue=p_CategoryId; 

			SET v_txt=CONCAT('Updated category named :', p_CategoryName);
			CALL ERP_Insert_AuditLog(p_UserAccount, v_txt);
	 
	   END IF;
	     
	 
	COMMIT;
	/* end  main block */
    
    	
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
