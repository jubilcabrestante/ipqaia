import 'package:ipqaia/features/main/sdg/repository/sdg_model/sdg_vm.dart';

abstract class ISdgRepository {
  Future<List<SdgVm>> addSdg(String selectedType);

  Future<List<SdgVm>> getSdg(String selectedType);

  Future<void> updateSdg(SdgVm sdg);

  Future<void> deleteReport(String sdgId);
}
