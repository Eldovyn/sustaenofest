import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Ketentuan & Privasi',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(10),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.textMedium,
              labelStyle:
                  const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'Syarat & Ketentuan Sewa'),
                Tab(text: 'Kebijakan Privasi Data'),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildTermsTab(),
            _buildPrivacyTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMetaHeader('Terakhir Diperbarui: 24 Oktober 2026'),
          const SizedBox(height: 16),
          _buildPolicyCard(
            number: '1',
            title: 'Ketentuan Umum & Kelayakan Pengguna',
            content:
                'Pengguna platform PakaiDulu wajib berusia minimal 17 tahun dan telah menyelesaikan verifikasi identitas resmi (e-KTP dan pemindaian wajah biometrik) sebelum dapat menyewa atau menyewakan barang. Setiap akun bersifat personal dan tidak boleh dialihkan kepada orang lain.',
          ),
          const SizedBox(height: 12),
          _buildPolicyCard(
            number: '2',
            title: 'Kewajiban Menjaga Barang & Aksesoris',
            content:
                'Penyewa berkewajiban merawat barang sewaan dengan itikad baik dan menggunakannya sesuai peruntukan normal. Penyewa dilarang keras membongkar, memodifikasi, menggadaikan, atau memindahtangankan barang kepada pihak ketiga tanpa izin tertulis dari pemilik.',
          ),
          const SizedBox(height: 12),
          _buildPolicyCard(
            number: '3',
            title: 'Dana Jaminan / Saldo Deposit',
            content:
                'Saldo deposit ditahan di rekening bersama resmi (escrow) PakaiDulu selama periode sewa berlangsung. Deposit akan otomatis dikembalikan 100% setelah barang diterima kembali oleh pemilik dalam keadaan utuh, berfungsi normal, dan lengkap.',
          ),
          const SizedBox(height: 12),
          _buildPolicyCard(
            number: '4',
            title: 'Keterlambatan & Biaya Denda',
            content:
                'Apabila ingin memperpanjang durasi sewa, permohonan wajib diajukan melalui aplikasi paling lambat 6 jam sebelum masa sewa berakhir. Keterlambatan tanpa persetujuan pemilik akan dikenakan denda proporsional harian yang dipotong dari saldo deposit.',
          ),
          const SizedBox(height: 12),
          _buildPolicyCard(
            number: '5',
            title: 'Klaim Kerusakan & Mediasi Perlindungan',
            content:
                'Jika terjadi kerusakan fisik atau kendala teknis saat masa sewa, kedua pihak wajib mengunggah bukti foto dan video sebelum dan sesudah pemakaian. Tim Resolusi PakaiDulu bertindak sebagai mediator independen berlandaskan program Proteksi PakaiDulu.',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPrivacyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMetaHeader('Sesuai UU No. 27 Tahun 2022 (UU PDP)'),
          const SizedBox(height: 16),
          _buildPolicyCard(
            number: '1',
            title: 'Data Pribadi yang Kami Kumpulkan',
            content:
                'Kami mengumpulkan informasi identitas (NIK KTP, nama lengkap, foto wajah liveness), kontak (nomor WhatsApp, alamat email), alamat pengiriman, koordinat lokasi perangkat saat transaksi, dan riwayat mutasi pembayaran guna memvalidasi transaksi terpercaya.',
          ),
          const SizedBox(height: 12),
          _buildPolicyCard(
            number: '2',
            title: 'Tujuan Pemrosesan & Pemanfaatan Data',
            content:
                'Data pribadi pengguna diproses semata-mata untuk verifikasi KYC (Know Your Customer), pencegahan penipuan sewa, fasilitasi pengantaran kurir, serta komunikasi operasional transaksi antar pengguna.',
          ),
          const SizedBox(height: 12),
          _buildPolicyCard(
            number: '3',
            title: 'Enkripsi & Keamanan Tingkat Tinggi',
            content:
                'Seluruh data identitas disimpan dalam database terenkripsi berstandar industri AES-256. Dokumen KTP Anda tidak pernah ditampilkan secara penuh kepada pengguna lain atau diperjualbelikan kepada pihak ketiga manapun.',
          ),
          const SizedBox(height: 12),
          _buildPolicyCard(
            number: '4',
            title: 'Hak Pengguna atas Data Pribadi',
            content:
                'Pengguna memiliki hak penuh untuk memperbarui profil, melihat arsip aktivitas, serta mengajukan penutupan akun dan penghapusan data identitas permanen melalui Pusat Bantuan PakaiDulu.',
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMetaHeader(String subtitle) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primaryGreen.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified_outlined,
              size: 16, color: AppColors.primaryGreen),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyCard({
    required String number,
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textMedium,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
