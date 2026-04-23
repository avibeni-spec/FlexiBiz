import 'package:flutter/material.dart';

import '../state/audit_log.dart';
import '../utils/permission_guard.dart';

class AuditLogScreen extends StatelessWidget {
  const AuditLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!PermissionGuard.isAdmin) {
      return Scaffold(
        appBar: AppBar(title: const Text("Audit Log")),
        body: const Center(
          child: Text(
            "You do not have permission to view audit logs",
          ),
        ),
      );
    }

    final events = AuditLog.all;

    return Scaffold(
      appBar: AppBar(title: const Text("Audit Log")),
      body: events.isEmpty
          ? const Center(
              child: Text("No audit events yet"),
            )
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (_, i) {
                final e = events[i];

                return ListTile(
                  title: Text(e.description),
                  subtitle: Text(
                    "${e.action.name.toUpperCase()} • "
                    "${e.userRole} • "
                    "${e.timestamp}",
                  ),
                );
              },
            ),
    );
  }
}