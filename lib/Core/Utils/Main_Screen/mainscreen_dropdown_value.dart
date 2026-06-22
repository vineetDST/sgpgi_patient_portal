import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/label_with_search.dart';

class MainscreenDropdownValue  extends StatelessWidget{

  final List<String> items ;
  final Function(String) onItemTap ;

  const MainscreenDropdownValue({super.key,required this.items,required this.onItemTap});


  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height ;
     return Container(
       padding: EdgeInsets.symmetric(horizontal: height * 0.015),
       decoration: BoxDecoration(
           color: AppColor.white,
           borderRadius: BorderRadius.all(Radius.circular(5)),
           border: Border.all(color: Color(0xFFEAEAEA),width: 1.5)
       ),
       child: ListView.builder(
           physics: NeverScrollableScrollPhysics(),
           shrinkWrap: true,
           itemCount: items.length,
           itemBuilder: (context,index) {
          return GestureDetector(
            onTap: () => onItemTap(items[index]),
             child: Container(
               color: Colors.transparent,
               padding:   EdgeInsets.symmetric(vertical: height * 0.015),
               child: Row(

                 children: [
                   Expanded(child: LabelWithSearch(label: "${items[index]}",)),
                   if(index == 0)
                     Icon(Icons.arrow_drop_down,color: AppColor.colorB7B7B7,size: 20)
                 ],
               ),
             )
          );
       })
     );
  }


}