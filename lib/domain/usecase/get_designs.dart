
import 'package:geo_artz/data/design_repository.dart';
import 'package:geo_artz/domain/model/drawing.dart';

class GetDesigns {

  final DesignRepository designRepository;

  GetDesigns(this.designRepository);

  Stream<List<Drawing>> execute() {
    return designRepository.getDesigns();
  }

}