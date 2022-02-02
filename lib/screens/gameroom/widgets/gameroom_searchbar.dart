
import 'dart:ui';

import 'package:ctrl_app/common/colorpalette.dart';
import 'package:flutter/material.dart';

class GameRoomSearchBar extends StatelessWidget {
  const GameRoomSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
       vertical: 4, horizontal: 10),
        child: ClipRRect(
     borderRadius: BorderRadius.circular(20),
     child: BackdropFilter(
       filter: ImageFilter.blur(
         sigmaX: 20,
         sigmaY: 20,
       ),
       child: Container(
           width: MediaQuery.of(context).size.width,
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
      );
  }
}
