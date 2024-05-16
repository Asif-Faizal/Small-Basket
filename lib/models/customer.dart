class Customer {
  final int id;
  final String name;
  final String imageUrl;
  final String street;
  final String street_two;
  final String city;

  Customer({
    required this.id,
    required this.name,
    required this.street,
    required this.street_two,
    required this.city,
    required this.imageUrl,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        name: json['id'],
        street: json['id'],
        street_two: json['id'],
        city: json['id'],
        imageUrl: json['id']);
  }
}
