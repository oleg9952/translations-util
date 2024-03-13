import 'dart:io' show Platform;

class Utils {
  String getExecutableDir() {
    final executablePath = Platform.script.path;
    final executableDir = executablePath
        .split('/')
        .sublist(0, executablePath.split('/').length - 1)
        .join('/');

    return executableDir;
  }
}

final Utils utilsService = Utils();
