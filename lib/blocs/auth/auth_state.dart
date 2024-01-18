part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool? getStartedRequesting,
      verifyCodeLoading,
      resetPasswordLoading,
      loginLoading,
      signUpLoading,
      updateProfileLoading,
      checkUsernameExistLoading;

  final GetStartedModel? getStartedModel;
  final ProfileModel? profileModel;
  final ThemeData? themeData;
  final String? getProfileError;
  final bool? getProfileLoading;
  factory AuthState.empty() {
    return AuthState(
      checkUsernameExistLoading: false,
      getStartedModel: null,
      profileModel: null,
      getStartedRequesting: false,
      verifyCodeLoading: false,
      resetPasswordLoading: false,
      loginLoading: false,
      signUpLoading: false,
      updateProfileLoading: false,
      themeData: ThemeManager().darkTheme,
      getProfileError: '',
      getProfileLoading: false,
    );
  }

  const AuthState({
    this.getProfileLoading,
    this.checkUsernameExistLoading,
    this.getStartedRequesting,
    this.verifyCodeLoading,
    this.resetPasswordLoading,
    this.getStartedModel,
    this.profileModel,
    this.loginLoading,
    this.signUpLoading,
    this.updateProfileLoading,
    this.themeData,
    this.getProfileError,
  });

  AuthState copyWith({
    bool? getStartedRequesting,
    verifyCodeLoading,
    resetPasswordLoading,
    loginLoading,
    signUpLoading,
    String? getStartedErrorCode,
    getStartedErrorMessage,
    GetStartedModel? getStartedModel,
    ProfileModel? profileModel,
    bool? updateProfileLoading,
    ThemeData? themeData,
    bool? checkUsernameExistLoading,
    String? getProfileError,
    bool? getProfileLoading,
  }) {
    return AuthState(
      getProfileLoading: getProfileLoading ?? this.getProfileLoading,
      getProfileError: getProfileError ?? this.getProfileError,
      checkUsernameExistLoading:
          checkUsernameExistLoading ?? this.checkUsernameExistLoading,
      updateProfileLoading: updateProfileLoading ?? this.updateProfileLoading,
      getStartedRequesting: getStartedRequesting ?? this.getStartedRequesting,
      verifyCodeLoading: verifyCodeLoading ?? this.verifyCodeLoading,
      getStartedModel: getStartedModel ?? this.getStartedModel,
      resetPasswordLoading: resetPasswordLoading ?? this.resetPasswordLoading,
      profileModel: profileModel ?? this.profileModel,
      loginLoading: loginLoading ?? this.loginLoading,
      signUpLoading: signUpLoading ?? this.signUpLoading,
      themeData: themeData ?? this.themeData,
    );
  }

  AuthState copyWithNull({
    bool? getStartedRequesting,
    verifyCodeLoading,
    resetPasswordLoading,
    loginLoading,
    signUpLoading,
    String? getStartedErrorCode,
    getStartedErrorMessage,
    GetStartedModel? getStartedModel,
    ProfileModel? profileModel,
    bool? updateProfileLoading,
    ThemeData? themeData,
    String? getProfileError,
    bool? getProfileLoading,
  }) {
    return AuthState(
      getProfileLoading: getProfileLoading ?? this.getProfileLoading,
      getProfileError: getProfileError ?? this.getProfileError,
      checkUsernameExistLoading: checkUsernameExistLoading,
      updateProfileLoading: updateProfileLoading ?? this.updateProfileLoading,
      getStartedRequesting: getStartedRequesting ?? this.getStartedRequesting,
      verifyCodeLoading: verifyCodeLoading ?? this.verifyCodeLoading,
      getStartedModel: getStartedModel,
      resetPasswordLoading: resetPasswordLoading ?? this.resetPasswordLoading,
      profileModel: profileModel,
      loginLoading: loginLoading ?? this.loginLoading,
      signUpLoading: signUpLoading ?? this.signUpLoading,
      themeData: themeData ?? this.themeData,
    );
  }

  @override
  List<Object?> get props => [
        getProfileLoading,
        getProfileError,
        checkUsernameExistLoading,
        updateProfileLoading,
        getStartedRequesting,
        getStartedModel,
        resetPasswordLoading,
        verifyCodeLoading,
        profileModel,
        loginLoading,
        signUpLoading,
        themeData,
      ];
}
