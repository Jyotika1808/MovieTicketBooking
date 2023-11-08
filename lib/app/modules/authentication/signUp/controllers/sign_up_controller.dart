import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/services/config.dart';
import 'package:movie_ticket_booking/app/data/services/models/user_model.dart';

class SignUpController extends GetxController {
  final _isPasswordHidden = true.obs;
  final _isConPasswordHidden = true.obs;
  var loadingStatus = LoadingStatus.loading.obs;

  bool get isPasswordHidden => _isPasswordHidden.value;
  bool get isConPasswordHidden => _isConPasswordHidden.value;

  void togglePasswordView() {
    _isPasswordHidden.value = !_isPasswordHidden.value;
  }

  void toggleConPasswordView() {
    _isConPasswordHidden.value = !_isConPasswordHidden.value;
  }

  void signUp({
    required String emailAddress,
    required String password,
    required String userName,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      final user = UserModel(
        uId: firebaseAuth.currentUser!.uid,
        name: userName,
        email: emailAddress,
      );
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .set(
            user.toMap(),
          );
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.back();
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "Email alreay in use.",
          position: SnackPosition.BOTTOM,
        );
      } else if (e.code == "invalid-email") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "Invalid email.",
          position: SnackPosition.BOTTOM,
        );
      } else if (e.code == "operation-not-allowed") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "Operation not allowed.",
          position: SnackPosition.BOTTOM,
        );
      } else if (e.code == "weak-password") {
        Get.back();
        AppConstant.showSnackbar(
          headText: "Failed",
          content: "Password is very weak.",
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

  Future<void> googleSignUp() async {
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
