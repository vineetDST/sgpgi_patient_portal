import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filter_heading.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Collection/collection.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Donor/donor.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Donor/previous_donation_detail.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Donor_Registration/donor_registration_camp.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/General/donor_search.dart';
import 'package:qc_hospital/Widgets/blood_bank_module_shell.dart';

class DonorDetailsDialog extends StatefulWidget {
  DonorData data ;


  DonorDetailsDialog({super.key,required this.data});

  @override
  State<DonorDetailsDialog> createState() => _DonorDetailsDialogState();
}

class _DonorDetailsDialogState extends State<DonorDetailsDialog> {
  List? items  ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items =  [
      {"item" : "Queue No", "isUpDownArrow" : true,"isIcon" : false,"value" : widget.data.queue},
      {"item" : "Donor Reg No", "isUpDownArrow" : true,"isIcon" : false,"value" : widget.data.regNo},
      {"item" : "Donor Name", "isUpDownArrow" : true,"isIcon" : false,"value" : widget.data.name},
      {"item" : "Date", "isUpDownArrow" : true,"isIcon" : false,"value" : "10-11-2025"},
      {"item" : "Donor Type", "isUpDownArrow" : true,"isIcon" : false,"value" : "Replacement"},
      {"item" : "Donation Type", "isUpDownArrow" : true,"isIcon" : false,"value" : "Whole Blood"},
      {"item" : "Previous Donation", "isUpDownArrow" : false,"isIcon" : true,"value" : ""},
      {"item" : "Photo Capture", "isUpDownArrow" : false,"isIcon" : false,"value" : "Photo Capture"},
      {"item" : "Bleeding Certificate", "isUpDownArrow" : false,"isIcon" : false,"value" : "677050"},
      {"item" : "Blood Group Certificate", "isUpDownArrow" : false,"isIcon" : false,"value" : "Blood Group Certificate"},
      {"item" : "Action", "isUpDownArrow" : false,"isIcon" : true,"value" : ""},

    ];
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(

            mainAxisSize: MainAxisSize.min,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 10,right: 20),
                child: HeadingFilter(heading: "Donor Details",),
              ),
              const SizedBox(height: 10),

              // --- Table/List Section ---

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                     itemCount: items?.length ?? 0,
                      itemBuilder: (context,index){
                          bool isLast = index == (items?.length ?? 0) - 1;
                          Color color = AppColor.color1E1E1E;
                          if(index > 6) {
                            color = AppColor.color117A7A;
                          }
                          return getDetail(context,items?[index],  color, isLast: isLast);
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDetail(BuildContext context,Map item,Color color,{bool isLast = false,}) {
    return Container(
      decoration: BoxDecoration(

        border:   Border(

          bottom: !isLast ? BorderSide(color: Colors.grey.shade200,width: 2) : BorderSide.none,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [


            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(left: 14, ),
                color: Color(0xFFECF9F9), // Matching the light teal/cyan color
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${item['item']}",
                        style:  TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.016,
                          fontWeight: FontWeight.w500, // Thoda bold text labels ke liye
                          color: AppColor.color1E1E1E,

                        ),
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                    if(item['isUpDownArrow']) ...[
                      SizedBox(width: 5),
                      Icon(Icons.unfold_more, size: 16, color: Colors.black),
                    ]

                  ],
                ),
              ),
            ),


            Container(width: 2, color: Colors.grey.shade200),


            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                color: const Color(0xFFFFFFFF),
                alignment: Alignment.centerLeft,
                child: (!item['isIcon']) ?
                  Text(
                  "${item['value']}",
                  style:  TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.014,
                    fontWeight: FontWeight.w400, // Thoda bold text labels ke liye
                    color: color,
                  ),
                ) : getIcon(item['item'])

                ,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getIcon(String itemName){
    return GestureDetector(
      onTap: () {
        if(itemName == "Previous Donation"){
          Navigator.of(context).pop();
          showDialog(context: context, builder: (context) =>   PreviousDonationDetailDialog());
        }
        else {
          Navigator.of(context).pop();
          bloodBankShellKey.currentState?.changeTab(2);
        }
      },
      child: Container(
          color: Colors.transparent,
          child: itemName == "Previous Donation" ? Icon(Icons.visibility, color: Colors.black87, size: 20) : Image.asset(
            'assets/editicons.png', // 👈 your image path
            height: 15,
            width: 15,
            color: Colors.black,
          ) , )
    ) ;
  }
}
