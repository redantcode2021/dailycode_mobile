// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FakeGotrueSessionResponse extends Fake implements GotrueSessionResponse {}

class MockGoTrueclient extends Mock implements GoTrueClient {}

void main() {
  late SupabaseAuthClient supabaseAuthClient;
  late GotrueSessionResponse gotrueSessionResponse;
  late GoTrueClient goTrueClient;

  const email = 'test@test.com';

  setUp(() {
    gotrueSessionResponse = FakeGotrueSessionResponse();
    goTrueClient = MockGoTrueclient();
    supabaseAuthClient = SupabaseAuthClient(
      auth: goTrueClient,
    );
  });

  group('SupabaseAuthClient', () {
    test('can be instantiated', () {
      expect(
        SupabaseAuthClient(
          auth: goTrueClient,
        ),
        isNotNull,
      );
    });
  });
}
