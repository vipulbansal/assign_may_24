


import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/image_entity.dart';
import '../repository/image_param.dart';
import '../repository/image_repository.dart';

class GetImageUseCase implements UseCase<DataState<List<ImageEntity>>,ImageParam>{
  
  final ImageRepository _articleRepository;

  GetImageUseCase(this._articleRepository);
  
  @override
  Future<DataState<List<ImageEntity>>> call({required ImageParam params}) {
    return _articleRepository.getImages(params);
  }

  
}