// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String customerId;
  String userName;
  String userEmail;
  String movieTitle;
  int numberOfTickets;
  String date;
  String time;
  String paymentId;
  String amount;
  String status;

  DateTime createdAt;

  BookingModel({
    required this.customerId,
    required this.userName,
    required this.userEmail,
    required this.movieTitle,
    required this.numberOfTickets,
    required this.date,
    required this.time,
    required this.paymentId,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "customerId": customerId,
      "userName": userName,
      "userEmail": userEmail,
      "movieTitle": movieTitle,
      "numberOfTickets": numberOfTickets,
      "date": date,
      "time": time,
      'paymentId': paymentId,
      'amount': amount,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory BookingModel.fromMap(
      QueryDocumentSnapshot<Map<String, dynamic>> map) {
    return BookingModel(
      customerId: map['customerId'] as String,
      userName: map['userName'] as String,
      userEmail: map['userEmail'] as String,
      movieTitle: map['movieTitle'] as String,
      numberOfTickets: map['numberOfTickets'] as int,
      date: map['date'] as String,
      time: map['time'] as String,
      paymentId: map['paymentId'] as String,
      amount: map['amount'] as String,
      status: map['status'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
