import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
class FilterSelectType extends StatefulWidget {
  final String hintText;



  const FilterSelectType({
    super.key,
    required this.hintText,


  });

  @override
  State<FilterSelectType> createState() => _LoginInputFieldState();
}

class _LoginInputFieldState extends State<FilterSelectType> {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding :   EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.013,
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






              Expanded( // TextField को बची हुई सारी जगह लेने के लिए
            child: TextFormField(

              readOnly: true,
              style: TextStyle(color: Color(0xFF1E1E1E), fontWeight: FontWeight.w400,fontSize: MediaQuery.of(context).size.height * 0.016,decoration: TextDecoration.none),
              decoration: InputDecoration(

                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: AppColor.colorB7B7B7,
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                isDense: true,


                border: InputBorder.none,

              ),
            ),
          ),

              GestureDetector(
            onTap: () {
              setState(() {

              });
            },
            child:
            Container(


                child:  Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFFB7B7B7),
                  size: 20,
                )
            ),
          )



        ],
      ),
    );
  }
}