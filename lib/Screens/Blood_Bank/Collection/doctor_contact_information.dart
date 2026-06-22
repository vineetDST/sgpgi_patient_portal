import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/label_with_search.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_radiobutton.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_detail_bodystructure.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_dropdown_controller.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_textfield.dart';



class DoctorContactInformation extends StatelessWidget {

  final VoidCallback onClose ;

  const DoctorContactInformation({super.key,required this.onClose});

  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.of(context).size.height ;
    return MainscreenSelecttypeDetailBodyStructure(
        children: [
          Padding(
            padding:  EdgeInsets.only(
              left: height * 0.01,
              right: height * 0.01,

            ),
            child: LabelWithSearch(
              label: "Donor Details",
              isSearchShow: true,
              icon: Icons.arrow_drop_up,
              iconColor: AppColor.color1E1E1E,
              onTap: onClose,
            ),
          ),
          SizedBox(height: height * 0.01,),

          LabelWithSearch(label: "First Name",isStarShow: true,),
          SizedBox(height: height * 0.01,),
          MainscreenTextfield(hintText: "First Name"),
          SizedBox(height: height * 0.02,),

          LabelWithSearch(label: "Middle Name",),
          SizedBox(height: height * 0.01,),
          MainscreenTextfield(hintText: "Middle Name"),
          SizedBox(height: height * 0.02,),

          LabelWithSearch(label: "Last Name",isStarShow: true,),
          SizedBox(height: height * 0.01,),
          MainscreenTextfield(hintText: "Last Name"),
          SizedBox(height: height * 0.02,),

          LabelWithSearch(label: "Father's Name",isStarShow: true,),
          SizedBox(height: height * 0.01,),
          MainscreenTextfield(hintText: "Father's Name"),
          SizedBox(height: height * 0.02,),

          LabelWithSearch(label: "Relation with CR No.",),
          SizedBox(height: height * 0.01,),
          MainscreenSelecttypeDropdownController(
              items: [
                "Brother",
                "Daughter",
                "Father",
                "Father-in-Law",
                "Husband",
                "Mother",
                "Mother-in-Law",
                "Others",
                "Self",
                "Sister",
                "Son",
                "Spouse",
                "Wife",
              ],
              onItemTap: (value) {
                print("Donor Details : $value");
              }
          ),

          LabelWithSearch(label: "Gender"),
          SizedBox(height: height * 0.01,),
          Padding(
            padding:  EdgeInsets.only(
              left: height * 0.02,
              right: height * 0.02,
            ),
            child: MainscreenRadiobutton(
              items: const [
                "Male",
                "Female",

              ],
              onChanged: (value) {
                debugPrint("Gender: $value");
              },
            ),
          ),
          SizedBox(height: height * 0.02,),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LabelWithSearch(label: "HB (gms/dl)",isStarShow: true,),
                    SizedBox(height: height * 0.01,),
                    MainscreenTextfield(hintText: "HB"),
                    SizedBox(height: height * 0.02,),
                  ],
                ),
              ),
              SizedBox(width: height * 0.01,),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LabelWithSearch(label: "HB Method",),
                    SizedBox(height: height * 0.01,),
                    MainscreenSelecttypeDropdownController(
                        items: [
                          "Cyanmethemoglobin",
                        ],
                        onItemTap: (value){

                        }
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Expanded(

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LabelWithSearch(label: "Marital Status",),
                    SizedBox(height: height * 0.01,),
                    MainscreenSelecttypeDropdownController(
                        items: [
                          "Married",
                          "Seperated",
                          "Single",
                        ],
                        onItemTap: (value){

                        }
                    ),
                  ],
                ),
              ),
              SizedBox(width: height * 0.01,),
              Expanded(

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LabelWithSearch(label: "Weight(kg)",),
                    SizedBox(height: height * 0.01,),
                    MainscreenTextfield(hintText: "HB"),
                    SizedBox(height: height * 0.02,),
                  ],
                ),
              ),
            ],
          ),

          LabelWithSearch(label: "Occupation"),
          SizedBox(height: height * 0.01,),
          MainscreenSelecttypeDropdownController(
              items: [
                "Advocate",
                "Business",
                "Doctor",
                "Farmer",
                "Others",
                "Student",
              ],
              onItemTap: (value) {

              }
          ),
          SizedBox(height: height * 0.01,),







        ]
    );
  }

}