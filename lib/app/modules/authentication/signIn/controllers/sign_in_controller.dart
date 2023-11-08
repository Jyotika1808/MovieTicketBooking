import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/services/config.dart';
import 'package:movie_ticket_booking/app/data/services/models/user_model.dart';

class SignInController extends GetxController {
  final _isHidden = true.obs;
  bool get isHidden => _isHidden.value;

  void togglePasswordView() {
    _isHidden.value = !_isHidden.value;
  }

  final loadingStatus = LoadingStatus.loading.obs;

  void signIn({
    required String emailAddress,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.back();
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "No user found.",
          position: SnackPosition.BOTTOM,
        );
      } else if (e.code == "invalid-email") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "Invalid email.",
          position: SnackPosition.BOTTOM,
        );
      } else if (e.code == "user-disabled") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "User is disabled.",
          position: SnackPosition.BOTTOM,
        );
      } else if (e.code == "wrong-password") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "Password is not correct.",
          position: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.back();
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> googleSignIn() async {
    try {
      await googleSignInInstance.signOut();
      final googleAccount = await googleSignInInstance.signIn();
      if (googleAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await firebaseAuth.signInWithCredential(credential);
        final user = UserModel(
          uId: firebaseAuth.currentUser!.uid,
          name: googleAccount.displayName!,
          email: googleAccount.email,
        );
        await firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .set(
              user.toMap(),
            );
      } else {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "No account selected",
          position: SnackPosition.BOTTOM,
        );
      }
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
