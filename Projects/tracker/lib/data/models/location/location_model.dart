class LocationModel {
  String? name;
  String? address;
  double? latitude;
  double? longitude;
  int? time;

  LocationModel(
      {this.name, this.address, this.latitude, this.longitude, this.time});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'time': time,
    };
  }

  LocationModel copyWith({
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    int? time,
  }) {
    return LocationModel(
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      time: time ?? this.time,
    );
  }

  @override
  String toString() {
    return 'LocationModel{name: $name, address: $address, latitude: $latitude, longitude: $longitude, time: $time}';
  }
}
