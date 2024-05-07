import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final int ? id;
  final int ? likes;
  final int ? views;
  final String previewUrl;
  final String webformatUrl;
  final String largeImageUrl;

  const ImageEntity({
    this.id,
    this.likes,
    this.views,
    this.previewUrl='',
    this.webformatUrl='',
    this.largeImageUrl=''
  });

  @override
  List <Object ?> get props {
    return [
      id,
      likes,
      views,
      previewUrl,
      webformatUrl,
      largeImageUrl
    ];
  }
}