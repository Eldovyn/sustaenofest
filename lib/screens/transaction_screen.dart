import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'laporan_barang_screen.dart';
import 'detail_request_screen.dart';
import 'laporan_after_sampe_screen.dart';
import 'chat_screen.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String _selectedTab = 'Semua';

  final List<String> _tabs = ['Semua', 'Aktif', 'Menunggu', 'Riwayat'];

  // List of transactions
  late List<Map<String, dynamic>> _transactions;

  @override
  void initState() {
    super.initState();
    _transactions = [
      {
        'id': 'canon',
        'title': 'Kamera DSLR Canon',
        'date': '11 Mei 2026',
        'status': 'Aktif', // Aktif, Menunggu, Dibatalkan
        'statusLabel': 'Status Aktif',
        'image': 'Aset/item_kamera_thumb.png',
        'isMyRequest': true, // Kita yang request sewa ke Fitriany
        'owner': 'Fitriany Wirayuda',
        'hasBeenAcc': true,
      },
      {
        'id': 'proyektor',
        'title': 'Proyektor Epson',
        'date': '29 April 2026',
        'status': 'Menunggu',
        'statusLabel': 'Menunggu Verifikasi',
        'image': 'Aset/item_proyektor.png',
        'isIncomingRequest': true, // Calon pengguna yang request sewa barang kita
        'requester': 'Budi Pratama',
      },
      {
        'id': 'bbq',
        'title': 'BBQ Grill',
        'date': '26 April 2026',
        'status': 'Aktif',
        'statusLabel': 'Status Aktif',
        'image': 'Aset/item_bbq.png',
      },
      {
        'id': 'speaker',
        'title': 'Speaker JBL',
        'date': '14 Februari 2026',
        'status': 'Riwayat',
        'statusLabel': 'Status Dibatalkan',
        'image': 'Aset/item_speaker.png',
      },
      {
        'id': 'dress',
        'title': 'Halloween Dress',
        'date': '31 Oktober 2025',
        'status': 'Riwayat',
        'statusLabel': 'Selesai',
        'image': 'Aset/item_tenda.png',
      },
    ];
  }

  int get _menungguCount {
    return _transactions.where((t) => t['status'] == 'Menunggu').length;
  }

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_selectedTab == 'Semua') return _transactions;
    if (_selectedTab == 'Aktif') {
      return _transactions.where((t) => t['status'] == 'Aktif').toList();
    }
    if (_selectedTab == 'Menunggu') {
      return _transactions.where((t) => t['status'] == 'Menunggu').toList();
    }
    if (_selectedTab == 'Riwayat') {
      return _transactions.where((t) => t['status'] == 'Riwayat').toList();
    }
    return _transactions;
  }

  void _openLaporanBarang(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LaporanBarangScreen(
          itemTitle: item['title'] as String,
          dateText: item['date'] as String,
          imagePath: item['image'] as String,
        ),
      ),
    );
  }

  void _openDetailRequest(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailRequestScreen(
          onAcc: () {
            setState(() {
              item['status'] = 'Aktif';
              item['statusLabel'] = 'Status Aktif';
            });
          },
          onReject: () {
            setState(() {
              item['status'] = 'Riwayat';
              item['statusLabel'] = 'Status Ditolak';
            });
          },
        ),
      ),
    );
  }

  void _simulateAccOurRequest() {
    // Dummy: rikues kita di-ACC oleh pihak pemilik barang
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎉 Rikues sewa Anda telah di-ACC oleh Fitriany Wirayuda!'),
        backgroundColor: AppColors.primaryGreen,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LaporanAfterSampeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // Tabs Header: Semua, Aktif, Menunggu, Riwayat
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: _tabs.map((tab) {
                  final isSelected = _selectedTab == tab;
                  final isMenunggu = tab == 'Menunggu';

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = tab;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFF1F8F3)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryGreen
                                : const Color(0xFFE2E8F0),
                            width: 1.2,
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Text(
                              tab,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                                color: isSelected
                                    ? AppColors.primaryGreen
                                    : AppColors.textDark,
                              ),
                            ),
                            if (isMenunggu && _menungguCount > 0)
                              Positioned(
                                top: -8,
                                right: -4,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.redAccent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '$_menungguCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Dummy Simulation Action for "Rikues kita di ACC"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: InkWell(
                onTap: _simulateAccOurRequest,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primaryGreen, width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rikues Kamera Canon Anda Di-ACC! ✨',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                            Text(
                              'Klik untuk mengisi dokumentasi kondisi barang',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded,
                          size: 14, color: AppColors.primaryGreen),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Transactions List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                itemCount: _filteredTransactions.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final item = _filteredTransactions[index];
                  return _buildTransactionCard(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> item) {
    final status = item['status'] as String;
    final isActive = status == 'Aktif';
    final isMenunggu = status == 'Menunggu';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F5),
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
        children: [
          // Top Row: Image, Title, Date, and 3-Dots for Active items
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  item['image'] as String,
                  width: 70,
                  height: 68,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 70,
                    height: 68,
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
                      item['title'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['date'] as String,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),

              // Titik Tiga di kanan atas untuk card yang statusnya aktif!
              if (isActive)
                PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    color: AppColors.textDark,
                    size: 22,
                  ),
                  onSelected: (val) {
                    if (val == 'lapor') {
                      _openLaporanBarang(item);
                    } else if (val == 'dokumen') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LaporanAfterSampeScreen(),
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'lapor',
                      child: Row(
                        children: [
                          Icon(Icons.report_problem_outlined,
                              color: Colors.orange, size: 20),
                          SizedBox(width: 10),
                          Text('Lapor Barang Bermasalah'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'dokumen',
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt_outlined,
                              color: AppColors.primaryGreen, size: 20),
                          SizedBox(width: 10),
                          Text('Dokumentasi Kondisi'),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),

          const SizedBox(height: 14),

          // Bottom Action Row: Chat, Status Pill, Detail
          Row(
            children: [
              // Chat Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatScreen()),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFDDE3EA)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.chat_bubble_outline_rounded,
                          size: 16, color: AppColors.textDark),
                      SizedBox(width: 6),
                      Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Status Pill
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: _getStatusBgColor(status),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item['statusLabel'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                      color: _getStatusTextColor(status),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Detail Button
              GestureDetector(
                onTap: () {
                  if (isMenunggu) {
                    _openDetailRequest(item);
                  } else {
                    _openLaporanBarang(item);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFDDE3EA)),
                  ),
                  child: const Text(
                    'Detail',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusBgColor(String status) {
    switch (status) {
      case 'Aktif':
        return const Color(0xFFC8E6C9);
      case 'Menunggu':
        return const Color(0xFFFFCC80);
      case 'Riwayat':
      default:
        return const Color(0xFFFFCDD2);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case 'Aktif':
        return AppColors.primaryGreen;
      case 'Menunggu':
        return const Color(0xFFE65100);
      case 'Riwayat':
      default:
        return Colors.red.shade700;
    }
  }
}

