import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _nextPage() {
    if (_currentIndex < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: Column(
          children: [
            // PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _buildPage1(),
                  _buildPage2(),
                  _buildPage3(),
                  _buildPage4(),
                ],
              ),
            ),

            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final bool isActive = _currentIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.primaryGreen : AppColors.dotInactive,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Bottom Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentIndex == 3 ? 'Mulai' : 'Lanjut',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Sub text / Skip button
            SizedBox(
              height: 40,
              child: _currentIndex == 3
                  ? Center(
                      child: GestureDetector(
                        onTap: _goToLogin,
                        child: RichText(
                          text: const TextSpan(
                            text: 'Sudah punya akun? ',
                            style: TextStyle(
                              color: AppColors.textDark,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: 'Masuk',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: _goToLogin,
                      child: const Text(
                        'Lewati',
                        style: TextStyle(
                          color: AppColors.primaryGreen,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // --- Page 1: emoji3.png ---
  Widget _buildPage1() {
    return _buildSlideContent(
      illustration: Stack(
        alignment: Alignment.center,
        children: [
          // Woman holding phone
          Center(
            child: Image.asset(
              'Aset/emoji3.png',
              height: 210,
              fit: BoxFit.contain,
            ),
          ),
          // Thought Bubbles / Items around her
          Positioned(
            left: 20,
            top: 20,
            child: _buildItemBadge('🪜', 'Tangga Lipat'),
          ),
          Positioned(
            right: 25,
            top: 30,
            child: _buildItemBadge('🧰', 'Toolkit'),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: _buildItemBadge('⛺', 'Tenda'),
          ),
          Positioned(
            left: 30,
            bottom: 50,
            child: _buildSpeechBubble(),
          ),
        ],
      ),
      title: 'Akses Barang\nTanpa Harus Membeli',
      description:
          'Temukan dan sewa barang yang kamu butuhkan, kapan saja dan di mana saja.',
    );
  }

  // --- Page 2: emoji4.png + emoji2.png ---
  Widget _buildPage2() {
    return _buildSlideContent(
      illustration: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Courier man with box
          Image.asset(
            'Aset/emoji4.png',
            height: 230,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12),
          // Woman receiving box
          Image.asset(
            'Aset/emoji2.png',
            height: 220,
            fit: BoxFit.contain,
          ),
        ],
      ),
      title: 'Aman & Terpercaya',
      description:
          'Verifikasi identitas, sistem deposit dan dokumentasi barang untuk transaksi yang lebih aman.',
    );
  }

  // --- Page 3: emoji5.png ---
  Widget _buildPage3() {
    return _buildSlideContent(
      illustration: Stack(
        alignment: Alignment.center,
        children: [
          // Man holding phone
          Center(
            child: Image.asset(
              'Aset/emoji5.png',
              height: 220,
              fit: BoxFit.contain,
            ),
          ),
          // Items around
          Positioned(
            left: 20,
            top: 30,
            child: _buildItemBadge('🧰', 'Perkakas'),
          ),
          Positioned(
            right: 35,
            top: 35,
            child: _buildItemBadge('🔨', 'Bor'),
          ),
          Positioned(
            left: 20,
            bottom: 40,
            child: _buildItemBadge('🪜', 'Tangga'),
          ),
          Positioned(
            right: 20,
            bottom: 35,
            child: _buildItemBadge('⛺', 'Tenda'),
          ),
        ],
      ),
      title: 'Sewakan Barang\nJarang Terpakai',
      description:
          'Ubah barang yang jarang dipakai menjadi penghasilan tambahan. Daftarkan barangmu, atur harga, dan terima penyewa terverifikasi.',
    );
  }

  // --- Page 4: emoji1.png ---
  Widget _buildPage4() {
    return _buildSlideContent(
      illustration: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Image.asset(
            'Aset/emoji1.png',
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
      title: 'Bersama untuk Masa\nDepan yang Lebih Hijau',
      description:
          'Manfaatkan barang yang ada, kurangi pembelian baru, perpanjang masa guna aset.',
    );
  }

  Widget _buildSlideContent({
    required Widget illustration,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Illustration Box
          Expanded(
            flex: 6,
            child: Center(child: illustration),
          ),
          // Text Box
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textMedium,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemBadge(String emoji, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeechBubble() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12, width: 1.2),
      ),
      child: const Text(
        '•••',
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

