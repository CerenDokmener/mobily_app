import 'package:firedart/firedart.dart';
import '../services/cloud_functions.dart';

class Branch {
  final String branchName, belongedCompany, password;

  Branch({
    required this.branchName,
    required this.belongedCompany,
    required this.password,
  });

  Map<String, dynamic> getDataMap() {
    return {
      "branchName": branchName,
      "belongedCompany": belongedCompany,
      "password": password,
    };
  }
}

CollectionReference branchesCollection = collectionOfItem('Branches');

Stream<List<Document>> branchesStream = streamOfCollection(branchesCollection);

addBranch(String branchName, belongedCompany, password) async {
  if (branchName.isNotEmpty &&
      belongedCompany.isNotEmpty &&
      password.isNotEmpty) {
    Branch branchToAdd = Branch(
      branchName: branchName,
      belongedCompany: belongedCompany,
      password: password,
    );
    branchesCollection.document(branchName).set(branchToAdd.getDataMap());
  }
}
