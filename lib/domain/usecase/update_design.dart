

import 'package:geo_artz/data/design_repository.dart';
import 'package:geo_artz/domain/model/drawing.dart';

class UpdateDesign {

  final DesignRepository designRepository;

  UpdateDesign(this.designRepository);

  Future<void> execute(Drawing design) {
    return designRepository.updateDesign(design);
  }

}