import 'package:fitly/sayfalar/acilis_ekran.dart'; // Açılış ekranı sayfasını içe aktarır
import 'package:flutter/material.dart'; // Flutter'ın temel bileşenlerini içe aktarır

import 'package:fitly/aikoc/aikoc.dart'; // AIKOC ekranını içe aktarır
import 'package:fitly/sayfalar/adim_sayar.dart'; // Adım sayar ekranını içe aktarır
import 'package:fitly/sayfalar/antrenmanlar.dart'; // Antrenmanlar ekranını içe aktarır
import 'package:fitly/sayfalar/kalori_hesap.dart'; // Kalori hesaplayıcı ekranını içe aktarır
import 'package:fitly/sayfalar/vki.dart'; // VKI sayfasını içe aktarır
import 'package:google_nav_bar/google_nav_bar.dart'; // Google Navigation Bar paketini içe aktarır
import 'package:line_icons/line_icons.dart'; // Line Icons paketini içe aktarır

void main() => runApp(MaterialApp(
    builder: (context, child) {
      return Directionality(textDirection: TextDirection.ltr, child: child!);
    },
    theme: ThemeData(
      primaryColor:
          const Color.fromARGB(255, 255, 255, 255), // Tema rengini ayarlar
    ),
    home: const AcilisEkrani())); // Uygulamanın başlangıç ekranını belirler

class Ekranlar extends StatefulWidget {
  const Ekranlar({super.key});

  @override
  EkranlarState createState() => EkranlarState();
}

class EkranlarState extends State<Ekranlar> {
  int _selectedIndex = 0; // Seçili olan alt gezinme çubuğu indeksi
  static const TextStyle yaziTipi = TextStyle(
      fontSize: 30, fontWeight: FontWeight.w600); // Metin stilini tanımlar
  static const List<Widget> _widgetOptions = <Widget>[
    AdimSayar(), // Adım sayar ekranı
    VkiSayfasi(), // VKI sayfası
    Antrenmanlar(), // Antrenmanlar ekranı
    KaloriHesaplayici(), // Kalori hesaplayıcı ekranı
    Text(
      ' yakında yayında!', // Gelecek ekran için placeholder metni
      style: TextStyle(color: Colors.white70), // Metin rengi
    ),
    AiKoc(), // AIKOC ekranı
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 0, 0, 0), // Arka plan rengini ayarlar
      body: Center(
        child:
            _widgetOptions.elementAt(_selectedIndex), // Seçilen ekranı gösterir
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(
              255, 0, 0, 0), // Alt gezinme çubuğu rengini ayarlar
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: const Color.fromARGB(255, 255, 255, 255)
                  .withOpacity(.1), // Gölge rengi ve büyüklüğü
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 15.0, vertical: 8), // Kenar boşlukları
            child: GNav(
              rippleColor: Colors.grey[300]!, // Tıklama efekti rengi
              hoverColor: Colors.grey[100]!, // Üzerine gelme efekti rengi
              gap: 8, // Butonlar arası boşluk
              activeColor:
                  const Color.fromARGB(255, 255, 255, 255), // Aktif buton rengi
              iconSize: 24, // İkon boyutu
              padding: const EdgeInsets.symmetric(
                  horizontal: 3, vertical: 12), // İç boşluklar
              duration: const Duration(milliseconds: 400), // Animasyon süresi
              tabBackgroundColor:
                  const Color.fromARGB(255, 0, 0, 0), // Buton arka plan rengi
              color:
                  const Color.fromARGB(255, 255, 254, 254), // Buton metin rengi
              tabs: const [
                GButton(
                  icon: LineIcons.running, // Koşu ikonu
                  text: 'Koşu', // Buton metni
                ),
                GButton(
                  icon: LineIcons.weight, // VKI ikonu
                  text: 'vki', // Buton metni
                ),
                GButton(
                  icon: LineIcons.dumbbell, // Egzersiz ikonu
                  text: 'Egzersiz', // Buton metni
                ),
                GButton(
                  icon: LineIcons.ruler, // Kalori Hesaplayıcı ikonu
                  text: 'Kalori Hesaplayıcı', // Buton metni
                ),
                GButton(
                  icon: LineIcons.user, // Hesap ikonu
                  text: 'hesap', // Buton metni
                ),
                GButton(
                  icon: LineIcons.robot, // AIKOC ikonu
                  text: 'AIKOC', // Buton metni
                ),
              ],
              selectedIndex: _selectedIndex, // Seçili olan butonun indeksi
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index; // Seçili olan indeksi günceller
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
