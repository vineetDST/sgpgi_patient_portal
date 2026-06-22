import 'dart:io';

import 'package:flutter/material.dart';

class HeadingFilter extends StatefulWidget {
  String? heading;
    HeadingFilter({super.key,this.heading = "Search"});

  @override
  State<HeadingFilter> createState() => _TextWithCloseRowState();
}

class _TextWithCloseRowState extends State<HeadingFilter> {


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height ;
    return Container(


      child: Row(
        children: [
          Expanded(
            child: Text(
              "${widget.heading}",
              style: TextStyle(
                fontSize: height * 0.017,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E1E1E),

              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: EdgeInsets.only(
                top: height * 0.01,
                bottom: height * 0.01,
                left: height * 0.01,
              ),
              color: Colors.transparent,
              child: Icon(Icons.close,size: height * 0.03,),
            ),
          )
        ],
      ),
    ); // empty when closed
  }
}
