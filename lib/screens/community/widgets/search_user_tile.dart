import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habbitable/models/user.dart';
import 'package:habbitable/widgets/intials_image_placeholder.dart';
import 'package:shimmer/shimmer.dart';

class SearchUserTile extends StatefulWidget {
  final User user;
  final Function(User) onRequest;
  const SearchUserTile(
      {super.key, required this.user, required this.onRequest});

  @override
  State<SearchUserTile> createState() => _SearchUserTileState();
}

class _SearchUserTileState extends State<SearchUserTile> {
  bool isLoading = false;
  bool isRequested = false;
  bool isFriend = false;
  @override
  void initState() {
    super.initState();
    isRequested = widget.user.sentRequest ?? false;
    isFriend = widget.user.friend ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.user.avatar != null
          ? CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                widget.user.avatar!.url,
              ),
            )
          : InitialsImagePlaceholder(name: widget.user.name),
      title: Text(widget.user.name),
      trailing: !isLoading
          ? !isRequested
              ? !isFriend
                  ? TextButton.icon(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final response = await widget.onRequest(widget.user);
                        if (response == 201) {
                          setState(() {
                            isRequested = true;
                          });
                        } else {
                          Get.snackbar(
                              "Error", "Failed to send friend request");
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      icon: const Icon(Icons.person_add),
                      label: const Text("Request"),
                    )
                  : null
              : TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.check),
                  label: const Text("Requested"),
                )
          : Shimmer.fromColors(
              baseColor: Get.theme.colorScheme.onSurface.withOpacity(0.1),
              highlightColor: Get.theme.colorScheme.onSurface.withOpacity(0.3),
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Text(
                      "Sending...",
                      style: Get.theme.textTheme.bodySmall,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
