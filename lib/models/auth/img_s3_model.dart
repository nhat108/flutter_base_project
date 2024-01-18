import 'package:equatable/equatable.dart';

class ImgS3Model extends Equatable {
  const ImgS3Model(
      {this.large,
      this.logo,
      this.medium,
      this.mini,
      this.thumbnail,
      this.orignalImageLink});

  final Image? large;
  final Image? logo;
  final Image? medium;
  final Image? mini;
  final Image? thumbnail;
  final String? orignalImageLink;

  factory ImgS3Model.fromJson(Map<String, dynamic> json) => ImgS3Model(
        large: Image.fromJson(json["large"]),
        orignalImageLink: json['original_image_link'],
        logo: Image.fromJson(json["logo"]),
        medium: Image.fromJson(json["medium"]),
        mini: Image.fromJson(json["mini"]),
        thumbnail: Image.fromJson(json["thumbnail"]),
      );
  Map<String, dynamic> toMap() {
    return {
      "large": large?.toMap(),
      "original_image_link": orignalImageLink,
      "logo": logo?.toMap(),
      "medium": medium?.toMap(),
      "mini": mini?.toMap(),
      "thumbnail": thumbnail?.toMap(),
    };
  }

  @override
  List<Object?> get props =>
      [large, logo, medium, mini, thumbnail, orignalImageLink];
}

class Image extends Equatable {
  const Image({
    this.width,
    this.height,
    this.url,
  });

  final int? width;
  final int? height;
  final String? url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        width: json["width"],
        height: json["height"],
        url: json["url"],
      );
  Map<String, dynamic> toMap() {
    return {
      "width": width,
      "height": height,
      "url": url,
    };
  }

  @override
  List<Object?> get props => [
        width,
        height,
        url,
      ];
}
