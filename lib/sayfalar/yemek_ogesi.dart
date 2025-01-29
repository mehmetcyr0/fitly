import 'package:flutter/material.dart';

class YemekOgesi extends StatelessWidget {
  final String ad;
  final String miktar;
  final double kcal;
  final String resimYolu;

  const YemekOgesi({
    super.key,
    required this.ad,
    required this.miktar,
    required this.kcal,
    required this.resimYolu,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                resimYolu,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ad,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    miktar,
                    style: TextStyle(color: Colors.grey[400]!),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "$kcal kcal",
            style: TextStyle(fontSize: 16, color: Colors.grey[400]!),
          ),
        ],
      ),
    );
  }
}
