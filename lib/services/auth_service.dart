import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class AuthResult {
  final bool success;
  final String? errorMessage;
  final User? user;
  final bool needsEmailConfirmation;

  const AuthResult({
    required this.success,
    this.errorMessage,
    this.user,
    this.needsEmailConfirmation = false,
  });
}

class AuthService {
  static final _client = SupabaseService.client;

  static Future<AuthResult> signUp({
    required String email,
    required String password,
    String? fullName,
    String? phone,
    String? province,
    String? municipality,
    String? propertyType,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone': phone,
        },
      );

      if (response.user == null) {
        return const AuthResult(
          success: false,
          errorMessage: 'Sign up failed. Please try again.',
        );
      }

      // Profile is created automatically by database trigger.
      // If email confirmation is required, session will be null.
      final needsConfirmation = response.session == null;

      return AuthResult(
        success: true,
        user: response.user,
        needsEmailConfirmation: needsConfirmation,
      );
    } on AuthException catch (e) {
      return AuthResult(success: false, errorMessage: e.message);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  static Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return const AuthResult(
          success: false,
          errorMessage: 'Invalid email or password.',
        );
      }

      return AuthResult(success: true, user: response.user);
    } on AuthException catch (e) {
      return AuthResult(success: false, errorMessage: e.message);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  static Future<AuthResult> resetPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
      return const AuthResult(success: true);
    } on AuthException catch (e) {
      return AuthResult(success: false, errorMessage: e.message);
    } catch (e) {
      return AuthResult(
        success: false,
        errorMessage: 'Failed to send reset email. Please try again.',
      );
    }
  }

  static Future<void> signOut() async {
    await _client.auth.signOut();
  }

  static Future<Map<String, dynamic>?> getProfile(String userId) async {
    try {
      final data = await _client
          .schema('spurhund')
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();
      return data;
    } catch (_) {
      return null;
    }
  }
}
