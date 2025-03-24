import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ipqaia/features/main/sdg/domain/i_sdg_repository.dart';
import 'package:ipqaia/features/main/sdg/repository/sdg_model/sdg_vm.dart';

part 'sdg_state.dart';
part 'sdg_cubit.freezed.dart';

class SdgCubit extends Cubit<SdgState> {
  final ISdgRepository _iSdgRepository;

  SdgCubit(this._iSdgRepository) : super(const SdgState());

  Future<void> getSdg(String selectedType) async {
    emit(state.copyWith(
        isLoading: true, isSuccess: false, errorMessage: state.errorMessage));
    try {
      final result = await _iSdgRepository.getSdg(selectedType);
      if (result.isNotEmpty) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          sdg: result,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          errorMessage: 'No SDG data found.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
        isSuccess: false,
      ));
    }
  }

  Future<void> updateSdg(SdgVm sdg) async {
    try {
      emit(state.copyWith(isLoading: true));
      _iSdgRepository.updateSdg(sdg);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isSuccess: false));
    }
  }

  Future<void> deleteSdg(String sdgId) async {
    try {
      emit(state.copyWith(isLoading: true));
      _iSdgRepository.deleteReport(sdgId);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
