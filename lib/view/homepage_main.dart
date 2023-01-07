import 'package:drago/controller/vehicle_controller.dart';
import 'package:drago/global/constant.dart';
import 'package:drago/podo/exp_cost.dart';
import 'package:drago/podo/exp_penalty.dart';
import 'package:drago/podo/exp_refuel.dart';
import 'package:drago/podo/expense.dart';
import 'package:drago/podo/vehicle.dart';
import 'package:drago/screens/maintenancetab_main.dart';
import 'package:drago/view/expenses/add_cost.dart';
import 'package:drago/view/expenses/add_panalty.dart';
import 'package:drago/widget/documents_view.dart';
import 'file:///C:/Users/Shahin/StudioProjects/drago/lib/screens/expiries_tab.dart';
import 'package:flutter/material.dart';
import 'expenses/add_refuel.dart';

class HomePage extends StatefulWidget {
  final Vehicle vehicle;
  HomePage(this.vehicle);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VehicleController _controller = VehicleController();
  List<Widget> dataTabsInfo = List();
  List<Widget> expensesTabsInfo = List();
  List<Widget> maintenanceTabsInfo = List();
  List<Widget> expiriesTabsInfo = List();
  List<Widget> documentsTabsInfo = List();
  bool isExpenseData = false;
  bool isAddExpense = false;

