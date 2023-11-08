import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_ticket_booking/app/data/components/app_constant.dart';
import 'package:movie_ticket_booking/app/data/services/config.dart';
import 'package:movie_ticket_booking/app/data/services/models/movie_list_model.dart';

class ParticularMovieWidget extends StatelessWidget {
  const ParticularMovieWidget({
    super.key,
    required this.movieData,
  });

  final MovieData movieData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 15.h,
      ),
      child: Container(
        width: 1.sw,
        decoration: BoxDecoration(
          image: movieData.posterPath == null
              ? null
              : DecorationImage(
                  image: NetworkImage(
                    '${Config.imageUrl}${movieData.posterPath}',
                  ),
                  fit: BoxFit.cover,
                ),
          borderRadius: BorderRadius.circular(
            15.r,
          ),
          border: movieData.posterPath == null
              ? Border.all(
                  color: AppConstant.appBlack,
                  width: 1.w,
                )
              : null,
        ),
        child: movieData.posterPath == null
            ? Stack(
                children: [
                  Center(
                    child: Text(
                      movieData.title,
                      // "${caseData.name}dsfnds,fsd,fdnsfmdsnfdshskfsdkfvdskfvdkfvdskvfsdkfvsk",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            fontSize: 16.sp,
                            color: AppConstant.appBlack,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
