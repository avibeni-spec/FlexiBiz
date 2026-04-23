import '../models/audit_event.dart';

class AuditLog {
  static final List<AuditEvent> _events = [];

  static List<AuditEvent> get all =>
      List.unmodifiable(_events);

  static void add(AuditEvent event) {
    _events.insert(0, event); // הכי חדש למעלה
  }
}