
import 'package:geo_artz/data/design_data_source_database.dart';
import 'package:geo_artz/domain/model/drawing.dart';

class DesignRepository {

  final DesignDataSourceDatabase designDataSourceDatabase;

  DesignRepository(this.designDataSourceDatabase);

  Future<void> storeDesign(Drawing design) {
    return designDataSourceDatabase.store(design);
  }

  Future<void> updateDesign(Drawing design) {
    return designDataSourceDatabase.update(design);
  }

  Stream<List<Drawing>> getDesigns() {
    return designDataSourceDatabase.getDesigns();
  }

}