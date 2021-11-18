import 'package:flutter/material.dart';

class SelectFieldItem{
  String text;
  String value;

  SelectFieldItem(this.text, this.value);
}

class MySelectField extends StatefulWidget {
  String label;
  String currentValue;
  List<SelectFieldItem> items;
  void Function(String?)? onChange;

  MySelectField(
      {required this.label,
        required this.currentValue,
        required this.items,
        this.onChange});

  @override
  _MySelectFieldState createState() => _MySelectFieldState();
}

class _MySelectFieldState extends State<MySelectField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: widget.items.map((SelectFieldItem item) {
        return new DropdownMenuItem(
            value: item.value,
            child: Row(
              children: <Widget>[
                Text(item.text),
              ],
            ));
      }).toList(),
      onChanged: widget.onChange,
      value: widget.currentValue.isNotEmpty ? widget.currentValue : null,
      decoration: InputDecoration(
        hintText: widget.label,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        labelText: widget.label,
        labelStyle: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}