import 'package:fitly/sayfalar/giris.dart'; // Giriş ekranını içeren dosyayı içe aktarır
import 'package:flutter/material.dart'; // Flutter'ın temel bileşenlerini içe aktarır

// AcilisEkrani adında bir StatefulWidget sınıfı oluşturur
class AcilisEkrani extends StatefulWidget {
  const AcilisEkrani({super.key});

  @override
  // StatefulWidget için durum (state) sınıfını oluşturur
  // ignore: library_private_types_in_public_api
  _AcilisEkraniDurumu createState() => _AcilisEkraniDurumu();
}

// AcilisEkraniDurumu adlı sınıf, AcilisEkrani widget'ının durumunu yönetir
class _AcilisEkraniDurumu extends State<AcilisEkrani> {
  @override
  void initState() {
    super.initState();
    _anaSayfayaGec(); // Widget oluşturulduktan sonra ana sayfaya geçişi başlatır
  }

  // 4 saniyelik bir gecikmeden sonra ana sayfaya geçiş yapan fonksiyon
  _anaSayfayaGec() async {
    await Future.delayed(const Duration(seconds: 4), () {}); // 4 saniye bekler
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
          builder: (context) =>
              const GirisEkrani()), // Giriş ekranına geçiş yapar
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 55, 55, 55), // Arka plan rengini ayarlar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // İçeriği ortalar
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    Colors.black, // Konteynerin arka plan rengini siyah yapar
                borderRadius: BorderRadius.circular(
                    20), // Konteynerin köşelerini yuvarlar
              ),
              child: Column(children: [
                Image.asset(
                  'assets/fit.png', // Fitly logosunu gösterir
                  width: 250,
                  height: 250,
                ),
                // Yorum satırı olarak bırakılmış bir metin widget'ı
                // const Text(
                //   "Fitly",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // )
              ]),
            ),
            const SizedBox(height: 20), // 20 piksel boşluk bırakır
            const Text(
              "Fit olmanın Yolu!", // Uygulama sloganını gösterir
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 200, // 200 piksel boşluk bırakır
            ),
            const Text(
              "Copyright Mehmet Çayır", // Telif hakkı bilgisini gösterir
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10, // 10 piksel boşluk bırakır
            )
          ],
        ),
      ),
    );
  }
}
