import 'dart:io';

import 'package:translations/constants/paths.dart'
    show differenceFolderPath, restoreFolderPath;

class Reset {
  void resetAll() {
    final restoreDir = Directory(restoreFolderPath);
    final differenceDir = Directory(differenceFolderPath);

    final restoreDirExists = restoreDir.existsSync();
    final differenceDirExists = differenceDir.existsSync();

    if (restoreDirExists) {
      restoreDir.deleteSync(recursive: true);
    }

    if (differenceDirExists) {
      differenceDir.deleteSync(recursive: true);
    }

    if (restoreDirExists || differenceDirExists) {
      print('✅ Reset complete.');
    }
  }
}

final Reset resetService = Reset();
