import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final String style;
  // ignore: prefer_typing_uninitialized_variables
  final iconSide;
  const MainButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.style = 'primary',
    this.iconSide = 'start',
  });

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: Text(widget.label),
      icon: Icon(widget.icon),
      iconAlignment:
          widget.iconSide == 'start' ? IconAlignment.start : IconAlignment.end,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.style == 'primary'
            ? Get.theme.colorScheme.primary
            : Get.theme.colorScheme.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
      onPressed: widget.onPressed,
    );
  }
}

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: const Text('Continue with Google'),
      icon: Image.asset(
        'assets/images/google_icon.png',
        width: 24,
        height: 24,
      ),
      iconAlignment: IconAlignment.start,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        iconColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          side: BorderSide(color: Colors.black, width: 0.3),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class AppleButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AppleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: const Text('Continue with Apple'),
      icon: const Icon(Icons.apple_rounded),
      iconAlignment: IconAlignment.start,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        iconColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class TextButtonCustom extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final String style;
  const TextButtonCustom({
    super.key,
    required this.label,
    required this.onPressed,
    this.style = 'primary',
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: style == 'primary'
              ? Get.theme.colorScheme.primary
              : Get.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
