import 'dart:convert';

class Phone {
  String country;
  String number;
  Phone({
    required this.country,
    required this.number,
  });


  Phone copyWith({
    String? country,
    String? number,
  }) {
    return Phone(
      country: country ?? this.country,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'number': number,
    };
  }

  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(
      country: map['country'] ?? '',
      number: map['number'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Phone.fromJson(String source) => Phone.fromMap(json.decode(source));

  @override
  String toString() => 'Phone(country: $country, number: $number)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Phone &&
      other.country == country &&
      other.number == number;
  }

  @override
  int get hashCode => country.hashCode ^ number.hashCode;
}
