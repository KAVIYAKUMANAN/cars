/*
  # Create bookings table

  1. New Tables
    - `bookings`
      - `id` (uuid, primary key)
      - `car_id` (uuid, foreign key to cars)
      - `user_id` (uuid, foreign key to auth.users)
      - `start_date` (timestamptz)
      - `end_date` (timestamptz)
      - `total_price` (numeric)
      - `status` (text)
      - `created_at` (timestamptz)

  2. Security
    - Enable RLS on `bookings` table
    - Add policies for authenticated users to manage their bookings
    - Add foreign key constraints

  3. Constraints
    - Ensure end_date is after start_date
    - Ensure status is one of: 'confirmed', 'cancelled'
*/

-- Create bookings table
CREATE TABLE IF NOT EXISTS public.bookings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  car_id uuid NOT NULL REFERENCES public.cars(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  start_date timestamptz NOT NULL,
  end_date timestamptz NOT NULL,
  total_price numeric NOT NULL CHECK (total_price >= 0),
  status text NOT NULL CHECK (status IN ('confirmed', 'cancelled')),
  created_at timestamptz DEFAULT now(),
  CONSTRAINT valid_booking_dates CHECK (end_date >= start_date)
);

-- Enable Row Level Security
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;

-- Policies for authenticated users
CREATE POLICY "Users can view their own bookings"
  ON public.bookings
  FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create bookings"
  ON public.bookings
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own bookings"
  ON public.bookings
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Create index for faster queries
CREATE INDEX bookings_car_id_idx ON public.bookings(car_id);
CREATE INDEX bookings_user_id_idx ON public.bookings(user_id);
CREATE INDEX bookings_dates_idx ON public.bookings(start_date, end_date);