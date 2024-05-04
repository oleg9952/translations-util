import 'difference.types.dart' show TranslationKeyType;

class KeyDifferences {
  final String google;
  final String llocal;

  KeyDifferences({
    required this.google,
    required this.llocal,
  });

  Map<String, dynamic> toJson() {
    return {
      'google': google,
      'llocal': llocal,
    };
  }
}

class DifferencesResult {
  final Map<TranslationKeyType, KeyDifferences> differences;
  final List<TranslationKeyType> missingKeysInGoogleDoc;
  final List<TranslationKeyType> missingKeysInLocalDoc;

  DifferencesResult({
    required this.differences,
    required this.missingKeysInGoogleDoc,
    required this.missingKeysInLocalDoc,
  });

  Map<String, dynamic> toJson() {
    return {
      'differences': differences,
      'missingKeysInGoogleDoc': missingKeysInGoogleDoc,
      'missingKeysInLocalDoc': missingKeysInLocalDoc,
    };
  }
}
