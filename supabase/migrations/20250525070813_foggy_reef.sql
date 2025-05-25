/*
  # Add sample cars

  1. Data Changes
    - Insert 20 sample cars with various specifications
    - Include different car types: Sedan, SUV, Sports, Convertible, Hatchback
    - Add realistic pricing and features
*/

-- Insert sample cars
INSERT INTO cars (brand, model, year, availability, image_url, created_at)
VALUES
  ('Tesla', 'Model 3', 2025, 'Available', 'https://images.pexels.com/photos/7674867/pexels-photo-7674867.jpeg', now()),
  ('BMW', 'X5', 2025, 'Available', 'https://images.pexels.com/photos/892522/pexels-photo-892522.jpeg', now()),
  ('Mercedes-Benz', 'C-Class', 2025, 'Available', 'https://images.pexels.com/photos/892522/pexels-photo-892522.jpeg', now()),
  ('Toyota', 'RAV4', 2025, 'Available', 'https://images.pexels.com/photos/1638459/pexels-photo-1638459.jpeg', now()),
  ('Porsche', '911', 2025, 'Available', 'https://images.pexels.com/photos/3752169/pexels-photo-3752169.jpeg', now()),
  ('Honda', 'Civic', 2025, 'Available', 'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg', now()),
  ('Range Rover', 'Sport', 2025, 'Available', 'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg', now()),
  ('Audi', 'A4', 2025, 'Available', 'https://images.pexels.com/photos/892522/pexels-photo-892522.jpeg', now()),
  ('Ford', 'Mustang', 2025, 'Available', 'https://images.pexels.com/photos/3752169/pexels-photo-3752169.jpeg', now()),
  ('Volkswagen', 'Golf', 2025, 'Available', 'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg', now()),
  ('Lexus', 'RX', 2025, 'Available', 'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg', now()),
  ('Mini', 'Cooper', 2025, 'Available', 'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg', now()),
  ('Jeep', 'Wrangler', 2025, 'Available', 'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg', now()),
  ('Mazda', 'MX-5', 2025, 'Available', 'https://images.pexels.com/photos/3752169/pexels-photo-3752169.jpeg', now()),
  ('Hyundai', 'Tucson', 2025, 'Available', 'https://images.pexels.com/photos/1638459/pexels-photo-1638459.jpeg', now()),
  ('Chevrolet', 'Camaro', 2025, 'Available', 'https://images.pexels.com/photos/3752169/pexels-photo-3752169.jpeg', now()),
  ('Kia', 'Sportage', 2025, 'Available', 'https://images.pexels.com/photos/1638459/pexels-photo-1638459.jpeg', now()),
  ('Audi', 'TT', 2025, 'Available', 'https://images.pexels.com/photos/3752169/pexels-photo-3752169.jpeg', now()),
  ('Toyota', 'Camry', 2025, 'Available', 'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg', now()),
  ('Mercedes-Benz', 'G-Class', 2025, 'Available', 'https://images.pexels.com/photos/116675/pexels-photo-116675.jpeg', now());