// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/services/config.dart';
import 'package:movie_ticket_booking/app/data/services/models/booking_model.dart';
import 'package:movie_ticket_booking/app/data/services/models/movie_details_model.dart';
import 'package:movie_ticket_booking/app/data/services/models/movie_list_model.dart';
import 'package:movie_ticket_booking/app/modules/home/views/movie_details_view.dart';
import 'package:movie_ticket_booking/app/routes/app_pages.dart';
import 'package:uuid/uuid.dart';

class DateSlots {
  final DateTime? date;
  bool selected;

  DateSlots({
    this.date,
    this.selected = false,
  });
}

class TimeSlots {
  final String time;
  bool selected;

  TimeSlots({
    required this.time,
    this.selected = false,
  });
}

class HomeController extends GetxController {
  final ticketCount = 1.obs;
  var loadingStatus = LoadingStatus.loading.obs;
  final queryValuePresent = false.obs;
  final _movieListModel = Rx<MovieListModel>(
    MovieListModel(
      page: 0,
      results: [],
      totalPages: 0,
      totalResults: 0,
    ),
  );
  final movieDetails = Rx<MovieDetailsModel>(
    MovieDetailsModel(),
  );

  final List<DateSlots> dateSlotList = [
    DateSlots(
      date: DateTime.now(),
    ),
    DateSlots(
      date: DateTime.now().add(
        const Duration(days: 1),
      ),
    ),
    DateSlots(
      date: DateTime.now().add(
        const Duration(days: 2),
      ),
    ),
  ];

  final List<TimeSlots> timeSlotList = [
    TimeSlots(time: '10:00 AM'),
    TimeSlots(time: '12:00 PM'),
    TimeSlots(time: '02:00 PM'),
    TimeSlots(time: '04:00 PM'),
    TimeSlots(time: '06:00 PM'),
  ];

  final selectedDateSlot = Rx<DateSlots?>(null);
  final selectedTimeSlot = Rx<TimeSlots?>(null);

  void selectDateSlot(DateSlots dateSlots) {
    if (dateSlots.selected) {
      dateSlots.selected = false;
      selectedDateSlot.value = null;
    } else {
      dateSlots.selected = true;
      selectedDateSlot.value = dateSlots;
    }
  }

  void selectDateEmpty() {
    selectedDateSlot.value = DateSlots(
      date: DateTime.now(),
    );
  }

  void selectTimeSlot(TimeSlots timeSlot) {
    if (timeSlot.selected) {
      timeSlot.selected = false;
      selectedTimeSlot.value = null;
    } else {
      timeSlot.selected = true;
      selectedTimeSlot.value = timeSlot;
    }
  }

  void selectTimeEmpty() {
    selectedTimeSlot.value = TimeSlots(
      time: '',
    );
  }

  Map<String, dynamic>? paymentIntent;

  RxList<String> searchHistory = <String>[].obs;

  List<MovieData> listOfMovies = [];

  late bool _hasNext;
  bool _isFetching = false;
  bool get hasNext => _hasNext;
  int page = 0;

  void increment() {
    ticketCount.value++;
  }

  void decrement() {
    if (ticketCount.value > 1) {
      ticketCount.value--;
    }
  }

  // void addToSearchHistory(String searchTerm) {
  //   if (searchHistory.contains(searchTerm)) return;
  //   searchHistory.add(searchTerm);
  // }

  @override
  void onInit() {
    fetchMovies();
    super.onInit();
  }

