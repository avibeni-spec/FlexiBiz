import '../state/mock_appointments.dart';
import '../models/revenue_report.dart';
import '../models/revenue_range.dart';

class PdfReportBuilder {
  static RevenueReport build({
    required RevenueRange range,
    required DateTime anchor,
  }) {
    final DateTime from;
    final DateTime to;

    switch (range) {
      case RevenueRange.day:
        from = DateTime(anchor.year, anchor.month, anchor.day);
        to = from.add(const Duration(days: 1));
        break;

      case RevenueRange.week:
        from = DateTime(
          anchor.year,
          anchor.month,
          anchor.day - (anchor.weekday % 7),
        );
        to = from.add(const Duration(days: 7));
        break;

      case RevenueRange.month:
        from = DateTime(anchor.year, anchor.month, 1);
        to = DateTime(anchor.year, anchor.month + 1, 1);
        break;
    }

    final rows = MockAppointments.all
        .where((a) =>
            a.status == AppointmentStatus.paid &&
            !a.dateTime.isBefore(from) &&
            a.dateTime.isBefore(to))
        .map(
          (a) => RevenueReportRow(
            dateTime: a.dateTime,
            client: a.client,
            service: a.service,
            durationMinutes: a.duration.inMinutes,
            price: a.price,
          ),
        )
        .toList();

    return RevenueReport(
      from: from,
      to: to,
      rows: rows,
    );
  }
}