import 'package:logger/logger.dart';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

final logger = Logger(
    output: ConsoleOutput(),
    printer: PrettyPrinter(
        methodCount: 1,
        noBoxingByDefault: true,
        lineLength: 80,
        errorMethodCount: 3,
        colors: true,
        levelColors: PrettyPrinter.defaultLevelColors,
        printEmojis: true));

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (event.level == Level.error || event.level == Level.warning) {
      return true;
    }
    return false;
  }
}

/// Extends 'LogOutput' to correctly display console colors on macOS systems.
///
/// The behavior is determined by the application's run mode (Release or Debug)
/// and the operating platform (iOS or non-iOS).
///
/// For more information, see: https://github.com/simc/logger/issues/1#issuecomment-1582076726
class ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    if (kReleaseMode || !Platform.isIOS) {
      event.lines.forEach(debugPrint);
    } else {
      event.lines.forEach(developer.log);
    }
  }
}
