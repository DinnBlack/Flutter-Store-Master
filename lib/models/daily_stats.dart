class DailyStats {
  final int dailyRevenue;
  final int currentOrders;
  final int completedOrdersToday;

  DailyStats({
    required this.dailyRevenue,
    required this.currentOrders,
    required this.completedOrdersToday,
  });

  factory DailyStats.fromMap(Map<String, dynamic> map) {
    return DailyStats(
      dailyRevenue: map['dailyRevenue'] ?? 0,
      currentOrders: map['currentOrders'] ?? 0,
      completedOrdersToday: map['completedOrdersToday'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dailyRevenue': dailyRevenue,
      'currentOrders': currentOrders,
      'completedOrdersToday': completedOrdersToday,
    };
  }

  int get getDailyRevenue => dailyRevenue;
  int get getCurrentOrders => currentOrders;
  int get getCompletedOrdersToday => completedOrdersToday;

  // Setters
  void setDailyRevenue(int dailyRevenue) => dailyRevenue = dailyRevenue;
  void setCurrentOrders(int currentOrders) => currentOrders = currentOrders;
  void setCompletedOrdersToday(int completedOrdersToday) =>
      completedOrdersToday = completedOrdersToday;
}
