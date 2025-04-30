import 'package:talker_flutter/talker_flutter.dart';

class TalkerService {
  static final Talker talker = TalkerFlutter.init(
    settings: TalkerSettings(
      enabled: true,
      useConsoleLogs: true,
      colors: {
        'debug': AnsiPen()..green(),
        'info': AnsiPen()..blue(),
        'warning': AnsiPen()..yellow(),
        'error': AnsiPen()..red(),
        'critical': AnsiPen()..magenta(),
      },
    ),
  );
}
