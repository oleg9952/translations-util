import 'dart:io' show Directory;

import '../constants/paths.dart'
    show differenceFolderPath, duplicatesFolderPath, restoreFolderPath;

class Reset {
  void resetAll() {
    final restoreDir = Directory(restoreFolderPath);
    final differenceDir = Directory(differenceFolderPath);
    final duplicatesDir = Directory(duplicatesFolderPath);

    final restoreDirExists = restoreDir.existsSync();
    final differenceDirExists = differenceDir.existsSync();
    final duplicatesDirExists = duplicatesDir.existsSync();

    if (restoreDirExists) {
      restoreDir.deleteSync(recursive: true);
    }

    if (differenceDirExists) {
      differenceDir.deleteSync(recursive: true);
    }

    if (duplicatesDirExists) {
      duplicatesDir.deleteSync(recursive: true);
    }

    if (restoreDirExists || differenceDirExists || duplicatesDirExists) {
      print('✅ Reset complete.');
    }
  }
}

final Reset resetService = Reset();
