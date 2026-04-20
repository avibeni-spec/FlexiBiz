class RevenueReportRow {
  final DateTime dateTime;
  final String client;
  final String service;
  final int durationMinutes;
  final int price;

  const RevenueReportRow({
    required this.dateTime,
    required this.client,
    required this.service,
    required this.durationMinutes,
    required this.price,
  });
}

class RevenueReport {
  final DateTime from;
  final DateTime to;
  final List<RevenueReportRow> rows;

  const RevenueReport({
    required this.from,
    required this.to,
    required this.rows,
  });

  int get total =>
      rows.fold<int>(0, (sum, r) => sum + r.price);

  bool get isEmpty => rows.isEmpty;
}