import 'package:flutter/material.dart';
import 'package:gastos_app_fixed/models/gasto_model.dart';

class ItemGastoWidget extends StatefulWidget {
  GastoModel data;
  ItemGastoWidget({
    required this.data,
  });

  @override
  State<ItemGastoWidget> createState() => _ItemGastoWidgetState();
}

class _ItemGastoWidgetState extends State<ItemGastoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xff101321).withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.asset(
          "assets/icons/${widget.data.type.contains("seguros") ? "bancos" : widget.data.type.toLowerCase()}.png",
          width: 50,
          height: 50,
        ),
        title: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Text(
            widget.data.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        subtitle: Text(
          widget.data.dateTime,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Text(
          "S/ ${widget.data.price}",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
