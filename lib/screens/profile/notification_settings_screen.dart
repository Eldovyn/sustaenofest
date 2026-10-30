import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  // Transaksi
  bool _orderStatus = true;
  bool _returnReminder = true;
  bool _depositUpdate = true;

  // Obrolan
  bool _chatMessages = true;
  bool _discussionUpdates = true;

  // Promo
  bool _promoDiscounts = false;
  bool _nearbyRecommendations = true;

  // Channels
  bool _pushNotifications = true;
  bool _whatsappNotifications = true;
  bool _emailSummary = false;

  void _showSavedFeedback() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preferensi notifikasi disimpan'),
        duration: Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundCream,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.textDark, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pengaturan Notifikasi',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transaksi & Sewa
              _buildSectionHeader(
                icon: Icons.receipt_long_rounded,
                title: 'Transaksi & Sewa',
              ),
              Container(
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: 'Update Status Pesanan',
                      subtitle:
                          'Pemberitahuan saat permintaan sewa disetujui, dikirim, atau selesai.',
                      value: _orderStatus,
                      onChanged: (val) {
                        setState(() => _orderStatus = val);
                        _showSavedFeedback();
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      title: 'Pengingat Pengembalian Barang',
                      subtitle:
                          'Pengingat H-1 dan hari pengembalian agar tepat waktu bebas denda.',
                      value: _returnReminder,
                      onChanged: (val) {
                        setState(() => _returnReminder = val);
                        _showSavedFeedback();
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      title: 'Konfirmasi Deposit & Refund',
                      subtitle:
                          'Notifikasi ketika saldo jaminan ditahan atau berhasil dicairkan.',
                      value: _depositUpdate,
                      onChanged: (val) {
                        setState(() => _depositUpdate = val);
                        _showSavedFeedback();
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Chat & Komunikasi
              _buildSectionHeader(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Chat & Komunikasi',
              ),
              Container(
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: 'Pesan Chat Pengguna',
                      subtitle:
                          'Notifikasi pesan instan baru dari pemilik atau penyewa barang.',
                      value: _chatMessages,
                      onChanged: (val) {
                        setState(() => _chatMessages = val);
                        _showSavedFeedback();
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      title: 'Diskusi & Negosiasi',
                      subtitle:
                          'Pemberitahuan respon tawaran harga atau ketersediaan barang.',
                      value: _discussionUpdates,
                      onChanged: (val) {
                        setState(() => _discussionUpdates = val);
                        _showSavedFeedback();
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Rekomendasi & Penawaran
              _buildSectionHeader(
                icon: Icons.local_offer_outlined,
                title: 'Promo & Rekomendasi',
              ),
              Container(
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: 'Promo & Voucher Diskon',
                      subtitle:
                          'Kupon potongan harga sewa mingguan dan cashback deposit.',
                      value: _promoDiscounts,
                      onChanged: (val) {
                        setState(() => _promoDiscounts = val);
                        _showSavedFeedback();
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      title: 'Rekomendasi Barang Terdekat',
                      subtitle:
                          'Info barang sewaan populer yang baru diunggah di sekitar lokasimu.',
                      value: _nearbyRecommendations,
                      onChanged: (val) {
                        setState(() => _nearbyRecommendations = val);
                        _showSavedFeedback();
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Saluran Notifikasi
              _buildSectionHeader(
                icon: Icons.send_rounded,
                title: 'Metode Pengiriman',
              ),
              Container(
                decoration: _cardDecoration(),
                child: Column(
                  children: [
                    _buildSwitchTile(
                      title: 'Push Notification HP',
                      subtitle: 'Muncul di status bar layar HP Anda.',
                      value: _pushNotifications,
                      onChanged: (val) {
                        setState(() => _pushNotifications = val);
                        _showSavedFeedback();
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      title: 'Notifikasi WhatsApp',
                      subtitle:
                          'Kirim ringkasan penting langsung ke WhatsApp Anda.',
                      value: _whatsappNotifications,
                      onChanged: (val) {
                        setState(() => _whatsappNotifications = val);
                        _showSavedFeedback();
                      },
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      title: 'Email Rangkuman Mingguan',
                      subtitle: 'Kirim riwayat aktivitas dan tips sewa berkala.',
                      value: _emailSummary,
                      onChanged: (val) {
                        setState(() => _emailSummary = val);
                        _showSavedFeedback();
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primaryGreen),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11.5,
            color: AppColors.textMedium,
            height: 1.3,
          ),
        ),
      ),
      value: value,
      activeColor: AppColors.primaryGreen,
      activeTrackColor: AppColors.primaryGreen.withValues(alpha: 0.25),
      onChanged: onChanged,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 0.8,
      indent: 16,
      endIndent: 16,
      color: Color(0xFFF1F3F5),
    );
  }
}
