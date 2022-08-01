import 'dart:ui';

import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import '../services/globals.dart' as globals;

import 'dart:math';

import 'dart:io';
import 'package:path/path.dart';
//import 'package:excel/excel.dart';

import 'package:flutter/services.dart' show ByteData, rootBundle;

import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
//import 'package:open_file/open_file.dart';
//import 'package:open_file/open_file.dart';

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
    String status,
    String orderNo) async {
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
    if (orderNo.isNotEmpty) {
      bool isNumeric(String s) {
        if (s == null) {
          return false;
        }
        return double.tryParse(s) != null;
      }

      if (isNumeric(orderNo)) {
        List<Document> orderOfItems = [];
        for (int i = 0; orders.length > i; i++) {
          Map<String, dynamic>? value = orders[i].map;

          if (value['orderNo'] == int.parse(orderNo)) {
            orderOfItems.add(orders[i]);
          }
        }
        orders = orderOfItems;
      }
    } else {
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
  }
  return orders;
}

Future<void> createExcelFile() async {
  /*
  
  print('test');
  var excel2 = Excel.createExcel();
  ByteData data = await rootBundle.load("assets/test.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    print(table); //sheet Name
    print(excel.tables[table]!.maxCols);
    print(excel.tables[table]!.maxRows);
    for (var row in excel.tables[table]!.rows) {
      print("$row");
    }
  }

  */

  final Workbook workbook = Workbook();

  //Accessing via index
  final Worksheet sheet = workbook.worksheets[0];
  sheet.showGridlines = false;

  // Enable calculation for worksheet.
  sheet.enableSheetCalculations();
/*
  final CellStyle globalStyle = workbook.styles.add('globalStyle');
globalStyle.backColor = '#37D8E9';
globalStyle.fontName = 'Times New Roman';
globalStyle.fontSize = 12;
globalStyle.fontColor = '#C67878';
globalStyle.italic = true;
globalStyle.bold = true;
globalStyle.underline = true;
globalStyle.wrapText = true;
globalStyle.hAlign = HAlignType.center;
globalStyle.vAlign = VAlignType.center;
globalStyle.borders.all.lineStyle = LineStyle.thick;
globalStyle.borders.all.color = '#9954CC';

  
*/

  Random random = new Random();
  int randomNumber = random.nextInt(100000000);

  List<Document> orderDocs = globals.orders;

  sheet.getRangeByName('A1').columnWidth = 12;
  sheet.getRangeByName('B1').columnWidth = 22;
  sheet.getRangeByName('C1').columnWidth = 6;
  sheet.getRangeByName('D1').columnWidth = 22;
  sheet.getRangeByName('E1').columnWidth = 4;
  sheet.getRangeByName('F1').columnWidth = 2;
  sheet.getRangeByName('G1').columnWidth = 5;
  sheet.getRangeByName('H1').columnWidth = 3;

  for (int i = 1; orderDocs.length + 1 > i; i++) {
    int a = 5 * (i - 1);
//+(i+a).toString()
    //Set data in the worksheet.

    sheet.getRangeByIndex(1 + a, 1).setText('Sipariş No:');
    sheet.getRangeByIndex(1 + a, 1).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(1 + a, 1).cellStyle.backColor = '#D3D3D3';
    sheet.getRangeByIndex(2 + a, 1).setText('Sipariş Tarih:');
    sheet.getRangeByIndex(2 + a, 1).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(2 + a, 1).cellStyle.backColor = '#D3D3D3';
    sheet.getRangeByIndex(3 + a, 1).setText('Bayi/Şube');
    sheet.getRangeByIndex(3 + a, 1).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(3 + a, 1).cellStyle.backColor = '#D3D3D3';
    sheet.getRangeByIndex(4 + a, 1).setText('Müşteri Adı:');
    sheet.getRangeByIndex(4 + a, 1).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(4 + a, 1).cellStyle.backColor = '#D3D3D3';
    sheet
        .getRangeByName(
            'A' + (5 + a).toString() + ':' + 'H' + (5 + a).toString())
        .merge();
    sheet.getRangeByName('A' + (5 + a).toString()).cellStyle.backColor =
        '#000000';

    /////////////////

    sheet
        .getRangeByIndex(1 + a, 2)
        .setText(orderDocs[i - 1]['orderNo'].toString());
    sheet.getRangeByIndex(1 + a, 2).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(1 + a, 2).cellStyle.hAlign = HAlignType.center;

    sheet
        .getRangeByIndex(2 + a, 2)
        .setText(orderDocs[i - 1]['orderTime'].toString());
    sheet.getRangeByIndex(2 + a, 2).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(2 + a, 2).cellStyle.hAlign = HAlignType.center;

    sheet
        .getRangeByIndex(3 + a, 2)
        .setText(orderDocs[i - 1]['companyOrBranchName'].toString());
    sheet.getRangeByIndex(3 + a, 2).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(3 + a, 2).cellStyle.hAlign = HAlignType.center;

    sheet
        .getRangeByIndex(4 + a, 2)
        .setText(orderDocs[i - 1]['customerName'].toString());
    sheet.getRangeByIndex(4 + a, 2).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(4 + a, 2).cellStyle.hAlign = HAlignType.center;

////////////////////////

    sheet.getRangeByIndex(1 + a, 3).setText('Model');
    sheet.getRangeByIndex(1 + a, 3).cellStyle.backColor = '#D3D3D3';
    sheet.getRangeByIndex(1 + a, 3).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(1 + a, 3).cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByIndex(1 + a, 4).setText(orderDocs[i - 1]['modelName']);
    sheet.getRangeByIndex(1 + a, 4).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(1 + a, 4).cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByIndex(1 + a, 5).setText('Adet');
    sheet.getRangeByIndex(1 + a, 5).cellStyle.backColor = '#D3D3D3';
    sheet.getRangeByIndex(1 + a, 5).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(1 + a, 5).cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByIndex(1 + a, 6).setText('1');
    sheet.getRangeByIndex(1 + a, 6).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(1 + a, 6).cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByIndex(1 + a, 7).setText('Fiş No');
    sheet.getRangeByIndex(1 + a, 7).cellStyle.backColor = '#D3D3D3';
    sheet.getRangeByIndex(1 + a, 7).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(1 + a, 7).cellStyle.hAlign = HAlignType.center;

    sheet
        .getRangeByIndex(1 + a, 8)
        .setText(i.toString() + '/' + orderDocs.length.toString());
    sheet.getRangeByIndex(1 + a, 8).cellStyle.borders.all =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByIndex(1 + a, 8).cellStyle.hAlign = HAlignType.center;

    sheet.getRangeByName('I' + (2 + a).toString()).cellStyle.borders.left =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByName('I' + (3 + a).toString()).cellStyle.borders.left =
        CellBorder(LineStyle.thin, '#000000');
    sheet.getRangeByName('I' + (4 + a).toString()).cellStyle.borders.left =
        CellBorder(LineStyle.thin, '#000000');

    List<String> items = orderDocs[i - 1]['product'].toString().split('+');

    for (int b = 0; items.length > b; b++) {
      sheet
          .getRangeByName(
              'C' + (b + 2 + a).toString() + ':' 'H' + (b + 2 + a).toString())
          .merge();
      sheet.getRangeByName('C' + (b + 2 + a).toString()).cellStyle.hAlign =
          HAlignType.center;

      sheet.getRangeByName('C' + (b + 2 + a).toString()).setText(
          items[b].toString() +
              ': ' +
              orderDocs[i - 1]['orderByFabrics'][b].toString() +
              '-' +
              orderDocs[i - 1]['orderByFabricColors'][b].toString() +
              '-' +
              orderDocs[i - 1]['orderByLegModels'][b].toString() +
              '-' +
              orderDocs[i - 1]['orderByLegColors'][b].toString());

      if (b == 3) {
        sheet.getRangeByName('C' + (b + 1 + a).toString()).setText(
            items[b - 1].toString() +
                ': ' +
                orderDocs[i - 1]['orderByFabrics'][b - 1].toString() +
                '-' +
                orderDocs[i - 1]['orderByFabricColors'][b - 1].toString() +
                '-' +
                orderDocs[i - 1]['orderByLegModels'][b - 1].toString() +
                '-' +
                orderDocs[i - 1]['orderByLegColors'][b - 1].toString() +
                items[b].toString() +
                ': ' +
                orderDocs[i - 1]['orderByFabrics'][b].toString() +
                '-' +
                orderDocs[i - 1]['orderByFabricColors'][b].toString() +
                '-' +
                orderDocs[i - 1]['orderByLegModels'][b].toString() +
                '-' +
                orderDocs[i - 1]['orderByLegColors'][b].toString());
      }
    }
  }

  //Save and launch the excel.
  final List<int> bytes = workbook.saveAsStream();
//Dispose the document.
  workbook.dispose();

//Get the storage folder location using path_provider package.
  final Directory directory = await getApplicationSupportDirectory();
  final String path = directory.path;
  final File file = File(Platform.isWindows
      ? '$path\\Siparişler' + randomNumber.toString() + '.xlsx'
      : '$path/Siparişler' + randomNumber.toString() + '.xlsx');
  await file.writeAsBytes(bytes, flush: true);
  if (Platform.isWindows) {
    await Process.run('start',
        <String>['$path\\Siparişler' + randomNumber.toString() + '.xlsx'],
        runInShell: true);
  } else if (Platform.isMacOS) {
    await Process.run('open',
        <String>['$path/Siparişler' + randomNumber.toString() + '.xlsx'],
        runInShell: true);
  } else if (Platform.isLinux) {
    await Process.run('xdg-open',
        <String>['$path/Siparişler' + randomNumber.toString() + '.xlsx'],
        runInShell: true);
  }
/*
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();

  final String path = (await getApplicationDocumentsDirectory()).path;
  final String fileName = '$path/Siparişler Excel.xlsx';
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);

  String win10Path =
      '"C:\\Program Files\\Microsoft Office\\root\\Office16\\EXCEL.EXE"';
  //String win7Path = 'C:\\progra~2\\micros~1\\Office14\\EXCEL.EXE';
  //'C:\\progra~1\\MIF5BA~1\\Office16\\EXCEL.EXE'
  // 'D:\\Flutter project\\mobily_app\\assets\\test.xlsx'
  try {
    print('process start');
    Process.run(win10Path, [fileName]).then((ProcessResult results) {
      print(results.stdout);
    });
  } catch (e) {
    print(e);
  }
  */
}

