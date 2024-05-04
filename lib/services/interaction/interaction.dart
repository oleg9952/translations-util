import 'package:interact/interact.dart' show Confirm, MultiSelect, Select;
import 'package:translations/constants/interaction.dart'
    show DiffOptions, Locales, Modes, diffOptionsMap, localesMap, modesMap;
import 'package:translations/services/interaction/interaction.model.dart';

class Interaction {
  final Select _modeSelection = Select(
    prompt: 'Select mode:',
    options: modesMap.values.toList(),
    initialIndex: Modes.restore.index,
  );
  final Select _localeSelection = Select(
    prompt: 'Select locale:',
    options: localesMap.values.toList(),
    initialIndex: Locales.en.index,
  );

  final _continueConfirmation = Confirm(
    prompt: 'Press enter to continue',
    defaultValue: true,
    waitForNewLine: true,
  );

  final _diffOptionsMultiSelect = MultiSelect(
    prompt: 'Specify options for finding differences:',
    options: diffOptionsMap.values.toList(),
    defaults: [false, false],
  );

  // Methods ---------------------------------------------------------------

  int selectMode() {
    return _modeSelection.interact();
  }

  Locales selectLocale() {
    final selectedLocaleIndex = _localeSelection.interact();
    return Locales.values[selectedLocaleIndex];
  }

  bool confirmContinue() {
    return _continueConfirmation.interact();
  }

  bool suggestToRestore(Locales selectedLocale) {
    final suggestion = Confirm(
      prompt:
          '❌ No restored output file "${selectedLocale.name}-google.json" found. Do you want to restore?',
      defaultValue: true,
    );
    return suggestion.interact();
  }

  SetDiffOptionsReturnType setDiffOptions() {
    final selectedOptions = _diffOptionsMultiSelect.interact();
    final shouldExcludeComas =
        selectedOptions.contains(DiffOptions.excludeComas.index);
    final shouldTrim = selectedOptions.contains(DiffOptions.trim.index);

    return SetDiffOptionsReturnType(
        shouldExcludeComas: shouldExcludeComas, shouldTrim: shouldTrim);
  }
}

final Interaction interactionService = Interaction();
