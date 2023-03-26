import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_database_client/src/models/model.dart';

void main() {
  group('SupabaseUser', () {
    test('supports value equality', () {
      final supabaseUserA =
          SupabaseUser(id: 'id', userName: 'A', companyName: 'B');
      final secondSupabaseUserA =
          SupabaseUser(id: 'id', userName: 'A', companyName: 'B');
      final supabaseUserB =
          SupabaseUser(id: '', userName: 'B', companyName: 'C');

      expect(supabaseUserA, equals(secondSupabaseUserA));
      expect(supabaseUserA, isNot(equals(supabaseUserB)));
    });
  });
}
