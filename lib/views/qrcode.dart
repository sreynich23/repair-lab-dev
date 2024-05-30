import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../components/notificatino_bell.dart';
import 'subpages/manage_profile.dart';

class ScanQRCodeView extends StatefulWidget {
  const ScanQRCodeView({Key? key}) : super(key: key);

  @override
  State<ScanQRCodeView> createState() => _ScanQRCodeViewState();
}

class _ScanQRCodeViewState extends State<ScanQRCodeView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? qrText;
  bool cameraPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    setState(() {
      cameraPermissionGranted = status.isGranted;
    });
  }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
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
                  builder: (context) => const ManageProfileView(),
                ),
              );
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text("Align frame with QR Code"),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 1,
                                spreadRadius: 2,
                                offset: const Offset(0, 0),
                              )
                            ]),
                        child: IconButton(
                            onPressed: () {}, icon: Icon(Icons.flashlight_on)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Flashlight")
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 0),
                                )
                              ]),
                          child: IconButton(
                              onPressed: () {}, icon: Icon(Icons.qr_code))),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Select QR")
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
