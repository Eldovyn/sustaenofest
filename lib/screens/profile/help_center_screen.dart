import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Semua';

  final List<Map<String, String>> _faqs = [
    {
      'category': 'Deposit',
      'q': 'Bagaimana mekanisme saldo deposit / jaminan di PakaiDulu?',
      'a':
          'Deposit berfungsi sebagai jaminan keamanan bagi pemilik barang. Dana deposit Anda disimpan di rekening bersama (escrow) resmi dan akan otomatis dikembalikan 100% ke saldo akun Anda setelah barang dikembalikan dalam kondisi utuh dan disetujui pemilik.',
    },
    {
      'category': 'Sewa',
      'q': 'Apa yang harus dilakukan jika barang mengalami kendala atau kerusakan?',
      'a':
          'Segera dokumentasikan kondisi barang dengan foto atau video, lalu gunakan tombol "Laporkan Kendala" di menu Transaksi pada kartu sewa aktif. Tim resolusi PakaiDulu akan membantu proses mediasi serta klaim asuransi perlindungan barang.',
    },
    {
      'category': 'Deposit',
      'q': 'Berapa lama proses pencairan saldo deposit ke rekening bank?',
      'a':
          'Pencairan saldo deposit ke rekening bank terdaftar (BCA, Mandiri, BRI, BNI) atau e-wallet (GoPay, OVO, DANA) berlangsung secara real-time instan dalam waktu 1-5 menit tanpa potongan biaya admin.',
    },
    {
      'category': 'Verifikasi',
      'q': 'Apakah identitas KTP dan swafoto saya aman?',
      'a':
          'Sangat aman. PakaiDulu menerapkan standar enkripsi AES-256 dan kepatuhan penuh terhadap UU Perlindungan Data Pribadi (UU PDP). Dokumen identitas Anda terenkripsi dan tidak pernah ditampilkan kepada penyewa atau pemilik lain.',
    },
    {
      'category': 'Pengembalian',
      'q': 'Bagaimana jika saya terlambat mengembalikan barang sewa?',
      'a':
          'Anda dapat mengajukan perpanjangan sewa di halaman Transaksi sebelum durasi berakhir. Keterlambatan tanpa persetujuan pemilik akan dikenakan denda keterlambatan proporsional yang dipotong dari saldo deposit.',
    },
    {
      'category': 'Sewa',
      'q': 'Bagaimana cara mulai menyewakan barang pribadi saya?',
      'a':
          'Masuk ke halaman Beranda atau Akun, pilih "Mulai Sewakan Barang", lalu unggah foto produk, rincian kelengkapan, harga sewa harian, dan besaran uang deposit jaminan yang diinginkan.',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showContactSnackbar(String channel) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.headset_mic_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text('Menghubungkan ke $channel Customer Support...'),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.toLowerCase();
    final filteredFaqs = _faqs.where((faq) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          faq['category'] == _selectedCategory;
      final matchesQuery = query.isEmpty ||
          faq['q']!.toLowerCase().contains(query) ||
          faq['a']!.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();

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
          'Pusat Bantuan & FAQ',
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
              // Contact Channels Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Butuh Bantuan Cepat?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tim layanan pelanggan PakaiDulu siap mendampingi Anda 24/7.',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMedium,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildContactCard(
                          icon: Icons.chat_rounded,
                          label: 'Live Chat',
                          sub: 'Respon Cepat',
                          color: AppColors.primaryGreen,
                          onTap: () => _showContactSnackbar('Live Chat'),
                        ),
                        const SizedBox(width: 10),
                        _buildContactCard(
                          icon: Icons.phone_forwarded_rounded,
                          label: 'WhatsApp',
                          sub: '0811-7252-4385',
                          color: const Color(0xFF25D366),
                          onTap: () => _showContactSnackbar('WhatsApp Support'),
                        ),
                        const SizedBox(width: 10),
                        _buildContactCard(
                          icon: Icons.email_rounded,
                          label: 'Email',
                          sub: 'support@pakaidulu',
                          color: AppColors.primaryOrange,
                          onTap: () => _showContactSnackbar('Email Support'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Cari topik atau pertanyaan...',
                    hintStyle: const TextStyle(
                      color: AppColors.textLight,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(Icons.search_rounded,
                        color: AppColors.primaryGreen, size: 22),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Categories Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Semua',
                    'Deposit',
                    'Sewa',
                    'Verifikasi',
                    'Pengembalian'
                  ].map((category) {
                    final isSel = _selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSel,
                        selectedColor:
                            AppColors.primaryGreen.withValues(alpha: 0.15),
                        labelStyle: TextStyle(
                          color: isSel
                              ? AppColors.primaryGreen
                              : AppColors.textMedium,
                          fontWeight:
                              isSel ? FontWeight.bold : FontWeight.w500,
                          fontSize: 12.5,
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedCategory = category);
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // FAQ List
              const Text(
                'Pertanyaan Sering Diajukan (FAQ)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 10),

              if (filteredFaqs.isEmpty)
                Container(
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(Icons.search_off_rounded,
                          size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 8),
                      const Text(
                        'Tidak ada jawaban ditemukan',
                        style: TextStyle(
                            color: AppColors.textMedium,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredFaqs.length,
                  itemBuilder: (context, index) {
                    final item = filteredFaqs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          iconColor: AppColors.primaryGreen,
                          collapsedIconColor: AppColors.textMedium,
                          title: Text(
                            item['q']!,
                            style: const TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16),
                              child: Text(
                                item['a']!,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: AppColors.textMedium,
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String label,
    required String sub,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                sub,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textMedium,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
