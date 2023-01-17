// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:user_repository/user_repository.dart';

class MockSupabaseAuthClient extends Mock implements SupabaseAuthClient {}

class MockSupabaseDatabaseClient extends Mock
    implements SupabaseDatabaseClient {}

void main() {
  late SupabaseAuthClient authClient;
  late SupabaseDatabaseClient databaseClient;
  late SupabaseUser supabaseUser;
  late User user;
  late UserRepository userRepository;
  const email = 'test@test.com';

  setUp(() {
    authClient = MockSupabaseAuthClient();
    databaseClient = MockSupabaseDatabaseClient();
    supabaseUser = SupabaseUser(
      id: 'id',
      userName: 'userName',
      companyName: 'companyName',
    );
    user = User(id: 'id', userName: 'userName', companyName: 'companyName');
    userRepository = UserRepository(
      authClient: authClient,
      databaseClient: databaseClient,
    );
    group('UserRepository', () {
      test('can be instantiated', () {
        expect(
          UserRepository(
            authClient: authClient,
            databaseClient: databaseClient,
          ),
          isNotNull,
        );
      });
    });
  });
}
