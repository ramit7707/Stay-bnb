CREATE SCHEMA STAYBNB;
SET search_path TO staybnb;


CREATE TABLE Users (
    User_ID varchar(20),
    Phone_Number char(10) NOT NULL,
    Full_Name varchar(30),
    Email varchar(15),
    Password varchar(150),
    Address varchar(20),
    Government_ID varchar(20),
    PRIMARY KEY (User_ID)
);


CREATE TABLE Preferences (
    Pref_ID BIGSERIAL NOT NULL,
    User_ID char(10),
    Pref_Amenities varchar(20),
    Pref_Property_Type varchar(20),
    Pref_Location varchar(20),
    PRIMARY KEY (Pref_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Host (
    Host_ID varchar(10) NOT NULL,
    Name varchar(20),
    Phone_Number varchar(15),
    Email varchar(30),
    Avg_Rating DECIMAL(5,2),
    Avg_Response_Time DECIMAL(6,2),
    Super_Host_Status bool,
    Total_Listing int,
    Response_Rate DECIMAL(5,2),
    PRIMARY KEY (Host_ID)
);


CREATE TABLE Host_Languages (
    Host_ID varchar(10) NOT NULL,
    Languages_Spoken varchar(20),
    PRIMARY KEY (Host_ID, Languages_Spoken),
    FOREIGN KEY (Host_ID) REFERENCES Host(Host_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Property_Category (
    Category_ID int NOT NULL,
    Category_Name varchar(20),
    PRIMARY KEY (Category_ID)
);


CREATE TABLE Property (
    Property_ID BIGSERIAL NOT NULL,
    Title varchar(20),
    Avg_Rating DECIMAL(5,2),
    Description varchar(100),
    Category_ID int,
    Price_Per_Night DECIMAL(8,2),
    Availability_Status varchar(15),
    No_of_Rooms int,
    No_of_Beds int,
    No_of_Bathrooms int,
    Accommodation_Limit int,
    Check_In_Time char(5),
    Check_Out_Time char(5),
    Pet_Permit bool,
    Smoking_Permit bool,
    Cancellation_Policy varchar(40),
    Host_ID varchar(10),
    Street_Name varchar(100),
    Street_Number varchar(10),
    Apartment_Number varchar(10),
    City varchar(20),
    State varchar(20),
    Country varchar(20),
    Zipcode int,
    PRIMARY KEY (Property_ID),
    FOREIGN KEY (Host_ID) REFERENCES Host(Host_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Category_ID) REFERENCES Property_Category(Category_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE Property_Amenities (
    Property_ID BIGINT NOT NULL,
    Amenity_Name varchar(50),
    PRIMARY KEY (Property_ID, Amenity_Name),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Ratings (
    User_ID char(10) NOT NULL,
    Property_ID BIGINT NOT NULL,
    Rating DECIMAL(4,1),
    Reviews varchar(200),
    PRIMARY KEY (User_ID, Property_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Wishlist (
    User_ID char(10) NOT NULL,
    Property_ID BIGINT NOT NULL,
    PRIMARY KEY (User_ID, Property_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Bookings (
    Booking_ID char(10) NOT NULL,
    User_ID char(10),
    Property_ID BIGINT,
    Booking_Date TIMESTAMP,
    CheckIn_Date DATE,
    CheckOut_Date DATE,
    Is_Confirmed bool,
    PRIMARY KEY (Booking_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Booking_Invoice (
    Invoice_ID char(10) NOT NULL,
    Booking_ID char(10),
    Transaction_ID char(10),
    Payment_Status varchar(10),
    Payment_Date DATE,
    Amount DECIMAL(8,2),
    PRIMARY KEY (Invoice_ID),
    FOREIGN KEY (Booking_ID) REFERENCES Bookings(Booking_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Booking_Cancellation (
    Cancellation_ID BIGSERIAL NOT NULL,
    Booking_ID char(10),
    Refund_Amount DECIMAL(8,2),
    Cancellation_Date TIMESTAMP,
    Cancellation_Reason varchar(100),
    Refund_Status varchar(10),
    PRIMARY KEY (Cancellation_ID),
    FOREIGN KEY (Booking_ID) REFERENCES Bookings(Booking_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE Contract_Details (
    Contract_ID SERIAL NOT NULL,
    Property_ID BIGINT NOT NULL,
    Commission_Per_Booking DECIMAL(6,2),
    Fixed_Monthly_Rent DECIMAL(8,2),
    Commission_Amount DECIMAL(8,2),
    Start_Date DATE,
    End_Date DATE,
    PRIMARY KEY (Contract_ID),
    FOREIGN KEY (Property_ID) REFERENCES Property(Property_ID)
);