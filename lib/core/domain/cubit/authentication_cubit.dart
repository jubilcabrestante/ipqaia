// import 'dart:developer';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:ipqaia/core/domain/i_user_repository.dart';
// import 'package:ipqaia/core/repository/model/user_vm.dart';

// part 'authentication_state.dart';
// part 'authentication_cubit.freezed.dart';

// class AuthenticationCubit extends Cubit<AuthenticationState> {
//   final IUserRepository _iUserRepository;
//   AuthenticationCubit({required IUserRepository iUserRepository})
//       : _iUserRepository = iUserRepository,
//         super(AuthenticationState());

//   Future<void> createAccount(
//       UserVm user, String password, String adminPassword) async {
//     emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));

//     try {
//       await _iUserRepository.createUserWithEmailAndPassword(
//         user,
//         password,
//         adminPassword,
//       );

//       // ✅ Convert FirebaseAuth User to UserModel
//       // final firebaseUser = await _iUserRepository.currentUserStream.first;
//       // final currentUser = firebaseUser != null
//       //     ? UserVm(
//       //         uid: firebaseUser.uid,
//       //         email: firebaseUser.email ?? '',
//       //         role: '', name: '', // Assign the role if needed
//       //       )
//       //     : null;

//       emit(state.copyWith(
//         isLoading: false,
//         isSuccess: true,
//         currentUser: user,
//       ));

//       log("Logged in user: ${user.email}");
//     } catch (e) {
//       emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
//     }
//   }

//   Future<void> logOut() async {
//     emit(state.copyWith(isLoading: true, hasError: false, errorMessage: null));
//     try {
//       await _iUserRepository.signOut(); // Ensure this is awaited
//       emit(state.copyWith(
//         currentUser: null, // Correctly set user to null
//         isLoading: false,
//         isSuccess: false,
//         hasError: false,
//         errorMessage: null,
//       ));
//     } catch (e) {
//       emit(state.copyWith(
//         isLoading: false,
//         hasError: true,
//         errorMessage: e.toString(),
//         isSuccess: false,
//       ));
//     }
//   }
// }
