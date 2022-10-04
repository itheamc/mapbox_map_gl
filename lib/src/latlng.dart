class LatLng {
  final double latitude;
  final double longitude;

  LatLng(this.latitude, this.longitude);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  factory LatLng.from(dynamic json) {
    return LatLng(json['latitude'], json['longitude']);
  }
}
