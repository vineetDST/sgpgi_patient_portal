import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';

class HeadingWithFilter extends StatefulWidget {
  String heading;
  bool isFilterShow;
  final VoidCallback? onFilterTap;
  HeadingWithFilter({super.key,required this.heading,this.isFilterShow = false,this.onFilterTap});

  @override
  State<StatefulWidget> createState() {
     return HeadingFilterState();
  }

}

class HeadingFilterState extends State<HeadingWithFilter>{
  @override
  Widget build(BuildContext context) {
   return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Expanded(
             child: Text(
              "${widget.heading}",
              style: TextStyle(fontSize:   16, fontWeight: FontWeight.w500,color: AppColor.color1E1E1E),
                       ),
           ),
          if(widget.isFilterShow)
          IconButton(
            icon:  Icon(Icons.filter_alt_outlined,color: AppColor.color1E1E1E,),

            onPressed: widget.onFilterTap,
          ),
        ],
      ),
    );
  }


}