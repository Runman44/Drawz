

import 'package:geo_artz/data/design_repository.dart';
import 'package:geo_artz/domain/model/drawing.dart';

class StoreDesign {

  final DesignRepository designRepository;

  StoreDesign(this.designRepository);

  Future<void> execute(Drawing design) {
    return designRepository.storeDesign(design);
  }

}