import 'package:get/get.dart';

class AllAnimationController extends GetxController {
  static AllAnimationController get to => Get.find();
  RxInt pageSelected = 0.obs;
  RxInt gameRoomCard = 0.obs;
  RxBool loadingIndicatorForRegistrationLogin = false.obs;
  RxBool loadingIndicatorForProfileUpload = false.obs;
  RxBool loadingIndicatorForGoogle = false.obs;
  RxBool loadingIndicatorForApple = false.obs;
}
