import 'package:get/get.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/services/config.dart';
import 'package:movie_ticket_booking/app/data/services/models/booking_model.dart';

class BookingsController extends GetxController {
  final _listOfbookings = Rx<List<BookingModel>>([]);
  final loadingStatus = LoadingStatus.loading.obs;

  List<BookingModel> get listOfbookings => _listOfbookings.value;

  @override
  void onInit() {
    fetchBookings();
    super.onInit();
  }

  void fetchBookings() async {
    try {
      loadingStatus(LoadingStatus.loading);
      var list = await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('bookings')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .get();

      if (list.docs.isNotEmpty) {
        _listOfbookings.value = list.docs
            .map(
              (e) => BookingModel.fromMap(e),
            )
            .toList();
      }
      loadingStatus(LoadingStatus.completed);
      // log(_listOfPayments.value.toList()[0].amount.toString());
    } catch (e) {
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }
}
