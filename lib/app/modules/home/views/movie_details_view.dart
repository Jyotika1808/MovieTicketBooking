import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket_booking/app/data/components/custom_app_bar_with_backarrow.dart';
import 'package:movie_ticket_booking/app/data/components/custom_elevated_button.dart';
import 'package:movie_ticket_booking/app/data/services/config.dart';
import 'package:movie_ticket_booking/app/data/services/models/movie_details_model.dart';
import 'package:movie_ticket_booking/app/modules/home/controllers/home_controller.dart';
import 'package:movie_ticket_booking/app/modules/home/views/book_ticket_view.dart';

class MovieDetailsView extends GetView<HomeController> {
  const MovieDetailsView({
    Key? key,
    required this.movieDetailsModel,
  }) : super(key: key);

  final MovieDetailsModel movieDetailsModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithBackArrow(
        context: context,
        text: movieDetailsModel.originalTitle ?? "Title not available",
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              movieDetailsModel.posterPath == null
                  ? Container(
                      height: 160.h,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                    )
                  : SizedBox(
                      width: 1.sw,
                      child: CachedNetworkImage(
                        imageUrl:
                            Config.imageUrl + movieDetailsModel.posterPath!,
                        fit: BoxFit.cover,
                      ),
                    ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Text(
                        "Overview",
                        textAlign: TextAlign.left,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 22.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      movieDetailsModel.overview ?? "Not available",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 17.sp,
                                color: Colors.black,
                              ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Runtime of the movie",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "${movieDetailsModel.runtime! ~/ 60} hours ${movieDetailsModel.runtime! % 60} minutes",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 17.sp,
                                color: Colors.black,
                              ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Budget",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "\$ ${movieDetailsModel.budget}",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 17.sp,
                                color: Colors.black,
                              ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Revenue Regenrated",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "\$ ${movieDetailsModel.revenue}",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 17.sp,
                                color: Colors.black,
                              ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Release Date",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    movieDetailsModel.releaseDate == null
                        ? Text(
                            "Not available",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 17.sp,
                                  color: Colors.black,
                                ),
                          )
                        : Text(
                            "${DateFormat.MMM().format(movieDetailsModel.releaseDate!)} ${movieDetailsModel.releaseDate!.day}, ${movieDetailsModel.releaseDate!.year} (Status - ${movieDetailsModel.status})",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 17.sp,
                                  color: Colors.black,
                                ),
                          ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Tagline",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                fontSize: 18.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      movieDetailsModel.tagline ?? "Not available",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 17.sp,
                                color: Colors.black,
                              ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    movieDetailsModel.genres == null
                        ? Text(
                            "Genres not available",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        : Text(
                            "Genres",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                    SizedBox(
                      height: 5.h,
                    ),
                    for (int i = 0; i < movieDetailsModel.genres!.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(
                          5,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              movieDetailsModel.genres![i].name ??
                                  "Not available",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    movieDetailsModel.productionCompanies == null
                        ? Text(
                            "Production Companies not available",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        : Text(
                            "Production Companies",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                    SizedBox(
                      height: 5.h,
                    ),
                    for (int i = 0;
                        i < movieDetailsModel.productionCompanies!.length;
                        i++)
                      Padding(
                        padding: const EdgeInsets.all(
                          5,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              movieDetailsModel.productionCompanies![i].name ??
                                  "Not available",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    movieDetailsModel.productionCountries == null
                        ? Text(
                            "Production Countries not available",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        : Text(
                            "Production Countries",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                    SizedBox(
                      height: 5.h,
                    ),
                    for (int i = 0;
                        i < movieDetailsModel.productionCountries!.length;
                        i++)
                      Padding(
                        padding: const EdgeInsets.all(
                          5,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              movieDetailsModel.productionCountries![i].name ??
                                  "Not available",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 10.h,
                    ),
                    movieDetailsModel.productionCountries == null
                        ? Text(
                            "Spoken languages not available",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        : Text(
                            "Spoken Languages",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontSize: 18.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                    SizedBox(
                      height: 5.h,
                    ),
                    for (int i = 0;
                        i < movieDetailsModel.spokenLanguages!.length;
                        i++)
                      Padding(
                        padding: const EdgeInsets.all(
                          5,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              movieDetailsModel.spokenLanguages![i].name ??
                                  "Not available",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => BookTicketView(
                            movieDetailsModel: movieDetailsModel,
                          ),
                        );
                      },
                      width: 1.sw,
                      child: Text(
                        "Book Ticket",
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
