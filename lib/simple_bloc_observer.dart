import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipqaia/talker_service.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SimpleBlocObserver extends BlocObserver {
  final Talker talker = TalkerService.talker;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    talker.log('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    talker.log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    talker.log('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    talker.log(
        'onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    talker.error(
      'onError -- bloc: ${bloc.runtimeType}, error: $error',
      error,
      stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    talker.log('onClose -- bloc: ${bloc.runtimeType}');
  }
}
