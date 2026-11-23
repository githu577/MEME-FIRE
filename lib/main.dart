import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://addjgttfwfinnsejblgb.supabase.co',
    anonKey: 'sb_publishable_tPLD9l0CHKd6UML3joIi6Q_2hbInZuA',
  );

  runApp(const MemeHuntApp());
}
