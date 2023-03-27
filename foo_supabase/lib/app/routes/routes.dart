import 'package:flutter/material.dart';
import 'package:foo_supabase/account/account.dart';
import 'package:foo_supabase/app/bloc/app_bloc.dart';
import 'package:foo_supabase/login/login.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
    case AppStatus.authenticated:
      return [AccountPage.page()];
  }
}
