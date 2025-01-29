import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Antrenmanlar ana sayfası
class Antrenmanlar extends StatelessWidget {
  const Antrenmanlar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800]!, // Arka plan rengi
      appBar: AppBar(
        backgroundColor: Colors.black, // AppBar arka plan rengi
        title: const Text(
          'Antrenmanları', // AppBar başlığı
          style: TextStyle(color: Colors.white), // Başlık rengi
        ),
        centerTitle: true, // Başlığı ortala
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Elemanları genişlet
          children: <Widget>[
            // Bu kısım veri tabanı bağlantısı yapıldıktan sonra değiştirilecek
            KasBolgesiKarti(
              kasAdi: 'Göğüs',
              kasResmi: 'assets/gogus.png',
              antrenmanlar: [
                {
                  'baslik': 'Bench Press',
                  'videoId': 'SCVCLChPQFY',
                },
                {
                  'baslik': 'Dumbbell Flyes',
                  'videoId': 'Nhvz9EzdJ4U',
                },
                {
                  'baslik': 'Push-Ups',
                  'videoId': 'JyCG_5l3XLk',
                },
              ],
            ),
            KasBolgesiKarti(
              kasAdi: 'Sırt',
              kasResmi: 'assets/sırt.png',
              antrenmanlar: [
                {
                  'baslik': 'Deadlift',
                  'videoId': '1ZXobu7JvvE',
                },
                {
                  'baslik': 'Pull-Ups',
                  'videoId': 'D8oUWMvb-pg',
                },
                {
                  'baslik': 'Barbell Row',
                  'videoId': 'Ourup_k',
                },
              ],
            ),
            KasBolgesiKarti(
              kasAdi: 'Omuz',
              kasResmi: 'assets/omuz.png',
              antrenmanlar: [
                {
                  'baslik': 'Shoulder Press',
                  'videoId': '5yWaNOvgFCM',
                },
                {
                  'baslik': 'Lateral Raises',
                  'videoId': 'XPPfnSEATJA',
                },
                {
                  'baslik': 'Front Raises',
                  'videoId': 'zkP0MsTcIVU',
                },
              ],
            ),
            KasBolgesiKarti(
              kasAdi: 'Kol',
              kasResmi: 'assets/kol.jpg',
              antrenmanlar: [
                {
                  'baslik': 'Bicep Curls',
                  'videoId': "N5x5M1x1Gd0",
                },
                {
                  'baslik': 'Tricep Dips',
                  'videoId': 'HCf97NPYeGY',
                },
                {
                  'baslik': 'Hammer Curls',
                  'videoId': 'CFBZ4jN1CMI',
                },
              ],
            ),
            KasBolgesiKarti(
              kasAdi: 'Bacak',
              kasResmi: 'assets/bacak.jpg',
              antrenmanlar: [
                {
                  'baslik': 'Squat',
                  'videoId': 'xqvCmoLULNY',
                },
                {
                  'baslik': 'Lunges',
                  'videoId': 'ASdqJoDPMHA',
                },
                {
                  'baslik': 'Leg Press',
                  'videoId': 'yZmx_Ac3880',
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Kas bölgesi kartı widget'ı
class KasBolgesiKarti extends StatelessWidget {
  final String kasAdi; // Kas bölgesinin adı
  final String kasResmi; // Kas bölgesinin resmi
  final List<Map<String, String>> antrenmanlar; // Antrenmanlar listesi

  const KasBolgesiKarti({
    super.key,
    required this.kasAdi,
    required this.kasResmi,
    required this.antrenmanlar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850], // Kartın arka plan rengi
      margin: const EdgeInsets.all(8.0), // Kartın kenar boşlukları
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Elemanları sola hizala
        children: <Widget>[
          // Kas bölgesi adı ve resmi gösteriliyor
          Padding(
            padding: const EdgeInsets.all(8.0), // İç boşluk ekle
            child: Row(
              children: [
                Image.asset(
                  kasResmi, // Kas bölgesi resmi
                  width: 100,
                  height: 100,
                ),
                const SizedBox(width: 10),
                Text(
                  kasAdi, // Kas bölgesi adı
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Yazı rengi
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey), // Ayırıcı çizgi
          // Antrenmanların listesi gösteriliyor, her biri tıklanabilir
          ListView.builder(
            shrinkWrap: true, // Listeyi sar
            physics:
                const NeverScrollableScrollPhysics(), // Kaydırmayı devre dışı bırak
            itemCount: antrenmanlar.length, // Antrenman sayısı
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  antrenmanlar[index]['baslik']!, // Antrenman başlığı
                  style: const TextStyle(color: Colors.white), // Yazı rengi
                ),
                onTap: () {
                  // Tıklanan antrenmanın videosunu göstermek için video ekranına yönlendiriliyor
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AntrenmanVideoEkrani(
                        antrenmanAdi: antrenmanlar[index]
                            ['baslik']!, // Antrenman adı
                        videoId: antrenmanlar[index]
                            ['videoId']!, // YouTube video ID
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// Antrenman video ekranı widget'ı
class AntrenmanVideoEkrani extends StatelessWidget {
  final String antrenmanAdi; // Antrenman adı
  final String videoId; // YouTube video ID

  const AntrenmanVideoEkrani({
    super.key,
    required this.antrenmanAdi,
    required this.videoId,
  });

  @override
  Widget build(BuildContext context) {
    // YouTube oynatıcı kontrolcüsü oluşturuluyor
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId, // Başlangıç video ID'si
      flags: const YoutubePlayerFlags(
        autoPlay: true, // Otomatik oynatma
        mute: false, // Sessiz değil
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black, // Arka plan rengi
      appBar: AppBar(
        centerTitle: true, // Başlığı ortala
        title: Text(
          antrenmanAdi, // AppBar başlığı
          style: const TextStyle(color: Colors.white), // Başlık rengi
        ),
        backgroundColor: Colors.black, // AppBar arka plan rengi
      ),
      body: YoutubePlayer(
        // YouTube oynatıcı gösteriliyor
        controller: controller,
        showVideoProgressIndicator: true, // Video ilerleme göstergesi
        progressIndicatorColor: Colors.white, // İlerleme göstergesi rengi
        progressColors: const ProgressBarColors(
          playedColor: Colors.white, // Oynatılan kısmın rengi
          handleColor: Colors.red, // İlerleme göstergesi tutamacı rengi
        ),
        onReady: () {
          // Oynatıcı hazır olduğunda yapılacak işlemler buraya eklenebilir
        },
        onEnded: (metaData) {
          // Video bittiğinde yapılacak işlemler buraya eklenebilir
        },
      ),
    );
  }
}
