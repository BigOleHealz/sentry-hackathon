-- original: 
INSERT INTO Services_Offered (_id, ServiceName, Description)
VALUES
  (UUID_TO_BIN(UUID()), 'Catering', 'Provide food catering services for events.'),
  (UUID_TO_BIN(UUID()), 'Interior Design', 'Design the interior of the restaurant.'),
  (UUID_TO_BIN(UUID()), 'Marketing', 'Marketing services to help promote the restaurant.'),
  (UUID_TO_BIN(UUID()), 'Photography', 'Photography services for menu items and restaurant ambiance.');

-- insert into restaurants
INSERT INTO Restaurants (_id, Email, Link, TipNoTip, About)
VALUES
  (UUID_TO_BIN(UUID()), 'info@restaurantA.com', 'restaurant-a', TRUE, 'A fine dining restaurant specializing in French cuisine.'),
  (UUID_TO_BIN(UUID()), 'contact@restaurantB.com', 'restaurant-b', FALSE, 'Casual dining with an extensive selection of burgers and craft beers.'),
  (UUID_TO_BIN(UUID()), 'reservations@restaurantC.com', 'restaurant-c', TRUE, 'A family-owned Italian restaurant offering a variety of pastas and pizzas.');

-- insert into restaurants images
INSERT INTO RestaurantImages (_id, Restaurant_id, ImageLink)
VALUES
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID()), 'https://example.com/images/restaurantA_1.jpg'),
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID()), 'https://example.com/images/restaurantA_2.jpg'),
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID()), 'https://example.com/images/restaurantB_1.jpg'),
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID()), 'https://example.com/images/restaurantC_1.jpg');

-- insert into contractors
INSERT INTO Contractors (_id, Email, PortfolioLink, Bio)
VALUES
  (UUID_TO_BIN(UUID()), 'contractor1@example.com', 'https://portfolio.com/contractor1', 'Specializes in restaurant interior design.'),
  (UUID_TO_BIN(UUID()), 'contractor2@example.com', 'https://portfolio.com/contractor2', 'Offers professional catering services.'),
  (UUID_TO_BIN(UUID()), 'contractor3@example.com', 'https://portfolio.com/contractor3', 'Photography services for restaurants.'),
  (UUID_TO_BIN(UUID()), 'contractor4@example.com', 'https://portfolio.com/contractor4', 'Experienced in digital marketing for hospitality businesses.');

-- insert into ContractorServices (connect Contractors and Services_offered)
INSERT INTO ContractorServices (Contractor_id, Service_id)
VALUES
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID())),  -- Link contractor1 to Interior Design service
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID())),  -- Link contractor2 to Catering service
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID())),  -- Link contractor3 to Photography service
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID()));  -- Link contractor4 to Marketing service

-- insert into listing
INSERT INTO Listings (_id, RestaurantLink, Description, Fulfilled)
VALUES
  (UUID_TO_BIN(UUID()), 'restaurant-a', 'Need catering services for a private event', FALSE),
  (UUID_TO_BIN(UUID()), 'restaurant-b', 'Looking for a photographer to capture new menu items', FALSE),
  (UUID_TO_BIN(UUID()), 'restaurant-c', 'Require interior design update for the dining area', TRUE);

-- ListingServices (connect listing posts with services_offered)
INSERT INTO ListingServices (Listing_id, Service_id)
VALUES
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID())),  -- Link listing1 to Catering service
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID())),  -- Link listing2 to Photography service
  (UUID_TO_BIN(UUID()), UUID_TO_BIN(UUID()));  -- Link listing3 to Interior Design service
