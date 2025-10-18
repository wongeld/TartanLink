import 'package:flutter/foundation.dart';

enum UserRole { student, realtor, landlord }

class UserProfile {
  String id;
  String name;
  String email;
  UserRole role;
  Map<String, dynamic> studentAnswers;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    Map<String, dynamic>? studentAnswers,
  }) : studentAnswers = studentAnswers ?? {};
}
