import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';

class TransparentCard extends StatelessWidget {
  const TransparentCard({
    Key? key,
    required this.listofWidgets,
  }) : super(key: key);

  final List<Widget> listofWidgets;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, right: 16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height:  150,
          decoration: BoxDecoration(
            color: ColorPalette.black,
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height:  150,
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
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: listofWidgets),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
