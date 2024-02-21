import 'package:flutter/material.dart';

class ItemTypeWidget extends StatefulWidget {
  Map<String, dynamic> type;
  bool isSelected;
  VoidCallback onTap;

  ItemTypeWidget({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<ItemTypeWidget> createState() => _ItemTypeWidgetState();
}

class _ItemTypeWidgetState extends State<ItemTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Color(0xff101321).withOpacity(0.05),
          borderRadius: BorderRadius.circular(14.0),
          border: widget.isSelected
              ? Border.all(width: 1.0, color: Color(0xff101321))
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              widget.type["image"],
              height: 40,
              width: 40,
            ),
            SizedBox(
              width: 5,
            ),
            Text(widget.type["name"])
          ],
        ),
      ),
    );
  }
}
