import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'home_screen.dart';

class Sewa2Screen extends StatefulWidget {
  final String itemTitle;
  final String ownerName;
  final int rentalFee;
  final int depositFee;
  final int deliveryFee;
  final int totalAmount;

  const Sewa2Screen({
    super.key,
    this.itemTitle = 'Kamera DSLR Canon EOS 2000D',
    this.ownerName = 'Fitriany Wirayuda',
    this.rentalFee = 150000,
    this.depositFee = 500000,
    this.deliveryFee = 0,
    this.totalAmount = 650000,
  });

  @override
  State<Sewa2Screen> createState() => _Sewa2ScreenState();
}

class _Sewa2ScreenState extends State<Sewa2Screen> {
  String _selectedPaymentMethod = 'QRIS';

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'COD',
      'title': 'COD',
      'icon': Icons.local_shipping_outlined,
      'color': const Color(0xFFF15A24),
      'hasHelp': true,
    },
    {
      'id': 'QRIS',
      'title': 'QRIS',
      'icon': Icons.qr_code_2_rounded,
      'color': Colors.black87,
      'hasHelp': false,
    },
    {
      'id': 'GoPay',
      'title': 'GoPay',
      'icon': Icons.account_balance_wallet_rounded,
      'color': const Color(0xFF00AED6),
      'hasHelp': false,
    },
    {
      'id': 'OVO',
      'title': 'OVO',
      'icon': Icons.lens_rounded,
      'color': const Color(0xFF4C3494),
      'hasHelp': false,
    },
    {
      'id': 'Dana',
      'title': 'Dana',
      'icon': Icons.send_to_mobile_rounded,
      'color': const Color(0xFF108EE9),
      'hasHelp': false,
    },
    {
      'id': 'Transfer Bank',
      'title': 'Transfer Bank',
      'icon': Icons.sync_alt_rounded,
      'color': const Color(0xFFF15A24),
      'hasHelp': true,
    },
    {
      'id': 'Kartu Kredit/Debit',
      'title': 'Kartu Kredit/Debit',
      'icon': Icons.credit_card_rounded,
      'color': const Color(0xFFF15A24),
      'hasHelp': true,
    },
    {
      'id': 'Bayar Tunai di Mitra/Agen',
      'title': 'Bayar Tunai di Mitra/Agen',
      'icon': Icons.store_rounded,
      'color': const Color(0xFFF15A24),
      'hasHelp': true,
    },
  ];

  String _formatCurrency(int number) {
    return 'Rp. ${number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated green success badge
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primaryGreen,
                      size: 58,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Pembayaran Berhasil!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFFFEDD5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.hourglass_top_rounded,
                          color: AppColors.primaryOrange, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Menunggu konfirmasi dari pihak pemilik barang (${widget.ownerName}).',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF9A3412),
                            fontWeight: FontWeight.w600,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Order summary snippet
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      _buildSummaryRow('Barang', widget.itemTitle),
                      const SizedBox(height: 6),
                      _buildSummaryRow('Metode', _selectedPaymentMethod),
                      const SizedBox(height: 6),
                      _buildSummaryRow(
                          'Total Bayar', _formatCurrency(widget.totalAmount),
                          isBold: true),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext); // Close dialog
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
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
                      'Kembali ke Beranda',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildSummaryRow(String label, String value,
      {bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12.5, color: AppColors.textMedium),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isBold ? AppColors.primaryGreen : AppColors.textDark,
            ),
          ),
        ),
      ],
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
              color: AppColors.textDark, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Metode pembayaran',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Methods Card
            Container(
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
              child: ListView.separated(
                itemCount: _paymentMethods.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 0.8,
                  color: Color(0xFFF1F3F5),
                ),
                itemBuilder: (context, index) {
                  final method = _paymentMethods[index];
                  final isSelected = _selectedPaymentMethod == method['id'];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = method['id'] as String;
                      });
                    },
                    borderRadius: BorderRadius.vertical(
                      top: index == 0 ? const Radius.circular(20) : Radius.zero,
                      bottom: index == _paymentMethods.length - 1
                          ? const Radius.circular(20)
                          : Radius.zero,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          // Payment Icon / Logo
                          Container(
                            width: 44,
                            height: 32,
                            decoration: BoxDecoration(
                              color: (method['color'] as Color)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              method['icon'] as IconData,
                              color: method['color'] as Color,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),

                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  method['title'] as String,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                if (method['hasHelp'] as bool) ...[
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.help_outline_rounded,
                                    size: 13,
                                    color: AppColors.textLight,
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Radio Check
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primaryGreen
                                    : const Color(0xFFCBD5E1),
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primaryGreen,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // "Informasi Deposit" Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFC8E6C9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: AppColors.primaryGreen.withValues(alpha: 0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryOrange.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: AppColors.primaryOrange,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Deposit',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Deposit akan ditahan oleh platform dan dikembalikan setelah barang diverifikasi dalam keadaan baik dan telah dikembalikan.',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF1B4D24),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // "Rincian pembayaran"
            const Text(
              'Rincian pembayaran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),

            _buildDetailLine(
                'Harga Sewa', _formatCurrency(widget.rentalFee)),
            const SizedBox(height: 8),
            _buildDetailLine(
                'Deposit (ditahan)', _formatCurrency(widget.depositFee)),
            const SizedBox(height: 8),
            _buildDetailLine(
                'Biaya ongkir', _formatCurrency(widget.deliveryFee)),
            const SizedBox(height: 8),
            _buildDetailLine('Tukarkan 50 point', '-'),
            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  _formatCurrency(widget.totalAmount),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Tombol Bayar Sekarang
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _showSuccessDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Bayar Sekarang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailLine(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13.5,
            color: AppColors.textMedium,
          ),
        ),
        Text(
          amount,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

