class RentalItem {
  final String id;
  final String title;
  final String imagePath;
  final double rating;
  final int reviewsCount;
  final int pricePerDay;
  final String distance;
  bool isFavorite;

  RentalItem({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.reviewsCount,
    required this.pricePerDay,
    required this.distance,
    this.isFavorite = false,
  });

  String get formattedPrice {
    return 'Rp. ${pricePerDay.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}/hari';
  }
}

