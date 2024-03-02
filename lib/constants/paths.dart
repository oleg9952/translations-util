import 'package:translations/services/utils.dart' show utilsService;

final executableDir = utilsService.getExecutableDir();

enum Paths { restoreFolder, restoreInputFolder, restoreOutputFolder }

final Map<int, String> paths = {
  Paths.restoreFolder.index: '$executableDir/restore',
  Paths.restoreInputFolder.index: '$executableDir/restore/input',
  Paths.restoreOutputFolder.index: '$executableDir/restore/output',
};

final restoreFolderPath = paths[Paths.restoreFolder.index]!;
final restoreInputFolderPath = paths[Paths.restoreInputFolder.index]!;
final restoreOutputFolderPath = paths[Paths.restoreOutputFolder.index]!;
