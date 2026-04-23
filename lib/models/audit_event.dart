enum AuditAction {
  payment,
  receipt,
  refund,
  invoice,
  invoiceShared,
}

class AuditEvent {
  final DateTime timestamp;
  final String userRole;
  final AuditAction action;
  final String description;

  const AuditEvent({
    required this.timestamp,
    required this.userRole,
    required this.action,
    required this.description,
  });
}
