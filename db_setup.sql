-- Disable foreign key checks to prevent errors during table creation
SET foreign_key_checks = 0;

-- Drop tables if they already exist
DROP TABLE IF EXISTS ListingServices;
DROP TABLE IF EXISTS ContractorServices;
DROP TABLE IF EXISTS RestaurantImages;
DROP TABLE IF EXISTS Listings;
DROP TABLE IF EXISTS Contractors;
DROP TABLE IF EXISTS Restaurants;
DROP TABLE IF EXISTS Services_Offered;

-- Enable foreign key checks after dropping tables
SET foreign_key_checks = 1;

-- Create the Services_Offered table
CREATE TABLE Services_Offered (
  _id CHAR(36) NOT NULL,
  ServiceName VARCHAR(255),
  Description TEXT,
  PRIMARY KEY (_id)
);

-- Create the Restaurants table
CREATE TABLE Restaurants (
  _id CHAR(36) NOT NULL,
  Email VARCHAR(255),
  Link VARCHAR(255) UNIQUE,
  TipNoTip BOOLEAN,
  About TEXT,
  PRIMARY KEY (_id)
);

-- Create the RestaurantImages table to store list of image links
CREATE TABLE RestaurantImages (
  _id CHAR(36) NOT NULL,
  Restaurant_id CHAR(36) NOT NULL,
  ImageLink VARCHAR(255),
  PRIMARY KEY (_id),
  FOREIGN KEY (Restaurant_id) REFERENCES Restaurants(_id)
);

-- Create the Contractors table
CREATE TABLE Contractors (
  _id CHAR(36) NOT NULL,
  Email VARCHAR(255),
  PortfolioLink VARCHAR(255),
  Bio TEXT,
  PRIMARY KEY (_id)
);

-- Junction table for Contractors and Services_Offered (many-to-many relationship)
CREATE TABLE ContractorServices (
  Contractor_id CHAR(36) NOT NULL,
  Service_id CHAR(36) NOT NULL,
  PRIMARY KEY (Contractor_id, Service_id),
  FOREIGN KEY (Contractor_id) REFERENCES Contractors(_id),
  FOREIGN KEY (Service_id) REFERENCES Services_Offered(_id)
);

-- Create the Listings table
CREATE TABLE Listings (
  _id CHAR(36) NOT NULL,
  RestaurantLink VARCHAR(255) NOT NULL,
  Description TEXT,
  Fulfilled BOOLEAN,
  PRIMARY KEY (_id),
  FOREIGN KEY (RestaurantLink) REFERENCES Restaurants(Link)
);

-- Junction table for Listings and Services_Offered (many-to-many relationship)
CREATE TABLE ListingServices (
  Listing_id CHAR(36) NOT NULL,
  Service_id CHAR(36) NOT NULL,
  PRIMARY KEY (Listing_id, Service_id),
  FOREIGN KEY (Listing_id) REFERENCES Listings(_id),
  FOREIGN KEY (Service_id) REFERENCES Services_Offered(_id)
);


CREATE OR REPLACE VIEW RestaurantWithImages AS
SELECT
    r._id AS RestaurantID,
    r.Email,
    r.Link,
    r.TipNoTip,
    r.About,
    JSON_ARRAYAGG(ri.ImageLink) AS Images
FROM
    Restaurants r
LEFT JOIN
    RestaurantImages ri ON r._id = ri.Restaurant_id
GROUP BY
    r._id, r.Email, r.Link, r.TipNoTip, r.About;

CREATE OR REPLACE VIEW ContractorWithServices AS
SELECT
    c._id AS ContractorID,
    c.Email,
    c.PortfolioLink,
    c.Bio,
    JSON_ARRAYAGG(so.ServiceName) AS ServicesOffered
FROM
    Contractors c
LEFT JOIN
    ContractorServices cs ON c._id = cs.Contractor_id
LEFT JOIN
    Services_Offered so ON cs.Service_id = so._id
