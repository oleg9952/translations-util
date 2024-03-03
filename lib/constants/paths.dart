import 'package:translations/services/utils.dart' show utilsService;

final executableDir = utilsService.getExecutableDir();

enum Paths {
  restoreFolder,
  restoreInputFolder,
  restoreOutputFolder,
  differenceFolder,
  differenceInputFolder,
  differenceOutputFolder,
}

final Map<int, String> paths = {
  Paths.restoreFolder.index: '$executableDir/restore',
  Paths.restoreInputFolder.index: '$executableDir/restore/input',
  Paths.restoreOutputFolder.index: '$executableDir/restore/output',
  Paths.differenceFolder.index: '$executableDir/difference',
  Paths.differenceInputFolder.index: '$executableDir/difference/input',
  Paths.differenceOutputFolder.index: '$executableDir/difference/output',
};

final restoreFolderPath = paths[Paths.restoreFolder.index]!;
final restoreInputFolderPath = paths[Paths.restoreInputFolder.index]!;
final restoreOutputFolderPath = paths[Paths.restoreOutputFolder.index]!;

final differenceFolderPath = paths[Paths.differenceFolder.index]!;
final differenceInputFolderPath = paths[Paths.differenceInputFolder.index]!;
final differenceOutputFolderPath = paths[Paths.differenceOutputFolder.index]!;
