import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import '../services/globals.dart' as globals;

// string.capitalize() function capitalize the first letter of string

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

CollectionReference collectionOfItem(String collectionName) {
  return Firestore.instance.collection(collectionName);
}

Stream<List<Document>> streamOfCollection(
    CollectionReference collectionReference) {
  return collectionReference.stream;
}

class Item {
  final String itemType, itemDetail;
  Item({
    required this.itemType,
    required this.itemDetail,
  });

  Map<String, dynamic> getDataMap() {
    return {
      itemType: itemDetail,
    };
  }
}

deleteOrder(String orderID, String status) async {
  String orderRef = '';
  switch (status) {
    case 'Beklemede':
      orderRef = 'newOrders';
      break;
    case 'Üretiliyor':
      orderRef = 'onGoingOrders';
      break;
    case 'Depoda':
      orderRef = 'inStorageOrders';
      break;
    case 'Tamamlandı':
      orderRef = 'completedOrders';
      break;
  }
  await collectionOfItem('Orders')
      .document(orderRef)
      .collection('orders')
      .document(orderID)
      .delete();
}

updateOrder(String status, Document doc, bool reverse) async {
  List<String> allOfDoc = doc.toString().split(' ');
  List<String> justPath = allOfDoc[0].split('/');
  String orderID = justPath[4];
  String orderRef = '';
  String orderToRef = '';

  switch (status) {
    case 'Beklemede':
      orderRef = 'newOrders';
      break;
    case 'Üretiliyor':
      orderRef = 'onGoingOrders';
      break;
    case 'Depoda':
      orderRef = 'inStorageOrders';
      break;
    case 'Tamamlandı':
      orderRef = 'completedOrders';
      break;
  }
  if (!reverse) {
    switch (status) {
      case 'Beklemede':
        orderToRef = 'onGoingOrders';
        break;
      case 'Üretiliyor':
        orderToRef = 'inStorageOrders';
        break;
      case 'Depoda':
        orderToRef = 'completedOrders';
        break;
    }
  } else {
    switch (status) {
      case 'Üretiliyor':
        orderToRef = 'newOrders';
        break;
      case 'Depoda':
        orderToRef = 'onGoingOrders';
        break;
      case 'Tamamlandı':
        orderToRef = 'inStorageOrders';
        break;
    }
  }

  await deleteOrder(orderID, status);

  await collectionOfItem('Orders')
      .document(orderToRef)
      .collection('orders')
      .document(orderID)
      .set(doc.map);
}

//////////////////////////////

Future<List<String>> getCustomerNames(String orderRef) async {
  List<Document> orders = await collectionOfItem('Orders')
      .document(orderRef)
      .collection('orders')
      .get();
  List<String> customers = [];

  for (int i = 0; orders.length > i; i++) {
    Map<String, dynamic>? value = orders[i].map;
    if (!customers.contains(value['customerName'])) {
      customers.add(value['customerName']);
    }
  }

  return customers;
}

Future<List<String>> getFabricColors() async {
  List<Document> fabrics = await collectionOfItem('Fabrics').get();
  List<String> fabricColors = [];
  for (int i = 0; fabrics.length > i; i++) {
    Map<String, dynamic>? value = fabrics[i].map;
    for (int a = 0; value['fabricColors'].length > a; a++) {
      if (!fabricColors.contains(value['fabricColors'][a])) {
        fabricColors.add(value['fabricColors'][a]);
      }
    }
  }
  return fabricColors;
}

/////////////////////////////////

deleteItem(String itemName, CollectionReference refOfItem) async {
  await refOfItem.document(itemName).delete();
}

addItem(String itemType, String itemDetail) async {
  if (!itemDetail.isEmpty) {
    Item itemToAdd = Item(
      itemType: itemType,
      itemDetail: itemDetail,
    );

    collectionOfItem(itemType.capitalize() + 's')
        .document(itemDetail)
        .set(itemToAdd.getDataMap());
  }
}

Future<List<Document>> getItems(String type) async {
  List<Document> items = await Firestore.instance.collection(type).get();
  return items;
}

List<Document> checkOrder(List<String> items, List<Document> orders,
    String nameElement, bool isArrayToBeCheck) {
  List<Document> orderOfItems = [];
  for (int i = 0; orders.length > i; i++) {
    Map<String, dynamic>? value = orders[i].map;
    if (!isArrayToBeCheck) {
      if (items.contains(value[nameElement])) {
        orderOfItems.add(orders[i]);
      }
    } else {
      if (items.every((item) => value[nameElement].contains(item))) {
        orderOfItems.add(orders[i]);
      }
    }
  }
  orders = orderOfItems;
  return orders;
}

Future<List<Document>> getOrders(
    List<String> models,
    List<String> products,
    List<String> fabrics,
    List<String> fabricColors,
    List<String> legColors,
    List<String> legModels,
    List<String> customerNames,
    String status) async {
  /*
  List<String> companyAndBranhes = [];
  List<Document> branches = await collectionOfItem('Branches').get();
  for (int i = 0; branches.length > i; i++) {
    Map<String, dynamic>? value = branches[i].map;
    companyAndBranhes.add(value['branchName']);
  }

  List<Document> companies = await collectionOfItem('Companies').get();
  for (int i = 0; companies.length > i; i++) {
    Map<String, dynamic>? value = companies[i].map;
    companyAndBranhes.add(value['companyName']);
  }
  */

  String orderRef = '';

  switch (status) {
    case 'Beklemede':
      orderRef = 'newOrders';
      break;
    case 'Üretiliyor':
      orderRef = 'onGoingOrders';
      break;
    case 'Depoda':
      orderRef = 'inStorageOrders';
      break;
    case 'Tamamlandı':
      orderRef = 'completedOrders';
      break;
  }

  List<Document> orders = await collectionOfItem('Orders')
      .document(orderRef)
      .collection('orders')
      .get();

  if (orders.isNotEmpty) {
    if (models.isNotEmpty) {
      orders = checkOrder(models, orders, 'modelName', false);
    }

    if (products.isNotEmpty) {
      orders = checkOrder(products, orders, 'product', false);
    }

    if (fabrics.isNotEmpty) {
      orders = checkOrder(fabrics, orders, 'orderByFabrics', true);
    }

    if (fabricColors.isNotEmpty) {
      orders = checkOrder(fabricColors, orders, 'orderByFabricColors', true);
    }

    if (legColors.isNotEmpty) {
      orders = checkOrder(legColors, orders, 'orderByLegColors', true);
    }

    if (legModels.isNotEmpty) {
      orders = checkOrder(legModels, orders, 'orderByLegModels', true);
    }

    if (customerNames.isNotEmpty) {
      orders = checkOrder(customerNames, orders, 'customerName', false);
    }
  }
  return orders;
}
