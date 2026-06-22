import 'package:flutter/material.dart';

class MainscreenSelecttypeDropdown  extends StatefulWidget{

  TextEditingController controller ;
  final String hintText;
  final Color hintTextColor;
  final IconData icon ;
  final Color iconColor ;

  final VoidCallback onTap;





  MainscreenSelecttypeDropdown({
    super.key,
    required this.controller,
    required this.hintText,

    required this.onTap,
    required this.hintTextColor,
    required this.icon ,
    required this.iconColor ,
  });


  @override
  State<StatefulWidget> createState() {
    return MainscreenSelecttypeDetailState();
  }

}

class MainscreenSelecttypeDetailState extends State<MainscreenSelecttypeDropdown> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
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
            Container(


                child:  Icon(
                  widget.icon,
                  color: widget.iconColor ?? Color(0xFFB7B7B7),
                  size: 20,
                )
            ),
          ],
        ),
      ),
    );
  }

}