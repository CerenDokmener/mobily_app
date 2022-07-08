import 'package:firedart/firedart.dart';
import '../services/cloud_functions.dart';


class Fabric {
  final String fabricModel;
  final List<String> fabricColors;
  final int selected;
  Fabric(
      {
        required this.fabricModel,
        required this.fabricColors,
        required this.selected,
      });

 Map<String, dynamic> getDataMap() {
    return {
      "fabricModel": fabricModel,
      "fabricColors": fabricColors,
      "selected": selected,
    };
  }
  
}

CollectionReference fabricsCollection = collectionOfItem('Fabrics');

Stream<List<Document>> fabricsStream = streamOfCollection(Firestore.instance.collection('Fabrics'));

updateFabric(String fabricModel,int index) async{
    await fabricsCollection.document(fabricModel).update({'selected': index});
}



addFabric(String fabricModel,List<String> fabricColors, int selected) async{

        if(!fabricModel.isEmpty && !fabricColors.isEmpty && selected != 0){
                  Fabric fabricToAdd = Fabric(
                   fabricModel:fabricModel,
                   fabricColors:fabricColors,
                   selected:selected,
                   );                
                fabricsCollection.document(fabricModel).set(fabricToAdd.getDataMap());
        }
}  



      
