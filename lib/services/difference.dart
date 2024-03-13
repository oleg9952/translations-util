import 'dart:convert' show JsonEncoder, jsonDecode;
import 'dart:io' show Directory, File, Process;

import 'package:translations/constants/interaction.dart' show Locales;
import 'package:translations/constants/paths.dart'
    show
        differenceFolderPath,
        differenceInputFolderPath,
        differenceOutputFolderPath,
        restoreOutputFolderPath;
import 'package:translations/services/interaction/interaction.dart'
    show interactionService;
import 'package:translations/services/restore.dart' show restoreService;

class Difference {
  void findDifferences() async {
    final selectedLocale = interactionService.selectLocale();

    final inputDiffGoogleDocFile =
        File('$restoreOutputFolderPath/${selectedLocale.name}-google.json');

    if (!_verifyGoogleDocInput(
        inputDiffGoogleDocFile: inputDiffGoogleDocFile,
        selectedLocale: selectedLocale)) {
      return;
    }

    final inputDiffLocalFile =
        File('$differenceInputFolderPath/${selectedLocale.name}-local.json');
    final outputDiffFile =
        File('$differenceOutputFolderPath/${selectedLocale.name}-diff.json');

    _createDiffInput(
        selectedLocale: selectedLocale, inputDiffLocalFile: inputDiffLocalFile);

    await _openFileAndConfirmContinue(file: inputDiffLocalFile);

    _createDiffOutput(outputDiffFile);

    _diffJSON(
        inputDiffGoogleDocFile: inputDiffGoogleDocFile,
        inputDiffLocalFile: inputDiffLocalFile,
        outputDiffFile: outputDiffFile);

    Process.start('open', [outputDiffFile.path]);
  }

  // Private Methods ---------------------------------------------------------------------
  bool _verifyGoogleDocInput(
      {required File inputDiffGoogleDocFile, required Locales selectedLocale}) {
    final hasGoogleDocInputFile = inputDiffGoogleDocFile.existsSync();

    if (!hasGoogleDocInputFile) {
      final suggestion = interactionService.suggestToRestore(selectedLocale);

      if (suggestion) {
        restoreService.restoreJSONFromGoogleDoc(selectedLocale);
      }
    }

    return hasGoogleDocInputFile;
  }

  void _createDiffInput(
      {required Locales selectedLocale, required File inputDiffLocalFile}) {
    final differenceDir = Directory(differenceFolderPath);
    final differenceInputDir = Directory(differenceInputFolderPath);

    if (!differenceDir.existsSync() || !differenceInputDir.existsSync()) {
      differenceInputDir.createSync(recursive: true);
    }

    if (!inputDiffLocalFile.existsSync()) {
      inputDiffLocalFile.createSync();
    }
  }

  void _createDiffOutput(File outputDiffFile) {
    final differenceOutputDir = Directory(differenceOutputFolderPath);

    if (!differenceOutputDir.existsSync()) {
      differenceOutputDir.createSync(recursive: true);
    }

    if (!outputDiffFile.existsSync()) {
      outputDiffFile.createSync();
    }
  }

  Future<void> _openFileAndConfirmContinue({required File file}) async {
    await Process.start('open', [file.path]);
    interactionService.confirmContinue();
  }

  void _diffJSON({
    required File inputDiffGoogleDocFile,
    required File inputDiffLocalFile,
    required File outputDiffFile,
  }) {
    print('');
    print('------- CHECKING DIFFERENCES -------');

    final googleDocData = inputDiffGoogleDocFile.readAsStringSync();
    final localData = inputDiffLocalFile.readAsStringSync();
    final Map<String, dynamic> decodedGoogleDocData = jsonDecode(googleDocData);
    final Map<String, dynamic> decodedLocalData = jsonDecode(localData);

    final diffOptions = interactionService.setDiffOptions();

    final Map<String, Map<String, String>> diffGoogleFromLocal = {};
    decodedGoogleDocData.forEach((key, value) {
      if (diffOptions.shouldExcludeComas) {
        final endsWithComma = value.endsWith(',');
        if (endsWithComma) {
          value = (value as String).substring(0, value.length - 1);
        }
      }

      if (diffOptions.shouldTrim) {
        value = value.trim();
      }

      if (decodedLocalData[key] != value) {
        diffGoogleFromLocal[key] = {
          'google': value,
          '-local': decodedLocalData[key] ?? '',
        };
      }
    });

    final encodedDiffData =
        JsonEncoder.withIndent('  ').convert(diffGoogleFromLocal);
    outputDiffFile.writeAsStringSync(encodedDiffData);

    print('😳 Found ${diffGoogleFromLocal.length} differences');
  }
}

final Difference differenceService = Difference();
