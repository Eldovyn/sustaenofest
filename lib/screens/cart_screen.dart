import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'explore_screen.dart';
import 'sewa2_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Pre-staged items in the rental cart bundle
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': 'tenda',
      'title': 'Tenda Camping Dome 4P',
      'owner': 'Dimas Outdoor Camp',
      'image': 'Aset/item_tenda.png',
      'pricePerDay': 50000,
      'deposit': 100000,
      'days': 2,
      'selected': true,
      'location': 'Depok, 1,8 km',
    },
    {
      'id': 'kompor',
      'title': 'Kompor Portable Camping',
      'owner': 'Dimas Outdoor Camp',
      'image': 'Aset/item_kompor.png',
      'pricePerDay': 20000,
      'deposit': 50000,
      'days': 2,
      'selected': true,
      'location': 'Depok, 1,8 km',
    },
    {
      'id': 'speaker',
      'title': 'Speaker Aktif Outdoor JBL',
      'owner': 'Audio Event Depok',
      'image': 'Aset/item_speaker.png',
      'pricePerDay': 75000,
      'deposit': 150000,
      'days': 1,
      'selected': false,
      'location': 'Depok, 2,1 km',
    },
  ];

  bool get _isAllSelected =>
      _cartItems.isNotEmpty && _cartItems.every((item) => item['selected'] == true);

  int get _selectedCount =>
      _cartItems.where((item) => item['selected'] == true).length;

  int get _totalRentalFee {
    int total = 0;
    for (var item in _cartItems) {
      if (item['selected'] == true) {
        total += (item['pricePerDay'] as int) * (item['days'] as int);
      }
    }
    return total;
  }

  int get _totalDeposit {
    int total = 0;
    for (var item in _cartItems) {
      if (item['selected'] == true) {
        total += (item['deposit'] as int);
      }
    }
    return total;
  }

  int get _grandTotal => _totalRentalFee + _totalDeposit;

  void _toggleSelectAll(bool? val) {
    setState(() {
      final target = val ?? false;
      for (var item in _cartItems) {
        item['selected'] = target;
      }
    });
  }

  void _removeItem(int index) {
    final removed = _cartItems[index];
    setState(() {
      _cartItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removed['title']} dihapus dari keranjang.'),
        action: SnackBarAction(
          label: 'Batal',
          textColor: AppColors.primaryOrange,
          onPressed: () {
            setState(() {
              _cartItems.insert(index, removed);
            });
          },
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _checkout() {
    if (_selectedCount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih setidaknya 1 barang untuk disewa.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final selectedItems =
        _cartItems.where((i) => i['selected'] == true).toList();
    final String itemNames =
        selectedItems.map((i) => i['title'] as String).join(', ');
    final String owners =
        selectedItems.map((i) => i['owner'] as String).toSet().join(', ');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Sewa2Screen(
          itemTitle: itemNames,
          ownerName: owners,
          rentalFee: _totalRentalFee,
          depositFee: _totalDeposit,
          deliveryFee: 0,
          totalAmount: _grandTotal,
        ),
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
            // Top Bar
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Keranjang Sewa',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Rencana paket & gabungan barang sewa',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  if (_cartItems.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _cartItems.clear();
                        });
                      },
                      child: const Text(
                        'Hapus Semua',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            if (_cartItems.isNotEmpty)
              // Select All Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isAllSelected,
                        activeColor: AppColors.primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        onChanged: _toggleSelectAll,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Pilih Semua (${_cartItems.length} Barang)',
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 10),

            // Cart Items or Empty State
            Expanded(
              child: _cartItems.isEmpty
                  ? _buildEmptyCart()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      itemCount: _cartItems.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final item = _cartItems[index];
                        return _buildCartCard(item, index);
                      },
                    ),
            ),

            // Bottom Checkout Bar
            if (_cartItems.isNotEmpty) _buildBottomCheckoutBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.remove_shopping_cart_outlined,
                size: 46,
                color: AppColors.primaryGreen,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Keranjang Sewa Kosong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Anda belum memilih barang untuk disewa secara bersamaan. Yuk cari barang kebutuhanmu!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.5,
                color: AppColors.textMedium,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExploreBarangScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.search_rounded, size: 18),
              label: const Text('Eksplorasi Barang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartCard(Map<String, dynamic> item, int index) {
    final int days = item['days'] as int;
    final int pricePerDay = item['pricePerDay'] as int;
    final int subtotal = days * pricePerDay;
    final int deposit = item['deposit'] as int;
    final bool isSelected = item['selected'] as bool;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? Border.all(color: AppColors.primaryGreen, width: 1.5)
            : Border.all(color: Colors.transparent),
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
          // Owner header
          Row(
            children: [
              Checkbox(
                value: isSelected,
                activeColor: AppColors.primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (val) {
                  setState(() {
                    item['selected'] = val ?? false;
                  });
                },
              ),
              const Icon(Icons.storefront_rounded,
                  size: 16, color: AppColors.primaryGreen),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  item['owner'] as String,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 20, color: Colors.grey),
                onPressed: () => _removeItem(index),
              ),
            ],
          ),

          const Divider(height: 1, color: Color(0xFFF1F3F5)),
          const SizedBox(height: 10),

          // Item Info Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item['image'] as String,
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 75,
                    height: 75,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.inventory_2),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Biaya: Rp. ${_formatNumber(pricePerDay)}/hari',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Deposit: Rp. ${_formatNumber(deposit)} (kembali)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Duration & Subtotal Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Day adjuster
                Row(
                  children: [
                    const Text(
                      'Durasi: ',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMedium,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (days > 1) {
                          setState(() {
                            item['days'] = days - 1;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Icon(Icons.remove, size: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '$days Hari',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          item['days'] = days + 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const Icon(Icons.add, size: 14),
                      ),
                    ),
                  ],
                ),

                // Subtotal
                Text(
                  'Rp. ${_formatNumber(subtotal)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCheckoutBar() {
    return Container(
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Brief breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Biaya Sewa ($_selectedCount barang):',
                style: const TextStyle(fontSize: 12, color: AppColors.textMedium),
              ),
              Text(
                'Rp. ${_formatNumber(_totalRentalFee)}',
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Deposit (Akan Dikembalikan):',
                style: TextStyle(fontSize: 12, color: AppColors.textMedium),
              ),
              Text(
                'Rp. ${_formatNumber(_totalDeposit)}',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0288D1)),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(height: 1, color: Color(0xFFF1F3F5)),
          ),

          Row(
            children: [
              Column(
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
                    'Rp. ${_formatNumber(_grandTotal)}',
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
                    onPressed: _checkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Checkout Sewa ($_selectedCount)',
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
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

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }
}

