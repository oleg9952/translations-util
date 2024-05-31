// Modes --------------------------------------------
enum Modes {
  restore,
  diff,
  duplicates,
  reset,
}

final Map<int, String> modesMap = {
  Modes.restore.index: 'Restore JSON from Google Doc',
  Modes.diff.index: 'Find differences between local json and google doc json',
  Modes.duplicates.index: 'Find duplicated values',
  Modes.reset.index: 'Reset all files'
};

// Locales --------------------------------------------
enum Locales {
  en,
  ar,
}

final Map<int, String> localesMap = {
  Locales.en.index: 'English',
  Locales.ar.index: 'Arabic',
};

// DiffOptions --------------------------------------------
enum DiffOptions {
  excludeComas,
  trim,
}

final Map<int, String> diffOptionsMap = {
  DiffOptions.excludeComas.index: 'Exclude comas',
  DiffOptions.trim.index: 'Trim',
};
