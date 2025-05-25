export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[];

export interface Database {
  public: {
    Tables: {
      cars: {
        Row: {
          id: string;
          created_at: string;
          name: string;
          description: string;
          price_per_day: number;
          car_type: string;
          transmission: string;
          fuel_type: string;
          seats: number;
          mileage: number;
          has_ac: boolean;
          image_url: string;
          images: string[];
          rating: number;
          available: boolean;
        };
        Insert: {
          id?: string;
          created_at?: string;
          name: string;
          description: string;
          price_per_day: number;
          car_type: string;
          transmission: string;
          fuel_type: string;
          seats: number;
          mileage: number;
          has_ac: boolean;
          image_url: string;
          images?: string[];
          rating?: number;
          available?: boolean;
        };
        Update: {
          id?: string;
          created_at?: string;
          name?: string;
          description?: string;
          price_per_day?: number;
          car_type?: string;
          transmission?: string;
          fuel_type?: string;
          seats?: number;
          mileage?: number;
          has_ac?: boolean;
          image_url?: string;
          images?: string[];
          rating?: number;
          available?: boolean;
        };
      };
      bookings: {
        Row: {
          id: string;
          created_at: string;
          car_id: string;
          user_id: string;
          start_date: string;
          end_date: string;
          total_price: number;
          status: string;
        };
        Insert: {
          id?: string;
          created_at?: string;
          car_id: string;
          user_id: string;
          start_date: string;
          end_date: string;
          total_price: number;
          status?: string;
        };
        Update: {
          id?: string;
          created_at?: string;
          car_id?: string;
          user_id?: string;
          start_date?: string;
          end_date?: string;
          total_price?: number;
          status?: string;
        };
      };
      profiles: {
        Row: {
          id: string;
          created_at: string;
          email: string;
          full_name: string;
          avatar_url: string;
          role: string;
        };
        Insert: {
          id: string;
          created_at?: string;
          email: string;
          full_name?: string;
          avatar_url?: string;
          role?: string;
        };
        Update: {
          id?: string;
          created_at?: string;
          email?: string;
          full_name?: string;
          avatar_url?: string;
          role?: string;
        };
      };
      reviews: {
        Row: {
          id: string;
          created_at: string;
          car_id: string;
          user_id: string;
          rating: number;
          comment: string;
        };
        Insert: {
          id?: string;
          created_at?: string;
          car_id: string;
          user_id: string;
          rating: number;
          comment?: string;
        };
        Update: {
          id?: string;
          created_at?: string;
          car_id?: string;
          user_id?: string;
          rating?: number;
          comment?: string;
        };
      };
    };
  };
}

export type Car = Database['public']['Tables']['cars']['Row'];
export type Booking = Database['public']['Tables']['bookings']['Row'];
export type Profile = Database['public']['Tables']['profiles']['Row'];
export type Review = Database['public']['Tables']['reviews']['Row'];