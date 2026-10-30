import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'sewa2_screen.dart';

class Sewa1Screen extends StatefulWidget {
  const Sewa1Screen({super.key});

  @override
  State<Sewa1Screen> createState() => _Sewa1ScreenState();
}

class _Sewa1ScreenState extends State<Sewa1Screen> {
  int _selectedDurationIndex = 0; // 0: 1 Hari, 1: 3 Hari, 2: 7 Hari
  int _selectedDeliveryOption = 0; // 0: Langsung Kirim, 1: Bertemu langsung
  int _selectedDate = 11;
  bool _usePoints = false;

  final List<Map<String, dynamic>> _durations = [
    {'title': '1 Hari', 'price': 150000, 'label': 'Rp. 150.000'},
    {'title': '3 Hari', 'price': 400000, 'label': 'Rp. 400.000'},
    {'title': '7 Hari', 'price': 990830, 'label': 'Rp. 990.830'},
  ];

  int get _rentalPrice => _durations[_selectedDurationIndex]['price'] as int;
  int get _depositPrice => 500000;
  int get _totalPrice => _rentalPrice + _depositPrice - (_usePoints ? 5000 : 0);

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
          'Sewa Barang',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Location Bar
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.primaryGreen,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fitriany wirayuda',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textLight,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Depok, Jawa Barat',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Calendar Card (Mei 2026)
                _buildCalendarCard(),

                const SizedBox(height: 24),

                // Durasi Sewa Section
                const Text(
                  'Durasi Sewa',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),

                // 3 Duration Cards
                Row(
                  children: List.generate(_durations.length, (index) {
                    final item = _durations[index];
                    final isSelected = _selectedDurationIndex == index;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDurationIndex = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            right: index < _durations.length - 1 ? 10 : 0,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryGreen
                                  : Colors.transparent,
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                item['title'] as String,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? AppColors.primaryGreen
                                      : AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['label'] as String,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: AppColors.textMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 12),

                // "Sesuaikan waktu peminjamanmu"
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.primaryGreen.withValues(alpha: 0.5),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Sesuaikan waktu peminjamanmu',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // "Pesan untuk Penjual"
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.primaryGreen.withValues(alpha: 0.4),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pesan untuk Penjual',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Tinggalkan pesan',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textLight,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 12, color: AppColors.textLight),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // "Opsi Pengiriman"
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Opsi Pengiriman',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Text(
                            'Lihat Semua',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: AppColors.textMedium,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 12, color: AppColors.textMedium),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Pengiriman 1: Langsung Kirim
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDeliveryOption = 0;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _selectedDeliveryOption == 0
                            ? AppColors.primaryGreen
                            : const Color(0xFFE2E8F0),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Langsung Kirim',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.help_outline_rounded,
                                    size: 14, color: AppColors.textLight),
                              ],
                            ),
                            RichText(
                              text: const TextSpan(
                                text: 'Rp. 15.000 ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textLight,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Rp.0',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryGreen,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'kamu mendapatkan gratis ongkir!',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Pengiriman 2: Bertemu langsung
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDeliveryOption = 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _selectedDeliveryOption == 1
                            ? AppColors.primaryGreen
                            : const Color(0xFFE2E8F0),
                        width: 1.5,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bertemu langsung',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Janji ketemu di mana?',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textLight,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Rp.0',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // Voucher Card
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFFFA26B),
                      width: 1.2,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.confirmation_number_outlined,
                          color: AppColors.primaryOrange, size: 22),
                      SizedBox(width: 10),
                      Text(
                        'Voucher',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Tukarkan 50 point
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFFFA26B),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.monetization_on,
                              color: Colors.amber, size: 22),
                          SizedBox(width: 10),
                          Text(
                            'Tukarkan 50 point',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: _usePoints,
                        onChanged: (val) {
                          setState(() {
                            _usePoints = val;
                          });
                        },
                        activeColor: AppColors.primaryOrange,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Reminder green badge
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC8E6C9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle,
                          color: AppColors.primaryGreen, size: 24),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Kamu akan mendapat pengingat sebelum tanggal pengembalian',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryGreen,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // BOTTOM ACTION BAR: Contextual addition requested by user to continue to sewa2.png!
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: AppColors.textLight,
                          ),
                        ),
                        Text(
                          'Rp. ${_totalPrice.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]}.',
                          )}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Sewa2Screen(
                                  itemTitle: 'Kamera DSLR Canon EOS 2000D',
                                  ownerName: 'Fitriany Wirayuda',
                                  rentalFee: _rentalPrice,
                                  depositFee: _depositPrice,
                                  deliveryFee: 0,
                                  totalAmount: _totalPrice,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryGreen,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Lanjut ke Pembayaran',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCard() {
    final weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          // Month Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.chevron_left_rounded,
                    color: AppColors.primaryGreen, size: 24),
                onPressed: () {},
              ),
              const Text(
                'Mei 2026',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryOrange,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.chevron_right_rounded,
                    color: AppColors.primaryGreen, size: 24),
                onPressed: () {},
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Weekdays
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays.map((day) {
              final isWeekend = day == 'Su';
              return SizedBox(
                width: 32,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: isWeekend
                        ? AppColors.primaryOrange
                        : AppColors.primaryGreen,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 10),

          // Dates Grid (Mei 2026 starts on Friday May 1)
          // Row 1: empty 5, 1, 2
          _buildCalendarWeek(['', '', '', '', '', '1', '2']),
          _buildCalendarWeek(['3', '4', '5', '6', '7', '8', '9']),
          _buildCalendarWeek(['10', '11', '12', '13', '14', '15', '16']),
          _buildCalendarWeek(['17', '18', '19', '20', '21', '22', '23']),
          _buildCalendarWeek(['24', '25', '26', '27', '28', '29', '30']),
          _buildCalendarWeek(['31', '', '', '', '', '', '']),
        ],
      ),
    );
  }

  Widget _buildCalendarWeek(List<String> days) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days.map((d) {
          if (d.isEmpty) {
            return const SizedBox(width: 32, height: 32);
          }
          final int dayNum = int.tryParse(d) ?? 0;
          final bool isSelected = dayNum == _selectedDate;
          final bool isSunday = (dayNum == 3 ||
              dayNum == 10 ||
              dayNum == 17 ||
              dayNum == 24 ||
              dayNum == 31);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = dayNum;
              });
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF81C784) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? Colors.white
                        : (isSunday
                            ? AppColors.primaryOrange
                            : AppColors.textDark),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

