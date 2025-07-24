
import 'package:tt_vpn_app/models/connection_stats_model.dart';
import 'package:tt_vpn_app/models/country_model.dart';

final List<Country> mockCountries = [
  Country(
    name: 'Italy',
    flag: 'assets/flags/italy.png',
    city: '',
    locationCount: 4,
    strength: 70,
  ),
  Country(
    name: 'Netherlands',
    flag: 'assets/flags/netherlands.png',
    city: 'Amsterdam',
    locationCount: 12,
    strength: 85,
  ),
  Country(
    name: 'Germany',
    flag: 'assets/flags/germany.png',
    city: '',
    locationCount: 10,
    strength: 90,
  ),
];

final ConnectionStats mockConnectionStats = ConnectionStats(
  downloadSpeed: 527,
  uploadSpeed: 49,
  connectedTime: const Duration(hours: 2, minutes: 41, seconds: 52),
  connectedCountry: mockCountries[1], // Netherlands
);
