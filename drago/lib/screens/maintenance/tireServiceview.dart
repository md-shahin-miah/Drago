import 'package:drago/pojo/serviceslist_pojo.dart';
import 'package:drago/provider/maintenance_provider.dart';
import 'package:drago/screens/maintenance/service_add.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TireService extends StatefulWidget {
  @override
  _TireServiceState createState() => _TireServiceState();
}

class _TireServiceState extends State<TireService> {
  List<ServicesPojo> servicesList =List();

  @override
  Widget build(BuildContext context) {
    final maintenanceProvider=Provider.of<MaintenanceProvider>(context);
    servicesList=maintenanceProvider.getServicesList;
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: servicesList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ServiceAdd(index),),
                              );
                            },
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Entry ${servicesList[index].notes}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  Text(
                                    ' ${servicesList[index].date}',
                                    style: TextStyle(color: Colors.grey[500]),
                                  ),
                                  Text(
                                    ' ${servicesList[index].componentsList.toString()}',
                                    style: TextStyle(color: Colors.grey[300]),
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
                                  maintenanceProvider.deleteServiceByIndex(index);
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
                    index != servicesList.length - 1
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
              MaterialPageRoute(builder: (context) => ServiceAdd(-1)),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.pink,
        )

    );
  }
}
