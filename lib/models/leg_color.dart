import 'package:firedart/firedart.dart';
import '../services/cloud_functions.dart';


class LegC {
  final String legColor;
  LegC(
      {required this.legColor,
      });

 Map<String, dynamic> getDataMap() {
    return {
      "legColor": legColor,
    };
  }

}
 
CollectionReference legColorsCollection = collectionOfItem('LegColors');

Stream<List<Document>> legColorsStream = streamOfCollection(legColorsCollection);

/*

addLegC(String legColor) async{

        if(!legColor.isEmpty){
                  LegC legColorToAdd = LegC(
                   legColor:legColor,
                   );                
                legColorsCollection.document(legColor).set(legColorToAdd.getDataMap());
        }
}     

*/
