import 'dart:math';

import 'models/question.dart';

/// Kumpulan soal lokal.
class QuestionBank {
  QuestionBank._();

  static const List<Question> all = [
    Question(
      text: 'Siapa kapten Kru Bajak Laut Topi Jerami?',
      options: ['Roronoa Zoro', 'Monkey D. Luffy', 'Nami', 'Usopp'],
      correctIndex: 1,
      explanation: 'Monkey D. Luffy adalah kapten Topi Jerami yang bermimpi menjadi Raja Bajak Laut.',
    ),
    Question(
      text: 'Karena Buah Iblis yang dimakannya, tubuh Luffy memiliki sifat seperti apa?',
      options: ['Seperti api', 'Seperti karet', 'Seperti es', 'Seperti cahaya'],
      correctIndex: 1,
      explanation: 'Gomu Gomu no Mi membuat seluruh tubuh Luffy elastis seperti karet.',
    ),
    Question(
      text: 'Siapa pendekar pedang Santoryu (gaya tiga pedang) di Kru Topi Jerami?',
      options: ['Sanji', 'Brook', 'Roronoa Zoro', 'Franky'],
      correctIndex: 2,
      explanation: 'Zoro bertarung dengan tiga pedang dan ingin menjadi pendekar pedang terhebat di dunia.',
    ),
    Question(
      text: 'Apa nama kapal pertama Kru Topi Jerami?',
      options: ['Thousand Sunny', 'Going Merry', 'Moby Dick', 'Oro Jackson'],
      correctIndex: 1,
      explanation: 'Going Merry adalah kapal pertama mereka, sebelum digantikan Thousand Sunny.',
    ),
    Question(
      text: 'Siapa pembuat kapal Thousand Sunny sekaligus anggota Kru Topi Jerami?',
      options: ['Franky', 'Usopp', 'Tom', 'Iceburg'],
      correctIndex: 0,
      explanation: 'Franky, sang ahli pembuat kapal, membangun Thousand Sunny dari kayu Adam.',
    ),
    Question(
      text: 'Apa profesi Nico Robin di Kru Topi Jerami?',
      options: ['Koki', 'Arkeolog', 'Navigator', 'Dokter'],
      correctIndex: 1,
      explanation: 'Nico Robin adalah arkeolog yang mampu membaca Poneglyph.',
    ),
    Question(
      text: 'Tony Tony Chopper, dokter Topi Jerami, adalah seekor...',
      options: ['Beruang', 'Rubah', 'Rusa', 'Kucing'],
      correctIndex: 2,
      explanation: 'Chopper adalah rusa kutub yang memakan Hito Hito no Mi sehingga bisa berubah wujud seperti manusia.',
    ),
    Question(
      text: 'Dari desa manakah Luffy berasal?',
      options: ['Cocoyasi', 'Foosha', 'Syrup', 'Ohara'],
      correctIndex: 1,
      explanation: 'Luffy tumbuh di Desa Foosha, East Blue.',
    ),
    Question(
      text: 'Siapa yang mempercayakan topi jerami kepada Luffy?',
      options: ['Gold Roger', 'Shanks', 'Monkey D. Garp', 'Dragon'],
      correctIndex: 1,
      explanation: 'Shanks "Si Rambut Merah (Akagami)" menitipkan topinya dengan syarat Luffy mengembalikannya setelah menjadi bajak laut hebat.',
    ),
    Question(
      text: 'Kompas khusus untuk berlayar di Grand Line disebut...',
      options: ['Log Pose', 'Eternal Pose', 'Vivre Card', 'Den Den Mushi'],
      correctIndex: 0,
      explanation: 'Log Pose merekam medan magnet sebuah pulau lalu menunjuk ke pulau berikutnya.',
    ),
    Question(
      text: 'Siapa Raja Bajak Laut legendaris yang berhasil mencapai Laugh Tale?',
      options: ['Edward Newgate', 'Gold Roger', 'Shanks', 'Kaido'],
      correctIndex: 1,
      explanation: 'Gold Roger (Gol D. Roger (Spoiler buat yang baru mulai nonton👀)), kapten Bajak Laut Roger, mencapai Laugh Tale dan dijuluki Raja Bajak Laut.',
    ),
    Question(
      text: 'Siapa kakek Luffy yang dijuluki Pahlawan Angkatan Laut?',
      options: ['Sengoku', 'Monkey D. Garp', 'Kuzan', 'Smoker'],
      correctIndex: 1,
      explanation: 'Monkey D. Garp adalah kakek Luffy sekaligus ayah dari Monkey D. Dragon.',
    ),
    Question(
      text: 'Siapa yang dijuluki "Pria Terkuat di Dunia" dan gugur di Perang Marineford?',
      options: ['Kaido', 'Edward Newgate (Whitebeard/Shirohige)', 'Charlotte Linlin', 'Sengoku'],
      correctIndex: 1,
      explanation: 'Edward "Whitebeard/Shirohige" Newgate memimpin Bajak Laut Whitebeard dan gugur di Marineford.',
    ),
    Question(
      text: 'Kelompok lima tetua yang menjadi petinggi Pemerintah Dunia disebut...',
      options: ['Gorosei', 'Shichibukai', 'Yonko', 'Cipher Pol'],
      correctIndex: 0,
      explanation: 'Gorosei, atau Lima Tetua, adalah para petinggi Pemerintah Dunia.',
    ),
    Question(
      text: 'Sanji bertarung hanya dengan kakinya. Gaya bertarungnya disebut...',
      options: ['Santoryu', 'Black Leg Style', 'Karate Manusia Ikan', 'Rokushiki'],
      correctIndex: 1,
      explanation: 'Sanji memakai Black Leg Style agar tangannya tetap terjaga untuk memasak.',
    ),
  ];

  /// Ambil [count] soal acak, dengan urutan pilihan yang juga diacak.
  static List<Question> pick(int count) {
    final random = Random();
    final pool = List<Question>.of(all)..shuffle(random);
    return pool
        .take(count)
        .map((q) => q.withShuffledOptions(random))
        .toList();
  }
}