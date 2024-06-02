import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/category_button.dart';
import '../../data/languages.dart';

class RepairServiceView extends StatelessWidget {
  const RepairServiceView({super.key});

  void _showBottomSheet(
      BuildContext context, Widget image, String title, String content) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                image,
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryRow(String titleKey, List<Map<String, dynamic>> buttons,
      BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleKey.tr, // Access translations using .tr extension
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: buttons
                  .map((buttonData) => Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(
                              context,
                              buttonData['image'],
                              buttonData['titleKey'],
                              buttonData['contentKey'],
                            );
                          },
                          child: CategoryButton(
                            image: buttonData['image'],
                            title: buttonData['titleKey'],
                            onPressed: () {
                              _showBottomSheet(
                                context,
                                buttonData['image'],
                                buttonData['titleKey'],
                                buttonData['contentKey'],
                              );
                            },
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(Languages()); // Put Languages class into GetX's memory
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'homeView.categoryService'
              .tr, // Access translations using .tr extension
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[500]),
        ),
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCategoryRow(
                "service.repair".tr,
                [
                  {
                    'image': Image.asset("assets/images/computer-repair.png",
                        width: 50),
                    'titleKey': "service.hardware".tr,
                    'contentKey': "service.hardwareTxt".tr
                  },
                  {
                    'image':
                        Image.asset("assets/images/testing.png", width: 50),
                    'titleKey': "service.software".tr,
                    'contentKey': "service.softwareTxt".tr
                  },
                  {
                    'image':
                        Image.asset("assets/images/printer.png", width: 50),
                    'titleKey': "service.printer".tr,
                    'contentKey': "service.printerTxt".tr
                  },
                ],
                context,
              ),
              buildCategoryRow(
                "service.mediaProduction".tr,
                [
                  {
                    'image': Image.asset("assets/images/assets.png", width: 50),
                    'titleKey': "service.videosCreation".tr,
                    'contentKey': "service.videosCreationTxt".tr
                  },
                ],
                context,
              ),
              const SizedBox(height: 20),
              buildCategoryRow(
                "service.programming".tr,
                [
                  {
                    'image': Image.asset("assets/images/coding-language.png",
                        width: 50),
                    'titleKey': "service.webDev".tr,
                    'contentKey': "service.webDevTxt".tr
                  },
                ],
                context,
              ),
              const SizedBox(height: 20),
              buildCategoryRow(
                "service.graphicDesign".tr,
                [
                  {
                    'image': Image.asset("assets/images/design-thinking.png",
                        width: 50),
                    'titleKey': "service.designing".tr,
                    'contentKey': "service.designingTxt".tr
                  },
                ],
                context,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const url = 'https://t.me/repairinglab017';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        child: const FaIcon(
          FontAwesomeIcons.telegram,
          color: Colors.blue,
        ),
      ),
    );
  }
}
