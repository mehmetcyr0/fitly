import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

class SonucEkran extends StatelessWidget {
  final double vkiSonuc;
  final int yas;

  const SonucEkran({
    super.key,
    required this.vkiSonuc,
    required this.yas,
  });

  @override
  Widget build(BuildContext context) {
    final yorum = vkiyorumuayar(vkiSonuc);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 91, 91, 91),
        centerTitle: true,
        title: const Text(
          "VKİ SONUÇ",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(12),
        child: Card(
          color: const Color.fromARGB(255, 51, 51, 51),
          elevation: 12,
          shape: const RoundedRectangleBorder(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Senin Sonucun",
                style: TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 255, 255, 255)),
              ),
              const SizedBox(height: 10),
              PrettyGauge(
                gaugeSize: 300,
                minValue: 0,
                maxValue: 40,
                segments: [
                  GaugeSegment("Düşük Kilolu", 18.5, Colors.red),
                  GaugeSegment("Normal Kilolu", 6.4, Colors.green),
                  GaugeSegment("Fazla Kilolu", 5, Colors.orange[800]!),
                  GaugeSegment("Obez", 10.1, Colors.pink),
                ],
                valueWidget: Text(
                  vkiSonuc.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
                currentValue: vkiSonuc.toDouble(),
                needleColor: Colors.orange[800]!,
              ),
              const SizedBox(height: 20),
              Text(
                yorum['vkiDurumu'] ?? '',
                style: TextStyle(
                  fontSize: 24,
                  color: yorum['vkiDurumRenk'],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                yorum['vkiYorum'] ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Text(
                      "Yeniden Hesapla",
                      style: TextStyle(color: Colors.orange[800]!),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Share.share(
                          "Senin $yas'ında Vücut Kitle İndeksin ${vkiSonuc.toStringAsFixed(1)}");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[800]!,
                    ),
                    child: const Text(
                      "Paylaş",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> vkiyorumuayar(double vkiSonuc) {
    String vkiDurumu;
    String vkiYorum;
    Color vkiDurumRenk;

    if (vkiSonuc < 18.5) {
      vkiDurumu = "Düşük Kilolu";
      vkiYorum = "VKİ'niz düşük, daha fazla kilo almanız gerekebilir.";
      vkiDurumRenk = Colors.red;
    } else if (vkiSonuc < 24.9) {
      vkiDurumu = "Normal Kilolu";
      vkiYorum = "VKİ'niz normal, sağlıklı bir kilodasınız.";
      vkiDurumRenk = Colors.green;
    } else if (vkiSonuc < 29.9) {
      vkiDurumu = "Fazla Kilolu";
      vkiYorum = "VKİ'niz yüksek, kilo vermeyi düşünmelisiniz.";
      vkiDurumRenk = Colors.orange[800]!;
    } else {
      vkiDurumu = "Obez";
      vkiYorum = "VKİ'niz çok yüksek, bir sağlık uzmanına danışmalısınız.";
      vkiDurumRenk = Colors.pink;
    }

    return {
      'vkiDurumu': vkiDurumu,
      'vkiYorum': vkiYorum,
      'vkiDurumRenk': vkiDurumRenk,
    };
  }
}
