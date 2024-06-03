import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../components/notificatino_bell.dart';
import 'subpages/manage_profile.dart';
import 'subpages/scan_result.dart';

class ScanQRCodeView extends StatefulWidget {
  const ScanQRCodeView({super.key});

  @override
  State<ScanQRCodeView> createState() => _ScanQRCodeViewState();
}

class _ScanQRCodeViewState extends State<ScanQRCodeView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final MobileScannerController cameraController = MobileScannerController();
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
    cameraController.dispose();
    super.dispose();
  }

  void _onQRViewCreated(BarcodeCapture capture) {
    final String code = capture.barcodes.first.rawValue ?? 'Unknown';
    Get.to(() => ResultScannerView(result: code));
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
                      'homeView.profile'.tr,
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
        child: cameraPermissionGranted
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('scanQRCodeView.scanTitle'.tr),
                  const SizedBox(
                    height: 15,
                  ),
                  // Scan through the camera
                  Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: MobileScanner(
                      key: qrKey,
                      controller: cameraController,
                      onDetect: _onQRViewCreated,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Open the flashlight
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
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                cameraController.toggleTorch();
                              },
                              icon: const Icon(Icons.flashlight_on),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text("scanQRCodeView.scanFlashlight".tr)
                        ],
                      ),
                    ],
                  )
                ],
              )
            : const Text("Camera permission denied"),
      ),
    );
  }
}
