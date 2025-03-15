import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider_man_app/base/color_data.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../models/model_booking.dart';

class BookingDetailsScreen extends StatefulWidget {
  final ModelBooking booking;

  const BookingDetailsScreen({Key? key, required this.booking}) : super(key: key);

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  late ModelBooking modelBooking;
  late int currentStatusIndex;

  @override
  void initState() {
    super.initState();
    modelBooking = widget.booking;
    currentStatusIndex =
        ModelBooking.bookingStatuses.indexOf(modelBooking.status!);
  }

  void updateStatus() {
    setState(() {
      if (currentStatusIndex < ModelBooking.bookingStatuses.length - 1) {
        currentStatusIndex++;
        modelBooking.status = ModelBooking.bookingStatuses[currentStatusIndex];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Align(
              child: Text(
                "Booking ID 26556",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            Align(
              child: Container(
                height:
                FetchPixels.getPixelHeight(60),
                width: FetchPixels.getPixelHeight(60),
                decoration: BoxDecoration(
                    image: getDecorationAssetImage(
                        context,
                        modelBooking.image ?? "")),
              ),
            ),

            const SizedBox(height: 16),
            _infoColumn("Customer Name", modelBooking.providerName ?? 'User'),
            _infoColumn("Address", "1901 Thornridge Cir. Shiloh, Hawaii 81063"),
            _infoRow("Booking For", modelBooking.serviceName ?? 'Cleaning'),
            _infoRow("Rooms", modelBooking.noOfRooms ?? '0'),
            _infoRow("SquareFeet", modelBooking.squareFeet ?? '0'),
            _infoRow("Date", modelBooking.date ?? ''),
            _infoRow("Start Time", modelBooking.startTime ?? ''),
            _infoRow("End Time", modelBooking.endTime ?? ''),
            _infoRow("Total Time", "2 Hrs"),
            _infoRow("Price", "100"),
            _infoRow("PaymentStatus", "Paid"),

            const SizedBox(height: 30),


            _statusSlider(),

            const Spacer(),
            /*Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        modelBooking.status =
                        ModelBooking.bookingStatuses[currentStatusIndex];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Accept",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),*/
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(width: 20),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(width: 20),
          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  double _dragPosition = 0.0; // Tracks the drag movement

  Widget _statusSlider() {
    bool isCompleted = modelBooking.status == "Completed";

    return Column(
      children: [
        if (!isCompleted)
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _dragPosition += details.primaryDelta!;
                _dragPosition = _dragPosition.clamp(0.0, 200.0); // Keep within bounds
              });
            },
            onHorizontalDragEnd: (details) {
              if (_dragPosition > 180) { // Ensure proper drag distance
                if (currentStatusIndex < ModelBooking.bookingStatuses.length - 1) {
                  setState(() {
                    currentStatusIndex++;
                    modelBooking.status = ModelBooking.bookingStatuses[currentStatusIndex];
                  });
                }
              }
              setState(() => _dragPosition = 0); // Reset after each slide
            },
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      "Slide to ${ModelBooking.bookingStatuses[currentStatusIndex + 1]}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  left: _dragPosition,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                    child: const Center(
                      child: Icon(Icons.keyboard_double_arrow_right, color: Colors.white, size: 24),
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Completed",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
      ],
    );
  }

}