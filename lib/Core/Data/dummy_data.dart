import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qc_hospital/main.dart';

class DummyData {
  static int registration = 0;

  static const List<String> donorTypes = [
    '--Select--',
    'Autologous',
    'Replacement',
    'Directed',
    'Voluntary',
    'Camp',
  ];

  static const List<String> donationTypes = [
    '--Select--',
    "Granulocyte-Pheresis",
    "Plasma-Pheresis",
    "Platelet-Pheresis",
    "Stem-cell-Pheresis",
    "Whole Blood",
  ];

  static const List<String> campSites = [
    '--Select--',
    'Camp Site 1',
    'Camp Site 2',
  ];

  static const List<String> relations = [
    '--Select--',
    'Brother',
    'Daughter',
    'Father',
    'Father-in-law',
    'Husband',
    'Mother',
    'Mother-in-law',
    'Others',
    'Self',
    'Sister',
  ];

  static const List<String> occupations = [
    '--Select--',
    'Advocate',
    'Business',
    'Doctor',
    'Farmer',
    'Others',
    'Student',
  ];

  static const List<String> department = [
    '--Select--',
    'Anaesthesia',
    'Apex Trauma Center',
    'Cardiology',
    'Cardiovascular and Thora Surg',
    'Endocrine Surgery',
    'Endocrinology',
    'Gastroenterology',
    'General Hospital',
    'Hematology',
    'Immunology',
    'Maternal And Reproductive Health',
    'Medical Genetics',
    'Microbiology',
    'Neonatology',
    'Nephrology',
    'Neurology',
    'Neurosurgery',
    'Nuclear Medicine',
    'Ophthalmology',
    'Paediatric Gastroenterology',
    'Paediatric Surgery',
  ];

  static const List<String> prefix = [
    '--Select--',
    'Dr',
    'Mr',
    'Mrs',
    'Miss',
    'Prof',
  ];

  static const List<String> maritalStatus = [
    '--Select--',
    'Married',
    'Un-Marreid',
    'Single',
    'Divorced',
  ];

  static const List<String> ageUnits = [
    '--Select--',
    'Years',
    'Months',
    'Days',
  ];

  static const List<String> religion = [
    '--Select--',
    'Christian',
    'Hindu',
    'Muslim',
    'Other',
  ];

  static const List<String> sex = ['--Select--', 'Male', 'Female', 'Other'];

  static const List<String> countries = ['--Select--', 'India', 'USA', 'UK'];

  static const List<String> states = [
    '--Select--',
    'Tamil Nadu',
    'Maharashtra',
    'Delhi',
  ];

  static const List<String> cities = [
    '--Select--',

    'Chennai',
    'Mumbai',
    'New Delhi',
  ];

  static const List<String> identity = [
    '--Select--',

    'Aadhar Card',
    'PAN Card',
    'Voter Card',
  ];

  static String password = 'Asgar@123';
  static String otp = '';

  static const List<String> countries1 = ['--Select--', 'India', 'USA', 'UK'];

  // Map: Country -> States
  static const Map<String, List<String>> statesByCountry1 = {
    'India': ['--Select--', 'Tamil Nadu', 'Maharashtra', 'Delhi'],
    'USA': ['--Select--', 'California', 'Texas', 'New York'],
    'UK': ['--Select--', 'England', 'Scotland', 'Wales'],
  };

  // Map: State -> Cities
  static const Map<String, List<String>> citiesByState1 = {
    'Tamil Nadu': ['--Select--', 'Chennai', 'Coimbatore', 'Madurai'],
    'Maharashtra': ['--Select--', 'Mumbai', 'Pune', 'Nagpur'],
    'Delhi': ['--Select--', 'New Delhi', 'Dwarka'],
    'California': ['--Select--', 'Los Angeles', 'San Francisco'],
    'Texas': ['--Select--', 'Houston', 'Dallas'],
    'New York': ['--Select--', 'New York City', 'Buffalo'],
    'England': ['--Select--', 'London', 'Manchester'],
    'Scotland': ['--Select--', 'Edinburgh', 'Glasgow'],
    'Wales': ['--Select--', 'Cardiff', 'Swansea'],
  };

  static const Map<String, dynamic> dummyProfile = {
    'name': 'Ram Sharma',
    'age': 34,
    'sex': 'Male',
    'crn': '2025000653',
  };
}

Future<void> showOtpNotification(String otp) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'otp_channel_id', // Must match when creating channel
    'OTP Notifications',
    channelDescription: 'This channel is for OTP messages',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
    ticker: 'OTP Notification',
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'Your OTP Code',
    '🔐 OTP is: $otp',
    notificationDetails,
  );
}

//

Future<void> requestNotificationPermission() async {
  var status = await Permission.notification.status;
  if (!status.isGranted) {
    await Permission.notification.request();
  }
}

// Global OTP Generator Function
String generateOtp() {
  var rnd = Random();
  var next = rnd.nextDouble() * 10000;
  while (next < 1000) {
    next *= 10;
  }
  return next.toInt().toString(); // 4 digit OTP banayega
}

// Global Resend Method
Future<void> sendOTP() async {
  // 1. Naya OTP generate karein
  String nayaOtp = generateOtp();

  // 2. Global variable me set karein taaki baad me match kar sakein
  DummyData.otp = nayaOtp;

  // 3. (Optional) Agar secure storage me rakhna h toh yaha code daal dein
  // await _storage.write(key: 'otp', value: nayaOtp);

  // 4. Notification bhejein
  await requestNotificationPermission();
  await showOtpNotification(nayaOtp);
}

void clearOtp() {
  DummyData.otp = '';
}
