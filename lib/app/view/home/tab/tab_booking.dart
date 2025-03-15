import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider_man_app/app/data/data_file.dart';
import 'package:provider_man_app/app/models/model_booking.dart';
import 'package:provider_man_app/app/routes/app_routes.dart';
import 'package:provider_man_app/base/color_data.dart';
import 'package:provider_man_app/base/constant.dart';
import 'package:provider_man_app/base/resizer/fetch_pixels.dart';
import 'package:provider_man_app/base/widget_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/data_file.dart';
import '../../details/booking_details.dart';
import '../../map_screen.dart';

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
                Icon(Icons.notifications_none,
                    size: FetchPixels.getPixelHeight(24),)
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
              dateHeader(modelBooking, index,context),
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
                              /*getSvgImage("check_complete.svg",
                                  width: FetchPixels.getPixelHeight(24),
                                  height:
                                      FetchPixels.getPixelHeight(24)),
                              getHorSpace(FetchPixels.getPixelWidth(6)),*/
                              getStatusBadge(modelBooking.status ?? "")
                            ],
                          )
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(6)),
                      Row(
                        children: [
                          getCustomFont(
                              modelBooking.startTime ?? "", 14, textColor, 1,
                              fontWeight: FontWeight.w400),
                          getCustomFont(
                              " - ", 14, textColor, 1,
                              fontWeight: FontWeight.w400),
                          getCustomFont(
                              modelBooking.endTime ?? "", 14, textColor, 1,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                          getCustomFont(
                              '${modelBooking.noOfRooms ?? ""} Rooms', 14, textColor, 1,
                              fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getCustomFont(
                              'Square Feet - ${modelBooking.squareFeet ?? ""}', 14, textColor, 1,
                              fontWeight: FontWeight.w400),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MapScreen()), // Open the map screen
                              );
                            },
                            child: getCustomFont(
                              'Location >>',
                              14,
                              greenColor,
                              1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),


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
                                tag: index,
                                child: Container(
                                  height:
                                      FetchPixels.getPixelHeight(42),
                                  width: FetchPixels.getPixelHeight(42),
                                  decoration: BoxDecoration(
                                      image: getDecorationAssetImage(
                                          context,
                                          modelBooking.image ?? "")),
                                ),
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
                                  color: Colors.green[50], // Light WhatsApp background
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.whatsapp, // ✅ WhatsApp Icon
                                    color: Colors.green,
                                    size: FetchPixels.getPixelHeight(24),
                                  ),
                                ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetailsScreen(booking: bookingLists[index]), // Use bookingLists
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }



  Widget dateHeader(ModelBooking modelBooking, int index, BuildContext context) {
    // Ensure `day` is correctly formatted in `dd-MM-yyyy`
    DateTime? bookingDate;
    if (modelBooking.day != null && modelBooking.day!.contains("-")) {
      try {
        bookingDate = DateFormat('dd-MM-yyyy').parse(modelBooking.day!);
      } catch (e) {
        bookingDate = DateTime.now();
      }
    } else {
      bookingDate = DateTime.now();
      modelBooking.day = DateFormat('dd-MM-yyyy').format(bookingDate);
    }

    // Get today's and yesterday's date
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));

    // Format dates properly
    String formattedBookingDate = DateFormat('dd-MM-yyyy').format(bookingDate);
    String formattedToday = DateFormat('dd-MM-yyyy').format(today);
    String formattedYesterday = DateFormat('dd-MM-yyyy').format(yesterday);

    // Determine label
    String displayDate;
    if (formattedBookingDate == formattedToday) {
      displayDate = "Today";
    } else if (formattedBookingDate == formattedYesterday) {
      displayDate = "Yesterday";
    } else {
      displayDate = formattedBookingDate; // Show actual date
    }

    // Ensure the date header appears **only above the first booking of that day**
    bool showDateHeader = index == 0 || bookingLists[index - 1].day != modelBooking.day;

    return showDateHeader
        ? Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Show "Bookings" title only for the first index
        index == 0
            ? getCustomFont("Bookings", 16, Colors.black, 1, fontWeight: FontWeight.w800)
            : Container(),

        // Always show Date Picker on the right
        Row(
          children: [
            getCustomFont(
              displayDate, // Now correctly handles Yesterday
              14,
              Colors.black,
              1,
              fontWeight: FontWeight.w400,
            ),
            IconButton(
              icon: const Icon(Icons.calendar_month, size: 16),
              onPressed: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: bookingDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  modelBooking.day = DateFormat('dd-MM-yyyy').format(selectedDate);
                  (context as Element).markNeedsBuild(); // Force UI update
                }
              },
            ),
          ],
        ),
      ],
    )
        : Container();
  }






  /* Row dateHeader(ModelBooking modelBooking, int index) {
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
  }*/
  Widget getStatusBadge(String status) {
    Color statusColor;

    switch (status) {
      case "Pending":
        statusColor = Colors.orange;
        break;
      case "Completed":
        statusColor = greenColor;
        break;
      case "Started":
        statusColor = Colors.blue;
        break;
      case "Travelling":
        statusColor = Colors.purple;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: getCustomFont(
        status,
        14,
        statusColor,
        1,
        fontWeight: FontWeight.w600,
      ),
    );
  }





}
