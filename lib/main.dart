import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://salhxszhlxekwbsjhxzw.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNhbGh4c3pobHhla3dic2poeHp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzM2MTMzODIsImV4cCI6MjA4OTE4OTM4Mn0.ALgBnlO6y6QDg9rHS-6c5AcsXgMdbmaHQa08OrlJOdg',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Feragown',
      theme: ThemeData(
        primaryColor: const Color(0xFFB76E79),
        fontFamily: 'Poppins',
      ),
      home: const HomePage(),
    );
  }
}
