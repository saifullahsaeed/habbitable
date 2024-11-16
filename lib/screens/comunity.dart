import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/widgets/mainappbar.dart';

class ComunityScreen extends StatelessWidget {
  const ComunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Community",
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('/searchuser');
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
