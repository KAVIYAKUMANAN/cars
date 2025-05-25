/*
  # Fix foreign key relationships and data connections

  1. Changes
    - Drop and recreate foreign key constraints with correct names
    - Update bookings table foreign key relationships
    - Ensure proper connection between profiles and bookings
*/

-- Drop existing foreign key constraints if they exist
DO $$ 
BEGIN
  IF EXISTS (
    SELECT 1 FROM information_schema.table_constraints 
    WHERE constraint_name = 'bookings_user_id_fkey'
  ) THEN
    ALTER TABLE bookings DROP CONSTRAINT bookings_user_id_fkey;
  END IF;
  
  IF EXISTS (
    SELECT 1 FROM information_schema.table_constraints 
    WHERE constraint_name = 'bookings_car_id_fkey'
  ) THEN
    ALTER TABLE bookings DROP CONSTRAINT bookings_car_id_fkey;
  END IF;
END $$;

-- Recreate foreign key constraints with correct names
ALTER TABLE bookings
ADD CONSTRAINT bookings_user_id_fkey
FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;

ALTER TABLE bookings
ADD CONSTRAINT bookings_car_id_fkey
FOREIGN KEY (car_id) REFERENCES cars(id) ON DELETE CASCADE;

-- Create index for faster joins
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_car_id ON bookings(car_id);

-- Ensure all bookings have valid user_id and car_id
DELETE FROM bookings WHERE user_id NOT IN (SELECT id FROM auth.users);
DELETE FROM bookings WHERE car_id NOT IN (SELECT id FROM cars);

-- Update sample data to ensure consistency
INSERT INTO auth.users (id, email, email_confirmed_at, created_at)
VALUES 
  ('d7bed83c-44e2-4066-9b6c-bb6a96c2c0f4', 'john@example.com', NOW(), NOW()),
  ('e9bed83c-44e2-4066-9b6c-bb6a96c2c0f5', 'jane@example.com', NOW(), NOW()),
  ('f8bed83c-44e2-4066-9b6c-bb6a96c2c0f6', 'mike@example.com', NOW(), NOW())
ON CONFLICT (id) DO NOTHING;

INSERT INTO profiles (id, email, full_name, role, created_at)
VALUES
  ('d7bed83c-44e2-4066-9b6c-bb6a96c2c0f4', 'john@example.com', 'John Doe', 'user', NOW()),
  ('e9bed83c-44e2-4066-9b6c-bb6a96c2c0f5', 'jane@example.com', 'Jane Smith', 'admin', NOW()),
  ('f8bed83c-44e2-4066-9b6c-bb6a96c2c0f6', 'mike@example.com', 'Mike Johnson', 'user', NOW())
ON CONFLICT (id) DO NOTHING;

-- Add some sample bookings with proper relationships
INSERT INTO bookings (
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
FROM cars c
WHERE c.brand = 'Tesla'
AND NOT EXISTS (
  SELECT 1 FROM bookings b 
  WHERE b.car_id = c.id 
  AND b.start_date = NOW() + INTERVAL '1 day'
)
LIMIT 1;