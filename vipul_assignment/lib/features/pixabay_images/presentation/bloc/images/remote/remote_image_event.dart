

import '../../../../domain/repository/image_param.dart';

abstract class RemoteImagesEvent {
  const RemoteImagesEvent();
}

class GetImages extends RemoteImagesEvent {
  const GetImages();
}

class GetImagesMore extends RemoteImagesEvent {
  final ImageParam imageParam;
   GetImagesMore(this.imageParam);
}

class SearchImages extends RemoteImagesEvent {
   final ImageParam imageParam;
  const SearchImages(this.imageParam);
}
