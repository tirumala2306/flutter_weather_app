import 'package:flutter/material.dart';
import 'package:glasscast/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://zkjykaqtdblctyqunlxl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpranlrYXF0ZGJsY3R5cXVubHhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjkxNTU1ODYsImV4cCI6MjA4NDczMTU4Nn0.p7t2oC7b4HTRuPFQ3bAZK_3BTKDG9Z4En_ijwqFLItI',
  );

  runApp(const GlasscastApp());
}

