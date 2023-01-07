import 'package:drago/pojo/insurence_pojo.dart';
import 'package:drago/pojo/others_expiries_pojo.dart';
import 'package:drago/provider/others_expiries_provider.dart';

import 'package:drago/screens/expiries/insurance_add.dart';
import 'package:drago/screens/expiries/others_expiries_add.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherExpiriesView extends StatelessWidget {
  List<OthersExpiriesPojo> othersExpiriesList =List();

  bool exDate=false;

  @override
  Widget build(BuildContext context) {
    final othersExpiriesProvider=Provider.of<OthersExpiriesProvider>(context);
    othersExpiriesList=othersExpiriesProvider.getOtherExpiriesList;


    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: othersExpiriesList.length,
            itemBuilder: (BuildContext context, int index) {
              exDate=othersExpiriesList[index].exDate;
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
                              MaterialPageRoute(builder: (context) => OtherExpiriesAdd(index),),
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
                                      '${othersExpiriesList[index].wtRemember}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      !exDate?'${othersExpiriesList[index].date}€':"Expiried",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      exDate?
                                      'Expires at ${othersExpiriesList[index].date.toString()}':'Expires date }',
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
                                  othersExpiriesProvider.deleteOtherExpiries(index);
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
                    index != othersExpiriesList.length - 1
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
              MaterialPageRoute(builder: (context) => OtherExpiriesAdd(-1)),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
        )

    );
  }
}
