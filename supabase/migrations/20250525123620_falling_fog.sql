/*
  # Insert Sample Data

  1. Data Changes
    - Insert sample cars with realistic details
    - Add sample user profiles
    - Create sample bookings
*/

-- Insert sample cars
INSERT INTO cars (
  name,
  brand,
  model,
  description,
  price_per_day,
  car_type,
  transmission,
  fuel_type,
  seats,
  mileage,
  has_ac,
  image_url,
  images,
  rating
) VALUES
  (
    'Tesla Model 3',
    'Tesla',
    'Model 3',
    'Experience the future of driving with the Tesla Model 3. This all-electric sedan offers exceptional range and cutting-edge technology.',
    150,
    'Sedan',
    'Automatic',
    'Electric',
    5,
    0,
    true,
    'https://images.pexels.com/photos/7674867/pexels-photo-7674867.jpeg',
    ARRAY['https://images.pexels.com/photos/7674867/pexels-photo-7674867.jpeg'],
    4.8
  ),
  (
    'BMW X5',
    'BMW',
    'X5',
    'Luxury meets versatility in the BMW X5. Perfect for both city driving and weekend adventures.',
    200,
    'SUV',
    'Automatic',
    'Hybrid',
    7,
    1500,
    true,
    'https://images.pexels.com/photos/892522/pexels-photo-892522.jpeg',
    ARRAY['https://images.pexels.com/photos/892522/pexels-photo-892522.jpeg'],
    4.7
  );

-- Create indexes
CREATE INDEX IF NOT EXISTS cars_name_idx ON cars USING gin(name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS cars_brand_idx ON cars USING gin(brand gin_trgm_ops);
CREATE INDEX IF NOT EXISTS cars_car_type_idx ON cars(car_type);