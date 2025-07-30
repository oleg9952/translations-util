import 'dart:convert' show JsonEncoder;
import 'dart:io' show Directory, File, Process;

import 'package:translations/constants/interaction.dart' show Locales;
import 'package:translations/constants/paths.dart'
    show restoreFolderPath, restoreInputFolderPath, restoreOutputFolderPath;
import 'package:translations/services/interaction/interaction.dart'
    show interactionService;

class Restore {
  // Methods ---------------------------------------------------------------------
  void restoreJSONFromGoogleDoc(Locales? locale) async {
    final selectedLocale = locale ?? interactionService.selectLocale();

    final keysFile = File('$restoreInputFolderPath/keys.txt');
    final valuesFile = File('$restoreInputFolderPath/values.txt');
    final outputFile =
        File('$restoreOutputFolderPath/${selectedLocale.name}-google.json');

    _createRestoreInput(keysFile: keysFile, valuesFile: valuesFile);

    await _openFileAndConfirmContinue(file: keysFile);
    await _openFileAndConfirmContinue(file: valuesFile);

    _createRestoreOutput(outputFile);

    _restoreJSON(
        keysFile: keysFile, valuesFile: valuesFile, outputFile: outputFile);

    Process.start('open', [outputFile.path]);
  }

  // Private Methods ---------------------------------------------------------------------

  void _createRestoreInput({
    required File keysFile,
    required File valuesFile,
  }) {
    final restoreDir = Directory(restoreFolderPath);
    final restoreInputDir = Directory(restoreInputFolderPath);

    if (!restoreDir.existsSync() || !restoreInputDir.existsSync()) {
      restoreInputDir.createSync(recursive: true);
    }

    if (!keysFile.existsSync()) {
      keysFile.createSync();
    }

    if (!valuesFile.existsSync()) {
      valuesFile.createSync();
    }
  }

  void _createRestoreOutput(File outputFile) {
    final restoreOutputDir = Directory(restoreOutputFolderPath);
    if (!restoreOutputDir.existsSync()) {
      restoreOutputDir.createSync(recursive: true);
    }

    if (!outputFile.existsSync()) {
      outputFile.createSync();
    }
  }

  Future<void> _openFileAndConfirmContinue({required File file}) async {
    await Process.start('open', [file.path]);
    interactionService.confirmContinue();
  }

  void _restoreJSON({
    required File keysFile,
    required File valuesFile,
    required File outputFile,
  }) {
    print('');
    print('------- RESTORING -------');

    final keys = keysFile.readAsLinesSync();
    final values = valuesFile.readAsLinesSync();

    final data = keys.asMap().map((index, key) {
      try {
        return MapEntry(key, values[index]);
      } catch (e) {
        print('🚨🚨🚨 issue with line "$index" for key "$key" 🚨🚨🚨');
        return MapEntry(key, '');
      }
    });

    final encodedData = JsonEncoder.withIndent('  ').convert(data);
    outputFile.writeAsStringSync(encodedData);

    print('✅ Restored ${data.length} translations');
  }
}

final Restore restoreService = Restore();
