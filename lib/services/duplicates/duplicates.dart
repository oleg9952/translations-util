import 'dart:convert';
import 'dart:io';

import '../interaction/interaction.dart';

import '../../constants/paths.dart';

class Duplicates {
  void findDuplicates() async {
    final duplicatesDir = Directory(duplicatesFolderPath);
    final duplicatesOutputFile =
        File('$duplicatesFolderPath/duplicates-output.json');

    if (!duplicatesDir.existsSync()) {
      duplicatesDir.createSync(recursive: true);
    }

    // create empty json file
    final duplicatesFile = File('$duplicatesFolderPath/duplicates-input.json');
    duplicatesFile.createSync();

    // open file
    await Process.start('open', [duplicatesFile.path]);
    interactionService.confirmContinue();

    final String jsonString = duplicatesFile.readAsStringSync();
    final Map<String, dynamic> decodedJson = jsonDecode(jsonString);

    final uniqueValuesCount = decodedJson.values.toSet().length;
    final totalValuesCount = decodedJson.values.length;
    final hasDuplicates = uniqueValuesCount != totalValuesCount;

    if (!hasDuplicates) {
      return print('✅ No duplicates found!');
    }

    final Map<String, Map<dynamic, dynamic>> duplicates = {};
    final uniqueValues = decodedJson.values
        .map((e) => (e as String).toLowerCase().trim())
        .toSet()
        .toList();

    int index = 1;
    for (final currentValue in uniqueValues) {
      final duplicatesOfCurrentValue = decodedJson.entries
          .toList()
          .where((element) =>
              (element.value as String).toLowerCase() == currentValue)
          .toList();
      final isDuplicatedValue = duplicatesOfCurrentValue.length > 1;

      if (!isDuplicatedValue) continue;

      final Map<String, String> duplicatesMapForCurrentValue = {};
      duplicatesOfCurrentValue.forEach((element) {
        duplicatesMapForCurrentValue[element.key] = element.value;
      });

      duplicates[index.toString()] = duplicatesMapForCurrentValue;
      index++;
    }

    final encodedOutput = JsonEncoder.withIndent('  ').convert(duplicates);
    duplicatesOutputFile.writeAsStringSync(encodedOutput);

    Process.start('open', [duplicatesOutputFile.path]);

    print('🔍 Found duplicates: ${duplicates.length}');
  }
}

final Duplicates duplicatesService = Duplicates();
