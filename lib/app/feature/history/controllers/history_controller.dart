import 'package:get/get.dart';

class HistoryController extends GetxController {
  List<OrderHistory> orderHistory = [
    OrderHistory(
      restaurantName: "Pizza Hub",
      dateTime: "May 18, 2025 - 6:30 PM",
      items: ["Pepperoni Pizza", "Garlic Bread"],
      totalAmount: 650,
      status: "Delivered",
    ),
    OrderHistory(
      restaurantName: "Burger Express",
      dateTime: "May 17, 2025 - 1:15 PM",
      items: ["Cheese Burger", "Fries", "Coke"],
      totalAmount: 420,
      status: "Canceled",
    ),
    OrderHistory(
      restaurantName: "Deshi Foods",
      dateTime: "May 16, 2025 - 8:00 PM",
      items: ["Beef Tehari", "Borhani"],
      totalAmount: 300,
      status: "Delivered",
    ),
    OrderHistory(
      restaurantName: "Sushi World",
      dateTime: "May 15, 2025 - 7:45 PM",
      items: ["Salmon Sushi", "Miso Soup"],
      totalAmount: 950,
      status: "Processing",
    ),
    OrderHistory(
      restaurantName: "Kacchi Bhai",
      dateTime: "May 14, 2025 - 2:00 PM",
      items: ["Kacchi Biryani", "Soft Drink"],
      totalAmount: 550,
      status: "Delivered",
    ),
  ];
}



class OrderHistory {
  final String restaurantName;
  final String dateTime;
  final List<String> items;
  final double totalAmount;
  final String status;

  OrderHistory({
    required this.restaurantName,
    required this.dateTime,
    required this.items,
    required this.totalAmount,
    required this.status,
  });
}

