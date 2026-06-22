import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/label_with_search.dart';

class MainscreenSelecttypeDetailBodyStructure extends StatelessWidget{

  final List<Widget> children ;

  const MainscreenSelecttypeDetailBodyStructure({super.key,required this.children});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height ;
    final width = MediaQuery.of(context).size.width ;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.015
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Color(0xFFEAEAEA))
      ),
       child: ListView(
         physics: NeverScrollableScrollPhysics(),
         shrinkWrap: true,
         children: children
       ),
    );
  }

}