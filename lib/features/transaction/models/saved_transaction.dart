class SavedTransaction {
  final String id;
  final String name;
  final String customerNumber;
  final DateTime date;

  SavedTransaction({
    required this.id,
    required this.name,
    required this.customerNumber,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'customerNumber': customerNumber,
      'date': date.toIso8601String(),
    };
  }

  factory SavedTransaction.fromJson(Map<String, dynamic> json) {
    return SavedTransaction(
      id: json['id'],
      name: json['name'],
      customerNumber: json['customerNumber'],
      date: DateTime.parse(json['date']),
    );
  }
}
