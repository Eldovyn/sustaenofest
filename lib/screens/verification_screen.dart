import 'dart:async';
import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'home_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  int _currentStep = 1; // 1: Info, 2: Scan KTP, 3: Selfie, 4: Loading, 5: Berhasil

  late AnimationController _rotationController;
  Timer? _loadingTimer;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _loadingTimer?.cancel();
    super.dispose();
  }

  void _goToStep2() {
    setState(() {
      _currentStep = 2;
    });
  }

  void _goToStep3() {
    setState(() {
      _currentStep = 3;
    });
  }

  void _startVerificationLoading() {
    setState(() {
      _currentStep = 4;
    });

    // Simulasi loading verifikasi beberapa detik sebelum ke Berhasil Verif
    _loadingTimer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        setState(() {
          _currentStep = 5;
        });
      }
    });
  }

  void _finishToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildCurrentStepWidget(),
        ),
      ),
    );
  }

  Widget _buildCurrentStepWidget() {
    switch (_currentStep) {
      case 1:
        return _buildStep1Info();
      case 2:
        return _buildStep2Ktp();
      case 3:
        return _buildStep3Selfie();
      case 4:
        return _buildStep4Loading();
      case 5:
        return _buildStep5Success();
      default:
        return _buildStep1Info();
    }
  }

  // --- Step Indicator matching verif1 - verif4 ---
  Widget _buildStepIndicator(int activeStep) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 20),
      child: Center(
        child: SizedBox(
          width: 140,
          height: 20,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  final int stepNumber = index + 1;
                  final bool isPassed = stepNumber < activeStep;
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 3,
                      decoration: BoxDecoration(
                        color: isPassed || stepNumber == activeStep
                            ? AppColors.primaryGreen
                            : const Color(0xFFCAD5CE),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
              // Dot on current step
              Positioned(
                left: _getDotPosition(activeStep),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getDotPosition(int step) {
    switch (step) {
      case 1:
        return 12;
      case 2:
        return 48;
      case 3:
        return 82;
      case 4:
      case 5:
        return 118;
      default:
        return 12;
    }
  }

  // ==========================================
  // STEP 1: verif1.png
  // ==========================================
  Widget _buildStep1Info() {
    return Padding(
      key: const ValueKey(1),
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepIndicator(1),
          const SizedBox(height: 12),
          const Text(
            'Verifikasi Identitas',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Verifikasi diperlukan untuk keamanan dan kenyamanan transaksi.',
            style: TextStyle(
              fontSize: 14.5,
              color: AppColors.textMedium,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0xFFE2E8F0), thickness: 1),
          const SizedBox(height: 28),

          _buildChecklistItem('Scan KTP asli', true),
          const SizedBox(height: 18),
          _buildChecklistItem('Pastikan pencahayaan baik', true),
          const SizedBox(height: 18),
          _buildChecklistItem('Lakukan selfie sesuai instruksi', true),
          const SizedBox(height: 18),
          _buildChecklistItem('Data kamu aman dan terenkripsi', true),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _goToStep2,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Mulai Verifikasi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  // ==========================================
  // STEP 2: verif2.png
  // ==========================================
  Widget _buildStep2Ktp() {
    return Padding(
      key: const ValueKey(2),
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStepIndicator(2),
          const SizedBox(height: 8),
          const Text(
            'Scan KTP',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 24),

          // Green KTP scanner container
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'Aset/verif_ktp_card.png',
              width: double.infinity,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 28),
          const Divider(color: Color(0xFFE2E8F0), thickness: 1),
          const SizedBox(height: 24),

          _buildChecklistItem('Pastikan foto jelas dan tidak blur', true),
          const SizedBox(height: 16),
          _buildChecklistItem('Semua informasi terlihat', false),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _goToStep3,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Scan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  // ==========================================
  // STEP 3: verif3.png
  // ==========================================
  Widget _buildStep3Selfie() {
    return Padding(
      key: const ValueKey(3),
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStepIndicator(3),
          const SizedBox(height: 8),
          const Text(
            'Lakukan Selfie',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 20),

          // Circular selfie camera preview
          ClipOval(
            child: Image.asset(
              'Aset/verif_selfie.png',
              width: 190,
              height: 190,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),
          const Divider(color: Color(0xFFE2E8F0), thickness: 1),
          const SizedBox(height: 16),

          _buildChecklistItem('Pastikan foto jelas dan tidak blur', true),
          const SizedBox(height: 12),
          _buildChecklistItem('Semua informasi terlihat', false),
          const SizedBox(height: 16),

          const Text(
            'Pastikan wajah terlihat jelas di dalam area lingkaran.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.5,
              color: AppColors.textMedium,
              height: 1.4,
            ),
          ),

          const Spacer(),

          // Shutter button (Green circle with orange camera icon)
          GestureDetector(
            onTap: _startVerificationLoading,
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                color: AppColors.primaryGreen,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGreen.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.primaryOrange,
                  size: 32,
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  // ==========================================
  // STEP 4: verif4.png (Loading Screen)
  // ==========================================
  Widget _buildStep4Loading() {
    return Padding(
      key: const ValueKey(4),
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStepIndicator(4),
          const Spacer(flex: 2),

          // Rotating clock loading animation
          RotationTransition(
            turns: _rotationController,
            child: Image.asset(
              'Aset/verif_clock.png',
              width: 190,
              height: 190,
              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(height: 36),

          const Text(
            'Sedang memverifikasi...',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'harap tidak menutup aplikasi',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryOrange,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Proses ini biasanya memakan waktu beberapa detik.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMedium,
              height: 1.4,
            ),
          ),

          const Spacer(flex: 3),
        ],
      ),
    );
  }

  // ==========================================
  // STEP 5: berhasil verif.png
  // ==========================================
  Widget _buildStep5Success() {
    return Padding(
      key: const ValueKey(5),
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 3),

          // Green checkmark success badge
          Image.asset(
            'Aset/verif_success.png',
            width: 190,
            height: 190,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 36),

          const Text(
            'Identitas Terverifikasi!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Akun kamu sekarang\ndapat digunakan.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textMedium,
              height: 1.4,
            ),
          ),

          const Spacer(flex: 4),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _finishToHome,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Lanjut ke Beranda',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(String title, bool isFullyActive) {
    return Row(
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: isFullyActive
                ? AppColors.primaryOrange
                : AppColors.primaryOrange.withValues(alpha: 0.35),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: isFullyActive
                  ? AppColors.primaryOrange
                  : AppColors.primaryOrange.withValues(alpha: 0.45),
            ),
          ),
        ),
      ],
    );
  }
}

