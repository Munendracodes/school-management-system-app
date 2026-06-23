class AttendanceStudent {

  final String name;

  final String rollNo;

  final String parentMobile;

  final bool fnPresent;

  final bool anPresent;

  bool notificationSent;

  AttendanceStudent({

    required this.name,

    required this.rollNo,

    required this.parentMobile,

    required this.fnPresent,

    required this.anPresent,

    this.notificationSent =
    false,
  });
}