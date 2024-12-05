import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/habit.dart';
import 'package:habbitable/widgets/habitcard.dart';

Widget defaultColors(Function(Color) onColorSelected, BuildContext context,
    {List<Color>? colors, Habit? habit}) {
  if (colors == null || colors.isEmpty) {
    //default colors
    colors = [
      Get.theme.colorScheme.primary,
      Get.theme.colorScheme.secondary,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.red,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.cyan,
    ];
  }
  //set all colors to opacity 0.5
  colors = colors.map((color) => color.withOpacity(0.7)).toList();

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(
        colors.length,
        (index) => GestureDetector(
          onTap: () => onColorSelected(colors![index]),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: colors![index],
              border: habit != null
                  ? habit.color.value == colors[index].value
                      ? Border.all(
                          color: Get.theme.colorScheme.onSurface,
                          width: 2,
                        )
                      : Border.all(
                          color: Colors.transparent,
                        )
                  : Border.all(color: Colors.transparent),
            ),
          ),
        ),
      )..add(
          GestureDetector(
            onTap: () {
              Get.dialog(
                barrierColor: Get.theme.colorScheme.surface,
                ColorPickerPage(
                  onColorSelected: onColorSelected,
                  habit: habit,
                ),
                transitionCurve: Curves.easeInOutCirc,
                transitionDuration: Duration(milliseconds: 600),
              );
            },
            child: CircleAvatar(
              backgroundColor: Get.theme.cardColor,
              child: Icon(
                Icons.edit,
                size: 18,
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
        ),
    ),
  );
}

//show dialog box for color picker
// ignore: must_be_immutable
class ColorPickerPage extends StatefulWidget {
  final Function(Color) onColorSelected;
  final Habit? habit;

  const ColorPickerPage({
    super.key,
    required this.onColorSelected,
    this.habit,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  Habit? _habit;

  @override
  void initState() {
    super.initState();
    _habit = widget.habit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton.icon(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back),
          label: Text('Back'),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        leadingWidth: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Hero(
              tag: 'habit_card_creation',
              child: HabbitCard(
                habit: _habit!,
                onCompleted: (bool isCompleted) {},
                disabled: true,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: _habit?.color ?? Colors.grey,
                  enableAlpha: false,
                  portraitOnly: true,
                  pickerAreaHeightPercent: 0.7,
                  pickerAreaBorderRadius: BorderRadius.circular(6),
                  hexInputBar: false,
                  paletteType: PaletteType.hsvWithHue,
                  labelTypes: [],
                  displayThumbColor: false,
                  onColorChanged: (color) {
                    setState(() {
                      _habit = Habit.copyWith(_habit!, {
                        'color': color.value.toRadixString(16),
                      });
                      widget.onColorSelected(color);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
