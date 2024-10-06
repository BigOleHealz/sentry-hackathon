-- original: 
INSERT INTO Services_Offered (_id, ServiceName, Description)
VALUES
  (UUID(), 'Catering', 'Provide food catering services for events.'),
  (UUID(), 'Interior Design', 'Design the interior of the restaurant.'),
  (UUID(), 'Marketing', 'Marketing services to help promote the restaurant.'),
  (UUID(), 'Photography', 'Photography services for menu items and restaurant ambiance.');

-- insert into restaurants
INSERT INTO Restaurants (_id, Email, Link, TipNoTip, About)
VALUES
  (UUID(), 'info@restaurantA.com', 'restaurant-a', TRUE, 'A fine dining restaurant specializing in French cuisine.'),
  (UUID(), 'contact@restaurantB.com', 'restaurant-b', FALSE, 'Casual dining with an extensive selection of burgers and craft beers.'),
  (UUID(), 'reservations@restaurantC.com', 'restaurant-c', TRUE, 'A family-owned Italian restaurant offering a variety of pastas and pizzas.');

-- insert into restaurants images
INSERT INTO RestaurantImages (_id, Restaurant_id, ImageLink)
VALUES
  (UUID(), UUID(), 'https://example.com/images/restaurantA_1.jpg'),
  (UUID(), UUID(), 'https://example.com/images/restaurantA_2.jpg'),
  (UUID(), UUID(), 'https://example.com/images/restaurantB_1.jpg'),
  (UUID(), UUID(), 'https://example.com/images/restaurantC_1.jpg');

-- insert into contractors
INSERT INTO Contractors (_id, Email, PortfolioLink, Bio)
VALUES
  (UUID(), 'contractor1@example.com', 'https://portfolio.com/contractor1', 'Specializes in restaurant interior design.'),
  (UUID(), 'contractor2@example.com', 'https://portfolio.com/contractor2', 'Offers professional catering services.'),
  (UUID(), 'contractor3@example.com', 'https://portfolio.com/contractor3', 'Photography services for restaurants.'),
  (UUID(), 'contractor4@example.com', 'https://portfolio.com/contractor4', 'Experienced in digital marketing for hospitality businesses.');

-- insert into ContractorServices (connect Contractors and Services_offered)
INSERT INTO ContractorServices (Contractor_id, Service_id)
VALUES
  (UUID(), UUID()),  -- Link contractor1 to Interior Design service
  (UUID(), UUID()),  -- Link contractor2 to Catering service
  (UUID(), UUID()),  -- Link contractor3 to Photography service
  (UUID(), UUID());  -- Link contractor4 to Marketing service

-- insert into listing
INSERT INTO Listings (_id, RestaurantLink, Description, Fulfilled)
VALUES
  (UUID(), 'restaurant-a', 'Need catering services for a private event', FALSE),
  (UUID(), 'restaurant-b', 'Looking for a photographer to capture new menu items', FALSE),
  (UUID(), 'restaurant-c', 'Require interior design update for the dining area', TRUE);

-- ListingServices (connect listing posts with services_offered)
INSERT INTO ListingServices (Listing_id, Service_id)
VALUES
  (UUID(), UUID()),  -- Link listing1 to Catering service
  (UUID(), UUID()),  -- Link listing2 to Photography service
  (UUID(), UUID());  -- Link listing3 to Interior Design service
