-- create database estate;
CREATE DATABASE estate;

use estate;

-- Create the Users Table
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create the Roles Table
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY AUTO_INCREMENT,
    RoleName VARCHAR(50) NOT NULL,
    Description TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create the UserRoles Table
CREATE TABLE UserRoles (
    UserRolesID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    RoleID INT NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Create the Agents Table
CREATE TABLE Agents (
    AgentID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT UNIQUE,
    LicenseNumber VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Create the Clients Table
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT UNIQUE,
    Phone VARCHAR(15),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Create the Owners Table
CREATE TABLE Owners (
    OwnerID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT UNIQUE,
    OwnerName VARCHAR(255),
    OwnerContactInfo VARCHAR(255),
    OwnershipStartDate DATE,
    OwnershipEndDate DATE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Create the Addresses Table
CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY AUTO_INCREMENT,
    Address VARCHAR(255),
    City VARCHAR(255),
    State VARCHAR(255),
    ZIPCode VARCHAR(10),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create the Properties Table
CREATE TABLE Properties (
    PropertyID INT PRIMARY KEY AUTO_INCREMENT,
    AddressID INT,
    PropertyType ENUM ('Single Family', 'Multi Family', 'Condo', 'Apartment', 'Townhouse', 'Other') NOT NULL,
    Price DECIMAL(10, 2),
    Bedrooms INT,
    Bathrooms DECIMAL(4, 2),
    SquareFootage INT,
    Description TEXT,
    ImageURL VARCHAR(255),
    AgentID INT,
    OwnerID INT,
    IsForSale ENUM('Yes', 'No') DEFAULT 'No',
    IsForRent ENUM('Yes', 'No') DEFAULT 'No',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID),
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID)
);

-- Create the Transactions Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    PropertyID INT,
    ClientID INT,
    AgentID INT,
    TransactionDate DATE,
    SalePrice DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    Status VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);


-- Create the Commission Table
CREATE TABLE Commission (
    CommissionID INT PRIMARY KEY AUTO_INCREMENT,
    AgentID INT,
    TransactionID INT,
    CommissionAmount DECIMAL(10, 2),
    CommissionPercentage DECIMAL(5, 2),
    CommissionDate DATE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID)
);

-- Create the PropertyImages Table
CREATE TABLE PropertyImages (
    ImageID INT PRIMARY KEY AUTO_INCREMENT,
    PropertyID INT,
    ImageURL VARCHAR(255),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID)
);


-- Create the Booking Table
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    PropertyID INT,
    ClientID INT,
    AgentID INT,
    BookingDateTime DATETIME,
    Purpose VARCHAR(255),
    Notes TEXT,
    Status VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID),
    FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);

show tables;