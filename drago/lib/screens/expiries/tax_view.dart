
import 'package:drago/pojo/tax_pojo.dart';
import 'package:drago/provider/tax_provider.dart';
import 'package:drago/screens/expiries/tax_add.dart';
import 'package:drago/screens/maintenance/service_add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaxView extends StatelessWidget {
  List<TaxPojo> taxList =List();


  @override
  Widget build(BuildContext context) {
    final taxProvider=Provider.of<TaxProvider>(context);
    taxList=taxProvider.getTaxList;
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: taxList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TaxAdd(index),),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      'Entry ${taxList[index].expiryMonth}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      ' ${taxList[index].expiryYear}',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      ' ${taxList[index].cost.toString()} ',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.06,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  taxProvider.deleteTaxByIndex(index);
                                },

                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,

                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    index != taxList.length - 1
                        ? Container(
                      margin: EdgeInsets.only(top: 5),
                      height: 0.5,
                      color: Colors.black26,
                    )
                        : Container()
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaxAdd(-1)),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
        )

    );
  }
}
