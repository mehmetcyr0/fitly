import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
// import 'package:intl/intl.dart';
import 'yemek_ogesi.dart';

// Uygulama ana giriş noktası

// KaloriHesaplayici sınıfı, ana ekranı tanımlar
class KaloriHesaplayici extends StatelessWidget {
  const KaloriHesaplayici({super.key});

  @override
  Widget build(BuildContext context) {
    // Günün tarihini al ve formatla
    // DateTime bugun = DateTime.now();
    // String formatlanmisTarih = DateFormat('d MMMM y', 'tr').format(bugun);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Bugün, 20 Haziran 2024',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        // Datetime ile günün tarihini olusturma
        //     Text(
        //   'Bugün, $formatlanmisTarih',
        //   style: const TextStyle(fontSize: 24, color: Colors.white),
        // ),
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.calendar_today),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _daireSelIlerlemeCubugu(),
              const SizedBox(height: 16),
              _besinBilgisi(),
              const SizedBox(height: 16),
              _yemekBolumu("Kahvaltı", 295.5, [
                const YemekOgesi(
                  ad: "Yulaf sütü",
                  miktar: "150 ml",
                  kcal: 66,
                  resimYolu: "assets/yulaf_sütü.png",
                ),
                const YemekOgesi(
                  ad: "Portakal suyu",
                  miktar: "80 ml",
                  kcal: 28.8,
                  resimYolu: "assets/prtsy.png",
                ),
                const YemekOgesi(
                  ad: "Peynir",
                  miktar: "110 gr",
                  kcal: 200.7,
                  resimYolu: "assets/peynir.png",
                ),
              ]),
              const SizedBox(height: 16),
              _yemekEkleDugmesi("Öğle Yemeği", 600),
              const SizedBox(height: 16),
              _yemekEkleDugmesi("Akşam Yemeği", 600),
            ],
          ),
        ),
      ),
    );
  }

  // Daire şeklinde ilerleme çubuğu widget'ı
  Widget _daireSelIlerlemeCubugu() {
    return Center(
      child: CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 15.0,
        percent: 0.295, // Yüzde 29.5 ilerleme
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "295.5",
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "1200 kcal'den",
              style: TextStyle(fontSize: 16.0, color: Colors.grey[400]!),
            ),
          ],
        ),
        progressColor: Colors.pink,
        backgroundColor: Colors.white24,
      ),
    );
  }

  // Besin bilgilerini gösteren widget
  Widget _besinBilgisi() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _besinSutunu("Proteinler, gr", "19.5", "97'den"),
        _besinSutunu("Yağlar, gr", "7.5", "28.7'den"),
        _besinSutunu("Karbonhidratlar, gr", "37.7", "161.6'dan"),
      ],
    );
  }

  // Besin sütunlarını oluşturan widget
  Widget _besinSutunu(String baslik, String deger, String altBaslik) {
    return Column(
      children: [
        Text(
          baslik,
          style: TextStyle(color: Colors.grey[400]!),
        ),
        const SizedBox(height: 4),
        Text(
          deger,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          altBaslik,
          style: TextStyle(color: Colors.grey[400]!),
        ),
      ],
    );
  }

  // Yemek bölümünü oluşturan widget
  Widget _yemekBolumu(
      String yemekTuru, double kcal, List<Widget> yemekOgeleri) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              yemekTuru,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "${kcal.toStringAsFixed(1)} kcal",
              style: TextStyle(fontSize: 16, color: Colors.grey[400]!),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(children: yemekOgeleri),
        const SizedBox(height: 8),
        _yemekEkleDugmesi("Ekle"),
      ],
    );
  }

  // Yemek ekleme düğmesini oluşturan widget
  Widget _yemekEkleDugmesi(String yemekTuru, [double onerilenKcal = 0]) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            yemekTuru,
            style: const TextStyle(fontSize: 18, color: Colors.pink),
          ),
          onerilenKcal > 0
              ? Text(
                  "Önerilen ${onerilenKcal.toStringAsFixed(1)} kcal",
                  style: TextStyle(fontSize: 16, color: Colors.grey[400]!),
                )
              : Container(),
        ],
      ),
    );
  }
}
