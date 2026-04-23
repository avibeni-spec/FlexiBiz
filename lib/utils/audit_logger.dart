import '../models/audit_event.dart';
import '../state/audit_log.dart';
import '../state/current_user.dart';

class AuditLogger {
  static void log({
    required AuditAction action,
    required String description,
  }) {
    AuditLog.add(
      AuditEvent(
        timestamp: DateTime.now(),
        userRole: CurrentUser.role.name,
        action: action,
        description: description,
      ),
    );
  }
}
