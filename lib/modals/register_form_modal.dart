import 'package:flutter/material.dart';
import 'package:gastos_app_fixed/db/db_admin.dart';
import 'package:gastos_app_fixed/models/gasto_model.dart';
import 'package:gastos_app_fixed/utils/data_general.dart';
import 'package:gastos_app_fixed/widgets/item_type_widget.dart';
import 'package:gastos_app_fixed/widgets/texfield_normal_widget.dart';
import 'package:intl/intl.dart';

class RegisterModal extends StatefulWidget {
  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  String typeSelected = "";

  showDateTimePicker() async {
    DateTime? datepicker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Color(0xff101321),
                ),
                dialogTheme: DialogTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                )),
            child: child!,
          );
        });
    // print(datepicker);
    // if (datepicker != null) {
    //   _dateController.text = datepicker.toString();
    //   setState(() {});
    // }
    if (datepicker != null) {
      final DateFormat _formatter = DateFormat("dd/MM/yyyy");
      _dateController.text = _formatter.format(datepicker);
      setState(() {});
    }
  }

  void _update() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34),
          topRight: Radius.circular(34),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Registrar salida",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          Divider(),
          TextFieldNormalWidget(
            update: _update,
            hintText: "Ingresa un título",
            controller: _titleController,
          ),
          TextFieldNormalWidget(
            update: _update,
            hintText: "Ingresa el precio",
            isNumber: true,
            controller: _priceController,
          ),
          TextFieldNormalWidget(
            update: _update,
            hintText: "Selecciona la fecha",
            isDatePicker: true,
            onTap: () {
              // print("este es el datepicjer");
              showDateTimePicker();
            },
            controller: _dateController,
          ),
          SizedBox(
            height: 16,
          ),
          Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 10.0,
              children: [
                ...types
                    .map((e) => ItemTypeWidget(
                  type: e,
                  isSelected: e["name"] == typeSelected,
                  onTap: () {
                    typeSelected = e["name"];
                    // print("Hola");
                    // print(typeSelected);
                    setState(() {});
                  },
                ))
                    .toList(),
              ]),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff101321),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              onPressed: () {
                GastoModel gasto = GastoModel(
                  dateTime: _dateController.text,
                  price: double.parse(_priceController.text),
                  title: _titleController.text,
                  type: typeSelected,
                );
                DBAdmin().insertarGasto(gasto).then((value) {
                  if (value > 0) {
                    //insertó correctamente
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.cyan,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        content: Text("Se registró correctamente"),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    //poner algun mensaje para indicar que no se insertó correctamente
                  }
                }).catchError((error) {
                  print(error);
                });
              },
              child: Text(
                "Agregar",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
