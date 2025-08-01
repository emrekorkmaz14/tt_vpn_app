import 'package:tt_vpn_app/models/connection_stats_model.dart';
import 'package:tt_vpn_app/models/country_model.dart';

final List<Country> mockCountries = [
  Country(
    name: 'Italy',
    flag: 'assets/flags/italy.png',
    city: 'Roma',
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
    city: 'Berlin',
    locationCount: 10,
    strength: 90,
  ),
  Country(
    name: 'China',
    flag: 'assets/flags/china.png',
    city: 'Pekin',
    locationCount: 3,
    strength: 35,
  ),
  Country(
    name: 'Spain',
    flag: 'assets/flags/spain.png',
    city: 'Barcelona',
    locationCount: 5,
    strength: 67,
  ),
  Country(
    name: 'France',
    flag: 'assets/flags/france.png',
    city: 'Paris',
    locationCount: 4,
    strength: 86,
  ),
  Country(
    name: 'United Kingdom',
    flag: 'assets/flags/united-kingdom.png',
    city: 'London',
    locationCount: 16,
    strength: 93,
  ),
  Country(
    name: 'United States',
    flag: 'assets/flags/united-states.png',
    city: 'New York',
    locationCount: 27,
    strength: 74,
  ),
];

final ConnectionStats mockConnectionStats = ConnectionStats(
  downloadSpeed: 527,
  uploadSpeed: 49,
  connectedTime: const Duration(hours: 2, minutes: 41, seconds: 52),
  connectedCountry: mockCountries[1], // Netherlands
);
