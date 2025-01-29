import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AdimSayar extends StatefulWidget {
  const AdimSayar({super.key});

  @override
  AdimSayarState createState() => AdimSayarState();
}

class AdimSayarState extends State<AdimSayar> {
  late Stream<StepCount> _adimSayaciAkisi;
  String _adimSayisi = '0';
  List<int> _haftalikAdimlar = List<int>.filled(7, 0);
  int _adimHedefi = 8000; // Başlangıçta adım hedefi 8000 olarak ayarlanmış
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    izinleriIste();
    _haftalikAdimlariYukle();
    _adimHedefiniYukle();
    _bildirimKurulum();
  }

  Future<void> izinleriIste() async {
    if (await Permission.activityRecognition.request().isGranted) {
      adimSayaciBaslat();
    } else {
      debugPrint('İzin verilmedi');
    }
  }

  void adimSayaciBaslat() {
    _adimSayaciAkisi = Pedometer.stepCountStream;
    _adimSayaciAkisi.listen(adimSayaciGuncelle).onError(adimSayaciHatasi);
  }

  void adimSayaciGuncelle(StepCount event) {
    setState(() {
      _adimSayisi = event.steps.toString();
      gunlukAdimlariKaydet(event.steps);
      if (event.steps >= _adimHedefi) {
        _bildirimGonder();
      }
    });
  }

  void adimSayaciHatasi(error) {
    debugPrint('Adım Sayar Hatası: $error');
    setState(() {
      _adimSayisi = 'Adım Sayısı Mevcut Değil';
    });
  }

  Future<void> _haftalikAdimlariYukle() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _haftalikAdimlar = (prefs.getStringList('haftalikAdimlar') ??
              List<String>.filled(7, '0'))
          .map((adim) => int.parse(adim))
          .toList();
    });
  }

  Future<void> gunlukAdimlariKaydet(int adimlar) async {
    final prefs = await SharedPreferences.getInstance();
    final bugun = DateTime.now().weekday -
        1; // Pazar = 0, Pazartesi = 1, ..., Cumartesi = 6
    _haftalikAdimlar[bugun] = adimlar;
    await prefs.setStringList('haftalikAdimlar',
        _haftalikAdimlar.map((adim) => adim.toString()).toList());
  }

  int _toplamAdimlar() {
    return _haftalikAdimlar.reduce((a, b) => a + b);
  }

  int _saglikPuanlari() {
    return _toplamAdimlar() ~/ 1000;
  }

  Future<void> _guncelAdimHedefiGirisi(BuildContext context) async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        int? localHedef;
        return AlertDialog(
          title: const Text('Adım Hedefini Güncelle'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration:
                const InputDecoration(hintText: 'Yeni adım hedefini girin'),
            onChanged: (value) {
              localHedef = int.tryParse(value);
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'İptal',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:
                  const Text('Kaydet', style: TextStyle(color: Colors.black)),
              onPressed: () {
                if (localHedef != null && localHedef! > 0) {
                  setState(() {
                    _adimHedefi = localHedef!;
                  });
                  _adimHedefiniKaydet(
                      localHedef!); // SharedPreferences'e kaydet
                  Navigator.of(context).pop(localHedef);
                } else {
                  // Uyarı veya hata mesajı gösterebilirsiniz
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _adimHedefiniKaydet(int hedef) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('adimHedefi', hedef);
  }

  Future<void> _adimHedefiniYukle() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _adimHedefi =
          prefs.getInt('adimHedefi') ?? 8000; // Varsayılan olarak 8000
    });
  }

  Future<void> _bildirimKurulum() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _bildirimGonder() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'adim_hedefi_kanali',
      'Adım Hedefi',
      channelDescription: 'Adım hedefinize ulaştınız!',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Tebrikler!',
      'Adım hedefinize ulaştınız!',
      platformChannelSpecifics,
      payload: 'Adım hedefinize ulaştınız!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Adım Sayar', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _saglikPuaniKart(),
                _toplamAdimKart(),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Bugünkü Toplam Adımlar',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 30),
            _adimDairesi(),
            const SizedBox(height: 20),
            _cokYakindaKart(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          _guncelAdimHedefiGirisi(context);
        },
        tooltip: 'Adım Hedefini Güncelle',
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _saglikPuaniKart() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(_saglikPuanlari().toString(),
                style: const TextStyle(fontSize: 24)),
            const Text('Sağlık Puanları'),
          ],
        ),
      ),
    );
  }

  Widget _toplamAdimKart() {
    return Card(
      color: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(_toplamAdimlar().toString(),
                style: const TextStyle(fontSize: 24, color: Colors.white)),
            const Text('Toplam Adımlar', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _adimDairesi() {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: int.tryParse(_adimSayisi)! / _adimHedefi,
            strokeWidth: 10,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_adimSayisi,
                    style: const TextStyle(color: Colors.white, fontSize: 48)),
                Text('Adım Hedefi: $_adimHedefi',
                    style: const TextStyle(color: Colors.redAccent)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cokYakindaKart() {
    return const Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Daha fazla özellik yakında!'),
            SizedBox(width: 10),
            Icon(Icons.fitness_center, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
