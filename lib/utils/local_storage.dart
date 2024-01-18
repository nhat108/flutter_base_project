import 'dart:convert';

import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_constrants.dart';
import '../config/env.dart';

class LocalStorage {
  final userPool = CognitoUserPool(
    AppConfig().userPoolId!,
    AppConfig().clientId!,
  );

  final storage = const FlutterSecureStorage();

  /// HANDLE TOKEN
  Future<void> refreshToken() async {
    dynamic userInfo = await getUserPass();
    final cognitoUser = CognitoUser(userInfo['user'], userPool);

    final authDetails = AuthenticationDetails(
        username: userInfo['user'], password: userInfo['pwd']);

    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      dynamic token = {
        'token': session?.getIdToken().getJwtToken(),
      };
      print(session!.accessToken.payload);
      await persistToken(
          user: userInfo['user'], pass: userInfo['pwd'], token: token['token']);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<dynamic> getUserPass() async {
    try {
      return {
        'user': await storage.read(key: AppConstrants.user),
        'pwd': await storage.read(key: AppConstrants.pwd),
        'email': await storage.read(key: AppConstrants.email),
      };
    } catch (e) {
      return {
        'user': null,
        'pwd': null,
        'email': null,
      };
    }
  }

  Future<void> persistToken(
      {required String user,
      required String pass,
      required String token}) async {
    await storage.write(key: AppConstrants.user, value: user);
    await storage.write(key: AppConstrants.pwd, value: pass);
    await storage.write(key: AppConstrants.token, value: token);
    final expireTimeInTimestamp =
        DateTime.now().millisecondsSinceEpoch + (1 * 60 * 60 * 1000);
    print("milisecond: ${DateTime.now().millisecondsSinceEpoch}");
    print("expireTimeInTimestamp $expireTimeInTimestamp");
    await storage.write(
        key: AppConstrants.expired, value: expireTimeInTimestamp.toString());

    return;
  }

  Future<dynamic> getToken() async {
    return await storage.read(key: AppConstrants.token);
  }

  Future<bool> hasExpireToken() async {
    try {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      if (await storage.read(key: AppConstrants.expired) != null) {
        final expireTime =
            int.parse((await storage.read(key: AppConstrants.expired))!);
        if ((expireTime - currentTime) < 60000) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> hasToken() async {
    try {
      String? token = await storage.read(key: AppConstrants.token);
      if (token != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      await storage.deleteAll();
      return false;
    }
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await storage.delete(key: AppConstrants.token);
    await storage.delete(key: AppConstrants.user);
    await storage.delete(key: AppConstrants.pwd);
    await storage.delete(key: AppConstrants.expired);
    await storage.delete(key: AppConstrants.email);
    await storage.delete(key: AppConstrants.theme);
    await storage.deleteAll();
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    await checkFirstInstall();

    await prefs.setBool('first_run', false);
    return;
  }

  Future<void> saveTheme({String theme = AppConstrants.darkTheme}) async {
    await storage.write(key: AppConstrants.theme, value: theme);
    return;
  }

  Future<String> readTheme() async {
    String? theme = await storage.read(key: AppConstrants.theme);
    return theme ?? AppConstrants.darkTheme;
  }

  /// API
  Future<String?> loginCognito(
      {required String userName, required String password}) async {
    final cognitoUser = CognitoUser(userName, userPool);
    final authDetails = AuthenticationDetails(
      username: userName,
      password: password,
    );
    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      print("getExpiration: ${session?.getIdToken().getExpiration()}");
    } catch (e) {
      print(e);
      rethrow;
    }

    return session?.getIdToken().getJwtToken();
  }

  Future<String> signUpCognito({
    required String id,
    required String fullName,
    required String password,
    required String phoneNumber,
  }) async {
    final userAttributes = [
      AttributeArg(
        name: 'name',
        value: fullName,
      ),
      AttributeArg(
        name: 'phone_number',
        value: phoneNumber,
      ),
    ];

    try {
      await userPool.signUp(
        id,
        password,
        userAttributes: userAttributes,
      );
      return id;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> verifyCodeCognito({String? userName, String? code}) async {
    final cognitoUser = CognitoUser(userName, userPool);
    try {
      var confrim = await cognitoUser.confirmRegistration(code!);
      return confrim;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resendCodeCognito({String? userName}) async {
    final cognitoUser = CognitoUser(userName, userPool);
    try {
      var data = await cognitoUser.resendConfirmationCode();
      print(data.toString());
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> forgotPassword({required String userName}) async {
    final cognitoUser = CognitoUser(userName, userPool);
    try {
      await cognitoUser.forgotPassword();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> confirmNewPassword(
      {required String userName,
      required String code,
      required String newPassword}) async {
    final cognitoUser = CognitoUser(userName, userPool);
    try {
      await cognitoUser.confirmPassword(code, newPassword);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updatePassword(
      {required String userName,
      required String currentPassword,
      required String newPassword}) async {
    final cognitoUser = CognitoUser(userName, userPool);
    final authDetails = AuthenticationDetails(
      username: userName,
      password: currentPassword,
    );

    await cognitoUser.authenticateUser(authDetails);
    try {
      await cognitoUser.changePassword(currentPassword, newPassword);
      await storage.write(key: AppConstrants.pwd, value: newPassword);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updatePhonenumber({required String phoneNumber}) async {
    final cognitoUser = await getCognitoUserWithAuthen();
    var data = await cognitoUser.getAttributeVerificationCode("phone_number");
    print(data);
    return true;
  }

  Future<bool> verifyAttribute(
      {required String confirmationCode,
      required String attributeName,
      required String value}) async {
    final cognitoUser = await getCognitoUserWithAuthen();
    // try {
    //   var data = await cognitoUser.getAttributeVerificationCode(attributeName);
    //   print(data);
    // } catch (e) {
    //   print(e.toString());
    // }

    bool isVerify =
        await cognitoUser.verifyAttribute(attributeName, confirmationCode);
    if (isVerify) {
      return updateAttribute(
          cognitoUser: cognitoUser, attributeName: attributeName, value: value);
    }
    return false;
  }

  Future<bool> updateAttribute(
      {required String attributeName,
      required String value,
      CognitoUser? cognitoUser}) async {
    CognitoUser? cognito;
    if (cognitoUser != null) {
      cognito = cognitoUser;
    } else {
      cognito = await getCognitoUserWithAuthen();
    }
    return cognito.updateAttributes(
        [CognitoUserAttribute(name: attributeName, value: value)]);
  }

  Future<CognitoUser> getCognitoUserWithAuthen() async {
    final userName = await storage.read(key: AppConstrants.user);
    final password = await storage.read(key: AppConstrants.pwd);
    final cognitoUser = CognitoUser(userName, userPool);
    final authDetails = AuthenticationDetails(
      username: userName,
      password: password,
    );

    await cognitoUser.authenticateUser(authDetails);

    return cognitoUser;
  }

  Future getAllAttributes() async {
    var cognito = await getCognitoUserWithAuthen();
    var attributes = await cognito.getUserAttributes();
    print(attributes);
  }

  Future<CognitoUserSession?> getSession() async {
    final userName = await storage.read(key: AppConstrants.user);
    final password = await storage.read(key: AppConstrants.pwd);
    final cognitoUser = CognitoUser(userName, userPool);
    final authDetails = AuthenticationDetails(
      username: userName,
      password: password,
    );

    return cognitoUser.authenticateUser(authDetails);
  }

  Future<bool> isFirstInstall() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getBool(AppConstrants.firstInstall);
    if (result != null) {
      return result;
    }
    return true;
  }

  Future<void> checkFirstInstall() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstrants.firstInstall, false);
  }

  Future<void> setProfileLocal(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstrants.profileLocal, jsonEncode(data));
  }

  Future<Map<String, dynamic>?> getProfileLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var result = prefs.getString(AppConstrants.profileLocal);
      if (result != null) {
        final map = jsonDecode(result) as Map<String, dynamic>;
        return map;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
