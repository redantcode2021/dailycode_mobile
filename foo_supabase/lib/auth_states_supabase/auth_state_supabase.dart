import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foo_supabase/app/bloc/app_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthStateSupabase<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onAuthenticated(Session session) {
    if (mounted) {
      context.read<AppBloc>().add(const AppAuthenticated());
    }
  }

  @override
  void onErrorAuthenticating(String message) {}

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onUnauthenticated() {
    if (mounted) {
      context.read<AppBloc>().add(AppUnauthenticated());
    }
  }
}
