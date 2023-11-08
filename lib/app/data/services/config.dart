import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum LoadingStatus {
  loading,
  completed,
  error,
}

mixin Config {
  static const movieListUrl = 'https://api.themoviedb.org/3/movie/popular';
  static const movieDetailsUrl = 'https://api.themoviedb.org/3/movie/';
  static const searchMovieUrl = 'https://api.themoviedb.org/3/search/movie';
  static const imageUrl = 'https://image.tmdb.org/t/p/w500/';
  static const apiKey = '7d79a0348d08945377e89a95cd670c5a';
}

final firebaseAuth = FirebaseAuth.instance;
final firebaseFirestore = FirebaseFirestore.instance;
final googleSignInInstance = GoogleSignIn();
final dio = Dio();
