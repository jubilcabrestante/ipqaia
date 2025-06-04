enum EnumCivilStatus {
  single,
  married,
  divorced,
  widowed,
  separated,
}

extension EnumCivilStatusX on EnumCivilStatus {
  String get value => _civilStatusValues[this]!;

  static const _civilStatusValues = {
    EnumCivilStatus.single: "Single",
    EnumCivilStatus.married: "Married",
    EnumCivilStatus.divorced: "Divorced",
    EnumCivilStatus.widowed: "Widowed",
    EnumCivilStatus.separated: "Separated",
  };
}