  @override
  void initState() {
    super.initState();

    print('car id ${widget.vehicle.get_id()}');

    //--------------------- DATA TABS INFO START ---------------------------

    dataTabsInfo.add(Text('Nome'));
    dataTabsInfo.add(Text(widget.vehicle.get_name()));
    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Genere'));
    dataTabsInfo.add(Text(widget.vehicle.get_type()));
    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Modella'));
    dataTabsInfo.add(Text(widget.vehicle.get_model()));
    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Piatto'));
    dataTabsInfo.add(Text(widget.vehicle.get_plate()));
    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Prima data di registrazione'));
    dataTabsInfo.add(Text(widget.vehicle.get_firstRegDate()));
    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Data di acquisto'));
    dataTabsInfo.add(Text(widget.vehicle.get_purchaseDate()));
    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Colore'));

    dataTabsInfo.add(Text(widget.vehicle.get_color()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Tipo di carburante'));

    dataTabsInfo.add(Text(widget.vehicle.get_fuelType()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Costo di acquisto'));

    dataTabsInfo.add(Text(widget.vehicle.get_purchasCost()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Utilizzo'));

    dataTabsInfo.add(Text(widget.vehicle.get_usage()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Costo di acquisto'));

    dataTabsInfo.add(Text(widget.vehicle.get_purchasCost()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Costo di acquisto'));

    dataTabsInfo.add(Text(widget.vehicle.get_purchasCost()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Dimensione pneumatico anteriore'));

    dataTabsInfo.add(Text(widget.vehicle.get_frontTyreSize()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Dimensione pneumatico posteriore'));

    dataTabsInfo.add(Text(widget.vehicle.get_rearTyreSize()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Condizione'));

    dataTabsInfo.add(Text(widget.vehicle.get_condition()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Cilindrata'));

    dataTabsInfo.add(Text(widget.vehicle.get_engineCapacity()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Codice motore'));

    dataTabsInfo.add(Text(widget.vehicle.get_engineCode()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Numero di serie del motore'));

    dataTabsInfo.add(Text(widget.vehicle.get_engineSerialNum()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Classe ambientale'));

    dataTabsInfo.add(Text(widget.vehicle.get_envClass()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Capacità serbatoio (lt)'));

    dataTabsInfo.add(Text(widget.vehicle.get_tankCapacity()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Codice VIN'));

    dataTabsInfo.add(Text(widget.vehicle.get_vinCode()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Data di scadenza della garanzia'));

    dataTabsInfo.add(Text(widget.vehicle.getWarrantyExpDate()));

    dataTabsInfo.add(Divider());

    dataTabsInfo.add(Text('Scadenza garanzia km'));

    dataTabsInfo.add(Text(widget.vehicle.get_warrantyExpKm()));

    //--------------------- DATA TABS INFO END ---------------------------

    //--------------------- EXPENSE TABS INFO START -----------------------

    Expense expense = widget.vehicle.getExpense();

    // --------------------  expense cost start  ------------------------------
    ExpenseCost expenseCost = expense.get_expenseCost();

    if (expenseCost != null) {
      isExpenseData = true;
      expensesTabsInfo.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Costo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(icon: Icon(Icons.edit), onPressed: null)
        ],
      ));

      expensesTabsInfo.add(Text('Costo'));
      expensesTabsInfo.add(Text(expenseCost.get_cost()));
      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Data di costo'));
      expensesTabsInfo.add(Text(expenseCost.get_costDate()));
      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Tipo di costo'));
      expensesTabsInfo.add(Text(expenseCost.getCostType()));
      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Appunti'));
      expensesTabsInfo.add(Text(expenseCost.get_notes()));
      expensesTabsInfo.add(Divider());
    } else {
      expensesTabsInfo.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Costo',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddCost(widget.vehicle)));
              })
        ],
      ));
    }

    // --------------------  expense cost end  ---------------------------

    //-------------------- expense penalty start --------------------------

    ExpensePenalty expensePenalty =
    widget.vehicle.getExpense().get_expensePenalty();

    if (expensePenalty != null) {
      expensesTabsInfo.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Penalty',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AddPenalty(widget.vehicle))))
        ],
      ));

      expensesTabsInfo.add(Text('Data della penalità'));

      expensesTabsInfo.add(Text(expensePenalty.get_penaltyDate()));

      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Data notificata'));

      expensesTabsInfo.add(Text(expensePenalty.get_notifiedDate()));

      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Posto'));

      expensesTabsInfo.add(Text(expensePenalty.get_place()));

      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Codice penale'));

      expensesTabsInfo.add(Text(expensePenalty.get_penaltyCode()));

      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Codice di violazione'));

      expensesTabsInfo.add(Text(expensePenalty.get_vilationCode()));

      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Costo'));

      expensesTabsInfo.add(Text(expensePenalty.get_cost()));

      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Data di pagamento'));

      expensesTabsInfo.add(Text(expensePenalty.get_paymentDate()));

      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Notes'));

      expensesTabsInfo.add(Text(expensePenalty.get_notes()));

      expensesTabsInfo.add(Divider());
    } else {
      expensesTabsInfo.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Penalty',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddPenalty(widget.vehicle)));
              })
        ],
      ));
    }

    //-------------------- expense penalty end ----------------------------

    //------------------------ expense refuel start ------------------------
    ExpenseRefuel expenseRefuel =
    widget.vehicle.getExpense().get_expenseRefuel();

    if (expenseRefuel != null) {
      expensesTabsInfo.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Refuel',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(icon: Icon(Icons.edit), onPressed: null)
        ],
      ));

      expensesTabsInfo.add(Text('Refuel date'));
      expensesTabsInfo.add(Text(expenseRefuel.get_refuelDate()));
      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Refueling cost'));
      expensesTabsInfo.add(Text(expenseRefuel.get_cost()));
      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Price per litre'));
      expensesTabsInfo.add(Text(expenseRefuel.get_unitPrice()));
      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Litre'));
      expensesTabsInfo.add(Text(expenseRefuel.get_litres()));
      expensesTabsInfo.add(Divider());

      expensesTabsInfo.add(Text('Mileage'));
      expensesTabsInfo.add(Text(expenseRefuel.get_mileage()));
      expensesTabsInfo.add(Divider());
    } else {
      expensesTabsInfo.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Refuel',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => AddRefuel(widget.vehicle))))
        ],
      ));
    }

    //--------------------- EXPENSE TABS INFO END -----------------------

    //--------------------- MAINTENANCE TABS INFO START -----------------------

    maintenanceTabsInfo.add(MaintenanceScreen());

    //--------------------- MAINTENANCE TABS INFO END -----------------------

    //--------------------- EXPIRIES TABS INFO START -----------------------

    expiriesTabsInfo.add(Expiries());

    //--------------------- EXPIRIES TABS INFO END -----------------------

    //--------------------- DOCUMENTS TABS INFO START -----------------------

    documentsTabsInfo.add(DocumentsWidget());

    //--------------------- DOCUMENTS TABS INFO END -----------------------

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            Container(
              height: 180,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '2021',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon:
                              Icon(Icons.notes, size: 20, color: Colors.white),
                              onPressed: null,
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.white,
                              ),
                              onPressed: null,
                            ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      '${widget.vehicle.get_name()}',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${widget.vehicle.get_plate()}',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              decoration: new BoxDecoration(
                color: const Color(0xff203e5d),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: new NetworkImage(
                    'https://images.pexels.com/photos/1098662/pexels-photo-1098662.jpeg',
                  ),
                ),
              ),
            ),
            _tabSection(context)
          ],
        ));
  }

  Widget _tabSection(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            child: TabBar(
                isScrollable: true,
                indicatorColor: ColorPrimary,
                labelColor: ColorPrimary,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: "DATA"),
                  Tab(text: "EXPENSES"),
                  Tab(text: "MAINTENANCE"),
                  Tab(text: "EXPIRIES"),
                  Tab(text: "DOCUMENTS"),
                ]),
          ),
          Container(
            //Add this to give height
            height: MediaQuery.of(context).size.height,
            child: TabBarView(children: [
              Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dataTabsInfo),
                    ),
                  )),
              Container(
                  child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: expensesTabsInfo),
                      ))),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: maintenanceTabsInfo),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: expiriesTabsInfo),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: documentsTabsInfo),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
