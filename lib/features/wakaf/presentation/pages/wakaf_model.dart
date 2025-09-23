class WakafModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String quote;
  final String detailedDescription;
  final List<String> benefits;
  final String buttonText;

  const WakafModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.quote,
    required this.detailedDescription,
    required this.benefits,
    this.buttonText = 'Mulai Donasi',
  });
}