import 'package:translations/constants/interaction.dart' show Modes;
import 'package:translations/services/difference/difference.dart'
    show differenceService;
import 'package:translations/services/duplicates/duplicates.dart';
import 'package:translations/services/interaction/interaction.dart'
    show interactionService;
import 'package:translations/services/reset.dart' show resetService;
import 'package:translations/services/restore.dart' show restoreService;

void main(List<String> arguments) async {
  final mode = interactionService.selectMode();
  final isRestoreMode = mode == Modes.restore.index;
  final isDiffMode = mode == Modes.diff.index;
  final isDuplicatesMode = mode == Modes.duplicates.index;
  final isResetMode = mode == Modes.reset.index;

  if (isRestoreMode) {
    restoreService.restoreJSONFromGoogleDoc(null);
  }

  if (isDiffMode) {
    differenceService.findDifferences();
  }

  if (isDuplicatesMode) {
    duplicatesService.findDuplicates();
  }

  if (isResetMode) {
    resetService.resetAll();
  }
}
