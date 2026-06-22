import 'package:flutter/material.dart';

class MainscreenSelecttypeDetail  extends StatefulWidget{

   String hintText;
   TextEditingController? controller;
   VoidCallback onTap;
   Color? hintTextColor;
   IconData? icon ;
   Color? iconColor ;

   MainscreenSelecttypeDetail({
    super.key,
    required this.hintText,
    this.controller,
    required this.onTap,
    this.hintTextColor,
    this.icon = Icons.arrow_drop_down,
    this.iconColor ,
  });


  @override
  State<StatefulWidget> createState() {
    return MainscreenSelecttypeState();
  }

}

class MainscreenSelecttypeState extends State<MainscreenSelecttypeDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding :   EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
        horizontal: MediaQuery.of(context).size.height * 0.015,
      ) ,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: Color(0xFFEAEAEA),
            width: 1.5
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              readOnly: true,
              onTap: widget.onTap,
              style: TextStyle(fontSize:  14),
              decoration: InputDecoration(
                hintText: "${widget.hintText}",
                hintStyle: TextStyle(
                    color: widget.hintTextColor ?? Color(0xFFB7B7B7),
                    fontWeight: widget.hintTextColor == null ? FontWeight.w400 : FontWeight.w500,
                    fontSize: widget.hintTextColor == null ? MediaQuery.of(context).size.height * 0.016 : MediaQuery.of(context).size.height * 0.015),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                isDense: true,


                border: InputBorder.none,


              ),
            ),
          ),
          GestureDetector(
            onTap:  widget.onTap,
            child:
            Container(


                child:  Icon(
                  widget.icon,
                  color: widget.iconColor ?? Color(0xFFB7B7B7),
                  size: 20,
                )
            ),
          )
        ],
      ),
    );
  }

}