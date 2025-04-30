import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ipqaia/features/main/sdg/domain/i_sdg_repository.dart';
import 'package:ipqaia/features/main/sdg/repository/article_model/article_vm.dart';
import 'package:ipqaia/features/main/sdg/repository/sdg_model/sdg_vm.dart';

part 'sdg_state.dart';
part 'sdg_cubit.freezed.dart';

class SdgCubit extends Cubit<SdgState> {
  final ISdgRepository _iSdgRepository;

  SdgCubit(this._iSdgRepository) : super(const SdgState()) {
    _getSdg();
    getArticles();
  }

  _getSdg() async {
    emit(state.copyWith(
      isLoading: true,
      isSuccess: false,
    ));

    try {
      final result = await _iSdgRepository.getSdg();

      emit(state.copyWith(
        isLoading: false,
        isSuccess: result.isNotEmpty,
        sdg: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  addSdg(int number, String title, List<String> words) async {
    emit(state.copyWith(isLoading: true));
    try {
      final newSdg = SdgVm(
        sdgNumber: number,
        sdgTitle: title,
        words: words,
      );
      await _iSdgRepository.addSdg(newSdg);
      _getSdg();
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.toString(), isSuccess: false));
    }
  }

  updateSdg(SdgVm sdg) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _iSdgRepository.updateSdg(sdg);
      _getSdg();
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.toString(), isSuccess: false));
    }
  }

  deleteSdg(String sdgId) async {
    try {
      emit(state.copyWith(isLoading: true));
      _iSdgRepository.deleteReport(sdgId);
      _getSdg();
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void updateWord(String oldWord, String newWord) {
    final updatedWords = state.newWords.map((word) {
      return word == oldWord ? newWord : word;
    }).toList();

    emit(state.copyWith(newWords: updatedWords));
  }

  addNewWord(String word) {
    final updatedWords = List<String>.from(state.newWords)..add(word);
    emit(state.copyWith(newWords: updatedWords));
  }

  clearWords() {
    emit(state.copyWith(newWords: []));
  }

  removeWord(String word) {
    final updatedWords = List<String>.from(state.newWords)..remove(word);
    emit(state.copyWith(newWords: updatedWords));
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  ///     Article
  ///
  /// //////////////////////////////////////////////////////
  getArticles() async {
    emit(state.copyWith(
      isLoading: true,
      isSuccess: false,
    ));

    try {
      final resultArticle = await _iSdgRepository.getArticles();
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        articles: resultArticle,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  addArticle(ArticleVm article) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _iSdgRepository.addArticle(article);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  updateArticle(ArticleVm article) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _iSdgRepository.updateArticle(article);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  deleteArticle(String id) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _iSdgRepository.deleteArticle(id);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void updateSelectedDate(DateTime newDate) {
    emit(state.copyWith(selectedDate: newDate));
  }

  void updateSelectedSdg(String newSdg) {
    emit(state.copyWith(selectedSdg: newSdg));
  }
}
