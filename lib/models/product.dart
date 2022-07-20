import 'package:firedart/firedart.dart';
import '../services/cloud_functions.dart';

class Product {
  final String productName;
  Product({
    required this.productName,
  });

  Map<String, dynamic> getDataMap() {
    return {
      "productName": productName,
    };
  }
}

CollectionReference productsCollection = collectionOfItem('ProductNames');

Stream<List<Document>> productsStream = streamOfCollection(productsCollection);

/*

addProduct(String productName) async{

        if(!productName.isEmpty){
                  Product productToAdd = Product(
                   productName:productName,
                   );                
                productNamesCollection.document(productName).set(productToAdd.getDataMap());
        }
}  

*/

      
