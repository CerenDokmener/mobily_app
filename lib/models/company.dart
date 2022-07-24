import 'package:firedart/firedart.dart';
import '../services/cloud_functions.dart';

class Company {
  final String companyName, password;

  Company({
    required this.companyName,
    required this.password,
  });

  Map<String, dynamic> getDataMap() {
    return {
      "companyName": companyName,
      "password": password,
    };
  }
}

CollectionReference companiesCollection = collectionOfItem('Companies');

Stream<List<Document>> companiesStream =
    streamOfCollection(companiesCollection);

addCompany(String companyName, password) async {
  if (companyName.isNotEmpty && password.isNotEmpty) {
    Company companyToAdd = Company(
      companyName: companyName,
      password: password,
    );
    companiesCollection.document(companyName).set(companyToAdd.getDataMap());
  }
}
