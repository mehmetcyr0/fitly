import 'package:fitly/main.dart'; // Ana uygulama dosyasını içe aktarır
import 'package:flutter/material.dart'; // Flutter'ın temel bileşenlerini içe aktarır

class GirisEkrani extends StatelessWidget {
  const GirisEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Arka plan rengini siyah olarak ayarlar
      body: Padding(
        padding:
            const EdgeInsets.all(16.0), // Kenar boşluklarını 16 piksel yapar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // İçeriği ortalar
          crossAxisAlignment: CrossAxisAlignment.center, // Yatayda merkezler
          children: <Widget>[
            const Spacer(), // Üstte boşluk bırakır

            // Giriş kutusu
            Container(
              padding: const EdgeInsets.all(20), // İç boşluğu 20 piksel yapar
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), // Köşeleri yuvarlar
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/fit.png', // Fitly logosunu gösterir
                    width: 150, // Görselin genişliğini ayarlar
                    height: 150, // Görselin yüksekliğini ayarlar
                  ),
                  const SizedBox(
                      height: 20), // Görsel ile metin arasında boşluk

                  const Text(
                    'Fitly\'a Hoşgeldiniz!', // Başlık metnini gösterir
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40), // Giriş kutusu ile form arasında boşluk

            // E-posta giriş alanı
            TextField(
              style: const TextStyle(
                  color: Colors.white), // Metin rengini beyaz yapar
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email,
                    color: Colors
                        .white), // Ön ikon olarak e-posta simgesi kullanır
                hintText: 'E-posta', // Placeholder metni
                hintStyle: const TextStyle(
                    color: Colors.white70), // Placeholder metin rengi
                filled: true,
                fillColor: Colors.grey[800], // Arka plan rengi
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Kenar yuvarlatma
                  borderSide: BorderSide.none, // Kenar çizgisiz
                ),
              ),
            ),
            const SizedBox(
                height: 3), // E-posta alanı ile parola alanı arasında boşluk

            // Parola giriş alanı
            TextField(
              style: const TextStyle(
                  color: Colors.white), // Metin rengini beyaz yapar
              obscureText: true, // Parolanın gizli olarak gösterilmesini sağlar
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline,
                    color:
                        Colors.white), // Ön ikon olarak kilit simgesi kullanır
                hintText: 'Parola', // Placeholder metni
                hintStyle: const TextStyle(
                    color: Colors.white70), // Placeholder metin rengi
                filled: true,
                fillColor: Colors.grey[800], // Arka plan rengi
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Kenar yuvarlatma
                  borderSide: BorderSide.none, // Kenar çizgisiz
                ),
              ),
            ),

            const SizedBox(height: 20), // Form ile giriş butonu arasında boşluk

            // Giriş Yap butonu
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Ekranlar()), // Ana ekran için yönlendirme yapar
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 50), // Butonun iç boşluğunu ayarlar
                backgroundColor:
                    Colors.grey[800]!, // Buton arka plan rengini gri yapar
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Buton kenarlarını yuvarlar
                ),
              ),
              child: const Text('GİRİŞ YAP',
                  style: TextStyle(
                      fontSize: 16, color: Colors.white)), // Buton metni
            ),

            const SizedBox(
                height:
                    20), // Giriş butonu ile gizlilik sözleşmesi arasında boşluk

            // Gizlilik Sözleşmesi metni
            TextButton(
              onPressed: () {},
              child: const Text(
                'Gizlilik Sözleşmesi', // Metin içeriği
                style: TextStyle(color: Colors.white70), // Metin rengi
              ),
            ),

            const Spacer(), // Altta boşluk bırakır

            // Kayıt Ol butonu
            TextButton(
              onPressed: () {},
              child: const Text(
                'KAYDOL', // Metin içeriği
                style: TextStyle(color: Colors.white), // Metin rengi
              ),
            ),

            const SizedBox(
                height: 10), // Kayıt Ol butonu ile alt boşluk arasında boşluk
          ],
        ),
      ),
    );
  }
}
