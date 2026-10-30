import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Stack(
        children: [
          // Bottom Wavy Hills from mockup
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'Aset/splash_hills.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.42,
            ),
          ),
          
          // Content
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),
                
                // Centered Logo & Tagline
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Image.asset(
                      'Aset/logo_pakaidulu_clean.png',
                      width: 280,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                
                const Spacer(flex: 4),

                // "Mulai" Button tap area aligned with hills image button graphic
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

