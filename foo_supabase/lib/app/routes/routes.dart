import 'package:flutter/material.dart';
import 'package:foo_supabase/app/bloc/app_bloc.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [];
    case AppStatus.authenticated:
      return [];
  }
}
