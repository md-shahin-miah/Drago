import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:drago/controller/vehicle_controller.dart';
import 'package:drago/helper/utility_helper.dart';
import 'package:drago/main.dart';
import 'package:drago/podo/vehicle.dart';
import 'package:drago/view/vehicle_list.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AddVehicle extends StatefulWidget {
  @override
  _AddVehicleState createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoading = false;
  String name,
      type,
      brand,
      model,
      plate,
      firstRegDate,
      purchaseDate,
      color,
      fuelType,
      usage,
      purchasCost,
      frameNum,
      frontTyreSize,
      rearTyreSize,
      condition,
      engineCapacity,
      engineCode,
      engineHorses,
      enginePower,
      engineSerialNum,
      envClass,
      tankCapacity,
      vinCode,
      warrantyExpDate,
      warrantyExpKm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'New vehicle',
            style: TextStyle(color: Colors.black),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                Vehicle vehicle = Vehicle();
                vehicle.set_name(name);
                vehicle.set_type(type);
                vehicle.set_brand(brand);
                vehicle.set_model(model);
                vehicle.set_plate(plate);
                vehicle.set_firstRegDate(firstRegDate);
                vehicle.set_purchaseDate(purchaseDate);
                vehicle.set_purchasCost(purchasCost);
                vehicle.set_color(color);
                vehicle.set_fuelType(fuelType);
                vehicle.set_usage(usage);
                vehicle.set_frameNum(frameNum);
                vehicle.set_frontTyreSize(frontTyreSize);
                vehicle.set_rearTyreSize(rearTyreSize);
                vehicle.set_condition(condition);
                vehicle.set_engineCapacity(engineCapacity);
                vehicle.set_engineCode(engineCode);
                vehicle.set_engineHorses(engineHorses);
                vehicle.set_enginePower(enginePower);
                vehicle.set_engineSerialNum(engineSerialNum);
                vehicle.set_envClass(envClass);
                vehicle.set_vinCode(vinCode);
                vehicle.set_tankCapacity(tankCapacity);
                vehicle.setWarrantyExpDate(warrantyExpDate);
                vehicle.set_warrantyExpKm(warrantyExpKm);

                bool isAdded = await VehicleController().addData(vehicle);

                if (isAdded) {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Drago()));
                } else {
                  setState(() {
                    isLoading = false;
                    MyUtil.showInSnackBar(_scaffoldKey,
                        "Something went wrong.\nPlease fill all the field and check your network connection.");
                  });
                }
              },
              child: Text(
                'SAVE',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          )
        ],
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Drago()))),
      ),
      body: LoadingOverlay(
        isLoading: isLoading,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      name = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Nome'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      plate = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Piatto'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      type = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Genere'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      brand = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Marca'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      model = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Modella'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      fuelType = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Tipo di carburante'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      usage = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Utilizzo'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      color = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Colore'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      firstRegDate = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Prima data di registrazione'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      purchaseDate = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Data di acquisto'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      purchasCost = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Costo di acquisto'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      frameNum = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Numero di telaio'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      frontTyreSize = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Dimensioni pneumatici anteriori'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      rearTyreSize = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Dimensioni pneumatici posteriori'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      condition = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Condizione'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      engineCapacity = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Cilindrata'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      engineCode = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Codice motore'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      engineHorses = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Cavalli motore (hp)'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      enginePower = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Potenza motore (kw)'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      engineSerialNum = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Numero di serie del motore'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      envClass = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Classe ambientale'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      tankCapacity = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Capacità serbatoio (lt)'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      vinCode = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Codice VIN'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      warrantyExpDate = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Data di scadenza della garanzia'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey[400])),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
                  child: TextField(
                    onChanged: (value) {
                      warrantyExpKm = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Scadenza garanzia km'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
