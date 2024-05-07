import 'dart:convert';



import '../../../../core/constants/constants.dart';
import '../../domain/entities/image_entity.dart';


List<ImageModel> parseImages(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return List<ImageModel>.from(parsed['hits'].map((model) => ImageModel.fromJson(model)));
}

class ImageModel extends ImageEntity {
  const ImageModel({
    int ? id,
    final int ? likes,
    final int ? views,

    required final String previewUrl,
    required  final String webformatUrl,
    required  final String largeImageUrl
  }) : super(
    id: id,
    likes: likes,
    views: views,
    previewUrl: previewUrl,
    webformatUrl: webformatUrl,
    largeImageUrl: largeImageUrl);

  factory ImageModel.fromJson(Map <String, dynamic> map) {
    return ImageModel(
        id: map["id"],
        previewUrl: map["previewURL"],
        webformatUrl: map["webformatURL"],
        largeImageUrl: map["largeImageURL"],
        views: map["views"],
        likes: map["likes"]
    );
  }

  factory ImageModel.fromEntity(ImageEntity entity) {
    return ImageModel(
        id: entity.id,
        views:entity.views,
        likes: entity.likes,
        previewUrl: entity.previewUrl,
        webformatUrl: entity.webformatUrl,
        largeImageUrl: entity.webformatUrl
    );
  }
}