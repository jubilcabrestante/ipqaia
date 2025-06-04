enum EnumAcademicsAction { cluster, campus, college, program, major }

extension EnumAcademicsActionExtension on EnumAcademicsAction {
  String get value {
    switch (this) {
      case EnumAcademicsAction.cluster:
        return 'Cluster';
      case EnumAcademicsAction.campus:
        return 'Campus';
      case EnumAcademicsAction.college:
        return 'College';
      case EnumAcademicsAction.program:
        return 'Program';
      case EnumAcademicsAction.major:
        return 'Major';
    }
  }
}
