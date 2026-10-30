import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AddressModel {
  String id;
  String label;
  String receiverName;
  String phone;
  String fullAddress;
  String notes;
  bool isPrimary;

  AddressModel({
    required this.id,
    required this.label,
    required this.receiverName,
    required this.phone,
    required this.fullAddress,
    required this.notes,
    required this.isPrimary,
  });
}

class AddressSettingsScreen extends StatefulWidget {
  const AddressSettingsScreen({super.key});

  @override
  State<AddressSettingsScreen> createState() => _AddressSettingsScreenState();
}

class _AddressSettingsScreenState extends State<AddressSettingsScreen> {
  final List<AddressModel> _addresses = [
    AddressModel(
      id: '1',
      label: 'Rumah',
      receiverName: "Ahmad Syafi'i",
      phone: '0812-3456-7890',
      fullAddress:
          'Jl. Margonda Raya No. 45, RT 02 / RW 07, Kel. Kemiri Muka, Kec. Beji, Kota Depok, Jawa Barat 16424',
      notes: 'Pagar hitam di sebelah minimarket, bel rumah di tiang pagar.',
      isPrimary: true,
    ),
    AddressModel(
      id: '2',
      label: 'Kantor / Studio',
      receiverName: "Ahmad Syafi'i (Creative)",
      phone: '0812-9876-5432',
      fullAddress:
          'Creative Hub Depok Lt. 2, Jl. Ir. H. Juanda No. 12, Sukmajaya, Kota Depok, Jawa Barat 16418',
      notes: 'Bisa titip di resepsionis depan atau security pos.',
      isPrimary: false,
    ),
  ];

