import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';

class LabelWithSearch extends StatefulWidget {
  String label;
  bool isSearchShow;
  bool isStarShow;
  IconData? icon;
  Color? iconColor;
  double? iconSize;
  VoidCallback? onTap ;
  LabelWithSearch({
    super.key,
    required this.label,
    this.isSearchShow = false,
    this.isStarShow = false,
    this.icon = Icons.search,
    this.iconColor ,
    this.iconSize,
    this.onTap
  });

  @override
  State<StatefulWidget> createState() {
    return HeadingFilterState();
  }

}

class HeadingFilterState extends State<LabelWithSearch>{
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height ;
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Expanded(
             child: Row(
               children: [
                 Flexible(
                   child: Text(
                    '${widget.label}',
                    style: TextStyle(
                        fontSize: height * 0.015,
                        fontWeight: FontWeight.w400,
                      color: AppColor.color1E1E1E
                    ),
                              ),
                 ),
                 if(widget.isStarShow)
                 Icon(Icons.star,color: Colors.red,size: height * 0.01,)
               ],
             ),
           ),
          if(widget.isSearchShow)
            GestureDetector(
              onTap: widget.onTap,
              child: Container(
                padding: EdgeInsets.only(
                  top: height * 0.01,
                  bottom: height * 0.01,
                  left: height * 0.02,

                ),
                color: Colors.transparent,
                child: Icon(widget.icon,size:widget.iconSize ??  height * 0.02 ,color: widget.iconColor ??  Color(0xFF111111),),
              ),
            ),
        ],
      ),
    );
  }


}