  Future<MovieListModel> fetchMovieList() async {
    try {
      // loadingStatus(LoadingStatus.loading);
      // Map<String, String> queryParams = {
      //   'api_key': Config.apiKey,
      // };
      // String queryString = Uri(queryParameters: queryParams).query;
      // var requestUrl = '${Config.movieListUrl}?$queryString';
      // var response = await http.get(
      //   Uri.parse(requestUrl),
      // );
      final response = await dio.get(
        Config.movieListUrl,
        queryParameters: {
          'api_key': Config.apiKey,
          'page': page,
        },
      );
      log(response.data.toString());
      if (response.statusCode == 200) {
        _movieListModel.value = MovieListModel.fromJson(response.data);
        // List list = response.data["data"];
        // _listOfCases.value = list.map((e) => CaseData.fromJson(e)).toList();
        loadingStatus(LoadingStatus.completed);
      }
    } catch (e) {
      Get.back();
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
    return _movieListModel.value;
  }

  Future fetchMovies() async {
    page = 0;
    _isFetching = false;
    listOfMovies.clear();
    await fetchNextMovies();
  }

  Future fetchNextMovies() async {
    if (_isFetching) return;
    _isFetching = true;
    page++;
    var request = await fetchMovieList();
    listOfMovies.addAll(request.results.map((e) => e));
    if (listOfMovies.isNotEmpty) {
      _hasNext = listOfMovies.length >= 20 ? true : false;
      _isFetching = false;
      update();
    } else {
      listOfMovies = [];
      update();
    }
  }

  void searchMovies({
    required String query,
  }) async {
    try {
      final response = await dio.get(
        Config.searchMovieUrl,
        queryParameters: {
          'api_key': Config.apiKey,
          'query': query,
        },
      );
      log(response.data.toString());
      List data = response.data['results'];
      listOfMovies = data.map((e) => MovieData.fromJson(e)).toList();
      update();
    } catch (e) {
      Get.back();
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

  void fetchMovieDetails({
    required int movieId,
  }) async {
    try {
      final response = await dio.get(
        Config.movieDetailsUrl + movieId.toString(),
        queryParameters: {
          'api_key': Config.apiKey,
          'page': page,
        },
      );
      log(response.toString());
      if (response.statusCode == 200) {
        movieDetails.value = MovieDetailsModel.fromJson(response.data);
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            Get.back();
            Get.to(
              () => MovieDetailsView(
                movieDetailsModel: movieDetails.value,
              ),
            );
          },
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

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  createPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse(
          'https://api.stripe.com/v1/payment_intents',
        ),
        headers: {
          'Authorization': 'Bearer ${AppConstant.stripeSecretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      log('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (e) {
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> makePayment({
    required String userName,
    required String userEmail,
    required String movieTitle,
    required int numberOfTickets,
    required String selectedDate,
    required String selectedTime,
    required String amount,
    required String currency,
    required BuildContext context,
  }) async {
    try {
      paymentIntent = await createPaymentIntent(
        amount: amount,
        currency: currency,
      );
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.light,
              merchantDisplayName: 'Ashwini',
            ),
          )
          .then(
            (value) {},
          );
      displayPaymentSheet(
        context: context,
        userName: userName,
        userEmail: userEmail,
        movieTitle: movieTitle,
        numberOfTickets: numberOfTickets,
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        amount: amount,
      );
    } catch (e) {
      AppConstant.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

  displayPaymentSheet({
    required String userName,
    required String userEmail,
    required String movieTitle,
    required int numberOfTickets,
    required String selectedDate,
    required String selectedTime,
    required String amount,
    required BuildContext context,
  }) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 30.sp,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Text(
                        "Payment and booking successful",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        final paymentId = const Uuid().v1();
        await firebaseFirestore
            .collection('users')
            .doc(firebaseAuth.currentUser!.uid)
            .collection('bookings')
            .doc(paymentId)
            .set(
              BookingModel(
                customerId: firebaseAuth.currentUser!.uid,
                userName: userName,
                userEmail: userEmail,
                movieTitle: movieTitle,
                numberOfTickets: numberOfTickets,
                date: selectedDate,
                time: selectedTime,
                paymentId: paymentId,
                amount: amount,
                status: "Success",
                createdAt: DateTime.now(),
              ).toMap(),
            );
        Future.delayed(
          const Duration(seconds: 1),
          () {
            Get.offNamedUntil(
              Routes.BOTTOM_NAVIGATION,
              (route) => false,
            );
          },
        );
        paymentIntent = null;
        paymentIntent = null;
      }).onError(
        (error, stackTrace) async {
          final paymentId = const Uuid().v1();
          await firebaseFirestore
              .collection('users')
              .doc(firebaseAuth.currentUser!.uid)
              .collection('bookings')
              .doc(paymentId)
              .set(
                BookingModel(
                  customerId: firebaseAuth.currentUser!.uid,
                  userName: userName,
                  userEmail: userEmail,
                  movieTitle: movieTitle,
                  numberOfTickets: numberOfTickets,
                  date: selectedDate,
                  time: selectedTime,
                  paymentId: paymentId,
                  amount: amount,
                  status: "Failed",
                  createdAt: DateTime.now(),
                ).toMap(),
              );
          AppConstant.showSnackbar(
            headText: "Failed",
            content: "Payment Failed",
            position: SnackPosition.TOP,
          );
          Future.delayed(
            const Duration(milliseconds: 200),
            () {
              Get.offNamedUntil(
                Routes.BOTTOM_NAVIGATION,
                (route) => false,
              );
            },
          );
          log('Error is:--->$error $stackTrace');
        },
      );
    } on StripeException catch (e) {
      log('Error is:---> $e');
    } catch (e) {
      log('$e');
    }
  }
}