GROUP BY
    c._id, c.Email, c.PortfolioLink, c.Bio;

CREATE OR REPLACE VIEW ListingsWithServices AS
SELECT
    l._id AS ListingID,
    l.RestaurantLink,
    l.Description,
    l.Fulfilled,
    JSON_ARRAYAGG(so.ServiceName) AS ServicesRequested
FROM
    Listings l
LEFT JOIN
    ListingServices ls ON l._id = ls.Listing_id
LEFT JOIN
    Services_Offered so ON ls.Service_id = so._id
GROUP BY
    l._id, l.RestaurantLink, l.Description, l.Fulfilled;
  
CREATE OR REPLACE VIEW ListingsWithRestaurantInfo AS
SELECT
    l._id AS ListingID,
    l.Description AS ListingDescription,
    l.Fulfilled,
    r._id AS RestaurantID,
    r.Email AS RestaurantEmail,
    r.Link AS RestaurantLink,
    r.TipNoTip,
    r.About AS RestaurantAbout
FROM
    Listings l
LEFT JOIN
    Restaurants r ON l.RestaurantLink = r.Link;

CREATE OR REPLACE VIEW ServicesWithContractors AS
SELECT
    so._id AS ServiceID,
    so.ServiceName,
    so.Description AS ServiceDescription,
    JSON_ARRAYAGG(c._id) AS ContractorIDs,
    JSON_ARRAYAGG(c.Email) AS ContractorEmails
FROM
    Services_Offered so
LEFT JOIN
    ContractorServices cs ON so._id = cs.Service_id
LEFT JOIN
    Contractors c ON cs.Contractor_id = c._id
GROUP BY
    so._id, so.ServiceName, so.Description;

CREATE OR REPLACE VIEW RestaurantListingsWithServices AS
SELECT
    r._id AS RestaurantID,
    r.Email AS RestaurantEmail,
    r.Link AS RestaurantLink,
    l._id AS ListingID,
    l.Description AS ListingDescription,
    l.Fulfilled,
    JSON_ARRAYAGG(so.ServiceName) AS ServicesRequested
FROM
    Restaurants r
LEFT JOIN
    Listings l ON r.Link = l.RestaurantLink
LEFT JOIN
    ListingServices ls ON l._id = ls.Listing_id
LEFT JOIN
    Services_Offered so ON ls.Service_id = so._id
GROUP BY
    r._id, r.Email, r.Link, l._id, l.Description, l.Fulfilled;

CREATE OR REPLACE VIEW ContractorServiceDetails AS
SELECT
    c._id AS ContractorID,
    c.Email,
    c.PortfolioLink,
    c.Bio,
    so._id AS ServiceID,
    so.ServiceName,
    so.Description AS ServiceDescription
FROM
    Contractors c
LEFT JOIN
    ContractorServices cs ON c._id = cs.Contractor_id
LEFT JOIN
    Services_Offered so ON cs.Service_id = so._id;

CREATE OR REPLACE VIEW FullListingDetails AS
SELECT
    l._id AS ListingID,
    l.Description AS ListingDescription,
    l.Fulfilled,
    r._id AS RestaurantID,
    r.Email AS RestaurantEmail,
    r.Link AS RestaurantLink,
    GROUP_CONCAT(DISTINCT so.ServiceName) AS ServicesRequested,
    GROUP_CONCAT(DISTINCT c.Email) AS PotentialContractors
FROM
    Listings l
LEFT JOIN
    Restaurants r ON l.RestaurantLink = r.Link
LEFT JOIN
    ListingServices ls ON l._id = ls.Listing_id
LEFT JOIN
    Services_Offered so ON ls.Service_id = so._id
LEFT JOIN
    ContractorServices cs ON so._id = cs.Service_id
LEFT JOIN
    Contractors c ON cs.Contractor_id = c._id
GROUP BY
    l._id, l.Description, l.Fulfilled, r._id, r.Email, r.Link;
