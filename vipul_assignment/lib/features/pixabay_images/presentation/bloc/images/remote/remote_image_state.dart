import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entities/image_entity.dart';

abstract class RemoteImagesState extends Equatable {
  final List<ImageEntity>? images;
  final int pageNumber;
  final DioException? error;

  const RemoteImagesState({this.images, this.error, this.pageNumber = 1});

  @override
  List<Object> get props => [images!, error!];
}

class RemoteArticlesLoading extends RemoteImagesState {
  const RemoteArticlesLoading();
}

class RemoteArticlesLoadingMore extends RemoteImagesState {
  RemoteArticlesLoadingMore(RemoteImagesState currentState)
      : super(images: currentState.images);
}

class RemoteArticlesDone extends RemoteImagesState {
  const RemoteArticlesDone(List<ImageEntity> article, int pageNumber)
      : super(images: article, pageNumber: pageNumber);
}

class RemoteArticlesError extends RemoteImagesState {
  RemoteArticlesError(DioException error, RemoteImagesState currentState)
      : super(error: error, images: currentState.images);
}
