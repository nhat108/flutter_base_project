import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:minakomi/export.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/auth/get_started_model.dart';
import '../../models/auth/profile_model.dart';
import '../../respositories/auth/auth_repositories.dart';
import '../../utils/local_storage.dart';
import '../../utils/notification_service.dart';
import '../../utils/theme_manager.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AppTheme { Light, Dark }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories authRepositories = AuthRepositories();
  final LocalStorage localStorage = LocalStorage();
  String? interestCategoryId;
  AuthBloc() : super(AuthState.empty()) {
    on<AuthResumeSession>(authResumeSession);
    on<AuthGetStarted>(authGetStarted);
    on<AuthLogin>(authLogin);
    on<AuthSignUp>(authSignUp);
    on<AuthResendCode>(authResendCode);
    on<AuthVerifyCode>(authVerifyCode);
    on<AuthForgotPassword>(authForgotPassword);
    on<AuthResetPassword>(authResetPassword);
    on<AuthFCM>(authFCM);
    on<AuthGetProfile>(getProfile);
    on<AuthUpdateProfile>(updateProfile);
    on<AuthChangeTheme>(_authChangeTheme);
    on<LogOut>(logOut);
    on<UpdatePhone>(_updatePhonenumber);
    on<UpdateUsername>(_updateUsername);
    on<VerifyCodeUpdatePhone>(_verifyCodeUpdatePhone);
    on<CheckUsername>(_checkUsername);
    on<DeactivateAccount>(_deactivateAccount);
  }
  bool useCacheFirstTime = true;

  void authResumeSession(
      AuthResumeSession event, Emitter<AuthState> emit) async {
    try {
      // DateTime dateTime = DateTime.now();
      // var hasToken = await localStorage.hasToken();
      // String? _localCategoryId;
      // try {
      //   _localCategoryId = await LocalStorage().getCategoryLocal();
      //   interestCategoryId = _localCategoryId;
      // } catch (_) {}
      // if (hasToken) {
      //   if (await localStorage.hasExpireToken()) {
      //     await localStorage.refreshToken();
      //   }

      //   ProfileModel? profileModel;
      //   if (useCacheFirstTime) {
      //     useCacheFirstTime = false;
      //     try {
      //       dynamic response = await localStorage.getProfileLocal();
      //       profileModel = ProfileModel.fromJson(response);
      //       interestCategoryId = profileModel.interstCategory!.id;
      //       emit(state.copyWith(profileModel: profileModel));

      //       print(
      //           "it take ${DateTime.now().difference(dateTime).inMilliseconds}");
      //     } catch (e) {
      //       print(e);
      //     } finally {
      //       event.onSuccess(true, true);
      //       add(AuthGetProfile());
      //     }
      //   } else {
      //     profileModel = await authRepositories.getProfile();
      //     if (profileModel.interstCategory?.id == null &&
      //         _localCategoryId != null) {
      //       //update category of user for some case user not upate category

      //       await _updateProfileCategory(
      //           userId: profileModel.id!, categoryId: _localCategoryId);
      //     } else if (profileModel.interstCategory?.id != null) {
      //       interestCategoryId = profileModel.interstCategory?.id;
      //     }
      //     emit(state.copyWith(profileModel: profileModel));
      //     event.onSuccess(true, interestCategoryId != null);
      //     await localStorage.setProfileLocal(profileModel.toMap());
      //   }
      // } else {
      //   event.onSuccess(false, false);
      // }
    } catch (e) {
      var result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        event.onError(e.parseErrorMessage());
      } else {
        event.onError(e.parseErrorMessage());
        if (e.parseError().code == 'NotAuthorizedException') {
          add(LogOut(onSuccess: () {}, onError: (error) {}));
        }
      }
    }
  }

  void authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    try {
      //    emit(state.copyWith(loginLoading: true));
      // final token = await localStorage.loginCognito(
      //   password: event.password,
      //   userName: event.userName,
      // );

      // await localStorage.persistToken(
      //   user: event.userName,
      //   pass: event.password,
      //   token: token!,
      // );
      // ProfileModel profileModel = await authRepositories.getProfile();
      // interestCategoryId = profileModel.interstCategory?.id;
      // emit(state.copyWith(profileModel: profileModel, loginLoading: false));
      // event.onSuccess(profileModel.interstCategory != null);
    } catch (e) {
      emit(state.copyWith(loginLoading: false));
      event.onError(e.parseError().code == 'NotAuthorizedException'
          ? 'key_wrong_password'.tr()
          : e.parseErrorMessage());
    }
  }

  void authGetStarted(AuthGetStarted event, Emitter<AuthState> emit) async {
    try {
      // emit(state.copyWith(getStartedRequesting: true));
      // GetStartedModel getStartedModel =
      //     await authRepositories.checkPhone(phoneNumber: event.phoneNumber);
      // emit(state.copyWith(
      //     getStartedModel: getStartedModel, getStartedRequesting: false));
      // if (getStartedModel.userExist!) {
      //   if (getStartedModel.isVerifiedUser!) {
      //     event.onSuccess(AppConstrants.login);
      //   } else {
      //     event.onSuccess(AppConstrants.verify);
      //   }
      // } else {
      //   event.onSuccess(AppConstrants.signup);
      // }
    } catch (e) {
      emit(state.copyWith(getStartedRequesting: false));
      event.onError(e.parseErrorMessage());
    }
  }

  void authResendCode(AuthResendCode event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(verifyCodeLoading: true));
      await localStorage.resendCodeCognito(userName: event.userName);
      emit(state.copyWith(verifyCodeLoading: false));
      event.onSuccess();
    } catch (e) {
      emit(state.copyWith(verifyCodeLoading: false));
      event.onError(e.parseErrorMessage());
    }
  }

  void authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    try {
      //  emit(state.copyWith(signUpLoading: true));
      // await localStorage.signUpCognito(
      //   id: event.body['id'],
      //   fullName: event.body['full_name'],
      //   password: event.body['password'],
      //   phoneNumber: event.body['phone_number'],
      // );
      // GetStartedModel getStartedModel =
      //     state.getStartedModel!.copyWith(username: event.body['id']);
      // emit(state.copyWith(
      //     signUpLoading: false, getStartedModel: getStartedModel));
      // bool value = await localStorage.getInsterestCategoryFromLocalToNewUser();
      // await localStorage.setInsterestCategoryFromLocalToNewUser(true);
      // event.onSuccess(value);
    } catch (e) {
      emit(state.copyWith(signUpLoading: false));
      event.onError(e.parseErrorMessage());
    }
  }

  void authVerifyCode(AuthVerifyCode event, Emitter<AuthState> emit) async {
    try {
      // emit(state.copyWith(verifyCodeLoading: true));

      // await localStorage.verifyCodeCognito(
      //     userName: event.userName, code: event.code);
      // if (event.password != null) {
      //   final token = await localStorage.loginCognito(
      //     password: event.password!,
      //     userName: event.userName,
      //   );
      //   await localStorage.persistToken(
      //     user: event.userName,
      //     pass: event.password!,
      //     token: token!,
      //   );
      //   ProfileModel profileModel = await authRepositories.getProfile();
      //   await localStorage.setProfileLocal(profileModel.toMap());
      //   emit(state.copyWith(
      //       profileModel: profileModel, verifyCodeLoading: false));
      // } else {
      //   emit(state.copyWith(verifyCodeLoading: false));
      // }
      // event.onSuccess();
    } catch (e) {
      emit(state.copyWith(verifyCodeLoading: false));
      event.onError(e.parseErrorMessage());
    }
  }

  void authForgotPassword(
      AuthForgotPassword event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(resetPasswordLoading: true));
      await localStorage.forgotPassword(userName: event.username);
      event.onSuccess();
      emit(state.copyWith(resetPasswordLoading: false));
    } catch (e) {
      emit(state.copyWith(
        resetPasswordLoading: false,
      ));
      event.onError(e.parseErrorMessage());
    }
  }

  void authResetPassword(
      AuthResetPassword event, Emitter<AuthState> emit) async {
    try {
      // emit(state.copyWith(resetPasswordLoading: true));
      // await localStorage.confirmNewPassword(
      //   code: event.code,
      //   newPassword: event.password,
      //   userName: event.username,
      // );
      // final token = await localStorage.loginCognito(
      //   password: event.password,
      //   userName: event.username,
      // );
      // await localStorage.persistToken(
      //   user: event.username,
      //   pass: event.password,
      //   token: token!,
      // );
      // ProfileModel profileModel = await authRepositories.getProfile();
      // emit(state.copyWith(
      //     profileModel: profileModel, resetPasswordLoading: false));
      // event.onSuccess();
    } catch (e) {
      emit(state.copyWith(resetPasswordLoading: false));
      event.onError(e.parseErrorMessage());
    }
  }

  void authFCM(AuthFCM event, Emitter<AuthState> emit) async {
    try {
      // await authRepositories.updateUserFCMDevice(body: event.body);
    } catch (e) {
      print(e.parseErrorMessage());
    }
  }

  void getProfile(AuthGetProfile event, Emitter<AuthState> emit) async {
    try {
      // emit(state.copyWith(
      //   getProfileLoading: true,
      // ));
      // ProfileModel profileModel = await authRepositories.getProfile();
      // await localStorage.setProfileLocal(profileModel.toMap());

      // emit(state.copyWith(
      //   profileModel: profileModel,
      //   getProfileLoading: false,
      // ));
    } catch (e) {
      emit(state.copyWith(
        getProfileLoading: false,
        getProfileError: e.parseErrorMessage(),
      ));
      NotificationService.showNotificationBottom(
          title: e.parseErrorMessage(),
          duration: const Duration(milliseconds: 5000));
    }
  }

  void updateProfile(AuthUpdateProfile event, Emitter<AuthState> emit) async {
    try {
// emit(state.copyWith(
//         updateProfileLoading: true,
//       ));
//       if (event.image != null) {
//         await authRepositories.updateAvatar(file: event.image!);
//       }
//       // await localStorage.updateAttribute(
//       //     attributeName: 'name', value: event.body['display_name']);
//       final session = await localStorage.getSession();
//       await authRepositories.updateProfile(
//           body: event.body, accessToken: session!.getAccessToken().jwtToken!);
//       event.onSuccess();
//       add(AuthGetProfile());
//       emit(state.copyWith(
//         updateProfileLoading: false,
//       ));
    } catch (e) {
      event.onError(e.parseErrorMessage());
      emit(state.copyWith(
        updateProfileLoading: false,
      ));
    }
  }

  void logOut(LogOut event, Emitter<AuthState> emit) async {
    try {
      //   String medi = await Helper.getMeidDevice();
      // final Map<String, dynamic> body = {
      //   "type": "M",
      //   "device": Platform.isAndroid ? 'A' : 'I',
      //   "meid": medi,
      //   "token": '',
      // };
      // try {
      //   await authRepositories.removeFcmDevice(body: body);
      //   interestCategoryId = await LocalStorage().getCategoryLocal();
      // } catch (e) {
      //   print("error: ${e.toString()}");
      // }
      // await localStorage.deleteToken();
      // emit(state.copyWithNull(profileModel: null));

      // event.onSuccess();
    } catch (e) {
      event.onError(e.parseErrorMessage());
    }
  }

  FutureOr<void> _updatePhonenumber(
      UpdatePhone event, Emitter<AuthState> emit) async {
    try {
      //  emit(state.copyWith(
      //   updateProfileLoading: true,
      // ));

      // final result =
      //     await localStorage.updatePhonenumber(phoneNumber: event.phoneNumber);
      // print(result);
      // emit(state.copyWith(
      //   updateProfileLoading: false,
      // ));
      // event.onSuccess();
      // add(AuthGetProfile());
    } catch (e) {
      event.onError(e.parseErrorMessage());
      emit(state.copyWith(
        updateProfileLoading: false,
      ));
    }
  }

  FutureOr<void> _updateUsername(
      UpdateUsername event, Emitter<AuthState> emit) async {
    try {
      // emit(state.copyWith(
      //   updateProfileLoading: true,
      // ));
      // var session = await localStorage.getSession();
      // await authRepositories.updateProfile(body: {
      //   "preferred_name": event.username,
      //   "display_name": event.displayName,
      // }, accessToken: session!.getAccessToken().jwtToken!);
      // add(AuthGetProfile());
      // emit(state.copyWith(
      //   updateProfileLoading: false,
      // ));
      // event.onSuccess();
    } catch (e) {
      event.onError(e.parseErrorMessage());
      emit(state.copyWith(
        updateProfileLoading: false,
      ));
    }
  }

  FutureOr<void> _verifyCodeUpdatePhone(
      VerifyCodeUpdatePhone event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(
        verifyCodeLoading: true,
      ));
      await localStorage.verifyAttribute(
          attributeName: 'phone_number',
          confirmationCode: event.code,
          value: event.phoneNumber);
      event.onSuccess();
      emit(state.copyWith(
        verifyCodeLoading: false,
      ));
    } catch (e) {
      event.onError(e.parseErrorMessage());
      emit(state.copyWith(
        verifyCodeLoading: false,
      ));
    }
  }

  FutureOr<void> _checkUsername(
      CheckUsername event, Emitter<AuthState> emit) async {
    try {
      //  emit(state.copyWith(checkUsernameExistLoading: true));
      // final result =
      //     await authRepositories.checkUsername(username: event.username);
      // event.onResult(result);
      // emit(state.copyWith(checkUsernameExistLoading: false));
    } catch (e) {
      emit(state.copyWith(checkUsernameExistLoading: false));
    }
  }

  FutureOr<void> _deactivateAccount(
      DeactivateAccount event, Emitter<AuthState> emit) async {
    try {
//  emit(state.copyWith(updateProfileLoading: true));
//       await authRepositories.deactivateAccount();
//       await localStorage.deleteToken();
//       emit(state.copyWithNull(profileModel: null));
//       event.onSuccess();
//       emit(state.copyWith(updateProfileLoading: false));
    } catch (e) {
      emit(state.copyWith(updateProfileLoading: false));

      event.onError(e.parseErrorMessage());
    }
  }

  FutureOr<void> _authChangeTheme(
      AuthChangeTheme event, Emitter<AuthState> emit) async {
    switch (event.theme) {
      case AppConstrants.lightTheme:
        emit(state.copyWith(themeData: ThemeManager().lightTheme));
        break;
      case AppConstrants.darkTheme:
        emit(state.copyWith(themeData: ThemeManager().darkTheme));
        break;
    }
    await localStorage.saveTheme(theme: event.theme);
  }
}
