import 'package:flutter/material.dart';

class YasKiloWidget extends StatefulWidget {
  final Function(int) onChange;
  final String title;
  final int initValue;
  final int min;
  final int max;

  const YasKiloWidget({
    super.key,
    required this.onChange,
    required this.title,
    required this.initValue,
    required this.min,
    required this.max,
  });

  @override
  State<YasKiloWidget> createState() => _YasKiloWidgetState();
}

class _YasKiloWidgetState extends State<YasKiloWidget> {
  int sayac = 0;

  @override
  void initState() {
    super.initState();
    sayac = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 12,
        color: Colors.black,
        shape: const RoundedRectangleBorder(),
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Slider(
                    value: sayac.toDouble(),
                    min: widget.min.toDouble(),
                    max: widget.max.toDouble(),
                    divisions: widget.max - widget.min,
                    activeColor: Colors.orange,
                    inactiveColor: Colors.grey,
                    onChanged: (double value) {
                      setState(() {
                        sayac = value.toInt();
                      });
                      widget.onChange(sayac);
                    },
                  ),
                  Text(
                    '$sayac',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
