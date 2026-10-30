import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../models/explore_item_model.dart';
import 'detail_barang_screen.dart';

class ExploreBarangScreen extends StatefulWidget {
  const ExploreBarangScreen({super.key});

  @override
  State<ExploreBarangScreen> createState() => _ExploreBarangScreenState();
}

class _ExploreBarangScreenState extends State<ExploreBarangScreen> {
  String _selectedFilter = 'Kategori';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'Kategori',
    'Lokasi',
    'Terdekat',
    'Metode Pembayaran',
  ];

  late List<ExploreItem> _items;

  @override
  void initState() {
    super.initState();
    _items = [
      ExploreItem(
        id: 'canon_2000d',
        title: 'Kamera DSLR Canon EOS 2000D',
        imagePath: 'Aset/item_kamera_thumb.png',
        rating: 4.9,
        reviewsCount: 29,
        pricePerDay: 150000,
        distance: '1,5 km',
      ),
      ExploreItem(
        id: 'tenda_camping',
        title: 'Tenda Camping',
        imagePath: 'Aset/item_tenda.png',
        rating: 4.8,
        reviewsCount: 8,
        pricePerDay: 50000,
        distance: '1,8 km',
      ),
      ExploreItem(
        id: 'toolkit',
        title: 'Toolkit',
        imagePath: 'Aset/item_toolkit.png',
        rating: 4.5,
        reviewsCount: 16,
        pricePerDay: 25000,
        distance: '1,5 km',
      ),
      ExploreItem(
        id: 'kompor',
        title: 'Kompor Portable',
        imagePath: 'Aset/item_kompor.png',
        rating: 4.8,
        reviewsCount: 31,
        pricePerDay: 20000,
        distance: '1 km',
      ),
      ExploreItem(
        id: 'stroller',
        title: 'Stroller Bayi',
        imagePath: 'Aset/item_stroller.png',
        rating: 5.0,
        reviewsCount: 36,
        pricePerDay: 52000,
        distance: '1,8 km',
      ),
      ExploreItem(
        id: 'vacuum',
        title: 'Vacuum Cleaner',
        imagePath: 'Aset/item_vacuum.png',
        rating: 4.8,
        reviewsCount: 13,
        pricePerDay: 27000,
        distance: '1 km',
      ),
      ExploreItem(
        id: 'kasur',
        title: 'Kasur Lipat',
        imagePath: 'Aset/item_kasur.png',
        rating: 4.5,
        reviewsCount: 24,
        pricePerDay: 48000,
        distance: '1 km',
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openDetail(ExploreItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailBarangScreen(item: item),
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

            // Top Bar: Back button & Search input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.textDark,
                      size: 22,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded,
                              color: AppColors.textLight, size: 22),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              autofocus: false,
                              style: const TextStyle(fontSize: 14, color: AppColors.textDark),
                              decoration: const InputDecoration(
                                hintText: 'Cari barang yang kamu butuhkan..',
                                hintStyle: TextStyle(
                                    color: AppColors.textLight, fontSize: 13.5),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          Container(
                            height: 22,
                            width: 1,
                            color: AppColors.borderLight,
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                          ),
                          const Icon(Icons.tune_rounded,
                              color: AppColors.textDark, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Horizontal Filter Chips
            SizedBox(
              height: 38,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryGreen.withValues(alpha: 0.08)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryGreen
                              : const Color(0xFFDDE3EA),
                          width: 1.2,
                        ),
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected
                              ? AppColors.primaryGreen
                              : AppColors.textDark,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Items List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                itemCount: _items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return _buildItemCard(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(ExploreItem item) {
    return GestureDetector(
      onTap: () => _openDetail(item),
      child: Container(
        padding: const EdgeInsets.all(12),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Image
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                item.imagePath,
                width: 100,
                height: 95,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 95,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Middle & Right Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Favorite button row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            item.isFavorite = !item.isFavorite;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            item.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border_rounded,
                            color: item.isFavorite
                                ? Colors.red
                                : Colors.grey.shade400,
                            size: 19,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 17, color: Colors.amber),
                      const SizedBox(width: 3),
                      Text(
                        '${item.rating} (${item.reviewsCount})',
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textMedium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Price & Distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.formattedPrice,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                      Text(
                        item.distance,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Verified pill badge
                  if (item.isVerified)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF43A047),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check, size: 13, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Verified',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

