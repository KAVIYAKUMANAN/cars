import { create } from 'zustand';
import { supabase } from '../lib/supabase';
import { type Booking } from '../types/supabase';
import { differenceInDays } from 'date-fns';

type BookingState = {
  bookings: Booking[];
  isLoading: boolean;
  error: string | null;
  fetchUserBookings: (userId: string) => Promise<void>;
  fetchAllBookings: () => Promise<void>;
  createBooking: (carId: string, userId: string, startDate: Date, endDate: Date, pricePerDay: number) => Promise<{ booking: Booking | null; error: any | null }>;
  cancelBooking: (bookingId: string) => Promise<{ error: any | null }>;
  checkAvailability: (carId: string, startDate: Date, endDate: Date) => Promise<boolean>;
};

export const useBookingStore = create<BookingState>((set, get) => ({
  bookings: [],
  isLoading: false,
  error: null,
  
  fetchUserBookings: async (userId: string) => {
    set({ isLoading: true, error: null });
    
    try {
      const { data, error } = await supabase
        .from('bookings')
        .select('*')
        .eq('user_id', userId)
        .order('created_at', { ascending: false });
      
      if (error) throw error;
      
      set({ bookings: data || [], isLoading: false });
    } catch (error: any) {
      set({ error: error.message, isLoading: false });
    }
  },
  
  fetchAllBookings: async () => {
    set({ isLoading: true, error: null });
    
    try {
      const { data, error } = await supabase
        .from('bookings')
        .select('*')
        .order('created_at', { ascending: false });
      
      if (error) throw error;
      
      set({ bookings: data || [], isLoading: false });
    } catch (error: any) {
      set({ error: error.message, isLoading: false });
    }
  },
  
  createBooking: async (carId, userId, startDate, endDate, pricePerDay) => {
    try {
      // Calculate total days
      const days = differenceInDays(endDate, startDate) + 1;
      const totalPrice = days * pricePerDay;
      
      const { data, error } = await supabase
        .from('bookings')
        .insert({
          car_id: carId,
          user_id: userId,
          start_date: startDate.toISOString(),
          end_date: endDate.toISOString(),
          total_price: totalPrice,
          status: 'confirmed',
        })
        .select()
        .single();
      
      if (error) throw error;
      
      // Refresh bookings list
      await get().fetchUserBookings(userId);
      
      return { booking: data, error: null };
    } catch (error) {
      return { booking: null, error };
    }
  },
  
  cancelBooking: async (bookingId) => {
    try {
      const { error } = await supabase
        .from('bookings')
        .update({ status: 'cancelled' })
        .eq('id', bookingId);
      
      if (error) throw error;
      
      // Update booking in state
      set(state => ({
        bookings: state.bookings.map(booking =>
          booking.id === bookingId 
            ? { ...booking, status: 'cancelled' } 
            : booking
        )
      }));
      
      return { error: null };
    } catch (error) {
      return { error };
    }
  },
  
  checkAvailability: async (carId, startDate, endDate) => {
    try {
      const { data, error } = await supabase
        .from('bookings')
        .select('*')
        .eq('car_id', carId)
        .eq('status', 'confirmed')
        .or(`start_date.lte.${endDate.toISOString()},end_date.gte.${startDate.toISOString()}`);
      
      if (error) throw error;
      
      return data.length === 0; // Available if no conflicting bookings
    } catch (error) {
      console.error('Error checking availability:', error);
      return false; // Assume not available on error
    }
  }
}));