import 'package:firedart/firedart.dart';
import '../services/cloud_functions.dart';

class Fabric {
  final String fabricModel;
  final List<String> fabricColors;

  Fabric({
    required this.fabricModel,
    required this.fabricColors,
  });

  Map<String, dynamic> getDataMap() {
    return {
      "fabricModel": fabricModel,
      "fabricColors": fabricColors,
    };
  }
}

CollectionReference fabricsCollection = collectionOfItem('Fabrics');

Stream<List<Document>> fabricsStream = streamOfCollection(fabricsCollection);

addFabric(String fabricModel, List<String> fabricColors) async {
  if (fabricModel.isNotEmpty && fabricColors.isNotEmpty) {
    Fabric fabricToAdd = Fabric(
      fabricModel: fabricModel,
      fabricColors: fabricColors,
    );
    fabricsCollection.document(fabricModel).set(fabricToAdd.getDataMap());
  }
}
