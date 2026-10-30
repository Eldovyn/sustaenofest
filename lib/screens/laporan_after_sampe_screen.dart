import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

class LaporanAfterSampeScreen extends StatefulWidget {
  final String itemTitle;

  const LaporanAfterSampeScreen({
    super.key,
    this.itemTitle = 'Kamera DSLR Canon EOS 2000D',
  });

  @override
  State<LaporanAfterSampeScreen> createState() => _LaporanAfterSampeScreenState();
}

class _LaporanAfterSampeScreenState extends State<LaporanAfterSampeScreen> {
  int _selectedTabIndex = 0; // 0: Sebelum Sewa, 1: Sesudah Sewa
  final List<bool> _uploaded = [false, false];
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _saveDocumentation() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: AppColors.primaryGreen, size: 28),
            SizedBox(width: 8),
            Text('Dokumentasi Disimpan',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ],
        ),
        content: const Text(
          'Foto dan data kondisi barang berhasil disimpan ke server dengan timestamp & geotagging otomatis untuk perlindungan deposit Anda.',
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
        title: const Text(
          'Dokumentasi Barang',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Segmented Tabs: Sebelum Sewa vs Sesudah Sewa
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F3F5),
                          borderRadius: BorderRadius.circular(16),
                          border: _selectedTabIndex == 0
                              ? const Border(
                                  bottom: BorderSide(
                                    color: AppColors.primaryGreen,
                                    width: 3,
                                  ),
                                )
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            'Sebelum Sewa',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: _selectedTabIndex == 0
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F3F5),
                          borderRadius: BorderRadius.circular(16),
                          border: _selectedTabIndex == 1
                              ? const Border(
                                  bottom: BorderSide(
                                    color: AppColors.primaryGreen,
                                    width: 3,
                                  ),
                                )
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            'Sesudah Sewa',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: _selectedTabIndex == 1
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: AppColors.textDark,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 2 Photo Upload Boxes
              Row(
                children: List.generate(2, (index) {
                  final bool isUp = _uploaded[index];
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: index == 0 ? 14 : 0),
                      padding: const EdgeInsets.all(12),
                      height: 140,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F3F5),
                        borderRadius: BorderRadius.circular(20),
                        border: isUp
                            ? Border.all(color: AppColors.primaryGreen, width: 2)
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.info_outline_rounded,
                              size: 16, color: Colors.grey),
                          Expanded(
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _uploaded[index] = !_uploaded[index];
                                  });
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      isUp
                                          ? Icons.check_circle_rounded
                                          : Icons.camera_alt_outlined,
                                      size: 40,
                                      color: isUp
                                          ? AppColors.primaryGreen
                                          : Colors.grey.shade600,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      isUp ? 'Foto Terunggah' : 'Tambahkan Foto',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: isUp
                                            ? AppColors.primaryGreen
                                            : Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 20),

              // Timestamp & Location
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.access_time_rounded,
                      size: 18, color: AppColors.primaryGreen),
                  const SizedBox(width: 6),
                  const Text(
                    '11 Mei 2026, 10.31',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.location_on_rounded,
                      size: 18, color: AppColors.primaryGreen),
                  const SizedBox(width: 4),
                  const Text(
                    'Jl. Margonda No. 12',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Instruction Notice
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Tambahkan foto kondisi barang sebelum diserahkan.\nMinimal 3 foto (depan, samping, dan detail)',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Section: Informasi Tambahan
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Informasi Tambahan',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              Container(
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F3F5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFDDE3EA)),
                ),
                child: TextField(
                  controller: _notesController,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 13.5, color: AppColors.textDark),
                  decoration: const InputDecoration(
                    hintText: 'Tambahkan catatan kondisi barang (optional)',
                    hintStyle: TextStyle(color: AppColors.textLight, fontSize: 13),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Button Simpan Dokumentasi
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _saveDocumentation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Simpan Dokumentasi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Footnote
              Text(
                'File akan dilengkapi waktu dan lokasi\nuntuk Keamanan bersama',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade500,
                  height: 1.35,
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

