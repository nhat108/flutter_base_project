import 'package:equatable/equatable.dart';

import 'img_s3_model.dart';

class ProfileModel extends Equatable {
  final String? id, phoneNumber, displayName, userName;
  final int? numberOfFollowers, numberOfFollowingUsers, numberOfVideos;
  final double? tipBalance;
  final ImgS3Model? avatar;
  final AddressModel? address;
  final String? email;
  final String? bio;
  final String? website;
  final String? pronouns;
  final int? numberOfTippers;

  final int? engagementPoints;
  const ProfileModel({
    this.tipBalance,
    this.numberOfFollowers,
    this.numberOfFollowingUsers,
    this.numberOfVideos,
    this.avatar,
    this.userName,
    this.phoneNumber,
    this.id,
    this.displayName,
    this.address,
    this.email,
    this.bio,
    this.pronouns,
    this.website,
    this.numberOfTippers,
    this.engagementPoints,
  });
  static ProfileModel fromJson(dynamic json) {
    return ProfileModel(
      engagementPoints: json['engagement_points'],
      id: json['id'],
      numberOfTippers: json['number_of_tippers'],
      displayName: json['display_name'],
      userName: json['username'],
      phoneNumber: json['phone_number'],
      avatar: json['cover_image_link'] != null
          ? ImgS3Model.fromJson(json['cover_image_link'])
          : null,
      numberOfFollowers: json['number_of_followers'],
      numberOfFollowingUsers: json['number_of_following_users'],
      numberOfVideos: json['number_of_videos'],
      tipBalance: json['tip_balance'],
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
      bio: json['bio'],
      email: json['email'],
      pronouns: json['pronouns'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "phone_number": phoneNumber,
      "cover_image_link": null,
      "username": userName,
      "display_name": displayName,
      "preferred_name": null,
      "number_of_followers": numberOfFollowers,
      "number_of_following_users": numberOfFollowingUsers,
      "number_of_videos": numberOfVideos,
      "number_of_tippers": numberOfTippers,
      "tip_balance": tipBalance,
      "pronouns": pronouns,
      "website": website,
      "dob": null,
      "bio": bio,
      "first_name": null,
      "last_name": null,
      "email": email,
      "address": null,
      "engagement_points": engagementPoints,
    };
  }

  @override
  List<Object?> get props => [
        engagementPoints,
        numberOfTippers,
        tipBalance,
        numberOfFollowers,
        numberOfFollowingUsers,
        numberOfVideos,
        avatar,
        userName,
        phoneNumber,
        id,
        displayName,
        address,
        email,
        bio,
        pronouns,
        website,
      ];
}

class AddressModel extends Equatable {
  final String? id;
  final String? country;
  final String? addressLine;
  final String? postalCode;
  final String? state;
  final String? city;

  const AddressModel(
      {this.id,
      this.country,
      this.addressLine,
      this.postalCode,
      this.state,
      this.city});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressLine: json['address_line'],
      city: json['city'],
      country: json['country'],
      id: json['id'],
      postalCode: json['postal_code'],
      state: json['state'],
    );
  }
  @override
  List<Object?> get props =>
      [id, country, addressLine, postalCode, state, city];
}