/*

Future<void> createExcelFile2() async {
//Create an Excel document.

  //Creating a workbook.
  final Workbook workbook = Workbook();
  //Accessing via index
  final Worksheet sheet = workbook.worksheets[0];
  sheet.showGridlines = false;

  // Enable calculation for worksheet.
  sheet.enableSheetCalculations();

  //Set data in the worksheet.
  sheet.getRangeByName('A1').columnWidth = 4.82;
  sheet.getRangeByName('B1:C1').columnWidth = 13.82;
  sheet.getRangeByName('D1').columnWidth = 13.20;
  sheet.getRangeByName('E1').columnWidth = 7.50;
  sheet.getRangeByName('F1').columnWidth = 9.73;
  sheet.getRangeByName('G1').columnWidth = 8.82;
  sheet.getRangeByName('H1').columnWidth = 4.46;

  sheet.getRangeByName('A1:H1').cellStyle.backColor = '#333F4F';
  sheet.getRangeByName('A1:H1').merge();
  sheet.getRangeByName('B4:D6').merge();

  sheet.getRangeByName('B4').setText('Invoice');
  sheet.getRangeByName('B4').cellStyle.fontSize = 32;

  sheet.getRangeByName('B8').setText('BILL TO:');
  sheet.getRangeByName('B8').cellStyle.fontSize = 9;
  sheet.getRangeByName('B8').cellStyle.bold = true;

  sheet.getRangeByName('B9').setText('Abraham Swearegin');
  sheet.getRangeByName('B9').cellStyle.fontSize = 12;

  sheet.getRangeByName('B10').setText('United States, California, San Mateo,');
  sheet.getRangeByName('B10').cellStyle.fontSize = 9;

  sheet.getRangeByName('B11').setText('9920 BridgePointe Parkway,');
  sheet.getRangeByName('B11').cellStyle.fontSize = 9;

  sheet.getRangeByName('B12').setNumber(9365550136);
  sheet.getRangeByName('B12').cellStyle.fontSize = 9;
  sheet.getRangeByName('B12').cellStyle.hAlign = HAlignType.left;

  final Range range1 = sheet.getRangeByName('F8:G8');
  final Range range2 = sheet.getRangeByName('F9:G9');
  final Range range3 = sheet.getRangeByName('F10:G10');
  final Range range4 = sheet.getRangeByName('F11:G11');
  final Range range5 = sheet.getRangeByName('F12:G12');

  range1.merge();
  range2.merge();
  range3.merge();
  range4.merge();
  range5.merge();

  sheet.getRangeByName('F8').setText('INVOICE#');
  range1.cellStyle.fontSize = 8;
  range1.cellStyle.bold = true;
  range1.cellStyle.hAlign = HAlignType.right;

  sheet.getRangeByName('F9').setNumber(2058557939);
  range2.cellStyle.fontSize = 9;
  range2.cellStyle.hAlign = HAlignType.right;

  sheet.getRangeByName('F10').setText('DATE');
  range3.cellStyle.fontSize = 8;
  range3.cellStyle.bold = true;
  range3.cellStyle.hAlign = HAlignType.right;

  sheet.getRangeByName('F11').dateTime = DateTime(2020, 08, 31);
  sheet.getRangeByName('F11').numberFormat =
      '[\$-x-sysdate]dddd, mmmm dd, yyyy';
  range4.cellStyle.fontSize = 9;
  range4.cellStyle.hAlign = HAlignType.right;

  range5.cellStyle.fontSize = 8;
  range5.cellStyle.bold = true;
  range5.cellStyle.hAlign = HAlignType.right;

  final Range range6 = sheet.getRangeByName('B15:G15');
  range6.cellStyle.fontSize = 10;
  range6.cellStyle.bold = true;

  sheet.getRangeByIndex(15, 2).setText('Code');
  sheet.getRangeByIndex(16, 2).setText('CA-1098');
  sheet.getRangeByIndex(17, 2).setText('LJ-0192');
  sheet.getRangeByIndex(18, 2).setText('So-B909-M');
  sheet.getRangeByIndex(19, 2).setText('FK-5136');
  sheet.getRangeByIndex(20, 2).setText('HL-U509');

  sheet.getRangeByIndex(15, 3).setText('Description');
  sheet.getRangeByIndex(16, 3).setText('AWC Logo Cap');
  sheet.getRangeByIndex(17, 3).setText('Long-Sleeve Logo Jersey, M');
  sheet.getRangeByIndex(18, 3).setText('Mountain Bike Socks, M');
  sheet.getRangeByIndex(19, 3).setText('ML Fork');
  sheet.getRangeByIndex(20, 3).setText('Sports-100 Helmet, Black');

  sheet.getRangeByIndex(15, 3, 15, 4).merge();
  sheet.getRangeByIndex(16, 3, 16, 4).merge();
  sheet.getRangeByIndex(17, 3, 17, 4).merge();
  sheet.getRangeByIndex(18, 3, 18, 4).merge();
  sheet.getRangeByIndex(19, 3, 19, 4).merge();
  sheet.getRangeByIndex(20, 3, 20, 4).merge();

  sheet.getRangeByIndex(15, 5).setText('Quantity');
  sheet.getRangeByIndex(16, 5).setNumber(2);
  sheet.getRangeByIndex(17, 5).setNumber(3);
  sheet.getRangeByIndex(18, 5).setNumber(2);
  sheet.getRangeByIndex(19, 5).setNumber(6);
  sheet.getRangeByIndex(20, 5).setNumber(1);

  sheet.getRangeByIndex(15, 6).setText('Price');
  sheet.getRangeByIndex(16, 6).setNumber(8.99);
  sheet.getRangeByIndex(17, 6).setNumber(49.99);
  sheet.getRangeByIndex(18, 6).setNumber(9.50);
  sheet.getRangeByIndex(19, 6).setNumber(175.49);
  sheet.getRangeByIndex(20, 6).setNumber(34.99);

  sheet.getRangeByIndex(15, 7).setText('Total');
  sheet.getRangeByIndex(16, 7).setFormula('=E16*F16+(E16*F16)');
  sheet.getRangeByIndex(17, 7).setFormula('=E17*F17+(E17*F17)');
  sheet.getRangeByIndex(18, 7).setFormula('=E18*F18+(E18*F18)');
  sheet.getRangeByIndex(19, 7).setFormula('=E19*F19+(E19*F19)');
  sheet.getRangeByIndex(20, 7).setFormula('=E20*F20+(E20*F20)');
  sheet.getRangeByIndex(15, 6, 20, 7).numberFormat = '\$#,##0.00';

  sheet.getRangeByName('E15:G15').cellStyle.hAlign = HAlignType.right;
  sheet.getRangeByName('B15:G15').cellStyle.fontSize = 10;
  sheet.getRangeByName('B15:G15').cellStyle.bold = true;
  sheet.getRangeByName('B16:G20').cellStyle.fontSize = 9;

  sheet.getRangeByName('E22:G22').merge();
  sheet.getRangeByName('E22:G22').cellStyle.hAlign = HAlignType.right;
  sheet.getRangeByName('E23:G24').merge();

  final Range range7 = sheet.getRangeByName('E22');
  final Range range8 = sheet.getRangeByName('E23');
  range7.setText('TOTAL');
  range7.cellStyle.fontSize = 8;
  range8.setFormula('=SUM(G16:G20)');
  range8.numberFormat = '\$#,##0.00';
  range8.cellStyle.fontSize = 24;
  range8.cellStyle.hAlign = HAlignType.right;
  range8.cellStyle.bold = true;

  sheet.getRangeByIndex(26, 1).text =
      '800 Interchange Blvd, Suite 2501, Austin, TX 78721 | support@adventure-works.com';
  sheet.getRangeByIndex(26, 1).cellStyle.fontSize = 8;

  final Range range9 = sheet.getRangeByName('A26:H27');
  range9.cellStyle.backColor = '#ACB9CA';
  range9.merge();
  range9.cellStyle.hAlign = HAlignType.center;
  range9.cellStyle.vAlign = VAlignType.center;

  //final Picture picture = sheet.pictures.addBase64(3, 4, '');
  //picture.lastRow = 7;
  // picture.lastColumn = 8;

  //Save and launch the excel.
  final List<int> bytes = workbook.saveAsStream();
  //Dispose the document.
  workbook.dispose();
  //Save and launch file.
  // SaveFilehelper.saveAndOpenFile(bytes);
  //await file.writeAsBytes(bytes, flush: true);
  //OpenFile.open(fileName);
  final String path = (await getApplicationDocumentsDirectory()).path;
  final String fileName = '$path/Output.xlsx';
  final File file = File(fileName);
  await file.writeAsBytes(bytes, flush: true);

  String win10Path =
      '"C:\\Program Files\\Microsoft Office\\root\\Office16\\EXCEL.EXE"';
  //String win7Path = 'C:\\progra~2\\micros~1\\Office14\\EXCEL.EXE';
  //'C:\\progra~1\\MIF5BA~1\\Office16\\EXCEL.EXE'
  // 'D:\\Flutter project\\mobily_app\\assets\\test.xlsx'
  try {
    print('process start');
    Process.run(win10Path, [fileName]).then((ProcessResult results) {
      print(results.stdout);
    });
  } catch (e) {
    print(e);
  }
}

*/
