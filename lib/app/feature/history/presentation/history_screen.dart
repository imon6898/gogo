import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gogo/app/feature/history/controllers/history_controller.dart';
import 'package:gogo/app/utils/constants/app_colors.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
      init: HistoryController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: CustomColors.BGColor,
          appBar: AppBar(
            backgroundColor: CustomColors.mainColor,
            title: const Text(
              "Order History",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.orderHistory.length,
            itemBuilder: (context, index) {
              final order = controller.orderHistory[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    // Optional: Navigate to order detail
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order.restaurantName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Chip(
                              avatar: Icon(
                                getStatusIcon(order.status),
                                size: 16,
                                color: Colors.white,
                              ),
                              label: Text(order.status),
                              backgroundColor: getStatusColor(order.status),
                              labelStyle: const TextStyle(color: Colors.white),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// Date & Time
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(order.dateTime,
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),

                        const Divider(height: 24),

                        /// Items
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.fastfood, size: 18, color: Colors.grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                order.items.join(", "),
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        /// Total amount
                        Row(
                          children: [
                            const Icon(Icons.attach_money, size: 18, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              "Total: ৳${order.totalAmount}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "Canceled":
        return Colors.red;
      case "Processing":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "Delivered":
        return Icons.check_circle;
      case "Canceled":
        return Icons.cancel;
      case "Processing":
        return Icons.hourglass_top;
      default:
        return Icons.info;
    }
  }
}
