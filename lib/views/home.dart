import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:repairing_lap_app/components/button.dart';
import 'package:repairing_lap_app/views/subpages/manage_profile.dart';
import 'package:repairing_lap_app/views/subpages/permission.dart';
import '../components/category_button.dart';
import '../components/notificatino_bell.dart';
import 'subpages/lab_request.dart';
import 'subpages/repair_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Widget buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "homeView.categoryTitle".tr,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                CategoryButton(
                  image: Image.asset(
                    "assets/icons/repair.png",
                    width: 70,
                  ),
                  title: "homeView.categoryService".tr,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RepairServiceView(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 15),
                CategoryButton(
                  image: Image.asset(
                    "assets/icons/computer.png",
                    width: 70,
                  ),
                  title: "homeView.categoryReqLab".tr,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LabRequestView(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 15),
                CategoryButton(
                  image: Image.asset(
                    "assets/icons/permission.png",
                    width: 70,
                  ),
                  title: "homeView.categoryPermissions".tr,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PermissionView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          "homeView.labStatusTitle".tr,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildLabCard(
      String labName, bool isAvailable, String? takenBy, String? duration) {
    return InkWell(
      onTap: () {
        if (isAvailable) {
          Navigator.push(
            Get.context!, 
            MaterialPageRoute(
              builder: (context) => const LabRequestView(),
            ),
          );
        } else {
          Get.bottomSheet(
            Container(
              height: 180,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lab $labName',
                      style: const TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${'homeView.labTakenBy'.tr} $takenBy',
                      style: const TextStyle(fontSize: 17),
                    ),
                    Text(
                      '${'homeView.durationUse'.tr} $duration',
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
      child: Card(
        color: isAvailable ? Colors.white : Colors.grey[300],
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labName,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              Text(
                isAvailable
                    ? "homeView.labStatusAvailable".tr
                    : "homeView.labStatusUnavailable".tr,
                style: TextStyle(
                  fontSize: 16,
                  color: isAvailable ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabsSection() {
    final labs = [
      {'name': '010', 'available': true, 'takenBy': null, 'duration': null},
      {'name': '011', 'available': true, 'takenBy': null, 'duration': null},
      {
        'name': '013',
        'available': false,
        'takenBy': 'John Doe',
        'duration': '2024-05-01 - 2024-05-30'
      },
      {'name': '014', 'available': true, 'takenBy': null, 'duration': null},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: labs.map((lab) {
        return buildLabCard(
          lab['name'] as String,
          lab['available'] as bool,
          lab['takenBy'] as String?,
          lab['duration'] as String?,
        );
      }).toList(),
    );
  }

  // AppBar + Body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ManageProfileView()));
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sok Sreypich',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "homeView.profile".tr,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: const [NotificationBell(notificationCount: 1)],
        leading: Container(
          padding: const EdgeInsets.only(left: 20),
          width: 40,
          child: const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/profile.webp'),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCategorySection(),
              const SizedBox(height: 15),
              buildLabsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