  void _setAsPrimary(String id) {
    setState(() {
      for (var addr in _addresses) {
        addr.isPrimary = (addr.id == id);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alamat utama berhasil diperbarui!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryGreen,
      ),
    );
  }

  void _deleteAddress(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus Alamat',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        content: const Text('Apakah Anda yakin ingin menghapus alamat ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal',
                style: TextStyle(color: AppColors.textMedium)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _addresses.removeWhere((item) => item.id == id);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Alamat berhasil dihapus.'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showAddAddressSheet([AddressModel? existing]) {
    final labelCtrl = TextEditingController(text: existing?.label ?? 'Rumah');
    final nameCtrl =
        TextEditingController(text: existing?.receiverName ?? "Ahmad Syafi'i");
    final phoneCtrl =
        TextEditingController(text: existing?.phone ?? '0812-3456-7890');
    final addressCtrl =
        TextEditingController(text: existing?.fullAddress ?? '');
    final notesCtrl = TextEditingController(text: existing?.notes ?? '');
    bool setPrimary = existing?.isPrimary ?? (_addresses.isEmpty);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setSheetState) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    existing == null ? 'Tambah Alamat Baru' : 'Ubah Alamat',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Label row chips
                  const Text('Label Alamat',
                      style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark)),
                  const SizedBox(height: 8),
                  Row(
                    children: ['Rumah', 'Kantor', 'Kos', 'Studio'].map((tag) {
                      final isSelected = labelCtrl.text == tag;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(tag),
                          selected: isSelected,
                          selectedColor:
                              AppColors.primaryGreen.withValues(alpha: 0.15),
                          labelStyle: TextStyle(
                            color: isSelected
                                ? AppColors.primaryGreen
                                : AppColors.textMedium,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 12,
                          ),
                          onSelected: (val) {
                            if (val) {
                              setSheetState(() => labelCtrl.text = tag);
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  _buildInput(labelCtrl, 'Nama Tempat / Label Kustom',
                      Icons.bookmark_outline),
                  const SizedBox(height: 12),
                  _buildInput(
                      nameCtrl, 'Nama Lengkap Penerima', Icons.person_outline),
                  const SizedBox(height: 12),
                  _buildInput(phoneCtrl, 'Nomor HP / WhatsApp',
                      Icons.phone_outlined, TextInputType.phone),
                  const SizedBox(height: 12),
                  _buildInput(addressCtrl, 'Alamat Lengkap & Kode Pos',
                      Icons.location_on_outlined, TextInputType.text, 3),
                  const SizedBox(height: 12),
                  _buildInput(notesCtrl, 'Catatan Pengiriman (Opsional)',
                      Icons.note_alt_outlined),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    value: setPrimary,
                    title: const Text('Jadikan Alamat Utama',
                        style: TextStyle(
                            fontSize: 13.5, fontWeight: FontWeight.w600)),
                    activeColor: AppColors.primaryGreen,
                    onChanged: (val) {
                      setSheetState(() => setPrimary = val);
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (addressCtrl.text.isEmpty || nameCtrl.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Nama dan Alamat wajib diisi.'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return;
                        }

                        Navigator.pop(ctx);
                        setState(() {
                          if (existing != null) {
                            existing.label = labelCtrl.text;
                            existing.receiverName = nameCtrl.text;
                            existing.phone = phoneCtrl.text;
                            existing.fullAddress = addressCtrl.text;
                            existing.notes = notesCtrl.text;
                            if (setPrimary) {
                              for (var a in _addresses) {
                                a.isPrimary = false;
                              }
                              existing.isPrimary = true;
                            }
                          } else {
                            if (setPrimary) {
                              for (var a in _addresses) {
                                a.isPrimary = false;
                              }
                            }
                            _addresses.add(
                              AddressModel(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                label: labelCtrl.text,
                                receiverName: nameCtrl.text,
                                phone: phoneCtrl.text,
                                fullAddress: addressCtrl.text,
                                notes: notesCtrl.text,
                                isPrimary: setPrimary || _addresses.isEmpty,
                              ),
                            );
                          }
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(existing == null
                                ? 'Alamat berhasil ditambahkan!'
                                : 'Alamat berhasil diperbarui!'),
                            backgroundColor: AppColors.primaryGreen,
                            behavior: SnackBarBehavior.floating,
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
                      child: Text(
                        existing == null
                            ? 'Simpan Alamat'
                            : 'Perbarui Alamat',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInput(TextEditingController ctrl, String hint, IconData icon,
      [TextInputType type = TextInputType.text, int maxLines = 1]) {
    return TextField(
      controller: ctrl,
      keyboardType: type,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 13.5, color: AppColors.textDark),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primaryGreen, size: 20),
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textLight, fontSize: 13),
        filled: true,
        fillColor: AppColors.inputField,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
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
          'Pengaturan Alamat',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _addresses.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_off_rounded,
                              size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          const Text(
                            'Belum ada alamat tersimpan',
                            style: TextStyle(
                              color: AppColors.textMedium,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Tambahkan alamat untuk pengiriman barang sewa.',
                            style: TextStyle(
                              color: AppColors.textLight,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      itemCount: _addresses.length,
                      itemBuilder: (context, index) {
                        final address = _addresses[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: address.isPrimary
                                  ? AppColors.primaryGreen
                                  : Colors.transparent,
                              width: 1.5,
                            ),
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
                              Row(
                                children: [
                                  Text(
                                    address.label,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: AppColors.textDark,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (address.isPrimary)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2.5),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryGreen
                                            .withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Text(
                                        'Utama',
                                        style: TextStyle(
                                          color: AppColors.primaryGreen,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  const Spacer(),
                                  PopupMenuButton<String>(
                                    icon: const Icon(Icons.more_vert,
                                        color: AppColors.textMedium, size: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    onSelected: (action) {
                                      if (action == 'primary') {
                                        _setAsPrimary(address.id);
                                      } else if (action == 'edit') {
                                        _showAddAddressSheet(address);
                                      } else if (action == 'delete') {
                                        _deleteAddress(address.id);
                                      }
                                    },
                                    itemBuilder: (ctx) => [
                                      if (!address.isPrimary)
                                        const PopupMenuItem(
                                          value: 'primary',
                                          child: Text('Jadikan Alamat Utama'),
                                        ),
                                      const PopupMenuItem(
                                        value: 'edit',
                                        child: Text('Ubah Alamat'),
                                      ),
                                      const PopupMenuItem(
                                        value: 'delete',
                                        child: Text('Hapus Alamat',
                                            style: TextStyle(
                                                color: Colors.redAccent)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${address.receiverName} • ${address.phone}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textMedium,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                address.fullAddress,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: AppColors.textDark,
                                  height: 1.35,
                                ),
                              ),
                              if (address.notes.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.inputField,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.info_outline,
                                          size: 13,
                                          color: AppColors.textMedium),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          address.notes,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppColors.textMedium,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => _showAddAddressSheet(),
                  icon: const Icon(Icons.add_location_alt_rounded, size: 20),
                  label: const Text(
                    'Tambah Alamat Baru',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
