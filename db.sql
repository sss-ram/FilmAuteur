-- Create the 'Users' table to store information about users (farmers and businesses)
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    UserType ENUM('Farmer', 'Business') NOT NULL
);

-- Create the 'Products' table to store information about different types of produce
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Category VARCHAR(100),
    Price DECIMAL(10, 2) NOT NULL
);

-- Create the 'Listings' table to represent produce listings by businesses
CREATE TABLE Listings (
    ListingID INT PRIMARY KEY AUTO_INCREMENT,
    BusinessID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Unit VARCHAR(50),
    PricePerUnit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (BusinessID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create the 'Orders' table to represent orders placed by farmers
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    FarmerID INT NOT NULL,
    ListingID INT NOT NULL,
    Quantity INT NOT NULL,
    OrderDate DATE,
    FOREIGN KEY (FarmerID) REFERENCES Users(UserID),
    FOREIGN KEY (ListingID) REFERENCES Listings(ListingID)
);

-- Create the 'Reviews' table to store reviews and ratings for users and products
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT NOT NULL,
    ProductID INT,
    Rating INT NOT NULL,
    Comment TEXT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
