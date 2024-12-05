import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  final Future Function() action;
  final Widget child;

  const Loader({super.key, required this.action, required this.child});
  @override
  // ignore: library_private_types_in_public_api
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  bool isLoading = false;

  void _performAction() async {
    setState(() {
      isLoading = true;
    });

    try {
      await widget.action();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _performAction, // Call the action when child is tapped
          child: widget.child, // Your main content (button or widget)
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
