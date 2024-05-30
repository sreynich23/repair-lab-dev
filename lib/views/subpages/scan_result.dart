import 'package:flutter/material.dart';

import '../../components/button.dart';
import '../../main.dart';

class ResultScannerView extends StatelessWidget {
  final String result;
  const ResultScannerView({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result Scanner",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[500]),
        ),
        backgroundColor: Colors.grey[100],
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        offset: const Offset(0, 0))
                  ]),
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Button(
                buttonText: 'Done',
                backgroundColor: Colors.blue[100],
                textColor: Colors.blue[500],
                func: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
