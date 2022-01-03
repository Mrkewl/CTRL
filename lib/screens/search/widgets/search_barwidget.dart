

import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, right: 16),
        child: Container(
          width: MediaQuery.of(context).size.width - 100,
          height: 40,
          decoration: const BoxDecoration(
            color: ColorPalette.black,
            borderRadius:
                BorderRadius.all(Radius.circular(360)),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 20,
            ),
            child: Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(360)),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: const TextField(
                  
                  style: TextStyle(color: ColorPalette.snow, fontSize: 18),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top:4),
                      prefixIcon: Icon(Icons.search, color: ColorPalette.snow,),
                      hintText: 'Search Here',
                      hintStyle:
                          TextStyle(color: ColorPalette.snow),
                  
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none),
                  keyboardType: TextInputType.visiblePassword,
                )),
          ),
        ),
      ),
    ]);
  }
}
