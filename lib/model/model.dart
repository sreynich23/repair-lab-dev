import 'package:get/get.dart';

class LabRequestController extends GetxController {
  final List<LabRequest> labRequests = <LabRequest>[].obs;

  void addLabRequest(LabRequest labRequest) {
    labRequests.add(labRequest);
  }

  void removeLabRequest(String labId) {
    labRequests.removeWhere((lab) => lab.labs == labId);
  }
}

class LabRequest {
  String fullName;
  String generation;
  String phoneNumber;
  String purpose;
  String gender;
  String year;
  String labs;
  String major;
  DateTime startDate;
  DateTime endDate;

  LabRequest({
    required this.fullName,
    required this.generation,
    required this.phoneNumber,
    required this.purpose,
    required this.gender,
    required this.year,
    required this.labs,
    required this.major,
    required this.startDate,
    required this.endDate,
  });
}
