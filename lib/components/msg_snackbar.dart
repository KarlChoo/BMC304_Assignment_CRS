import 'package:flutter/material.dart';

class MessageSnackbar extends StatelessWidget {
  final String message;
  final int duration;
  final Color fontColor;
  final Color background;
  final bool hasAction;
  final String actionText;

  const MessageSnackbar({
    this.message,
    this.background,
    this.fontColor = Colors.black,
    this.duration = 2,
    this.hasAction = false,
    this.actionText = "Cancel",
  });

  const MessageSnackbar.successMsg({
    this.message,
    this.duration = 2,
    this.fontColor = Colors.white,
    this.background = Colors.green,
    this.hasAction = false,
    this.actionText = "Cancel",
  });

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: fontColor
        ),
      ),
      backgroundColor: background,
      duration: Duration(seconds: duration),
      action: hasAction ? SnackBarAction(
        label: actionText,
        onPressed: () {  },
      ) : null,
      behavior: SnackBarBehavior.fixed,
    );
  }

}

