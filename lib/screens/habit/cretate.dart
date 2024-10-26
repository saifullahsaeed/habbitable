import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:habbitable/widgets/input.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({super.key});

  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  final TextEditingController _nameController = TextEditingController();
  IconPickerIcon? _selectedIcon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Habit',
          style: Get.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                //icon picker
                IconButton(
                  onPressed: () async {
                    await showIconPicker(
                      context,
                      configuration: SinglePickerConfiguration(
                        preSelected: _selectedIcon,
                        adaptiveDialog: false,
                        showTooltips: true,
                        showSearchBar: true,
                        iconPickerShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        searchIcon: const Icon(Icons.search),
                        iconPackModes: [IconPack.material],
                        searchComparator: (String search,
                                IconPickerIcon icon) =>
                            search.toLowerCase().contains(
                                icon.name.replaceAll('_', ' ').toLowerCase()) ||
                            icon.name
                                .toLowerCase()
                                .contains(search.toLowerCase()),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
                Expanded(
                  child: buildInput(
                    label: 'Name',
                    hint: 'Enter habit name',
                    controller: _nameController,
                    context: context,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
