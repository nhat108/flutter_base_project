import 'package:equatable/equatable.dart';

import '../../auth/img_s3_model.dart';

class NotificationModel extends Equatable {
  final String? id;
  final SenderNotice? senderNotice;
  final String? title;
  final String? body;
  final bool? isRead;
  final int? types;
  final String? createdAt;

  const NotificationModel(
      {this.id,
      this.senderNotice,
      this.title,
      this.body,
      this.isRead,
      this.types,
      this.createdAt});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      body: json['body'],
      createdAt: json['created_at'],
      id: json['id'],
      isRead: json['is_read'],
      senderNotice: json['sender_notice'] != null
          ? SenderNotice.fromJson(json['sender_notice'])
          : null,
      title: json['title'],
      types: json['types'],
    );
  }
  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      body: body,
      createdAt: createdAt,
      id: id,
      isRead: isRead ?? this.isRead,
      senderNotice: senderNotice,
      title: title,
      types: types,
    );
  }

  @override
  List<Object?> get props =>
      [id, senderNotice, title, body, isRead, types, createdAt];
}

class SenderNotice extends Equatable {
  final String? id;
  final String? displayUsername;
  final String? username;
  final ImgS3Model? image;
  final String? preferredName;

  const SenderNotice(
      {this.id,
      this.displayUsername,
      this.username,
      this.image,
      this.preferredName});

  factory SenderNotice.fromJson(Map<String, dynamic> json) {
    return SenderNotice(
      displayUsername: json['display_name'],
      id: json['id'],
      image: json['image'] != null ? ImgS3Model.fromJson(json['image']) : null,
      preferredName: json['preferred_name'],
      username: json['username'],
    );
  }
  @override
  List<Object?> get props =>
      [id, displayUsername, username, image, preferredName];
}
