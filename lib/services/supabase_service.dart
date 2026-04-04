import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const _supabaseUrl = 'https://ltongoxfshmzfqbioqyf.supabase.co';
  static const _supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx0b25nb3hmc2htemZxYmlvcXlmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzIwNTg3NDUsImV4cCI6MjA4NzYzNDc0NX0.oXR54so2u3JEVRHiyroBjxzdakWzutgFPEIUKVSSRt0';

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialise() async {
    await Supabase.initialize(
      url: _supabaseUrl,
      anonKey: _supabaseAnonKey,
    );
  }

  static User? get currentUser => client.auth.currentUser;
  static bool get isAuthenticated => currentUser != null;
  static Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;
}
