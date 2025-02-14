import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider_man_app/app/data/data_file.dart';
import 'package:provider_man_app/app/models/model_review.dart';
import 'package:provider_man_app/base/resizer/fetch_pixels.dart';
import 'package:provider_man_app/base/widget_utils.dart';

import '../../../../base/color_data.dart';

class TabReview extends StatefulWidget {
  const TabReview({Key? key}) : super(key: key);

  @override
  State<TabReview> createState() => _TabReviewState();
}

class _TabReviewState extends State<TabReview> {
  List<ModelReview> reviewLists = DataFile.reviewList;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return SafeArea(
      child: getPaddingWidget(
        EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getVerSpace(FetchPixels.getPixelHeight(20)),
            Align(
              alignment: Alignment.topCenter,
              child: getCustomFont("Reviews", 24, Colors.black, 1,
                  fontWeight: FontWeight.w800),
            ),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            reviewLists.isEmpty ? nullListView() : reviewList()
          ],
        ),
      ),
    );
  }

  Expanded reviewList() {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont("${reviewLists.length} Reviews", 16, Colors.black, 1,
            fontWeight: FontWeight.w800),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        Expanded(
          child: ListView.builder(
            itemCount: reviewLists.length,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              ModelReview modelReview = reviewLists[index];
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: FetchPixels.getPixelHeight(50),
                        width: FetchPixels.getPixelHeight(50),
                        decoration: BoxDecoration(
                            image: getDecorationAssetImage(
                                context, modelReview.image ?? "")),
                      ),
                      getHorSpace(FetchPixels.getPixelWidth(10)),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCustomFont(modelReview.name ?? '', 14,
                                        Colors.black, 1,
                                        fontWeight: FontWeight.w800),
                                    getVerSpace(FetchPixels.getPixelHeight(4)),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: 5,
                                          itemBuilder: (context, index) =>
                                              getSvgImage("star.svg"),
                                          itemCount: 5,
                                          itemSize:
                                              FetchPixels.getPixelHeight(16),
                                          direction: Axis.horizontal,
                                          itemPadding: EdgeInsets.only(
                                              right:
                                                  FetchPixels.getPixelWidth(6)),
                                        ),
                                        getHorSpace(
                                            FetchPixels.getPixelWidth(8)),
                                        getCustomFont(
                                            "4.5", 14, Colors.black, 1,
                                            fontWeight: FontWeight.w400)
                                      ],
                                    )
                                  ],
                                ),
                                getCustomFont("1 d ago", 14, textColor, 1,
                                    fontWeight: FontWeight.w400)
                              ],
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(12)),
                            getMultilineCustomFont(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                                16,
                                Colors.black,
                                fontWeight: FontWeight.w400,
                                txtHeight: FetchPixels.getPixelHeight(1.3)),
                            getVerSpace(FetchPixels.getPixelHeight(10)),
                            Row(
                              children: [
                                getSvgImage("heart.svg",
                                    width: FetchPixels.getPixelHeight(20),
                                    height: FetchPixels.getPixelHeight(20)),
                                getHorSpace(FetchPixels.getPixelWidth(6)),
                                getCustomFont("25", 14, textColor, 1,
                                    fontWeight: FontWeight.w400),
                                getHorSpace(FetchPixels.getPixelWidth(22)),
                                getSvgImage("reply.svg",
                                    width: FetchPixels.getPixelHeight(20),
                                    height: FetchPixels.getPixelHeight(20)),
                                getHorSpace(FetchPixels.getPixelWidth(6)),
                                getCustomFont("Reply", 14, textColor, 1,
                                    fontWeight: FontWeight.w400),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(24)),
                  getDivider(dividerColor, 0, 1),
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                ],
              );
            },
          ),
        )
      ],
    ));
  }

  Expanded nullListView() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getSvgImage("review_null.svg",
            height: FetchPixels.getPixelHeight(101.8),
            width: FetchPixels.getPixelHeight(124)),
        getVerSpace(FetchPixels.getPixelHeight(31.1)),
        getCustomFont("No Reviews Yet!", 20, Colors.black, 1,
            fontWeight: FontWeight.w800),
      ],
    ));
  }
}
