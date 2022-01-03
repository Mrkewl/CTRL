import 'package:get/get.dart';

class HomeController extends GetxController{
static HomeController get to =>Get.find();
  RxInt pageSelected = 0.obs;
  RxInt gameRoomCard = 0.obs;
}