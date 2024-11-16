import 'package:flutter/material.dart';
import 'package:habbitable/widgets/button.dart';

class ActionButtons extends StatelessWidget {
  final bool isMyProfile;
  final bool requestSent;
  final bool requestReceived;
  final bool isFriend;

  // Add callback handlers
  final VoidCallback? onEditProfile;
  final VoidCallback? onSendRequest;
  final VoidCallback? onAcceptRequest;
  final VoidCallback? onRejectRequest;
  final VoidCallback? onCancelRequest;

  const ActionButtons({
    super.key,
    required this.isMyProfile,
    required this.requestSent,
    required this.requestReceived,
    required this.isFriend,
    this.onEditProfile,
    this.onSendRequest,
    this.onAcceptRequest,
    this.onRejectRequest,
    this.onCancelRequest,
  });

  Widget _buildEditProfileButton() {
    return MainButton(
      onPressed: onEditProfile ?? () {},
      label: 'Edit Profile',
      icon: Icons.edit,
    );
  }

  Widget _buildRequestSentButton() {
    return MainButton(
      onPressed: onCancelRequest ?? () {},
      label: 'Request Sent',
      icon: Icons.check,
      disabled: onCancelRequest == null,
    );
  }

  Widget _buildRequestReceivedButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MainButton(
          onPressed: onAcceptRequest ?? () {},
          label: 'Accept Request',
          icon: Icons.check,
        ),
        const SizedBox(width: 10),
        OutlinedButtonCustom(
          onPressed: onRejectRequest ?? () {},
          label: 'Reject Request',
        ),
      ],
    );
  }

  Widget _buildSendRequestButton() {
    return MainButton(
      onPressed: onSendRequest ?? () {},
      label: 'Send Request',
      icon: Icons.person_add,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Handle each case with early returns for better readability
    if (isMyProfile) {
      return _buildEditProfileButton();
    }

    if (isFriend) {
      return const SizedBox.shrink();
    }

    if (requestSent) {
      return _buildRequestSentButton();
    }

    if (requestReceived) {
      return _buildRequestReceivedButtons();
    }

    return _buildSendRequestButton();
  }
}
