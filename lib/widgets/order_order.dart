// ignore_for_file: prefer_const_constructors

import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:mobily_app/screens/admin_main_page.dart';
import 'package:mobily_app/screens/orders_page.dart';

import '../services/cloud_functions.dart';

import '../services/globals.dart' as globals;

class OrderOrder extends StatefulWidget {
  final orders;
  final String status;
  final bool streamStatus;
  OrderOrder({
    Key? key,
    required this.orders,
    required this.status,
    required this.streamStatus,
  }) : super(key: key);

  @override
  State<OrderOrder> createState() => _OrderOrderState();
}

class _OrderOrderState extends State<OrderOrder> {
  Widget rowLeft(String firsttext, String secondtext) {
    return Row(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Container(
                padding: EdgeInsets.only(right: 100),
                child: Container(
                  width: 90,
                  child: Text(firsttext,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Color.fromRGBO(174, 93, 64, 1))),
                ),
              ),
              VerticalDivider(
                thickness: 2,
                color: Colors.black,
              ),
              SizedBox(
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Container(
                  width: 90,
                  child: Text(secondtext,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                ),
              ),
              Container(
                color: Colors.black,
                height: 35,
                width: 2,
              ),
            ],
          ),
        )
      ],
    );
  }

  //List<Document> orderDocs = [];
  //List<Document> listedOrders = [];

  @override
  Widget build(BuildContext context) {
    getDeleteAndUpdate(Document orders) {
      bool value = false;

      if (globals.orders.contains(orders)) {
        value = true;
      } else {
        value = false;
      }

      return Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.brown,
            ),
            onPressed: () {
              List<String> allOfDoc = orders.toString().split(' ');
              List<String> justPath = allOfDoc[0].split('/');
              String orderID = justPath[4];

              deleteOrder(orderID, widget.status);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AdminMain()));
            },
          ),
          widget.status != 'Beklemede'
              ? SizedBox(
                  width: 150,
                  height: 30,
                  child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      heroTag: null,
                      backgroundColor: Color.fromRGBO(151, 54, 20, 1),
                      child: Text(widget.status != 'Üretiliyor'
                          ? widget.status == 'Depoda'
                              ? 'Üretime Taşı'
                              : 'Depoya Taşı'
                          : 'Beklemeye taşı'),
                      onPressed: () {
                        updateOrder(widget.status, orders, true);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => OrdersPage(
                                  status: widget.status,
                                )));
                      }),
                )
              : SizedBox(),
          SizedBox(
            width: 10,
          ),
          widget.status != 'Tamamlandı'
              ? SizedBox(
                  width: 150,
                  height: 30,
                  child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      heroTag: null,
                      backgroundColor: Color.fromRGBO(151, 54, 20, 1),
                      child: Text(widget.status != 'Beklemede'
                          ? widget.status == 'Üretiliyor'
                              ? 'Depoya Taşı'
                              : 'Tamamlandıya Taşı'
                          : 'Üretime Taşı'),
                      onPressed: () {
                        updateOrder(widget.status, orders, false);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => OrdersPage(
                                  status: widget.status,
                                )));
                      }),
                )
              : SizedBox(),
          Checkbox(
            checkColor: Colors.white,
            activeColor: Colors.green,
            value: value,
            onChanged: (bool? value) {
              setState(() {
                if (globals.orders.contains(orders)) {
                  globals.orders.remove(orders);
                } else {
                  globals.orders.add(orders);
                }
              });
            },
          ),
        ],
      );
    }

    if (widget.streamStatus) {
      return Container(
        child: FutureBuilder<List<Document>>(
          future: widget.orders,
          builder:
              (BuildContext context, AsyncSnapshot<List<Document>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return snapshot.data!.isEmpty
                ? const Center(child: Text('Sipariş Yok:'))
                : ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: snapshot.data!
                        .map((orders) {
                          List<String> products = orders['product'].split('+');
                          return Column(
                            children: [
                              Container(
                                width: 1000,
                                height: 195,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 2.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: IntrinsicHeight(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 458,
                                            child: IntrinsicHeight(
                                              child: Column(children: [
                                                rowLeft(
                                                    'Sipariş No:',
                                                    orders['orderNo']
                                                        .toString()),
                                                Container(
                                                  color: Colors.black,
                                                  height: 2,
                                                  width: 460,
                                                ),
                                                rowLeft(
                                                    'Sipariş tarihi:',
                                                    orders['orderTime']
                                                        .toString()),
                                                Container(
                                                  color: Colors.black,
                                                  height: 2,
                                                  width: 460,
                                                ),
                                                rowLeft(
                                                    'Bayi- Şube:',
                                                    orders[
                                                        'companyOrBranchName']),
                                                Container(
                                                  color: Colors.black,
                                                  height: 2,
                                                  width: 460,
                                                ),
                                                rowLeft('Musteri Adi:',
                                                    orders['customerName'])
                                              ]),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Row(
                                                children: [
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 30,
                                                        ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 100),
                                                          child: Container(
                                                            width: 90,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          4),
                                                              child: Text(
                                                                  'Model',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15,
                                                                      color: Color.fromRGBO(
                                                                          174,
                                                                          93,
                                                                          64,
                                                                          1))),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          color: Colors.black,
                                                          height: 26,
                                                          width: 2,
                                                        ),
                                                        SizedBox(
                                                          width: 30,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 100,
                                                                  bottom: 4),
                                                          child: Container(
                                                            width: 90,
                                                            child: Text(
                                                                orders[
                                                                    'modelName'],
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        15)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                color: Colors.black,
                                                height: 2,
                                                width: 536,
                                              ),

                                              //siparişlerin asıl listesi
                                              Container(
                                                width: 537,
                                                height: 90,
                                                child: ListView.builder(
                                                    itemExtent: 25.0,
                                                    shrinkWrap: false,
                                                    itemCount: products.length,
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return ListTile(
                                                        title: Row(children: [
                                                          Center(),
                                                          Text(products[index]
                                                                  .toString() +
                                                              ':'),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            orders['orderByFabrics']
                                                                    [index] +
                                                                '-',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            orders['orderByFabricColors']
                                                                    [index] +
                                                                '-',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            orders['orderByLegModels']
                                                                    [index] +
                                                                '-',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            orders['orderByLegColors']
                                                                [index],
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ]),
                                                      );
                                                    })),
                                              ),
                                              Text('Durum: ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15)),

                                              Text(widget.status,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              getDeleteAndUpdate(orders),
                            ],
                          );
                        })
                        .toList()
                        .cast(),
                  );
          },
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
