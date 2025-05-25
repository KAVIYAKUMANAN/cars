/*
  # Fix car data structure and add missing fields

  1. Schema Changes
    - Add name field to cars table
    - Update existing car records with proper names
*/

-- Add name column if it doesn't exist
DO $$ 
BEGIN 
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'cars' AND column_name = 'name'
  ) THEN
    ALTER TABLE cars ADD COLUMN name text NOT NULL DEFAULT '';
  END IF;
END $$;

-- Update existing cars with proper names
UPDATE cars
SET name = brand || ' ' || model
WHERE name = '';

-- Add any missing columns that components might be using
DO $$ 
BEGIN 
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'cars' AND column_name = 'images'
  ) THEN
    ALTER TABLE cars ADD COLUMN images text[] DEFAULT '{}';
  END IF;
END $$;

-- Update cars with sample image arrays
UPDATE cars
SET images = ARRAY[image_url, image_url]
WHERE images IS NULL OR images = '{}';