import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class LaporanBarangScreen extends StatefulWidget {
  final String itemTitle;
  final String dateText;
  final String imagePath;

  const LaporanBarangScreen({
    super.key,
    this.itemTitle = 'Kamera DSLR Canon EOS 2000D',
    this.dateText = '11 Mei 2026',
    this.imagePath = 'Aset/item_kamera_thumb.png',
  });

  @override
  State<LaporanBarangScreen> createState() => _LaporanBarangScreenState();
}

class _LaporanBarangScreenState extends State<LaporanBarangScreen> {
  final TextEditingController _descController = TextEditingController();
  final List<bool> _uploadedPhotos = [false, false, false];

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  void _submitLaporan() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.primaryGreen, size: 28),
            SizedBox(width: 8),
            Text('Laporan Terkirim', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          'Laporan Anda telah diterima oleh tim dukungan PakaiDulu. Kami akan meninjau bukti dan menghubungi Anda dalam 1-3 hari kerja.',
          style: TextStyle(fontSize: 13.5, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text(
              'Selesai',
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryGreen, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // STEP 1: Pilih Transaksi
              _buildStepHeader(
                step: '1',
                title: 'Pilih Transaksi',
                subtitle: 'Pilih transaksi yang bermasalah',
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.imagePath,
                        width: 65,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 65,
                          height: 60,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.inventory_2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.itemTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.dateText,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textDark, size: 24),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // STEP 2: Unggah Bukti
              _buildStepHeader(
                step: '2',
                title: 'Unggah Bukti',
                subtitle: 'Tambahkan foto/Vidio dan deskripsi masalah',
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // 3 Photo Upload Boxes
                    Row(
                      children: List.generate(3, (index) {
                        final bool hasPhoto = _uploadedPhotos[index];
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _uploadedPhotos[index] = !_uploadedPhotos[index];
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: index < 2 ? 10 : 0),
                              height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE2E8F0),
                                borderRadius: BorderRadius.circular(16),
                                border: hasPhoto
                                    ? Border.all(color: AppColors.primaryGreen, width: 2)
                                    : null,
                              ),
                              child: Center(
                                child: Icon(
                                  hasPhoto
                                      ? Icons.check_circle_rounded
                                      : Icons.camera_alt_outlined,
                                  color: hasPhoto
                                      ? AppColors.primaryGreen
                                      : Colors.grey.shade600,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 16),

                    // Description TextField
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextField(
                            controller: _descController,
                            maxLines: 4,
                            maxLength: 500,
                            onChanged: (_) => setState(() {}),
                            style: const TextStyle(fontSize: 13.5, color: AppColors.textDark),
                            decoration: const InputDecoration(
                              hintText: 'Tulis deskripsi masalah..',
                              hintStyle: TextStyle(color: AppColors.textLight, fontSize: 13),
                              border: InputBorder.none,
                              counterText: '',
                            ),
                          ),
                          Text(
                            '${_descController.text.length}/500',
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // STEP 3: Kirim Laporan
              _buildStepHeader(
                step: '3',
                title: 'Kirim Laporan',
                subtitle: 'Tim kami akan meninjau laporan dalam 1-3 hari kerja',
              ),

              const SizedBox(height: 36),

              // Tombol Kirim Laporan
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submitLaporan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Kirim Laporan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepHeader({
    required String step,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: AppColors.primaryGreen,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

