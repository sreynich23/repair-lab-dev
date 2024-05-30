import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:repairing_lap_app/views/subpages/manage_profile.dart';
import 'package:repairing_lap_app/views/subpages/permission.dart';
import '../components/category_button.dart';
import '../components/notificatino_bell.dart';
import '../data/data.dart';
import '../model/model.dart';
import 'subpages/lab_request.dart';
import 'subpages/repair_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final MyData data = Get.find<MyData>();
  final LabRequestController labRequestController =
      Get.put(LabRequestController());

  Widget buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Categories",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  title: "Repair",
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
                  title: "Request Labs",
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
                  title: "Permission",
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
        const Text(
          "Labs Status",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            context,
            MaterialPageRoute(
              builder: (context) => const LabRequestView(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Lab $labName'),
                content: Text('Taken by $takenBy\nDuration usage: $duration'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ],
              );
            },
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
                isAvailable ? 'Available' : 'Not Available',
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
      {'name': 'Lab 010', 'available': true, 'takenBy': null, 'duration': null},
      {'name': 'Lab 011', 'available': true, 'takenBy': null, 'duration': null},
      {
        'name': '013',
        'available': false,
        'takenBy': 'John Doe',
        'duration': '2024-05-01 - 2024-05-30'
      },
      {'name': 'Lab 014', 'available': true, 'takenBy': null, 'duration': null},
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
                      'Profile',
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


