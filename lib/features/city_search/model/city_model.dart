class CityModel {
  final String name;
  final double lat;
  final double lon;
  final String country;

  CityModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      name: json['name'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      country: json['country'] ?? '',
    );
  }
}
