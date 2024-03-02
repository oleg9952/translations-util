import 'dart:io';

import 'package:translations/constants/paths.dart' show restoreFolderPath;

class Reset {
  void resetAll() {
    final restoreDir = Directory(restoreFolderPath);
    if (restoreDir.existsSync()) {
      restoreDir.deleteSync(recursive: true);
      print('✅ Reset completed');
    }
  }
}

final Reset resetService = Reset();
