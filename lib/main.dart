import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'constants/app_color.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco de Tiempo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.backgraundColor,
        fontFamily: GoogleFonts.getFont('Press Start 2P').fontFamily,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primaryColor,
          foregroundColor: AppColor.fontColor,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primaryColor,
          secondary: AppColor.secundaryColor,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
