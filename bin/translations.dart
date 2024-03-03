import 'package:translations/constants/interaction.dart' show Modes;
import 'package:translations/services/difference.dart' show differenceService;
import 'package:translations/services/interaction.dart' show interactionService;
import 'package:translations/services/reset.dart' show resetService;
import 'package:translations/services/restore.dart' show restoreService;

void main(List<String> arguments) async {
  final mode = interactionService.selectMode();
  final isRestoreMode = mode == Modes.restore.index;
  final isDiffMode = mode == Modes.diff.index;
  final isResetMode = mode == Modes.reset.index;

  if (isRestoreMode) {
    restoreService.restoreJSONFromGoogleDoc(null);
  }

  if (isDiffMode) {
    differenceService.findDifferences();
  }

  if (isResetMode) {
    resetService.resetAll();
  }
}
