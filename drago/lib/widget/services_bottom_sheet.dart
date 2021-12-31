import 'package:chips_choice/chips_choice.dart';
import 'package:drago/model/maintenance_model.dart';
import 'package:drago/provider/maintenance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesBottomSheet extends StatefulWidget {
  final int index;
  ServicesBottomSheet(this.index);
  //  List<String> formValue;
  // ServicesBottomSheet(this.formValue);

  @override
  _ServicesBottomSheetState createState() => _ServicesBottomSheetState();
}

class _ServicesBottomSheetState extends State<ServicesBottomSheet> {
  List<String> options = [
    '10kg hooks',
    'ABS',
    'ABS sensor',
    'ABS sensor ring',
    'ABS valve',
    'AC components',
    'AC filter',
    'Accelerate cable',
    'arm',
    'axle',
    'armrest',
  ];

  List<String> _selectedCats = ["Cat 001", "Cat 002", "Cat 003"];

  final formKey = GlobalKey<FormState>();

  // MaintenanceModel maintenanceModel = MaintenanceModel();

  @override
  Widget build(BuildContext context) {
    final maintenanceProvider = Provider.of<MaintenanceProvider>(context);

    // List<String> formValue=maintenanceModel.selectValueGet;
    return ListView(
      addAutomaticKeepAlives: true,
      children: [
        Content(
          title: 'Works with FormField and Validator',
          child: Form(
            key: formKey,
            child: Column(
              children: [
                FormField<List<String>>(
                  autovalidate: true,
                  initialValue: widget.index > -1
                      ? maintenanceProvider.getNewSelectedItems
                      : maintenanceProvider.getSelectValue,
                  onSaved: (val) => setState(() => widget.index > -1
                      ? maintenanceProvider.editNewItems(val)
                      : maintenanceProvider.setSelectedValue(val)),
                  validator: (value) {
                    if (value?.isEmpty ?? value == null) {
                      return 'Please select some categories';
                    }
                    // if (value.length > 5) {
                    //   return "Can't select more than 5 categories";
                    // }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: ChipsChoice<String>.multiple(
                            value: state.value,
                            onChanged: (val) => state.didChange(val),
                            choiceItems: C2Choice.listFrom<String, String>(
                              source: options,
                              value: (i, v) => v.toLowerCase(),
                              label: (i, v) => v,
                              tooltip: (i, v) => v,
                            ),
                            choiceStyle: const C2ChoiceStyle(
                              color: Colors.indigo,
                              borderOpacity: .3,
                            ),
                            choiceActiveStyle: const C2ChoiceStyle(
                              color: Colors.indigo,
                              brightness: Brightness.dark,
                            ),
                            wrapped: true,
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              state.errorText ??
                                  state.value.length.toString() +
                                      '/${options.length} selected',
                              style: TextStyle(
                                  color: state.hasError
                                      ? Colors.redAccent
                                      : Colors.green),
                            ))
                      ],
                    );
                  },
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('Selected Value:'),
                              SizedBox(height: 5),
                              Text(
                                  '${maintenanceProvider.getSelectValue.toString()}')
                            ]),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      RaisedButton(
                          child: const Text('Add'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();

                            print((maintenanceProvider.getSelectValue)
                                .toString());
                            // Validate returns true if the form is valid, or false otherwise.
                            if (formKey.currentState.validate()) {
                              // If the form is valid, save the value.
                              formKey.currentState.save();
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Content extends StatefulWidget {
  final String title;
  final Widget child;

  Content({
    Key key,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content>
    with AutomaticKeepAliveClientMixin<Content> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            color: Colors.blueGrey[50],
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(fit: FlexFit.loose, child: widget.child),
        ],
      ),
    );
  }
}
