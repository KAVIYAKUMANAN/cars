-- Create cars table
CREATE TABLE IF NOT EXISTS public.cars (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at timestamptz DEFAULT now(),
  name text NOT NULL,
  brand text NOT NULL,
  model text NOT NULL,
  description text NOT NULL DEFAULT '',
  price_per_day numeric NOT NULL DEFAULT 0,
  car_type text NOT NULL DEFAULT '',
  transmission text NOT NULL DEFAULT 'Automatic',
  fuel_type text NOT NULL DEFAULT 'Petrol',
  seats integer NOT NULL DEFAULT 5,
  mileage integer NOT NULL DEFAULT 0,
  has_ac boolean NOT NULL DEFAULT true,
  image_url text NOT NULL,
  images text[] DEFAULT '{}',
  rating numeric DEFAULT 0,
  available boolean DEFAULT true
);

-- Create profiles table
CREATE TABLE IF NOT EXISTS public.profiles (
  id uuid PRIMARY KEY REFERENCES auth.users ON DELETE CASCADE,
  email text NOT NULL,
  full_name text,
  role text DEFAULT 'user',
  created_at timestamptz DEFAULT now()
);

-- Create bookings table
CREATE TABLE IF NOT EXISTS public.bookings (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at timestamptz DEFAULT now(),
  car_id uuid NOT NULL REFERENCES public.cars(id) ON DELETE CASCADE,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  start_date timestamptz NOT NULL,
  end_date timestamptz NOT NULL,
  total_price numeric NOT NULL CHECK (total_price >= 0),
  status text NOT NULL CHECK (status IN ('confirmed', 'cancelled')),
  CONSTRAINT valid_booking_dates CHECK (end_date >= start_date)
);

-- Enable Row Level Security
ALTER TABLE public.cars ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;

-- Policies for cars
CREATE POLICY "Anyone can view cars"
  ON public.cars
  FOR SELECT
  TO public
  USING (true);

-- Policies for profiles
CREATE POLICY "Users can read any profile"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Users can update their own profile"
  ON public.profiles
  FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- Policies for bookings
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

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_bookings_car_id ON public.bookings(car_id);
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON public.bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_dates ON public.bookings(start_date, end_date);