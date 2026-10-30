import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Preset spesifikasi perangkat mobile untuk simulasi preview
class DevicePreset {
  final String id;
  final String name;
  final String brand;
  final double width;
  final double height;
  final double cornerRadius;
  final double statusBarHeight;
  final double bottomBarHeight;
  final bool hasDynamicIsland;
  final bool hasPunchHole;

  const DevicePreset({
    required this.id,
    required this.name,
    required this.brand,
    required this.width,
    required this.height,
    required this.cornerRadius,
    required this.statusBarHeight,
    required this.bottomBarHeight,
    this.hasDynamicIsland = false,
    this.hasPunchHole = false,
  });

  static const List<DevicePreset> all = [
    DevicePreset(
      id: 'iphone_15_pro',
      name: 'iPhone 15 Pro',
      brand: 'Apple',
      width: 393,
      height: 852,
      cornerRadius: 48,
      statusBarHeight: 54,
      bottomBarHeight: 34,
      hasDynamicIsland: true,
    ),
    DevicePreset(
      id: 'iphone_15_promax',
      name: 'iPhone 15 Pro Max',
      brand: 'Apple',
      width: 430,
      height: 932,
      cornerRadius: 52,
      statusBarHeight: 54,
      bottomBarHeight: 34,
      hasDynamicIsland: true,
    ),
    DevicePreset(
      id: 'galaxy_s24',
      name: 'Samsung Galaxy S24',
      brand: 'Samsung',
      width: 412,
      height: 915,
      cornerRadius: 38,
      statusBarHeight: 40,
      bottomBarHeight: 24,
      hasPunchHole: true,
    ),
    DevicePreset(
      id: 'pixel_8',
      name: 'Google Pixel 8',
      brand: 'Google',
      width: 412,
      height: 892,
      cornerRadius: 36,
      statusBarHeight: 40,
      bottomBarHeight: 24,
      hasPunchHole: true,
    ),
  ];
}

/// Custom scroll behavior agar pengguna desktop bisa drag & swipe dengan mouse
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

/// Wrapper untuk preview mobile app dengan frame smartphone pada web / desktop (Netlify).
/// Jika dibuka di HP asli (layar <= 600px atau native app), app akan tampil penuh layar tanpa frame.
class DevicePreviewWrapper extends StatefulWidget {
  final Widget child;

  const DevicePreviewWrapper({
    super.key,
    required this.child,
  });

  @override
  State<DevicePreviewWrapper> createState() => _DevicePreviewWrapperState();
}

class _DevicePreviewWrapperState extends State<DevicePreviewWrapper> {
  DevicePreset _selectedDevice = DevicePreset.all.first;
  bool _showFrame = true;
  bool _isLandscape = false;
  int _backgroundTheme = 0; // 0: Dark Studio, 1: Brand Warm, 2: Minimalist Light

