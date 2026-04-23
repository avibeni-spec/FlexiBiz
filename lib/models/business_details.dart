class BusinessDetails {
  final String name;
  final String registrationId; // ח.פ / עוסק
  final String address;
  final String phone;
  final String email;
  final String footerNote;

  const BusinessDetails({
    required this.name,
    required this.registrationId,
    required this.address,
    required this.phone,
    required this.email,
    required this.footerNote,
  });
}
