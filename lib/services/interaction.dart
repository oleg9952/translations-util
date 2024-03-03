import 'package:interact/interact.dart' show Confirm, Select;
import 'package:translations/constants/interaction.dart'
    show Locales, Modes, localesMap, modesMap;

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
}

final Interaction interactionService = Interaction();
