import 'package:flutter/material.dart';
import 'services/supabase_service.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialise();
  runApp(const SpurhundApp());
}
