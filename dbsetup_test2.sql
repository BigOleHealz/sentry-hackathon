INSERT INTO Services_Offered (_id, ServiceName, Description)
VALUES
  (UUID(), 'Catering', 'Provide food catering services for events.'),
  (UUID(), 'Interior Design', 'Design the interior of the restaurant.'),
  (UUID(), 'Marketing', 'Marketing services to help promote the restaurant.'),
  (UUID(), 'Photography', 'Photography services for menu items and restaurant ambiance.');

INSERT INTO Contractors (_id, Email, PortfolioLink, Bio)
VALUES
  (UUID(), 'contractor1@example.com', 'https://portfolio.com/contractor1', 'Specializes in restaurant interior design.'),
  (UUID(), 'contractor2@example.com', 'https://portfolio.com/contractor2', 'Offers professional catering services.'),
  (UUID(), 'contractor3@example.com', 'https://portfolio.com/contractor3', 'Photography services for restaurants.'),
  (UUID(), 'contractor4@example.com', 'https://portfolio.com/contractor4', 'Experienced in digital marketing for hospitality businesses.');

INSERT INTO ContractorServices (Contractor_id, Service_id)
VALUES
  (
    (SELECT _id FROM Contractors WHERE Email = 'contractor1@example.com' LIMIT 1), 
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Interior Design' LIMIT 1)
  ),
  (
    (SELECT _id FROM Contractors WHERE Email = 'contractor2@example.com' LIMIT 1), 
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Catering' LIMIT 1)
  ),
  (
    (SELECT _id FROM Contractors WHERE Email = 'contractor3@example.com' LIMIT 1), 
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Photography' LIMIT 1)
  ),
  (
    (SELECT _id FROM Contractors WHERE Email = 'contractor4@example.com' LIMIT 1), 
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Marketing' LIMIT 1)
  );
 
INSERT INTO Restaurants (_id, Email, Link, TipNoTip, About)
VALUES
  (UUID(), 'contact@restaurantA.com', 'restaurant-a', TRUE, 'A fine dining restaurant specializing in French cuisine.'),
  (UUID(), 'contact@restaurantB.com', 'restaurant-b', FALSE, 'Casual dining with an extensive selection of burgers and craft beers.'),
  (UUID(), 'contact@restaurantC.com', 'restaurant-c', TRUE, 'A family-owned Italian restaurant offering a variety of pastas and pizzas.');
 
INSERT INTO Listings (_id, RestaurantLink, Description, Fulfilled)
VALUES
  (UUID(), 'restaurant-a', 'Need catering services for a private event', FALSE),
  (UUID(), 'restaurant-b', 'Looking for a photographer to capture new menu items', FALSE),
  (UUID(), 'restaurant-c', 'Require interior design update for the dining area', TRUE);


 INSERT INTO ListingServices (Listing_id, Service_id)
VALUES
  (
    (SELECT _id FROM Listings WHERE Description = 'Need catering services for a private event' LIMIT 1),
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Catering' LIMIT 1)
  ),
  (
    (SELECT _id FROM Listings WHERE Description = 'Looking for a photographer to capture new menu items' LIMIT 1),
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Photography' LIMIT 1)
  ),
  (
    (SELECT _id FROM Listings WHERE Description = 'Require interior design update for the dining area' LIMIT 1),
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Interior Design' LIMIT 1)
  );
 
INSERT IGNORE INTO ContractorServices (Contractor_id, Service_id)
VALUES
  (
    (SELECT _id FROM Contractors WHERE Email = 'contractor1@example.com' LIMIT 1),
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Interior Design' LIMIT 1)
  ),
  (
    (SELECT _id FROM Contractors WHERE Email = 'contractor2@example.com' LIMIT 1),
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Catering' LIMIT 1)
  ),
  (
    (SELECT _id FROM Contractors WHERE Email = 'contractor3@example.com' LIMIT 1),
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Photography' LIMIT 1)
  ),
  (
    (SELECT _id FROM Contractors WHERE Email = 'contractor4@example.com' LIMIT 1),
    (SELECT _id FROM Services_Offered WHERE ServiceName = 'Marketing' LIMIT 1)
  );
 
   
INSERT INTO RestaurantImages (_id, Restaurant_id, ImageLink)
VALUES
  (
    UUID(), 
    (SELECT _id FROM Restaurants WHERE Link = 'restaurant-a' LIMIT 1), 
    'https://example.com/images/restaurantA_1.jpg'
  ),
  (
    UUID(), 
    (SELECT _id FROM Restaurants WHERE Link = 'restaurant-a' LIMIT 1), 
    'https://example.com/images/restaurantA_2.jpg'
  ),
  (
    UUID(), 
    (SELECT _id FROM Restaurants WHERE Link = 'restaurant-b' LIMIT 1), 
    'https://example.com/images/restaurantB_1.jpg'
  ),
  (
    UUID(), 
    (SELECT _id FROM Restaurants WHERE Link = 'restaurant-c' LIMIT 1), 
    'https://example.com/images/restaurantC_1.jpg'
  ),
  (
    UUID(), 
    (SELECT _id FROM Restaurants WHERE Link = 'restaurant-c' LIMIT 1), 
    'https://example.com/images/restaurantC_2.jpg'
  );