  @override
  Widget build(BuildContext context) {
    // Pada mobile native (Android / iOS) atau widget test, tampilkan langsung native
    if (!kIsWeb) {
      return widget.child;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // Jika layar kecil (akses langsung dari browser HP asli di Netlify), tampilkan native tanpa frame
        if (screenWidth <= 600) {
          return widget.child;
        }

        // Tampilan Desktop / Web Preview (Netlify)
        return Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: _getBackgroundGradient(),
            ),
            child: Column(
              children: [
                _buildTopToolbar(),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      child: _buildDeviceViewport(constraints),
                    ),
                  ),
                ),
                _buildBottomInfoBar(),
              ],
            ),
          ),
        );
      },
    );
  }

  LinearGradient _getBackgroundGradient() {
    switch (_backgroundTheme) {
      case 1: // Brand Warm
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF7F1E8), Color(0xFFEADBCE), Color(0xFFDDD0C2)],
        );
      case 2: // Minimalist Light
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
        );
      case 0: // Dark Studio (default)
      default:
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E293B),
            Color(0xFF0B132B),
          ],
        );
    }
  }

  Color _getTextColor() {
    return _backgroundTheme == 0 ? Colors.white : AppColors.textDark;
  }

  Color _getCardBgColor() {
    return _backgroundTheme == 0
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.85);
  }

  Color _getBorderColor() {
    return _backgroundTheme == 0
        ? Colors.white.withValues(alpha: 0.12)
        : Colors.black.withValues(alpha: 0.08);
  }

  Widget _buildTopToolbar() {
    final textColor = _getTextColor();
    final cardBg = _getCardBgColor();
    final borderColor = _getBorderColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: cardBg,
        border: Border(bottom: BorderSide(color: borderColor)),
      ),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Logo & Brand Name
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryGreen.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.handshake_rounded,
                          color: Colors.white, size: 18),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            'PakaiDulu',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.primaryGreen.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppColors.primaryGreen
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: const Text(
                              'NETLIFY PREVIEW',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Simulasi Tampilan Mobile App',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: textColor.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(width: 24),

              // Device Selector Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: borderColor),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedDevice.id,
                    dropdownColor: _backgroundTheme == 0
                        ? const Color(0xFF1E293B)
                        : Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down_rounded,
                        color: textColor, size: 18),
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                    items: DevicePreset.all.map((device) {
                      return DropdownMenuItem<String>(
                        value: device.id,
                        child: Row(
                          children: [
                            Icon(
                              device.brand == 'Apple'
                                  ? Icons.phone_iphone_rounded
                                  : Icons.phone_android_rounded,
                              size: 15,
                              color: AppColors.primaryGreen,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${device.name} (${device.width.toInt()}x${device.height.toInt()})',
                              style: TextStyle(color: textColor),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _selectedDevice = DevicePreset.all
                              .firstWhere((element) => element.id == val);
                        });
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Frame Toggle Button
              InkWell(
                onTap: () => setState(() => _showFrame = !_showFrame),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: _showFrame
                        ? AppColors.primaryGreen.withValues(alpha: 0.15)
                        : cardBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          _showFrame ? AppColors.primaryGreen : borderColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _showFrame
                            ? Icons.crop_portrait_rounded
                            : Icons.fullscreen_rounded,
                        size: 16,
                        color: _showFrame ? AppColors.primaryGreen : textColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _showFrame ? 'Frame ON' : 'Frame OFF',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color:
                              _showFrame ? AppColors.primaryGreen : textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Rotate Orientation
              InkWell(
                onTap: () => setState(() => _isLandscape = !_isLandscape),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: _isLandscape
                        ? AppColors.primaryGreen.withValues(alpha: 0.15)
                        : cardBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: _isLandscape
                          ? AppColors.primaryGreen
                          : borderColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.screen_rotation_rounded,
                        size: 16,
                        color:
                            _isLandscape ? AppColors.primaryGreen : textColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _isLandscape ? 'Lanskap' : 'Potret',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: _isLandscape
                              ? AppColors.primaryGreen
                              : textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Background Theme Toggle
              InkWell(
                onTap: () {
                  setState(() {
                    _backgroundTheme = (_backgroundTheme + 1) % 3;
                  });
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _backgroundTheme == 0
                            ? Icons.dark_mode_rounded
                            : (_backgroundTheme == 1
                                ? Icons.coffee_rounded
                                : Icons.light_mode_rounded),
                        size: 16,
                        color: textColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _backgroundTheme == 0
                            ? 'Tema Gelap'
                            : (_backgroundTheme == 1
                                ? 'Tema Warm'
                                : 'Tema Terang'),
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceViewport(BoxConstraints constraints) {
    final rawWidth =
        _isLandscape ? _selectedDevice.height : _selectedDevice.width;
    final rawHeight =
        _isLandscape ? _selectedDevice.width : _selectedDevice.height;

    const framePadding = 14.0;
    const buttonThickness = 3.5;

    final totalTargetWidth = _showFrame
        ? rawWidth + (framePadding * 2) + (buttonThickness * 2)
        : rawWidth;
    final totalTargetHeight =
        _showFrame ? rawHeight + (framePadding * 2) : rawHeight;

    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        width: totalTargetWidth,
        height: totalTargetHeight,
        child: Center(
          child: _showFrame
              ? _buildPhysicalPhoneFrame(rawWidth, rawHeight)
              : _buildFramelessScreen(rawWidth, rawHeight),
        ),
      ),
    );
  }

  /// Tampilan dengan bingkai fisik smartphone nyata (Titanium bezel, tombol, Dynamic Island)
  Widget _buildPhysicalPhoneFrame(double screenWidth, double screenHeight) {
    const bezelWidth = 12.0;

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Side Buttons (Kiri: Volume, Kanan: Power)
        Positioned(
          left: -4,
          top: 140,
          child: _buildSideButton(height: 38),
        ),
        Positioned(
          left: -4,
          top: 190,
          child: _buildSideButton(height: 52),
        ),
        Positioned(
          left: -4,
          top: 252,
          child: _buildSideButton(height: 52),
        ),
        Positioned(
          right: -4,
          top: 190,
          child: _buildSideButton(height: 76),
        ),

        // Outer Metallic Chassis
        Container(
          width: screenWidth + (bezelWidth * 2),
          height: screenHeight + (bezelWidth * 2),
          decoration: BoxDecoration(
            color: const Color(0xFF1E242B),
            borderRadius:
                BorderRadius.circular(_selectedDevice.cornerRadius + 10),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF38404B),
                Color(0xFF181B20),
                Color(0xFF282F38),
                Color(0xFF14171B),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.55),
                blurRadius: 40,
                spreadRadius: 4,
                offset: const Offset(0, 20),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.08),
                blurRadius: 8,
                spreadRadius: -2,
                offset: const Offset(0, -2),
              ),
            ],
            border: Border.all(
              color: const Color(0xFF4A5568).withValues(alpha: 0.6),
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(bezelWidth),
            child: Stack(
              children: [
                // Inner Screen Canvas
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(_selectedDevice.cornerRadius),
                  child: Container(
                    color: AppColors.backgroundCream,
                    width: screenWidth,
                    height: screenHeight,
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        size: Size(screenWidth, screenHeight),
                        padding: EdgeInsets.only(
                          top: _selectedDevice.statusBarHeight,
                          bottom: _selectedDevice.bottomBarHeight,
                        ),
                        viewPadding: EdgeInsets.only(
                          top: _selectedDevice.statusBarHeight,
                          bottom: _selectedDevice.bottomBarHeight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(child: widget.child),
                          // Simulated Status Bar
                          if (!_isLandscape)
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: IgnorePointer(
                                child: _buildSimulatedStatusBar(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Top Sensor Hardware (Dynamic Island atau Punch Hole)
                if (!_isLandscape) ...[
                  if (_selectedDevice.hasDynamicIsland)
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 120,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: 11,
                                height: 11,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0F172A),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E3A8A)
                                          .withValues(alpha: 0.8),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else if (_selectedDevice.hasPunchHole)
                    Positioned(
                      top: 12,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 13,
                          height: 13,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Color(0xFF1E293B),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  // Bottom iOS Home Indicator Bar
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 134,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSideButton({required double height}) {
    return Container(
      width: 4,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2B333E),
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildSimulatedStatusBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Time
          const Text(
            '09:41',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
              letterSpacing: -0.2,
            ),
          ),
          // System Icons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.signal_cellular_alt_rounded,
                  size: 15, color: AppColors.textDark),
              const SizedBox(width: 5),
              const Icon(Icons.wifi_rounded,
                  size: 15, color: AppColors.textDark),
              const SizedBox(width: 5),
              Container(
                width: 22,
                height: 11,
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.5),
                  border: Border.all(color: AppColors.textDark, width: 1.2),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.textDark,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Tampilan minimalis tanpa bingkai fisik (bersih & fokus layar)
  Widget _buildFramelessScreen(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_selectedDevice.cornerRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_selectedDevice.cornerRadius),
        child: Container(
          color: AppColors.backgroundCream,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: Size(screenWidth, screenHeight),
              padding: EdgeInsets.only(
                top: _selectedDevice.statusBarHeight,
                bottom: _selectedDevice.bottomBarHeight,
              ),
              viewPadding: EdgeInsets.only(
                top: _selectedDevice.statusBarHeight,
                bottom: _selectedDevice.bottomBarHeight,
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomInfoBar() {
    final textColor = _getTextColor().withValues(alpha: 0.7);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.touch_app_rounded, size: 14, color: textColor),
            const SizedBox(width: 6),
            Text(
              'Klik & geser layar dengan mouse untuk mensimulasikan gestur sentuh HP',
              style: TextStyle(
                fontSize: 11.5,
                color: textColor,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: textColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              'Ukuran Resolusi: ${_selectedDevice.width.toInt()} × ${_selectedDevice.height.toInt()} pt',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
