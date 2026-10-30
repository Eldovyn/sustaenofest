class ExploreItem {
  final String id;
  final String title;
  final String imagePath;
  final double rating;
  final int reviewsCount;
  final int pricePerDay;
  final String distance;
  final bool isVerified;
  bool isFavorite;

  ExploreItem({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.reviewsCount,
    required this.pricePerDay,
    required this.distance,
    this.isVerified = true,
    this.isFavorite = false,
  });

  String get formattedPrice {
    return 'Rp. ${pricePerDay.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}/hari';
  }
}

