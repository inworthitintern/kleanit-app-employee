import 'package:flutter/material.dart';
import 'package:provider_man_app/app/data/data_file.dart';
import 'package:provider_man_app/app/models/model_booking.dart';
import 'package:provider_man_app/app/routes/app_routes.dart';
import 'package:provider_man_app/base/color_data.dart';
import 'package:provider_man_app/base/constant.dart';
import 'package:provider_man_app/base/resizer/fetch_pixels.dart';
import 'package:provider_man_app/base/widget_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/data_file.dart';

class TabBooking extends StatefulWidget {
  const TabBooking({Key? key}) : super(key: key);

  @override
  State<TabBooking> createState() => _TabBookingState();
}

class _TabBookingState extends State<TabBooking> {
  List<ModelBooking> bookingLists = DataFile.bookingList;
  SharedPreferences? selection;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      selection = sp;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return SafeArea(
      child: Column(
        children: [
          getVerSpace(FetchPixels.getPixelHeight(16)),
          getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: FetchPixels.getPixelHeight(46),
                      width: FetchPixels.getPixelHeight(46),
                      decoration: BoxDecoration(
                          image: getDecorationAssetImage(
                              context, "profile.png")),
                    ),
                    getHorSpace(FetchPixels.getPixelWidth(12)),
                    getCustomFont("Albert Flores", 16, Colors.black, 1,
                        fontWeight: FontWeight.w400)
                  ],
                ),
                getSvgImage("more.svg",
                    height: FetchPixels.getPixelHeight(24),
                    width: FetchPixels.getPixelHeight(24))
              ],
            ),
          ),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          bookingLists.isEmpty ? nullListView() : bookingList()
        ],
      ),
    );
  }

  Expanded nullListView() {
    return Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getSvgImage("booking_null.svg",
                height: FetchPixels.getPixelHeight(124),
                width: FetchPixels.getPixelHeight(84.77)),
            getVerSpace(FetchPixels.getPixelHeight(30)),
            getCustomFont("No Bookings Yet!", 20, Colors.black, 1,
                fontWeight: FontWeight.w800)
          ],
        ));
  }

  Expanded bookingList() {
    return Expanded(
      flex: 1,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
        shrinkWrap: true,
        primary: true,
        itemCount: bookingLists.length,
        itemBuilder: (context, index) {
          ModelBooking modelBooking = bookingLists[index];
          return Column(
            children: [
              dateHeader(modelBooking, index),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: FetchPixels.getPixelHeight(20)),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0.0, 4.0)),
                      ],
                      borderRadius: BorderRadius.circular(
                          FetchPixels.getPixelHeight(12))),
                  padding: EdgeInsets.symmetric(
                      horizontal: FetchPixels.getPixelWidth(16),
                      vertical: FetchPixels.getPixelHeight(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          getCustomFont(modelBooking.serviceName ?? "",
                              16, Colors.black, 1,
                              fontWeight: FontWeight.w800),
                          Row(
                            children: [
                              getSvgImage("check_complete.svg",
                                  width: FetchPixels.getPixelHeight(24),
                                  height:
                                      FetchPixels.getPixelHeight(24)),
                              getHorSpace(FetchPixels.getPixelWidth(6)),
                              getCustomFont(
                                "Approved",
                                16,
                                success,
                                1,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          )
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(6)),
                      getCustomFont(
                          modelBooking.date ?? "", 14, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      getDivider(dividerColor, 0, 1),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Hero(
                                child: Container(
                                  height:
                                      FetchPixels.getPixelHeight(42),
                                  width: FetchPixels.getPixelHeight(42),
                                  decoration: BoxDecoration(
                                      image: getDecorationAssetImage(
                                          context,
                                          modelBooking.image ?? "")),
                                ),
                                tag: index,
                              ),
                              getHorSpace(FetchPixels.getPixelWidth(9)),
                              getCustomFont(
                                  modelBooking.providerName ?? "",
                                  16,
                                  Colors.black,
                                  1,
                                  fontWeight: FontWeight.w400)
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                height: FetchPixels.getPixelHeight(42),
                                width: FetchPixels.getPixelHeight(42),
                                decoration: BoxDecoration(
                                    image: getDecorationAssetImage(
                                        context, "round_chat.png")),
                              ),
                              getHorSpace(
                                  FetchPixels.getPixelWidth(12)),
                              Container(
                                height: FetchPixels.getPixelHeight(42),
                                width: FetchPixels.getPixelHeight(42),
                                decoration: BoxDecoration(
                                    image: getDecorationAssetImage(
                                        context, "call_bg.png")),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                onTap: () {
                  selection!.setInt("index", index);
                  Constant.sendToNext(
                      context, Routes.bookingDetailRoute);
                },
              )
            ],
          );
        },
      ),
    );
  }

  Row dateHeader(ModelBooking modelBooking, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        index == 0
            ? getCustomFont("Bookings", 16, Colors.black, 1,
                fontWeight: FontWeight.w800)
            : Container(),
        if (index == 0)
          getCustomFont(modelBooking.day ?? "", 16, Colors.black, 1,
              fontWeight: FontWeight.w400)
        else if (bookingLists[index - 1].day == bookingLists[index].day)
          Container()
        else
          getCustomFont(modelBooking.day ?? "", 14, textColor, 1,
              fontWeight: FontWeight.w400)
      ],
    );
  }
}
