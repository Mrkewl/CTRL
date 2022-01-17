import 'dart:ui';


import 'package:flutter/material.dart';

class GameButton extends StatelessWidget {
  const GameButton({
    Key? key,
    required this.color,
    required this.header,
  }) : super(key: key);
  final Color color;
  final String header;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 8, right: 8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.black38.withOpacity(0.2),
                offset: const Offset(0, 4),
                spreadRadius: 3,
                blurRadius: 5,
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white.withOpacity(0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    offset: const Offset(0, 4),
                    spreadRadius: 3,
                    blurRadius: 5,
                  )
                ],
              ),
              child: Center(child: Text(header)),
            ),
          ),
        ),
      ),
    ]);
  }
}
