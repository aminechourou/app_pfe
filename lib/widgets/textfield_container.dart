import 'package:flutter/material.dart';
class TextFieldContainer extends StatefulWidget {
  late final double width;
  late final double radius;
  late final Color color;
  late final int maxLines;
  late final String label;
  late final String hintText;
  late final IconData icon;
  late final TextEditingController controller;


  TextFieldContainer(this.width, this.radius, this.color, this.maxLines,
      this.label, this.hintText, this.icon, this.controller);

  @override
  _TextFieldContainerState createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(

      width: MediaQuery.of(context).size.width*widget.width,

      decoration:  BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius),),
          color: widget.color
      ),

      child:  TextField(
        maxLines: widget.maxLines,
        controller: widget.controller,
        decoration: InputDecoration(

          label: Text(widget.label),
          hintText: widget.hintText,
          prefixIcon: Icon(widget.icon),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(color: widget.color,)


            // borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
          ),



        ),



      ),
    );
  }
}
