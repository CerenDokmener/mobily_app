import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';


// string.capitalize() function capitalize the first letter of string

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
}

CollectionReference collectionOfItem(String collectionName){
   return Firestore.instance.collection(collectionName);
}


Stream<List<Document>> streamOfCollection(CollectionReference collectionReference){

  return collectionReference.stream;

}





class Item {
  final String itemType,itemDetail;
  Item(
      {required this.itemType,required this.itemDetail,
      });

 Map<String, dynamic> getDataMap() {
    return {
      itemType: itemDetail,
    };
  }

}

deleteItem(String itemName, CollectionReference refOfItem) async{
        await refOfItem.document(itemName).delete();
}

addItem(String itemType,String itemDetail) async{

        if(!itemDetail.isEmpty){
                  Item itemToAdd = Item(
                   itemType:itemType,
                   itemDetail:itemDetail,
                   );             

                collectionOfItem(itemType.capitalize()+'s').document(itemDetail).set(itemToAdd.getDataMap());
        }
}     