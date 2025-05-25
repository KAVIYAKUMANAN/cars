import { create } from 'zustand';
import { supabase } from '../lib/supabase';
import { type Profile } from '../types/supabase';

type AuthState = {
  user: any | null;
  profile: Profile | null;
  isAdmin: boolean;
  isLoading: boolean;
  checkAuth: () => Promise<void>;
  login: (email: string, password: string, isAdmin?: boolean) => Promise<{ error: any | null }>;
  signup: (email: string, password: string, fullName: string) => Promise<{ error: any | null }>;
  logout: () => Promise<void>;
  setAdminSession: () => void;
};

export const useAuthStore = create<AuthState>((set, get) => ({
  user: null,
  profile: null,
  isAdmin: localStorage.getItem('adminSession') === 'true',
  isLoading: true,
  
  checkAuth: async () => {
    set({ isLoading: true });
    
    // Check for admin session first
    if (localStorage.getItem('adminSession') === 'true') {
      set({ 
        user: { id: 'admin', email: 'admin@carznow.com' },
        profile: { 
          id: 'admin',
          email: 'admin@carznow.com',
          full_name: 'Administrator',
          role: 'admin',
          created_at: new Date().toISOString(),
          avatar_url: ''
        },
        isAdmin: true,
        isLoading: false
      });
      return;
    }
    
    const { data: { session } } = await supabase.auth.getSession();
    
    if (session?.user) {
      const { data: profile } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', session.user.id)
        .maybeSingle();
      
      set({ 
        user: session.user, 
        profile: profile || null,
        isAdmin: profile?.role === 'admin' || false,
        isLoading: false 
      });
    } else {
      set({ user: null, profile: null, isAdmin: false, isLoading: false });
    }
  },
  
  login: async (email, password) => {
    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });
      
      if (!error && data.user) {
        await get().checkAuth();
      }
      
      return { error };
    } catch (error) {
      return { error };
    }
  },
  
  signup: async (email, password, fullName) => {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
    });
    
    if (!error && data.user) {
      await supabase.from('profiles').insert({
        id: data.user.id,
        email,
        full_name: fullName,
        role: 'user',
      });
      
      await get().checkAuth();
    }
    
    return { error };
  },
  
  logout: async () => {
    localStorage.removeItem('adminSession');
    await supabase.auth.signOut();
    set({ user: null, profile: null, isAdmin: false });
  },
  
  setAdminSession: () => {
    localStorage.setItem('adminSession', 'true');
    set({
      user: { id: 'admin', email: 'admin@carznow.com' },
      profile: {
        id: 'admin',
        email: 'admin@carznow.com',
        full_name: 'Administrator',
        role: 'admin',
        created_at: new Date().toISOString(),
        avatar_url: ''
      },
      isAdmin: true
    });
  }
}));