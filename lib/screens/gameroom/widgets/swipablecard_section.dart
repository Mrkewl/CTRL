import 'package:ctrl_app/common/colorpalette.dart';
import 'package:ctrl_app/controller/dashboardcontroller.dart';
import 'package:ctrl_app/screens/gameroom/widgets/transparentcard.dart';
import 'package:flutter/material.dart';

class SwipableCardSection extends StatelessWidget {
  SwipableCardSection({
    Key? key,
  }) : super(key: key);

  final HomeController homeController = HomeController.to;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.6,
      child: PageView(
        scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
        onPageChanged: (pageNumber) {
          homeController.gameRoomCard.value = pageNumber;
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TransparentCard(
       
              listofWidgets: [
                Row(
                  children: const [
                    Text(
                      'Duration:\n16 Weeks',
                      style: TextStyle(color: ColorPalette.snow, fontSize: 18),
                    ),
                    Spacer(),
                    Text(
                      'Total Amount: \n\$200',
                      style: TextStyle(color: ColorPalette.snow, fontSize: 18),
                    ),
                  ],
                ),
                const Spacer(),
                const Text(
                  '\$100 Buy in',
                  style: TextStyle(color: ColorPalette.snow, fontSize: 18),
                ),
                const Text(
                  '16 Oct 2021 - 20 Dec 2021',
                  style: TextStyle(color: ColorPalette.snow, fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TransparentCard(
  
              listofWidgets: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.w3schools.com/howto/img_avatar.png'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Commitment:  4 / Week',
                            style: TextStyle(
                                color: ColorPalette.snow, fontSize: 18),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Missed:  5',
                            style: TextStyle(
                                color: ColorPalette.snow, fontSize: 18),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Total Weeks Left: 4',
                            style: TextStyle(
                                color: ColorPalette.snow, fontSize: 18),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Total Workout Left This Week: 4',
                            style: TextStyle(
                                color: ColorPalette.snow, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
