import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/services/config.dart';
import 'package:movie_ticket_booking/app/modules/home/views/widgets/particular_movie_widget.dart';
import 'package:movie_ticket_booking/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final scrollController = ScrollController();
  final controller = Get.find<HomeController>();
  final profileController = Get.find<ProfileController>();
  final searchController = TextEditingController();

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      if (controller.hasNext && !controller.queryValuePresent.value) {
        controller.fetchNextMovies();
      }
    }
  }

  // @override
  // void dispose() {
  //   scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppConstant.subtitleColor,
          statusBarIconBrightness:
              Get.isDarkMode ? Brightness.dark : Brightness.light,
          statusBarBrightness:
              Get.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70.h,
        title: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileController.user.name,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                "Let's relax and book a movie ticket...",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        color: AppConstant.primaryColor,
        backgroundColor: Colors.white,
        strokeWidth: 2.w,
        onRefresh: () async {
          controller.fetchMovies();
          controller.queryValuePresent(false);
          searchController.clear();
        },
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return false;
          },
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return ListView(
                controller: scrollController,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    child: SizedBox(
                      height: 40.h,
                      child: TextFormField(
                        controller: searchController,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                        maxLines: 1,
                        onFieldSubmitted: (value) {
                          controller.searchMovies(
                            query: value,
                          );
                          controller.queryValuePresent(true);
                          // controller.addToSearchHistory(value);
                        },
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding: EdgeInsets.only(
                            top: 10.h,
                            left: 15.w,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.w,
                              color: Colors.black,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(
                              10.r,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(
                              right: 10.w,
                            ),
                            child: const Icon(
                              Icons.search,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.w,
                              color: Colors.black,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(
                              10.r,
                            ),
                          ),
                          hintText: 'Search by title',
                          hintStyle:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  controller.loadingStatus.value == LoadingStatus.loading
                      ? Center(
                          child: Platform.isAndroid
                              ? CircularProgressIndicator(
                                  strokeWidth: 2.w,
                                  color: AppConstant.primaryColor,
                                )
                              : CupertinoActivityIndicator(
                                  color: AppConstant.primaryColor,
                                  animating: true,
                                  radius: 15.r,
                                ),
                        )
                      : controller.listOfMovies.isEmpty
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25.w,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 300.h,
                                    ),
                                    Text(
                                      "No movies available",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17.sp,
                                            color: Colors.black,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: controller.listOfMovies.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 5.w,
                                ),
                                itemBuilder: (context, index) {
                                  final particularMovie =
                                      controller.listOfMovies[index];
                                  return InkWell(
                                    onTap: () {
                                      AppConstant.showLoader(context: context);
                                      controller.fetchMovieDetails(
                                        movieId: particularMovie.id,
                                      );
                                    },
                                    child: ParticularMovieWidget(
                                      movieData: particularMovie,
                                    ),
                                  );
                                },
                              ),
                            ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
