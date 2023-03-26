import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foo_supabase/app/app.dart';
import 'package:foo_supabase/bootstrap.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:supabase_database_client/supabase_database_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:user_repository/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/.env');

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('ANON_KEY'),
  );

  await bootstrap(() {
    final authClient = SupabaseAuthClient(
      auth: Supabase.instance.client.auth,
    );
    final databaseClient = SupabaseDatabaseClient(
      supabaseClient: Supabase.instance.client,
    );
    final userRepository = UserRepository(
      authClient: authClient,
      databaseClient: databaseClient,
    );

    return App(userRepository: userRepository);
  });
}
