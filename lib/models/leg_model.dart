import 'package:firedart/firedart.dart';
import '../services/cloud_functions.dart';


class Leg {
  final String legModel;
  Leg(
      {required this.legModel,
      });

 Map<String, dynamic> getDataMap() {
    return {
      "legModel": legModel,
    };
  }

}
 
CollectionReference legModelsCollection = collectionOfItem('LegModels');

final Stream<List<Document>> legModelsStream = streamOfCollection(legModelsCollection);

addLeg(String legModel) async{

        if(!legModel.isEmpty){
                  Leg legToAdd = Leg(
                   legModel:legModel,
                   );                
                legModelsCollection.document(legModel).set(legToAdd.getDataMap());
        }
}     

      
