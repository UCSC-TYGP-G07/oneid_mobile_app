import 'package:flutter/material.dart';
import 'package:oneid_mobile_app/util/constants.dart' as constants;

class SnackBarService {
  final BuildContext context;

  static const Duration defaultDuration = Duration(seconds: 4);

  static const Color defaultTextColor = Colors.white;
  static const Color defaultIconColor = Colors.white;
  static const Color successBackgroundColor = Color(0xFF2E7D32);
  static const Color warningBackgroundColor = Color(0xFFEF6C00);
  static const Color errorBackgroundColor = Color(0xFFC62828);
  static const Color noInternetBackgroundColor = Color(0xFF424242);

  static const IconData successIcon = Icons.check_circle_outline_rounded;
  static const IconData warningIcon = Icons.warning_amber_rounded;
  static const IconData errorIcon = Icons.error_outline_rounded;
  static const IconData noInternetIcon =
      Icons.signal_cellular_connected_no_internet_4_bar_rounded;

  const SnackBarService(this.context);

  void showSuccessMessage({
    String content = constants.successMessage,
    Duration duration = defaultDuration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(successIcon, color: defaultIconColor),
            const SizedBox(
              width: 8,
            ),
            Flexible(
                child: Text(
              content,
              style: const TextStyle(color: defaultTextColor),
            )),
          ],
        ),
        backgroundColor: successBackgroundColor,
        duration: duration,
      ),
    );
  }

  void showWarningMessage({
    String content = constants.warningMessage,
    Duration duration = defaultDuration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(warningIcon, color: defaultIconColor),
            const SizedBox(
              width: 8,
            ),
            Flexible(
                child: Text(
              content,
              style: const TextStyle(color: defaultTextColor),
            )),
          ],
        ),
        backgroundColor: warningBackgroundColor,
        duration: duration,
      ),
    );
  }

  void showErrorMessage({
    String content = constants.errorMessage,
    Duration duration = defaultDuration,
  }) {
    Future.delayed(
        const Duration(milliseconds: 500),
        () => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(errorIcon, color: defaultIconColor),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                          child: Text(
                        content,
                        style: const TextStyle(color: defaultTextColor),
                      )),
                    ],
                  ),
                  backgroundColor: errorBackgroundColor,
                  duration: duration,
                ),
              )
            });
  }

  void showNoInternetMessage({
    String content = constants.noInternetMessage,
    Duration duration = defaultDuration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(noInternetIcon, color: defaultIconColor),
            const SizedBox(
              width: 8,
            ),
            Flexible(
                child: Text(
              content,
              style: const TextStyle(color: defaultTextColor),
            )),
          ],
        ),
        backgroundColor: noInternetBackgroundColor,
        duration: duration,
      ),
    );
  }

  void showCustomMessage({
    required String content,
    required Duration duration,
    required IconData icon,
    required Color iconColor,
    required Color textColor,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(
              width: 8,
            ),
            Flexible(
                child: Text(
              content,
              style: TextStyle(color: textColor),
            )),
          ],
        ),
        backgroundColor: backgroundColor,
        duration: duration,
      ),
    );
  }
}
