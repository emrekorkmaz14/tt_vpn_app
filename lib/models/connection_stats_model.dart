import 'package:tt_vpn_app/models/country_model.dart';

class ConnectionStats {
  final int downloadSpeed; 
  final int uploadSpeed; 
  final Duration connectedTime;
  final Country? connectedCountry;

  ConnectionStats({
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.connectedTime,
    this.connectedCountry,
  });
}
