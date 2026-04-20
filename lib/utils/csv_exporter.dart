import '../state/mock_appointments.dart';

class CsvExporter {
  static String exportPaidAppointmentsToCsv() {
    final buffer = StringBuffer();

    // Header
    buffer.writeln(
        "Date,Time,Client,Service,Duration(min),Price");

    for (final a in MockAppointments.all) {
      if (a.status != AppointmentStatus.paid) continue;

      final date =
          "${a.dateTime.year}-${a.dateTime.month.toString().padLeft(2, '0')}-${a.dateTime.day.toString().padLeft(2, '0')}";
      final time = a.timeLabel;
      final duration = a.duration.inMinutes;
      final price = a.price;

      buffer.writeln(
          "$date,$time,${a.client},${a.service},$duration,$price");
    }

    return buffer.toString();
  }
}
