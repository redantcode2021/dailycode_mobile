// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}

class MockPostgrestFilterBuilder extends Mock
    implements PostgrestFilterBuilder {}

class MockPostgrestTransformBuilder extends Mock
    implements PostgrestTransformBuilder<dynamic> {}

class MockPostgrestBuilder extends Mock implements PostgrestBuilder<dynamic> {}

class FakeUser extends Fake implements User {
  @override
  String id = 'id';
}

class FakePostgrestResponse extends Fake implements PostgrestResponse<dynamic> {
  @override
  final Map<String, dynamic> data = <String, String>{
    'username': 'username',
    'companyname': 'companyName'
  };
}

void main() {
  const tableName = 'account';

  late SupabaseClient supabaseClient;
  late GoTrueClient goTrueClient;
  late PostgrestResponse<dynamic> postgrestResponse;
  late PostgrestResponse<dynamic> updatePostgrestResponse;
}
