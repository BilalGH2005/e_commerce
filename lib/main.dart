import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/widgets/my_app.dart';

//TODO: imp(3) - Error: AuthException(message: Code verifier could not be found in local storage., statusCode: null)

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  String anonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  String url = dotenv.env['SUPABASE_URL']!;
  await Supabase.initialize(url: url, anonKey: anonKey);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(Phoenix(child: MyApp())));
}
