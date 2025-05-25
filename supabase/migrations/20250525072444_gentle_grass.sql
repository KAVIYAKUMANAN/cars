/*
  # Add car details and sample data

  1. Schema Changes
    - Add columns for car details (price, type, features, etc.)
    - Add sample car data with prices and specifications

  2. Changes
    - Add new columns to cars table
    - Insert sample car data
*/

-- Add new columns to cars table
ALTER TABLE cars 
  ADD COLUMN IF NOT EXISTS price_per_day numeric NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS car_type text NOT NULL DEFAULT '',
  ADD COLUMN IF NOT EXISTS transmission text NOT NULL DEFAULT 'Automatic',
  ADD COLUMN IF NOT EXISTS fuel_type text NOT NULL DEFAULT 'Petrol',
  ADD COLUMN IF NOT EXISTS seats integer NOT NULL DEFAULT 5,
  ADD COLUMN IF NOT EXISTS mileage integer NOT NULL DEFAULT 0,
  ADD COLUMN IF NOT EXISTS has_ac boolean NOT NULL DEFAULT true,
  ADD COLUMN IF NOT EXISTS description text NOT NULL DEFAULT '';

-- Insert sample cars with prices and additional details
INSERT INTO cars (
  brand, 
  model, 
  year, 
  availability, 
  image_url, 
  created_at,
  price_per_day,
  car_type,
  transmission,
  fuel_type,
  seats,
  mileage,
  has_ac,
  description
)
VALUES
  ('Tesla', 'Model 3', 2025, 'Available', 'https://images.pexels.com/photos/7674867/pexels-photo-7674867.jpeg', now(), 150, 'Sedan', 'Automatic', 'Electric', 5, 0, true, 'Experience the future of driving with the Tesla Model 3. This all-electric sedan offers exceptional range and cutting-edge technology.'),
  ('BMW', 'X5', 2025, 'Available', 'https://images.pexels.com/photos/892522/pexels-photo-892522.jpeg', now(), 200, 'SUV', 'Automatic', 'Hybrid', 7, 1500, true, 'Luxury meets versatility in the BMW X5. Perfect for both city driving and weekend adventures.'),
  ('Mercedes-Benz', 'C-Class', 2025, 'Available', 'https://images.pexels.com/photos/892522/pexels-photo-892522.jpeg', now(), 180, 'Sedan', 'Automatic', 'Petrol', 5, 1200, true, 'The epitome of elegance and comfort, the Mercedes-Benz C-Class offers a premium driving experience.'),
  ('Toyota', 'RAV4', 2025, 'Available', 'https://images.pexels.com/photos/1638459/pexels-photo-1638459.jpeg', now(), 120, 'SUV', 'Automatic', 'Hybrid', 5, 2000, true, 'Reliable and efficient, the Toyota RAV4 is perfect for both city commutes and outdoor adventures.'),
  ('Porsche', '911', 2025, 'Available', 'https://images.pexels.com/photos/3752169/pexels-photo-3752169.jpeg', now(), 350, 'Sports', 'Automatic', 'Petrol', 2, 500, true, 'Experience the thrill of driving with the iconic Porsche 911. Pure performance meets luxury.'),
  ('Honda', 'Civic', 2025, 'Available', 'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg', now(), 90, 'Sedan', 'Automatic', 'Petrol', 5, 2500, true, 'The Honda Civic offers reliability, efficiency, and modern features at an affordable price.'),
  ('Range Rover', 'Sport', 2025, 'Available', 'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg', now(), 280, 'SUV', 'Automatic', 'Diesel', 5, 1800, true, 'Luxury and off-road capability combine in the Range Rover Sport. Perfect for any terrain.'),
  ('Audi', 'A4', 2025, 'Available', 'https://images.pexels.com/photos/892522/pexels-photo-892522.jpeg', now(), 160, 'Sedan', 'Automatic', 'Petrol', 5, 1500, true, 'The Audi A4 delivers sophisticated styling and advanced technology in a refined package.'),
  ('Ford', 'Mustang', 2025, 'Available', 'https://images.pexels.com/photos/3752169/pexels-photo-3752169.jpeg', now(), 200, 'Sports', 'Manual', 'Petrol', 4, 1000, true, 'American muscle meets modern technology in the Ford Mustang. Pure driving excitement.'),
  ('Volkswagen', 'Golf', 2025, 'Available', 'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg', now(), 100, 'Hatchback', 'Automatic', 'Petrol', 5, 2200, true, 'The Volkswagen Golf offers practicality and driving pleasure in a compact package.'),
  ('Lexus', 'RX', 2025, 'Available', 'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg', now(), 220, 'SUV', 'Automatic', 'Hybrid', 5, 1600, true, 'Experience luxury and efficiency with the Lexus RX. Comfort meets environmental consciousness.'),
  ('Mini', 'Cooper', 2025, 'Available', 'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg', now(), 110, 'Hatchback', 'Manual', 'Petrol', 4, 1800, true, 'The Mini Cooper combines iconic styling with go-kart handling for maximum driving fun.'),
  ('Jeep', 'Wrangler', 2025, 'Available', 'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg', now(), 180, 'SUV', 'Manual', 'Petrol', 4, 1500, true, 'Adventure awaits with the Jeep Wrangler. The ultimate off-road companion.'),
  ('Mazda', 'MX-5', 2025, 'Available', 'https://images.pexels.com/photos/3752169/pexels-photo-3752169.jpeg', now(), 150, 'Convertible', 'Manual', 'Petrol', 2, 1000, true, 'Pure driving joy in the Mazda MX-5. The perfect roadster for sunny days.'),
  ('Hyundai', 'Tucson', 2025, 'Available', 'https://images.pexels.com/photos/1638459/pexels-photo-1638459.jpeg', now(), 130, 'SUV', 'Automatic', 'Hybrid', 5, 2000, true, 'Modern design meets practicality in the Hyundai Tucson. Perfect for family adventures.'),
  ('Chevrolet', 'Camaro', 2025, 'Available', 'https://images.pexels.com/photos/3752169/pexels-photo-3752169.jpeg', now(), 190, 'Sports', 'Manual', 'Petrol', 4, 1200, true, 'American performance legend. The Chevrolet Camaro delivers thrills at every turn.'),
  ('Kia', 'Sportage', 2025, 'Available', 'https://images.pexels.com/photos/1638459/pexels-photo-1638459.jpeg', now(), 120, 'SUV', 'Automatic', 'Hybrid', 5, 2100, true, 'Style and substance combine in the Kia Sportage. Modern features at a great value.'),
  ('Audi', 'TT', 2025, 'Available', 'https://images.pexels.com/photos/3752169/pexels-photo-3752169.jpeg', now(), 220, 'Sports', 'Automatic', 'Petrol', 2, 800, true, 'Design meets performance in the Audi TT. A true driver''s car with distinctive style.'),
  ('Toyota', 'Camry', 2025, 'Available', 'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg', now(), 110, 'Sedan', 'Automatic', 'Hybrid', 5, 2300, true, 'The Toyota Camry offers comfort, efficiency, and reliability in an elegant package.'),
  ('Mercedes-Benz', 'G-Class', 2025, 'Available', 'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg', now(), 400, 'SUV', 'Automatic', 'Petrol', 5, 1000, true, 'Legendary luxury and capability unite in the Mercedes-Benz G-Class. The ultimate status symbol.');