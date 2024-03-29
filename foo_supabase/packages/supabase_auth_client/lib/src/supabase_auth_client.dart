// ignore_for_file: public_member_api_docs

import 'package:supabase_flutter/supabase_flutter.dart';

/// {@templage supabase_auth_exception}
/// Abstract class to handle supabase auth exceptions.
/// {@endtemplate}
abstract class SupabaseAuthException implements Exception {
  /// {@macro supabase_auth_exception}
  const SupabaseAuthException(this.error);

  /// The error which was caught.
  final Object error;
}

/// {@template supabase_sign_in_failure}
/// Thrown during the sign in process if a failure occurs.
/// {@endtemplate}
class SupabaseSignInFailure extends SupabaseAuthException {
  const SupabaseSignInFailure(super.error);
}

/// {@template supabase_sign_in_failure}
/// Thrown during the sign out process if a failure occurs.
/// {@endtemplate}
class SupabaseSignOutFailure extends SupabaseAuthException {
  const SupabaseSignOutFailure(super.error);
}

/// {@template supabase_auth_client}
/// Supabase auth client
/// {@endtemplate}
class SupabaseAuthClient {
  /// {@macro supabase_auth_client}
  const SupabaseAuthClient({
    required GoTrueClient auth,
  }) : _auth = auth;

  final GoTrueClient _auth;

  // Method to do sign in on Supabase
  Future<void> signIn({
    required String email,
    required bool isWeb,
  }) async {
    try {
      await _auth.signIn(
        email: email,
        options: AuthOptions(
          redirectTo:
              isWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
        ),
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SupabaseSignInFailure(error), stackTrace);
    }
  }

  // Method to do sign out on Supabase
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SupabaseSignOutFailure(error), stackTrace);
    }
  }
}
