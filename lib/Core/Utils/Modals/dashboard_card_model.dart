class DashboardCardModel {
  final DateTime date;
  final String dateTimeText; // E.g. "January 12, 2026 | 8:00 AM - 1:00 PM"
  final String title; // E.g. "Endocrine Surgery"
  final String badgeText; // E.g. "IP", "OP", "Booked"
  final String row1Label; // E.g. "Visit ID : " or "Appointment Type : "
  final String row1Value; // E.g. "IP-001" or "Consultation"
  final String row2Label; // Usually "Consultant Doctor : "
  final String row2Value; // E.g. "Dr. Sabaretnam Mayilaganam"
  final String recordType; // Internal filter flag: "IP", "OP", or "Appointment"

  DashboardCardModel({
    required this.date,
    required this.dateTimeText,
    required this.title,
    required this.badgeText,
    required this.row1Label,
    required this.row1Value,
    this.row2Label = "Consultant Doctor : ",
    required this.row2Value,
    required this.recordType,
  });
}
