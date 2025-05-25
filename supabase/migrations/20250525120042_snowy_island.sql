/*
  # Add sample data for users, profiles, rentals and bookings

  1. Data Changes
    - Insert sample users in auth.users
    - Create corresponding profiles
    - Add sample rental records
    - Add sample bookings (both upcoming and past)
    - Update car ratings
*/

-- First, create some sample users in auth.users
DO $$
BEGIN
  -- Only insert if the users don't exist
  IF NOT EXISTS (SELECT 1 FROM auth.users WHERE email = 'john@example.com') THEN
    INSERT INTO auth.users (id, email, email_confirmed_at, created_at)
    VALUES 
      ('d7bed83c-44e2-4066-9b6c-bb6a96c2c0f4', 'john@example.com', NOW(), NOW()),
      ('e9bed83c-44e2-4066-9b6c-bb6a96c2c0f5', 'jane@example.com', NOW(), NOW()),
      ('f8bed83c-44e2-4066-9b6c-bb6a96c2c0f6', 'mike@example.com', NOW(), NOW());
  END IF;
END $$;

-- Insert sample profiles
INSERT INTO public.profiles (id, email, full_name, role, created_at)
VALUES
  ('d7bed83c-44e2-4066-9b6c-bb6a96c2c0f4', 'john@example.com', 'John Doe', 'user', NOW()),
  ('e9bed83c-44e2-4066-9b6c-bb6a96c2c0f5', 'jane@example.com', 'Jane Smith', 'admin', NOW()),
  ('f8bed83c-44e2-4066-9b6c-bb6a96c2c0f6', 'mike@example.com', 'Mike Johnson', 'user', NOW())
ON CONFLICT (id) DO NOTHING;

-- Insert sample rentals
INSERT INTO public.rentals (car_id, renter_name, rented_on, returned_on)
SELECT 
  id as car_id,
  'John Doe' as renter_name,
  NOW() - INTERVAL '7 days' as rented_on,
  NOW() - INTERVAL '2 days' as returned_on
FROM public.cars
WHERE brand = 'Tesla'
LIMIT 1;

INSERT INTO public.rentals (car_id, renter_name, rented_on, returned_on)
SELECT 
  id as car_id,
  'Jane Smith' as renter_name,
  NOW() - INTERVAL '14 days' as rented_on,
  NOW() - INTERVAL '7 days' as returned_on
FROM public.cars
WHERE brand = 'BMW'
LIMIT 1;

-- Insert sample bookings (upcoming)
INSERT INTO public.bookings (
  car_id,
  user_id,
  start_date,
  end_date,
  total_price,
  status
)
SELECT 
  c.id as car_id,
  'e9bed83c-44e2-4066-9b6c-bb6a96c2c0f5' as user_id,
  NOW() + INTERVAL '1 day' as start_date,
  NOW() + INTERVAL '3 days' as end_date,
  c.price_per_day * 3 as total_price,
  'confirmed' as status
FROM public.cars c
WHERE c.brand = 'Tesla'
LIMIT 1;

INSERT INTO public.bookings (
  car_id,
  user_id,
  start_date,
  end_date,
  total_price,
  status
)
SELECT 
  c.id as car_id,
  'd7bed83c-44e2-4066-9b6c-bb6a96c2c0f4' as user_id,
  NOW() + INTERVAL '5 days' as start_date,
  NOW() + INTERVAL '8 days' as end_date,
  c.price_per_day * 4 as total_price,
  'confirmed' as status
FROM public.cars c
WHERE c.brand = 'BMW'
LIMIT 1;

-- Add past bookings (cancelled)
INSERT INTO public.bookings (
  car_id,
  user_id,
  start_date,
  end_date,
  total_price,
  status,
  created_at
)
SELECT 
  c.id as car_id,
  'f8bed83c-44e2-4066-9b6c-bb6a96c2c0f6' as user_id,
  NOW() - INTERVAL '10 days' as start_date,
  NOW() - INTERVAL '7 days' as end_date,
  c.price_per_day * 3 as total_price,
  'cancelled' as status,
  NOW() - INTERVAL '15 days' as created_at
FROM public.cars c
WHERE c.brand = 'Mercedes-Benz'
LIMIT 1;

-- Add some ratings to cars
UPDATE public.cars
SET rating = ROUND(CAST(RANDOM() * 2 + 3 AS numeric), 1)
WHERE rating = 0;