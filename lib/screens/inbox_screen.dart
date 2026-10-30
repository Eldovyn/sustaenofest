import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import 'chat_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  String _selectedFilter = 'Semua';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'Semua',
    'Pemilik Barang',
    'Penyewa',
    'Bantuan Resmi',
  ];

  final List<Map<String, dynamic>> _chatList = [
    {
      'id': '1',
      'name': 'Fitriany Wirayuda',
      'role': 'Pemilik Barang',
      'category': 'Pemilik Barang',
      'itemTitle': 'Kamera DSLR Canon EOS 2000D',
      'itemImage': 'Aset/item_kamera_thumb.png',
      'itemPrice': 'Rp. 150.000/hari',
      'lastMessage':
          'Barangnya ready dan baterai sudah terisi penuh lengkap dengan memory card ya kak.',
      'time': '10:03',
      'unreadCount': 1,
      'isOnline': true,
      'initialMessages': [
        {
          'sender': 'Fitriany Wirayuda',
          'text': 'Halo! Terima kasih sudah tertarik dengan Kamera DSLR Canon EOS 2000D.',
          'time': '10:02',
          'isMe': false,
        },
        {
          'sender': 'Fitriany Wirayuda',
          'text': 'Barangnya ready dan baterai sudah terisi penuh lengkap dengan memory card ya kak.',
          'time': '10:03',
          'isMe': false,
        },
      ],
    },
    {
      'id': '2',
      'name': 'Budi Pratama',
      'role': 'Calon Penyewa',
      'category': 'Penyewa',
      'itemTitle': 'Proyektor Epson EB-E500',
      'itemImage': 'Aset/item_proyektor.png',
      'itemPrice': 'Rp. 50.000/hari',
      'lastMessage':
          'Halo kak, proyektornya bisa saya ambil sore ini di Margonda untuk keperluan sidang?',
      'time': '09:42',
      'unreadCount': 2,
      'isOnline': true,
      'initialMessages': [
        {
          'sender': 'Budi Pratama',
          'text': 'Halo kak, apakah Proyektor Epson EB-E500 masih bisa disewa untuk 3 hari?',
          'time': '09:30',
          'isMe': false,
        },
        {
          'sender': 'Budi Pratama',
          'text': 'Halo kak, proyektornya bisa saya ambil sore ini di Margonda untuk keperluan sidang?',
          'time': '09:42',
          'isMe': false,
        },
      ],
    },
    {
      'id': '3',
      'name': 'Dimas Outdoor Camp',
      'role': 'Pemilik Barang',
      'category': 'Pemilik Barang',
      'itemTitle': 'Tenda Camping Kapasitas 4 Orang',
      'itemImage': 'Aset/item_tenda.png',
      'itemPrice': 'Rp. 50.000/hari',
      'lastMessage':
          'Tenda dome kapasitas 4 orang sudah siap ya kak, pasak dan matras lengkap.',
      'time': 'Kemarin',
      'unreadCount': 0,
      'isOnline': false,
      'initialMessages': [
        {
          'sender': 'Dimas Outdoor Camp',
          'text': 'Tenda dome kapasitas 4 orang sudah siap ya kak, pasak dan matras lengkap.',
          'time': 'Kemarin',
          'isMe': false,
        },
      ],
    },
    {
      'id': '4',
      'name': 'Siti Nurhaliza',
      'role': 'Pemilik Barang',
      'category': 'Pemilik Barang',
      'itemTitle': 'Stroller Bayi Lipat Compact',
      'itemImage': 'Aset/item_stroller.png',
      'itemPrice': 'Rp. 52.000/hari',
      'lastMessage':
          'Stroller sudah disterilkan dan dicuci bersih sebelum dipinjamkan kak.',
      'time': '28 Apr',
      'unreadCount': 0,
      'isOnline': false,
      'initialMessages': [
        {
          'sender': 'Siti Nurhaliza',
          'text': 'Stroller sudah disterilkan dan dicuci bersih sebelum dipinjamkan kak.',
          'time': '28 Apr',
          'isMe': false,
        },
      ],
    },
    {
      'id': '5',
      'name': 'Layanan Bantuan PakaiDulu',
      'role': 'Official Support',
      'category': 'Bantuan Resmi',
      'itemTitle': 'Pusat Bantuan & Transaksi',
      'itemImage': 'Aset/item_bbq.png',
      'itemPrice': 'PakaiDulu Care',
      'lastMessage':
          'Deposit sewa BBQ Grill Anda sebesar Rp 300.000 telah berhasil dikembalikan ke saldo.',
      'time': '26 Apr',
      'unreadCount': 0,
      'isOnline': true,
      'isOfficial': true,
      'initialMessages': [
        {
          'sender': 'Layanan Bantuan PakaiDulu',
          'text': 'Halo Ahmad, terima kasih telah menyelesaikan sewa BBQ Grill dengan baik.',
          'time': '26 Apr',
          'isMe': false,
        },
        {
          'sender': 'Layanan Bantuan PakaiDulu',
          'text': 'Deposit sewa BBQ Grill Anda sebesar Rp 300.000 telah berhasil dikembalikan ke saldo.',
          'time': '26 Apr',
          'isMe': false,
        },
      ],
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredChats {
    final query = _searchController.text.toLowerCase().trim();
    return _chatList.where((chat) {
      final matchesFilter =
          _selectedFilter == 'Semua' || chat['category'] == _selectedFilter;
      final matchesQuery = query.isEmpty ||
          (chat['name'] as String).toLowerCase().contains(query) ||
          (chat['itemTitle'] as String).toLowerCase().contains(query) ||
          (chat['lastMessage'] as String).toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  void _openChat(Map<String, dynamic> chat) {
    setState(() {
      chat['unreadCount'] = 0;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          name: chat['name'] as String,
          role: chat['role'] as String,
          itemTitle: chat['itemTitle'] as String,
          itemImage: chat['itemImage'] as String,
          itemPrice: chat['itemPrice'] as String,
          initialMessages:
              chat['initialMessages'] as List<Map<String, dynamic>>?,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Kotak Masuk',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Percakapan seputar sewa & konfirmasi barang',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textMedium,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
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
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded,
                        color: AppColors.textLight, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: const TextStyle(
                            fontSize: 13.5, color: AppColors.textDark),
                        decoration: const InputDecoration(
                          hintText: 'Cari pesan atau nama orang...',
                          hintStyle: TextStyle(
                              color: AppColors.textLight, fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                        child: const Icon(Icons.close_rounded,
                            size: 18, color: AppColors.textLight),
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Horizontal Filter Chips
            SizedBox(
              height: 36,
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
                          horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryGreen
                            : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryGreen
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.w500,
                          color: isSelected ? Colors.white : AppColors.textDark,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Chat List
            Expanded(
              child: _filteredChats.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_bubble_outline_rounded,
                              size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text(
                            'Tidak ada percakapan ditemukan',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
                      itemCount: _filteredChats.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final chat = _filteredChats[index];
                        final unreadCount = chat['unreadCount'] as int;
                        final isOnline = chat['isOnline'] as bool;
                        final isOfficial = chat['isOfficial'] == true;

                        return InkWell(
                          onTap: () => _openChat(chat),
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: unreadCount > 0
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.85),
                              borderRadius: BorderRadius.circular(18),
                              border: unreadCount > 0
                                  ? Border.all(
                                      color: AppColors.primaryGreen
                                          .withValues(alpha: 0.35),
                                      width: 1.2,
                                    )
                                  : null,
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
                                // Avatar with status indicator
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: isOfficial
                                          ? AppColors.primaryOrange
                                          : AppColors.primaryGreen,
                                      child: isOfficial
                                          ? const Icon(
                                              Icons.support_agent_rounded,
                                              color: Colors.white,
                                              size: 24,
                                            )
                                          : Text(
                                              (chat['name'] as String)
                                                  .substring(0, 2)
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                    ),
                                    if (isOnline)
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF4CAF50),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),

                                const SizedBox(width: 12),

                                // Chat Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    chat['name'] as String,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 14.5,
                                                      fontWeight: unreadCount > 0
                                                          ? FontWeight.bold
                                                          : FontWeight.w600,
                                                      color: AppColors.textDark,
                                                    ),
                                                  ),
                                                ),
                                                if (isOfficial) ...[
                                                  const SizedBox(width: 4),
                                                  const Icon(
                                                    Icons.verified,
                                                    size: 14,
                                                    color: AppColors.primaryOrange,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                          Text(
                                            chat['time'] as String,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: unreadCount > 0
                                                  ? AppColors.primaryGreen
                                                  : AppColors.textLight,
                                              fontWeight: unreadCount > 0
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 3),

                                      // Item Tag
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 7, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF1F3F5),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          chat['itemTitle'] as String,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textMedium,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      // Last Message Preview & Unread Badge
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              chat['lastMessage'] as String,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12.5,
                                                color: unreadCount > 0
                                                    ? AppColors.textDark
                                                    : AppColors.textMedium,
                                                fontWeight: unreadCount > 0
                                                    ? FontWeight.w600
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          if (unreadCount > 0)
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 8),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryGreen,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                '$unreadCount',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.5,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

