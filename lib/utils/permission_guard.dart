import '../models/user_role.dart';
import '../state/current_user.dart';

class PermissionGuard {
  static bool get isAdmin =>
      CurrentUser.role == UserRole.admin;

  static bool get canViewInvoices =>
      CurrentUser.role == UserRole.admin;

  static bool get canExportRevenue =>
      CurrentUser.role == UserRole.admin;

  static bool get canEditServices =>
      CurrentUser.role == UserRole.admin;
}