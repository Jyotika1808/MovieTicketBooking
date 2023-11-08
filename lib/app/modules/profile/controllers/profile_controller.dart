import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/services/config.dart';
import 'package:movie_ticket_booking/app/data/services/models/user_model.dart';

class ProfileController extends GetxController {
  final _user = Rx<UserModel>(
    UserModel(
      uId: '',
      name: '',
      email: '',
    ),
  );
  UserModel get user => _user.value;

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  void fetchUserDetails() async {
    try {
      var data = await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      // var gyms = await firebaseFirestore.collection('gyms').get().then(
      //       (value) => value.docs.toList(),
      //     );
      // log("gyms${gyms[1].data()}");
      if (data.exists) {
        var userData = data.data();

        _user.value = UserModel.fromMap(userData!);
      }
      log(_user.value.toMap().toString());
    } catch (e) {
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await firebaseAuth.signOut();
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.back();
        },
      );
    } catch (e) {
      Get.back();
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }
}
