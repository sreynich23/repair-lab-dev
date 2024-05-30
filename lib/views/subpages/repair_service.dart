// ignore_for_file: deprecated_member_use
// ignore: unnecessary_import

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/category_button.dart';

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
                fontSize: 15,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryRow(
      String title, List<Map<String, dynamic>> buttons, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
                              buttonData['title'],
                              buttonData['content'],
                            );
                          },
                          child: CategoryButton(
                            image: buttonData['image'],
                            title: buttonData['title'],
                            onPressed: () {
                              _showBottomSheet(
                                context,
                                buttonData['image'],
                                buttonData['title'],
                                buttonData['content'],
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Repair Service',
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
                "Hardware",
                [
                  {
                    'image': Image.asset("assets/images/computer-repair.png",
                        width: 50),
                    'title': "PC Repair",
                    'content':
                        "We offer comprehensive PC repair services, including hardware diagnostics, replacements, and upgrades."
                  },
                  {
                    'image':
                        Image.asset("assets/images/system-unit.png", width: 50),
                    'title': "System Unit Repair",
                    'content':
                        "Our system unit repair services cover all aspects, from power supply issues to motherboard replacements."
                  },
                  {
                    'image':
                        Image.asset("assets/images/printer.png", width: 50),
                    'title': "Printer Installing",
                    'content':
                        "We provide professional printer installation services to ensure your printer is set up and running smoothly."
                  },
                ],
                context,
              ),
              buildCategoryRow(
                "Software",
                [
                  {
                    'image':
                        Image.asset("assets/images/testing.png", width: 50),
                    'title': "Licence / Crack",
                    'content':
                        "We assist with software licensing and installation of crack versions for testing and educational purposes."
                  },
                  {
                    'image': Image.asset("assets/images/office.png", width: 50),
                    'title': "Microsoft Office",
                    'content':
                        "Our services include installation and troubleshooting of Microsoft Office applications."
                  },
                  {
                    'image':
                        Image.asset("assets/images/engineer.png", width: 50),
                    'title': "Architecture / CE",
                    'content':
                        "We provide software solutions for architecture and civil engineering, including AutoCAD and other industry-standard tools."
                  },
                  {
                    'image':
                        Image.asset("assets/images/planting.png", width: 50),
                    'title': "Agriculture",
                    'content':
                        "We offer agricultural software solutions to help manage and optimize farming activities."
                  },
                  {
                    'image': Image.asset("assets/images/assets.png", width: 50),
                    'title': "Multimedia",
                    'content':
                        "Our multimedia services include installation and troubleshooting of software for video editing, graphic design, and more."
                  },
                ],
                context,
              ),
              const SizedBox(height: 20),
              buildCategoryRow(
                "Components",
                [
                  {
                    'image': Image.asset("assets/images/hard-disk-drive.png",
                        width: 50),
                    'title': "PC Components",
                    'content':
                        "We offer a range of PC components, including hard drives, RAM, graphics cards, and more, with installation services."
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
