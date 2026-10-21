class AppConfig {
  AppConfig._();

  static const String appName = 'Grand Line Quest';
  static const String tagline = 'Road to Pirate King';

  static const int questionsPerRound = 10;
  static const int bountyPerCorrect = 300000000; // 10 benar = 3.000.000.000 Berry

  static const int minNameLength = 2;
  static const int maxNameLength = 16;
}

/// Nama rute untuk navigasi antar-halaman.
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String quiz = '/quiz';
  static const String result = '/result';
  static const String review = '/review';
}

/// Lokasi aset gambar.
class AppAssets {
  AppAssets._();

  static const String logo = 'assets/images/logo.png';
  static const String background = 'assets/images/bg_ocean.jpg';
}