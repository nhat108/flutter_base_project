import 'package:equatable/equatable.dart';

class GetStartedModel extends Equatable {
  const GetStartedModel({
    this.userExist,
    this.phoneNumber,
    this.isVerifiedUser,
    this.userId,
    this.username,
    this.isActive,
  });

  final bool? userExist;
  final String? phoneNumber;
  final bool? isVerifiedUser;
  final String? userId, username;
  final bool? isActive;

  GetStartedModel copyWith(
          {bool? userExist,
          String? phoneNumber,
          bool? isVerifiedUser,
          String? userId,
          bool? isActive,
          username}) =>
      GetStartedModel(
        isActive: isActive ?? this.isActive,
        userExist: userExist ?? this.userExist,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isVerifiedUser: isVerifiedUser ?? this.isVerifiedUser,
        userId: userId ?? this.userId,
        username: username ?? this.username,
      );

  factory GetStartedModel.fromJson(Map<String, dynamic> json) =>
      GetStartedModel(
        isActive: json['is_active'],
        userExist: json["is_exist"],
        phoneNumber: json["phone"],
        isVerifiedUser: json["is_verified_phone"],
        username: json["username"],
        userId: json["user_id"],
      );

  @override
  List<Object?> get props =>
      [userExist, phoneNumber, isVerifiedUser, userId, username, isActive];
}
