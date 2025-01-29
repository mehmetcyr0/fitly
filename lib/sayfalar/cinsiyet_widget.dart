import 'package:flutter/material.dart';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';

class CinsiyetWidget extends StatefulWidget {
  final Function(int) onChange;

  const CinsiyetWidget({super.key, required this.onChange});

  @override
  State<CinsiyetWidget> createState() => _CinsiyetWidgetState();
}

class _CinsiyetWidgetState extends State<CinsiyetWidget> {
  int _cinsiyet = 0;
  final ChoiceChip3DStyle selectedStyle = ChoiceChip3DStyle(
      topColor: Colors.grey[700]!,
      backColor: Colors.grey,
      borderRadius: BorderRadius.circular(20));

  final ChoiceChip3DStyle unselectedStyle = ChoiceChip3DStyle(
      topColor: Colors.black,
      backColor: Colors.grey[700]!,
      borderRadius: BorderRadius.circular(20));
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip3D(
                border: Border.all(color: Colors.grey),
                style: _cinsiyet == 1 ? selectedStyle : unselectedStyle,
                onSelected: () {
                  setState(() {
                    _cinsiyet = 1;
                  });
                  widget.onChange(_cinsiyet);
                },
                onUnSelected: () {
                  _cinsiyet = 1;
                },
                selected: _cinsiyet == 1,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/fitMan.png",
                      width: 50,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Erkek",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
            const SizedBox(
              width: 20,
            ),
            ChoiceChip3D(
                border: Border.all(color: Colors.grey),
                style: _cinsiyet == 2 ? selectedStyle : unselectedStyle,
                onSelected: () {
                  setState(() {
                    _cinsiyet = 2;
                  });
                  widget.onChange(_cinsiyet);
                },
                onUnSelected: () {},
                selected: _cinsiyet == 2,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/fitWomen.png",
                      width: 50,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      "Kadın",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ))
          ],
        ));
  }
}
