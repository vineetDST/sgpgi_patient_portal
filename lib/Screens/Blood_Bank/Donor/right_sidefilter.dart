
import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filterLabel.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filterSelectType.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filterTextField.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filter_button.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/fromDate_toDate.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filter_heading.dart';



class FilterSideSheet extends StatefulWidget {
  final Function(Map<String, String>) onSearch;
  const FilterSideSheet({super.key, required this.onSearch});

  @override
  State<FilterSideSheet> createState() => _FilterSideSheetState();
}

class _FilterSideSheetState extends State<FilterSideSheet> {
  final DonorNameController = TextEditingController();
  final queueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height ;
    final width = MediaQuery.of(context).size.width ;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
        ),
        child: ListView(
          children: [
            SizedBox(height: height * 0.01,),
            HeadingFilter(),
            Filterlabel(text: "Donor Name",),
            SizedBox(height: height * 0.01,),
            FilterTextField(



              hintText: "Donor Name",

              textColor: Color(0xFF111111),
            ),
            SizedBox(height: height * 0.015,),

            Filterlabel(text: "Queue No",),
            SizedBox(height: height * 0.01,),
            FilterTextField(



              hintText: "Queue No",

              textColor: Color(0xFF111111),
            ),
            SizedBox(height: height * 0.015,),

            Filterlabel(text: "Donor Reg.No",),
            SizedBox(height: height * 0.01,),
            FilterTextField(



              hintText: "Donor Reg.No",

              textColor: Color(0xFF111111),
            ),
            SizedBox(height: height * 0.015,),

            Filterlabel(text: "Donor Type",),
            SizedBox(height: height * 0.01,),
            FilterSelectType(hintText: "--Select--",),
            SizedBox(height: height * 0.015,),

            Filterlabel(text: "Donation Type",),
            SizedBox(height: height * 0.01,),
            FilterSelectType(hintText: "--Select--",),
            SizedBox(height: height * 0.015,),

            DateRangePicker(),
            SizedBox(height: height * 0.03,),
            Row(
              children: [
                FilterButton(
                  text: "Clear",
                  textColor: Color(0xFF1E1E1E),
                  backgroundColor: Colors.white,
                  borderColor: AppColor.colorB7B7B7,
                  borderWidth: 0.7,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                SizedBox(width: width * 0.05,),
                FilterButton(
                  text: "Search",
                  textColor: Colors.white,
                  backgroundColor: AppColor.color117A7A,

                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            )







          ],
        ),
      )
      ,
    );
  }
}



