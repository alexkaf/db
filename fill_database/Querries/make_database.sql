DROP DATABASE ehotels;
CREATE DATABASE ehotels;
USE ehotels;

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
    IRS_Number BIGINT(10) NOT NULL,
    Last_Name VARCHAR(25) NOT NULL,
    First_Name VARCHAR(20) NOT NULL,
    Street VARCHAR(25),
    Number TINYINT(3),
    Postal_Code MEDIUMINT(5),
    City VARCHAR(30),
    First_Registration DATE,
    Social_Security_Number BIGINT(10) NOT NULL,
    PRIMARY KEY (IRS_Number));

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees(
    IRS_Number BIGINT(10) NOT NULL,
    Social_Security_Number BIGINT(10) NOT NULL,
    First_Name VARCHAR(20) NOT NULL,
    Last_Name VARCHAR(25) NOT NULL,
    Street VARCHAR(25),
    Number TINYINT(3),
    Postal_Code MEDIUMINT(5),
    City VARCHAR(30),
    PRIMARY KEY (IRS_Number));

DROP TABLE IF EXISTS Hotel_Group;
CREATE TABLE Hotel_Group(
    Hotel_Group_ID MEDIUMINT(6) NOT NULL,
    Hotel_Group_Name VARCHAR(20),
    Email VARCHAR(30),
    Phone_Number VARCHAR(50),
    Number_Of_Hotels TINYINT(3) NOT NULL,
    Street VARCHAR(25),
    Number TINYINT(3),
    City VARCHAR(30),
    Postal_Code MEDIUMINT(5),
    PRIMARY KEY (Hotel_Group_ID));

DROP TABLE IF EXISTS Hotels;
CREATE TABLE Hotels(
    Hotel_ID MEDIUMINT(6) NOT NULL,
    Email VARCHAR(50),
    Phone_Number VARCHAR(55),
    Stars TINYINT(1),
    Number_Of_Rooms TINYINT(3) NOT NULL,
    Street VARCHAR(25),
    Number TINYINT(3),
    Postal_Code MEDIUMINT(5),
    City VARCHAR(30),
    PRIMARY KEY (Hotel_ID));

DROP TABLE IF EXISTS Has_Hotels;
CREATE TABLE Has_Hotels (
    Hotel_Group_ID MEDIUMINT(6) NOT NULL,
    Hotel_ID MEDIUMINT(6) NOT NULL,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotels(Hotel_ID)
    ON DELETE CASCADE,
    FOREIGN KEY (Hotel_Group_ID) REFERENCES Hotel_Group(Hotel_Group_ID)
    ON DELETE CASCADE);

DROP TABLE IF EXISTS Hotel_Room;
CREATE TABLE Hotel_Room(
    Room_ID MEDIUMINT(5) NOT NULL AUTO_INCREMENT,
    Repairs_Need VARCHAR(20),
    Expandable VARCHAR(30),
    View VARCHAR(15),
    Capacity TINYINT(2),
    Amenities BLOB,
    Price FLOAT(5,2) NOT NULL,
    Hotel_ID MEDIUMINT(6) NOT NULL,
    PRIMARY KEY (Room_ID,Hotel_ID),
    FOREIGN KEY (Hotel_ID) REFERENCES Hotels(Hotel_ID)
    ON DELETE CASCADE);

DROP TABLE IF EXISTS Has_Room;
CREATE TABLE Has_Room(
    Hotel_ID MEDIUMINT(6) NOT NULL,
    Room_ID MEDIUMINT(5) NOT NULL,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotels(Hotel_ID)
    ON DELETE CASCADE,
    FOREIGN KEY (Room_ID) REFERENCES Hotel_Room(Room_ID)
    ON DELETE CASCADE);

DROP TABLE IF EXISTS Rents;
CREATE TABLE Rents (
    Rent_ID MEDIUMINT(5) NOT NULL AUTO_INCREMENT,
    IRS_Number_E BIGINT(10) NOT NULL,
    IRS_Number_C BIGINT(10) NOT NULL,
    Room_ID MEDIUMINT(5) NOT NULL,
    Start_Date DATE NOT NULL,
    Finish_Date DATE NOT NULL,
    Payment_ID MEDIUMINT(5) UNIQUE NOT NULL,
    PRIMARY KEY (Rent_ID),
    FOREIGN KEY (IRS_Number_C) REFERENCES Customers(IRS_Number)
    ON DELETE CASCADE);

DROP TABLE IF EXISTS Payment_Transaction;
CREATE TABLE Payment_Transaction (
    Payment_ID MEDIUMINT(5) NOT NULL,
    Payment_Amount FLOAT(10,2) NOT NULL,
    Payment_Method VARCHAR(20) NOT NULL,
    FOREIGN KEY (Payment_ID) REFERENCES Rents(Payment_ID)
    ON DELETE CASCADE);

DROP TABLE IF EXISTS Reserves;
CREATE TABLE Reserves(
    Reservation_ID MEDIUMINT(5) NOT NULL AUTO_INCREMENT,
    Room_ID MEDIUMINT(5) NOT NULL,
    IRS_Number BIGINT(10) NOT NULL,
    Start_Date DATE NOT NULL,
    Paid VARCHAR(3),
    Finish_Date DATE NOT NULL,
    Hotel_ID MEDIUMINT(6) NOT NULL,
    PRIMARY KEY (Reservation_ID),
    FOREIGN KEY (IRS_Number) REFERENCES Customers(IRS_Number)
    ON DELETE CASCADE);

DROP TABLE IF EXISTS Works;
CREATE TABLE Works (
    IRS_Number BIGINT(10) NOT NULL,
    Hotel_ID MEDIUMINT(6) NOT NULL,
    Start_Date DATE,
    Position VARCHAR(15),
    Finish_Date DATE,
    FOREIGN KEY (IRS_Number) REFERENCES Employees(IRS_Number)
    ON DELETE CASCADE,
    FOREIGN KEY (Hotel_ID) REFERENCES Hotels(Hotel_ID)
    ON DELETE CASCADE);

DROP TABLE IF EXISTS Logins;
CREATE TABLE Logins(
    IRS_Number BIGINT(10) NOT NULL,
    User_Name VARCHAR(20) NOT NULL,
    Password MEDIUMINT(6) NOT NULL,
    PRIMARY KEY (User_Name),
    FOREIGN KEY (IRS_Number) REFERENCES Employees(IRS_Number)
    ON DELETE CASCADE);

CREATE VIEW Capacity AS
SELECT Room_ID,Hotel_ID,Capacity
FROM Hotel_Room;

CREATE VIEW Room_Today AS
SELECT H.City,COUNT(HR.Room_ID)
FROM Hotel_Room as HR, Hotels as H
WHERE HR.Room_ID NOT IN (
    SELECT R.Room_ID
    FROM Reserves as R
    WHERE(
        (SELECT CURDATE()) BETWEEN R.Start_Date AND R.Finish_Date
    )
    )
    AND HR.Room_ID NOT IN (
        SELECT R.Room_ID
        FROM Rents as R
        WHERE(
            (SELECT CURDATE()) BETWEEN R.Start_Date AND R.Finish_Date
            )
    ) AND HR.Hotel_ID = H.Hotel_ID
GROUP BY H.City
ORDER BY COUNT(HR.Room_ID) DESC;