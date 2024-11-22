import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/Services/authentication.dart';
import 'package:habbitable/controllers/home_controller.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/utils/functions.dart';
import 'package:habbitable/utils/iconpicker.dart';
import 'package:habbitable/widgets/button.dart';
import 'package:habbitable/widgets/dawselector.dart';
import 'package:habbitable/widgets/defaultcolors.dart';
import 'package:habbitable/widgets/habitcard.dart';
import 'package:habbitable/widgets/input.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({super.key});

  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  late Habit _habit;
  final TextEditingController _nameController = TextEditingController(
    text: 'Habit Name',
  );
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _timeController = TextEditingController(
    text: '15',
  );
  String _rate = 'daily';
  IconData _selectedIcon = Icons.star_border_outlined;
  bool _setGoal = false;
  bool _isPublic = false;
  final List<String> _customDays = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeHabit();
  }

  void _initializeHabit() {
    _habit = Habit(
      id: 0,
      name: _nameController.text,
      streak: 9,
      goal: 0,
      time: int.parse(_timeController.text),
      icon: _selectedIcon,
      iconFontFamily: _selectedIcon.fontFamily ?? 'MaterialIcons',
      color: Get.theme.colorScheme.primary,
      frequency: _rate,
      owner: Get.find<GlobalAuthenticationService>().currentUser,
      users: [],
      nextDue:
          DateTime.now().add(Duration(days: 1)).copyWith(hour: 10, minute: 0),
      reminderTime: TimeOfDay(hour: 10, minute: 0),
      customDays: _customDays,
      isPublic: _isPublic,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  void _updateHabit(Map<String, dynamic> updates) {
    setState(() {
      _habit = Habit.copyWith(_habit, updates);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Create Habit',
          style: Get.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'habit_card_creation',
                  child: HabbitCard(
                    habit: _habit,
                    onCompleted: (bool isCompleted) {},
                    disabled: true,
                  ),
                ),
                const SizedBox(height: 10),
                _buildColorPicker(),
                const SizedBox(height: 10),
                _buildIconAndNameInput(),
                const SizedBox(height: 10),
                _buildHabitDetails(),
                const SizedBox(height: 10),
                _buildReminder(),
                const SizedBox(height: 10),
                _buildTimeInput(),
                const SizedBox(height: 10),
                _buildRateDropdown(),
                const SizedBox(height: 10),
                if (_rate == 'custom')
                  DaysOfWeekSelector(
                    selectedDays: _customDays,
                    onChanged: (value) {
                      if (_customDays.contains(value)) {
                        setState(() {
                          _customDays.remove(value);
                          _updateHabit({'customDays': _customDays});
                        });
                      } else {
                        setState(() {
                          _customDays.add(value);
                          _updateHabit({'customDays': _customDays});
                        });
                      }
                    },
                  ),
                if (_rate == 'weekly')
                  DaysOfWeekSelector(
                    selectedDays: _customDays,
                    onChanged: (value) {
                      if (_customDays.contains(value)) {
                        setState(() {
                          _customDays.clear();
                          _customDays.add(value);
                          _updateHabit({'customDays': _customDays});
                        });
                      } else {
                        setState(() {
                          _customDays.clear();
                          _customDays.add(value);
                          _updateHabit({'customDays': _customDays});
                        });
                      }
                    },
                  ),
                if (_rate == 'biweekly')
                  DaysOfWeekSelector(
                    selectedDays: _customDays,
                    onChanged: (value) {
                      if (_customDays.contains(value)) {
                        setState(() {
                          _customDays.remove(value);
                          _updateHabit({'customDays': _customDays});
                        });
                      } else {
                        setState(() {
                          if (_customDays.length < 2) {
                            _customDays.add(value);
                            _updateHabit({'customDays': _customDays});
                          } else {
                            _customDays.removeAt(0);
                            _customDays.add(value);
                            _updateHabit({'customDays': _customDays});
                          }
                        });
                      }
                    },
                  ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _setGoal,
                      activeColor: Get.theme.colorScheme.primary,
                      onChanged: (bool? value) {
                        setState(() {
                          _setGoal = value!;
                        });
                      },
                    ),
                    Text('Set a goal'),
                  ],
                ),
                const SizedBox(height: 10),
                if (_setGoal)
                  buildInput(
                    label: 'Goal',
                    hint: '5 ${getTypofromRate(_rate)}',
                    inputType: TextInputType.number,
                    context: context,
                    controller: _goalController,
                  ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: _isPublic,
                      activeColor: Get.theme.colorScheme.primary,
                      onChanged: (bool? value) {
                        setState(() {
                          _isPublic = value!;
                          _updateHabit({'isPublic': value});
                        });
                      },
                    ),
                    Text('Public'),
                  ],
                ),
                Text(
                  'NOTE: Public habits are visible to all users on your profile and can be joined by anyone from the community.',
                  style: Get.theme.textTheme.bodySmall!.copyWith(
                    color: Get.theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w200,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: Get.width,
                  child: MainButton(
                    label: 'Create Habit',
                    icon: Icons.add,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        HomeController homeController =
                            Get.find<HomeController>();
                        homeController.createHabit(_habit);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildColorPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: Get.theme.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        defaultColors(
          habit: _habit,
          (Color value) =>
              _updateHabit({'color': value.value.toRadixString(16)}),
          context,
        ),
      ],
    );
  }

  Widget _buildIconAndNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icon & Name',
          style: Get.theme.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Get.theme.cardColor,
              ),
              child: IconButton(
                onPressed: () async {
                  await showIconPickerCustom(
                    context,
                    (IconData icon, String? fontFamily) {
                      _updateHabit({
                        'icon': icon.codePoint,
                        'iconFontFamily': fontFamily ?? 'MaterialIcons',
                      });
                      setState(() => _selectedIcon = icon);
                    },
                  );
                },
                icon: Icon(_selectedIcon),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: buildInput(
                label: 'Habit Name',
                hint: 'Enter habit name',
                controller: _nameController,
                maxLength: 30,
                onChanged: (value) => _updateHabit({'name': value}),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Name is required' : null,
                context: context,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHabitDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Habit Details',
          style: Get.theme.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        buildInput(
          label: 'Description',
          hint: 'What is this habit about?',
          maxLines: 3,
          controller: _descriptionController,
          context: context,
        ),
      ],
    );
  }

  Widget _buildReminder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reminder',
          style: Get.theme.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        showTimePickerField(
          context,
          timeOfDayToString(
            _habit.reminderTime,
          ),
          (TimeOfDay value) =>
              _updateHabit({'reminderTime': timeOfDayToString(value)}),
        ),
      ],
    );
  }

  Widget _buildTimeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        buildInput(
          label: 'Time',
          hint: 'Enter time',
          controller: _timeController,
          context: context,
          suffixIcon: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Minutes',
              style: Get.theme.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          validator: (value) => value?.isEmpty ?? true
              ? 'Time is required'
              : value?.isEmpty ?? true
                  ? 'Time must be greater than 0'
                  : null,
        ),
      ],
    );
  }

  Widget _buildRateDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate',
          style: Get.theme.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        buildDropdown(
          label: 'Rate',
          hint: 'Enter rate',
          context: context,
          items: ['daily', 'weekly', 'biweekly', 'monthly', 'custom'],
          value: _rate,
          onChanged: (value) => setState(() {
            _rate = value!;
            _updateHabit({'frequency': value});
          }),
        ),
      ],
    );
  }

  String getTypofromRate(String rate) {
    switch (rate) {
      case 'daily':
        return 'days';
      case 'weekly':
        return 'weeks';
      case 'biweekly':
        return 'weeks';
      case 'monthly':
        return 'months';
      default:
        return 'days';
    }
  }
}
