import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'laporan_after_sampe_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Permintaan Sewa Di-ACC! 🎉',
      'body':
          'Fitriany Wirayuda telah menyetujui permintaan sewa Kamera DSLR Canon EOS 2000D Anda. Silakan lengkapi dokumentasi kondisi barang.',
      'time': '5 menit yang lalu',
      'isUnread': true,
      'type': 'rental_acc',
      'icon': Icons.camera_alt_rounded,
      'iconColor': AppColors.primaryGreen,
    },
    {
      'id': '2',
      'title': 'Permintaan Sewa Masuk 📥',
      'body':
          'Budi Pratama mengajukan sewa Proyektor Epson Anda untuk durasi 3 hari. Segera tinjau permintaan.',
      'time': '30 menit yang lalu',
      'isUnread': true,
      'type': 'request_in',
      'icon': Icons.pending_actions_rounded,
      'iconColor': AppColors.primaryOrange,
    },
    {
      'id': '3',
      'title': 'Verifikasi Identitas Berhasil ✅',
      'body':
          'Data KTP dan selfie Anda telah berhasil diverifikasi oleh sistem. Akun Anda kini berstatus Verified.',
      'time': '2 jam yang lalu',
      'isUnread': false,
      'type': 'kyc',
      'icon': Icons.verified_user_rounded,
      'iconColor': const Color(0xFF0288D1),
    },
    {
      'id': '4',
      'title': 'Pengingat Pengembalian ⏰',
      'body':
          'Peminjaman Tenda Camping dijadwalkan selesai dalam 2 hari. Pastikan barang dikembalikan tepat waktu.',
      'time': 'Kemarin',
      'isUnread': false,
      'type': 'reminder',
      'icon': Icons.notifications_active_rounded,
      'iconColor': Colors.amber.shade800,
    },
    {
      'id': '5',
      'title': 'Promo Spesial Sustaenofest 🌿',
      'body':
          'Nikmati cashback deposit dan gratis ongkir untuk seluruh kategori Outdoor & Camping minggu ini!',
      'time': '2 hari yang lalu',
      'isUnread': false,
      'type': 'promo',
      'icon': Icons.local_offer_rounded,
      'iconColor': const Color(0xFF7C3AED),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textDark, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var item in _notifications) {
                  item['isUnread'] = false;
                }
              });
            },
            child: const Text(
              'Tandai Dibaca',
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _notifications[index];
          final bool isUnread = item['isUnread'] as bool;

          return GestureDetector(
            onTap: () {
              setState(() {
                item['isUnread'] = false;
              });

              if (item['type'] == 'rental_acc') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaporanAfterSampeScreen(),
                  ),
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUnread ? Colors.white : Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(18),
                border: isUnread
                    ? Border.all(color: AppColors.primaryGreen.withValues(alpha: 0.4), width: 1.2)
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: (item['iconColor'] as Color).withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: item['iconColor'] as Color,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item['title'] as String,
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight:
                                      isUnread ? FontWeight.bold : FontWeight.w600,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ),
                            if (isUnread)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['body'] as String,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: isUnread
                                ? AppColors.textMedium
                                : AppColors.textLight,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['time'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

