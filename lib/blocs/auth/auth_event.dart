part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthGetStarted extends AuthEvent {
  final String phoneNumber;
  final Function(String) onSuccess;
  final Function(String) onError;
  const AuthGetStarted(
      {required this.onError,
      required this.onSuccess,
      required this.phoneNumber});
}

class AuthResumeSession extends AuthEvent {
  final Function(bool isResume, bool hasCategory) onSuccess;
  final Function(String) onError;
  const AuthResumeSession({required this.onSuccess, required this.onError});
}

class AuthLogin extends AuthEvent {
  final String userName, password;
  final Function(bool hasCategory) onSuccess;
  final Function(String) onError;
  const AuthLogin(
      {required this.onError,
      required this.userName,
      required this.password,
      required this.onSuccess});
}

class AuthSignUp extends AuthEvent {
  final Map<String, dynamic> body;
  final Function(bool showUpdateCategory) onSuccess;
  final Function(String) onError;
  const AuthSignUp(
      {required this.onError, required this.body, required this.onSuccess});
}

class AuthLogout extends AuthEvent {
  final Function onSuccess;

  const AuthLogout({required this.onSuccess});
}

class AuthResendCode extends AuthEvent {
  final String userName;
  final Function onSuccess;
  final Function(String) onError;
  const AuthResendCode(
      {required this.userName, required this.onError, required this.onSuccess});
}

class AuthVerifyCode extends AuthEvent {
  final String userName;
  final String? password;
  final String code;
  final Function onSuccess;
  final Function(String) onError;
  const AuthVerifyCode(
      {this.password,
      required this.code,
      required this.userName,
      required this.onError,
      required this.onSuccess});
}

class AuthDismissError extends AuthEvent {}

class AuthUpdatePassword extends AuthEvent {
  final String currentPassword;
  final String newPassword;
  final Function onSuccess;
  final Function(String) onError;
  const AuthUpdatePassword(
      {required this.currentPassword,
      required this.newPassword,
      required this.onError,
      required this.onSuccess});
}

class AuthForgotPassword extends AuthEvent {
  final String username;
  final Function onSuccess;
  final Function(String) onError;
  const AuthForgotPassword(
      {required this.username, required this.onError, required this.onSuccess});
}

class AuthResetPassword extends AuthEvent {
  final String code;
  final String password;
  final String username;
  final Function onSuccess;
  final Function(String) onError;
  const AuthResetPassword({
    required this.code,
    required this.password,
    required this.onError,
    required this.onSuccess,
    required this.username,
  });
}

class AuthFCM extends AuthEvent {
  final Map<String, dynamic> body;
  const AuthFCM({required this.body});
}

class AuthGetProfile extends AuthEvent {}

class AuthUpdateProfile extends AuthEvent {
  final Map<String, dynamic> body;
  final File? image;
  final Function onSuccess;
  final Function(String) onError;

  const AuthUpdateProfile(
      {required this.body,
      required this.onSuccess,
      required this.onError,
      this.image});
}

class AuthChangeTheme extends AuthEvent {
  final String theme;

  const AuthChangeTheme({required this.theme});
}

class LogOut extends AuthEvent {
  final VoidCallback onSuccess;
  final Function(String) onError;
  const LogOut({required this.onError, required this.onSuccess});
}

class UpdatePhone extends AuthEvent {
  final String phoneNumber;
  final Function(String) onError;
  final VoidCallback onSuccess;

  const UpdatePhone(
      {required this.onError,
      required this.onSuccess,
      required this.phoneNumber});
}

class VerifyCodeUpdatePhone extends AuthEvent {
  final String code;
  final String phoneNumber;
  final VoidCallback onSuccess;
  final Function(String) onError;

  const VerifyCodeUpdatePhone(
      {required this.phoneNumber,
      required this.onSuccess,
      required this.onError,
      required this.code});
}

class UpdateUsername extends AuthEvent {
  final String username;
  final String displayName;
  final Function(String) onError;
  final VoidCallback onSuccess;

  const UpdateUsername(
      {required this.displayName,
      required this.username,
      required this.onError,
      required this.onSuccess});
}

class CheckUsername extends AuthEvent {
  final String username;
  final Function(bool) onResult;

  const CheckUsername({required this.username, required this.onResult});
}

class DeactivateAccount extends AuthEvent {
  final VoidCallback onSuccess;
  final Function(String) onError;

  const DeactivateAccount({required this.onSuccess, required this.onError});
}
