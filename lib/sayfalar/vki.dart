import 'dart:math';
import 'package:fitly/sayfalar/boy_widget.dart';
import 'package:fitly/sayfalar/cinsiyet_widget.dart';
import 'package:fitly/sayfalar/sonuc_ekran.dart';
import 'package:fitly/sayfalar/yas_kilo_widget.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class VkiSayfasi extends StatefulWidget {
  const VkiSayfasi({super.key});

  @override
  State<VkiSayfasi> createState() => _VkiSayfasiState();
}

class _VkiSayfasiState extends State<VkiSayfasi> {
  // int _cinsiyet = 0; // Cinsiyet bilgisini saklamak için değişken, şu anda kullanılmıyor.
  int _boy = 150; // Varsayılan olarak ayarlanmış boy değeri
  final int _yas = 30; // Sabit olarak ayarlanmış yaş değeri
  int _kilo = 50; // Başlangıç kilo değeri
  bool _bitti = false; // Hesaplama tamamlandı mı kontrolü için boolean değişken
  double _vkisonuc = 0; // VKI sonucunu saklamak için double değişken

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black, // Arka plan rengi siyah olarak ayarlanıyor
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Card(
              color:
                  const Color.fromARGB(255, 52, 51, 51), // Kart arka plan rengi
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Cinsiyet seçimi
                  CinsiyetWidget(
                    onChange: (cinsiyetVal) {
                      setState(() {
                        // _cinsiyet = cinsiyetVal; // Cinsiyet değeri değiştiğinde state güncelleniyor
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BoyWidget(
                    onChange: (boyVal) {
                      setState(() {
                        _boy =
                            boyVal; // Boy değeri değiştiğinde state güncelleniyor
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      YasKiloWidget(
                        onChange: (kiloVal) {
                          setState(() {
                            _kilo =
                                kiloVal; // Kilo değeri değiştiğinde state güncelleniyor
                          });
                        },
                        initValue: 50, // Başlangıç kilo değeri
                        max: 200, // Kilo maksimum değeri
                        min: 0, // Kilo minimum değeri
                        title: 'Kilo', // Kilo widget'ı başlığı
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: SwipeableButtonView(
                        isFinished:
                            _bitti, // Butonun tamamlanıp tamamlanmadığı kontrolü
                        onFinish: () async {
                          await Navigator.push(
                              context,
                              PageTransition(
                                  child: SonucEkran(
                                      vkiSonuc: _vkisonuc,
                                      yas:
                                          _yas), // Sonuç ekranına geçiş yapılıyor
                                  type: PageTransitionType
                                      .fade)); // Geçiş animasyonu türü
                          setState(() {
                            _bitti =
                                false; // Hesaplama tamamlandıktan sonra tekrar hesapla butonu aktif olacak şekilde state güncelleniyor
                          });
                        },
                        onWaitingProcess: () {
                          vkihesapla(); // VKI hesaplama fonksiyonu çağrılıyor

                          Future.delayed(const Duration(seconds: 1), () {
                            setState(() {
                              _bitti =
                                  true; // Butonun bekleme süresi tamamlandığında state güncelleniyor
                            });
                          });
                        },
                        activeColor: Colors.black, // Butonun aktif rengi
                        buttonWidget: const Icon(
                          Icons.arrow_forward_ios_outlined, // Buton ikonu
                          color: Colors.black, // Buton ikon rengi
                        ),
                        buttonText: "HESAPLA"), // Buton metni
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  vkihesapla() {
    _vkisonuc = _kilo / pow(_boy / 100, 2); // VKI hesaplama formülü
  }
}
