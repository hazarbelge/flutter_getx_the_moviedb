import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardUtil {
  const KeyboardUtil();

  static void hideKeyboard(BuildContext context) {
    try {
      SystemChannels.textInput.invokeMethod("TextInput.hide");
      final FocusScopeNode currentFocus = FocusScope.of(context);
      if (currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    } catch (e) {
      debugPrint("HideKeyboardError: $e");
    }
  }
}
