/// Gelar bajak laut berdasarkan persentase jawaban benar.
class PirateRank {
  final String title;
  final String message;

  const PirateRank({required this.title, required this.message});

  factory PirateRank.fromPercentage(int percentage) {
    if (percentage >= 100) {
      return const PirateRank(
        title: 'Raja Bajak Laut',
        message: 'Sempurna! Kamu menemukan One Piece dan menguasai Grand Line.',
      );
    }
    if (percentage >= 80) {
      return const PirateRank(
        title: 'Yonko',
        message: 'Satu dari Empat Kaisar! Lautan tunduk pada pengetahuanmu.',
      );
    }
    if (percentage >= 60) {
      return const PirateRank(
        title: 'Supernova',
        message: 'Rookie yang mengguncang Grand Line. Tinggal selangkah lagi!',
      );
    }
    if (percentage >= 40) {
      return const PirateRank(
        title: 'Bajak Laut Rookie',
        message: 'Pelayaranmu baru dimulai. Terus berlatih, Nakama!',
      );
    }
    if (percentage >= 20) {
      return const PirateRank(
        title: 'Kru Kapal',
        message: 'Kamu sudah naik kapal! Pelajari lagi peta Grand Line-nya.',
      );
    }
    return const PirateRank(
      title: 'Pelaut Amatir',
      message: 'Jangan menyerah! Setiap Raja Bajak Laut pernah mulai dari nol.',
    );
  }
}