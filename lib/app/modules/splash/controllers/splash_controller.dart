import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:movie_ticket_booking/app/routes/app_pages.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  late Rx<User?> user;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(
      auth.userChanges(),
    );
    ever(
      user,
      initialPage,
    );
  }

  initialPage(User? user) {
    if (user == null) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Get.offNamedUntil(
            Routes.SIGN_IN,
            (route) => false,
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Get.offNamedUntil(
            Routes.BOTTOM_NAVIGATION,
            (route) => false,
          );
        },
      );
    }
  }
}
