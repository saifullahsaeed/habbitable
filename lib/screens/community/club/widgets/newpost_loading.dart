import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewPostLoading extends StatelessWidget {
  const NewPostLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        CupertinoActivityIndicator(
          color: Get.theme.colorScheme.primary,
        ),
      ],
    );
  }
}
