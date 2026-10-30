import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/device_preview_wrapper.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SustaenofestApp());
}

class SustaenofestApp extends StatelessWidget {
  const SustaenofestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PakaiDulu - Sewa Menyewa Mudah & Aman',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      scrollBehavior: const AppScrollBehavior(),
      builder: (context, child) {
        return DevicePreviewWrapper(
          child: child ?? const SplashScreen(),
        );
      },
      home: const SplashScreen(),
    );
  }
}
