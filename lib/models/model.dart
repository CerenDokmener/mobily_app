import 'package:firedart/firedart.dart';

import '../services/cloud_functions.dart';

class Model {
  final String modelName;
  final List<String> products;
  final List<String> fabrics;
  final List<String> legColors;
  final List<String> legModels;

  Model(
      {required this.products,
      required this.fabrics,
      required this.legColors,
      required this.legModels,
      required this.modelName});

  Map<String, dynamic> getDataMap() {
    return {
      "products": products,
      "fabrics": fabrics,
      "legColors": legColors,
      "legModels": legModels,
      "modelName": modelName,
    };
  }
}

CollectionReference modelsCollection = collectionOfItem('Models');

Stream<List<Document>> modelsStream = streamOfCollection(modelsCollection);

addModel(String modelName, List<String> products, fabrics, legColors,
    legModels) async {
  if (modelName.isNotEmpty &&
      products.isNotEmpty &&
      fabrics.isNotEmpty &&
      legColors.isNotEmpty &&
      legModels.isNotEmpty) {
    Model modelToAdd = Model(
      modelName: modelName,
      products: products,
      fabrics: fabrics,
      legColors: legColors,
      legModels: legModels,
    );
    modelsCollection.document(modelName).set(modelToAdd.getDataMap());
  }
}
