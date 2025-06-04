enum EnumEmployment {
  permanent,
  contractual,
  jobOrder,
  casual,
  probationary,
}

extension EnumEmploymentX on EnumEmployment {
  String get value => _employmentValues[this]!;

  static const _employmentValues = {
    EnumEmployment.permanent: "Permanent",
    EnumEmployment.contractual: "Contractual",
    EnumEmployment.jobOrder: "Job Order",
    EnumEmployment.casual: "Casual",
    EnumEmployment.probationary: "Probationary",
  };
}
