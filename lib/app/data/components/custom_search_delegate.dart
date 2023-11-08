// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class HomeSearchScreen extends SearchDelegate {
//   final homeController = Get.find<HomeController>();
//   // List<String> searchTerm = [
//   //   'clothes',
//   //   'all',
//   //   'books',
//   // ];

//   final List<String> searchTerm;

//   HomeSearchScreen({
//     required this.searchTerm,
//   });
//   @override
//   ThemeData appBarTheme(BuildContext context) {
//     final ThemeData theme = Theme.of(context).copyWith();
//     return theme;
//   }

//   @override
//   TextStyle get searchFieldStyle => TextStyle(
//         color: AppConstant.appBlack,
//         fontSize: 15.sp,
//       );

//   @override
//   String? get searchFieldLabel => 'Search by place';

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       if (query.isNotEmpty)
//         IconButton(
//           onPressed: () {
//             query = '';
//           },
//           icon: const Icon(
//             Icons.clear_rounded,
//             color: Colors.black,
//           ),
//         )
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: Icon(
//         Icons.keyboard_arrow_left_rounded,
//         size: 30.sp,
//         color: Colors.black,
//       ),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var item in searchTerm) {
//       if (item.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(item);
//       }
//     }
//     return ListView.builder(
//       itemCount: matchQuery.length,
//       itemBuilder: (context, index) {
//         var result = matchQuery[index];
//         return InkWell(
//           onTap: () {
//             Get.back();
//             homeController.fetchGyms(
//               query: result,
//             );
//           },
//           child: ListTile(
//             title: Text(
//               result,
//               style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                     fontSize: 15.sp,
//                     color: Colors.black,
//                   ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> matchQuery = [];
//     for (var item in searchTerm) {
//       if (item.toLowerCase().contains(query.toLowerCase())) {
//         matchQuery.add(item);
//       }
//     }
//     return matchQuery.isEmpty
//         ? Column(
//             children: [
//               SizedBox(
//                 height: 20.h,
//               ),
//               Center(
//                 child: Text(
//                   "No results",
//                   style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                         fontSize: 15.sp,
//                         color: Colors.black,
//                       ),
//                 ),
//               ),
//             ],
//           )
//         : ListView.builder(
//             itemCount: matchQuery.length,
//             itemBuilder: (context, index) {
//               var result = matchQuery[index];
//               return InkWell(
//                 onTap: () {
//                   log(result);
//                   Get.back();
//                   homeController.fetchGyms(
//                     query: result,
//                   );
//                 },
//                 child: ListTile(
//                   title: Text(
//                     result,
//                     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                           fontSize: 15.sp,
//                           color: Colors.black,
//                         ),
//                   ),
//                 ),
//               );
//             },
//           );
//   }
// }
