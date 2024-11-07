import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/input.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    ageController.text =
        widget.user.age == null ? '' : widget.user.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: Get.textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: InitialsImagePlaceholder(
                    name: widget.user.name,
                    radius: 50,
                  ),
                ),
                Center(
                  child: MainButton(
                    label: 'Change Icon',
                    onPressed: () {},
                    style: 'secondary',
                  ),
                ),
                const SizedBox(height: 10),
                buildInput(
                  context: context,
                  label: 'Name',
                  hint: 'Enter your name',
                  controller: nameController,
                ),
                const SizedBox(height: 10),
                buildInput(
                  context: context,
                  label: 'Age',
                  hint: 'Enter your age',
                  controller: ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    }
                    if (int.tryParse(value) == null) {
                      return 'Age must be a number';
                    }
                    if (int.parse(value) < 18) {
                      return 'You must be at least 18 years old';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: Get.width,
                  child: MainButton(
                    label: 'Save',
                    icon: Icons.save_outlined,
                    isLoading: isLoading,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      if (formKey.currentState!.validate()) {
                        await Future.delayed(const Duration(seconds: 2));
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    style: 'primary',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
