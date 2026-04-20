import 'service_prices.dart';

enum AppointmentStatus {
  scheduled,
  checkedIn,
  cancelled,
  paid,
}

class Appointment {
  final DateTime dateTime;
  final Duration duration;
  final String client;
  final String service;
  final AppointmentStatus status;

  Appointment({
    required this.dateTime,
    required this.duration,
    required this.client,
    required this.service,
    this.status = AppointmentStatus.scheduled,
  });

  int get price => ServicePrices.getPrice(service);

  String get timeLabel =>
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

  DateTime get endTime => dateTime.add(duration);
}

class MockAppointments {
  static final List<Appointment> _appointments = [];

  static List<Appointment> get all => List.unmodifiable(_appointments);

  // ✅ Add
  static void add(Appointment appointment) {
    _appointments.add(appointment);
  }

  // ✅ Replace (immutable update)
  static void replace(Appointment oldA, Appointment newA) {
    final index = _appointments.indexOf(oldA);
    if (index != -1) {
      _appointments[index] = newA;
    }
  }

  // ✅ Status updates
  static void checkIn(Appointment a) {
    replace(
      a,
      Appointment(
        dateTime: a.dateTime,
        duration: a.duration,
        client: a.client,
        service: a.service,
        status: AppointmentStatus.checkedIn,
      ),
    );
  }

  static void pay(Appointment a) {
    replace(
      a,
      Appointment(
        dateTime: a.dateTime,
        duration: a.duration,
        client: a.client,
        service: a.service,
        status: AppointmentStatus.paid,
      ),
    );
  }

  static void cancel(Appointment a) {
    replace(
      a,
      Appointment(
        dateTime: a.dateTime,
        duration: a.duration,
        client: a.client,
        service: a.service,
        status: AppointmentStatus.cancelled,
      ),
    );
  }
}