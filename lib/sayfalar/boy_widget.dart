import 'package:flutter/material.dart';

class BoyWidget extends StatefulWidget {
  final Function(int) onChange;
  const BoyWidget({super.key, required this.onChange});

  @override
  State<BoyWidget> createState() => _BoyWidgetState();
}

class _BoyWidgetState extends State<BoyWidget> {
  int _boy = 150;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.black,
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Boy",
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _boy.toString(),
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "cm",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  )
                ],
              ),
              Slider(
                thumbColor: const Color.fromARGB(255, 254, 254, 254),
                inactiveColor: Colors.grey,
                activeColor: Colors.orange,
                min: 0,
                max: 240,
                value: _boy.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _boy = value.toInt();
                  });
                  widget.onChange(_boy);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
