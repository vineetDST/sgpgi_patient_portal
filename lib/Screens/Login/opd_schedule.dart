import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class OpdSchedule extends StatefulWidget {
  OpdSchedule({super.key});
  @override
  State<OpdSchedule> createState() => _OnlineRegistrationState();
}

class _OnlineRegistrationState extends State<OpdSchedule> {


  // ================= DEMOGRAPHICS VARIABLES =================
  final dateOfDischargeController = TextEditingController();
  DateTime? toDate;

  final dobController = TextEditingController();
  DateTime? dobDate;

  String? _department;





  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
             Navigator.pop(context);
          },
        ),
        title: const Text(
          'OPD Schedule',
          style: TextStyle(
            color: Colors.black,

            fontSize: 16,
          ),
        ),
        centerTitle: true,
        // Gradient background set karne ke liye flexibleSpace
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFC6F2D6), // Light Greenish
                Color(0xFFBCEBEB), // Light Bluish
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),


      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: Column(
          children: [

            Expanded(child:
            ListView(
              children: [
                const SizedBox(height: 16),

                SharedComponents.buildFormLabel('Department', ),
                const SizedBox(height: 8),
                FunctionalDropdown(
                  value: _department,
                  hint: 'Select the Department',
                  items: DummyData.department,
                  onChanged: (val) => setState(() => _department = val),
                ),
                const SizedBox(height: 16),

                SharedComponents.buildFormLabel('OPD Schedule as on'),
                const SizedBox(height: 8),
                AppDateField(
                  controller: dateOfDischargeController,
                  onTap: () async {
                    DateTime? pickedDate = await CustomCalendarDialog.show(
                      context,
                      initialDate: toDate ?? DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        toDate = pickedDate;
                        dateOfDischargeController.text = formatDate(pickedDate);
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF117A7A),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SharedComponents.buildFormLabel('N : New Visit F : Follow Up'),
                const SizedBox(height: 8),
                const SizedBox(height: 16),

                ScrollableDataTable(
                  isFirstRowHeader: true, // 🔥 Flag enable kiya
                  // rowHeight: 60.0, // Thodi badi height taaki multiple doctors fit ho jayein
                  labels: const [
                    'Departments',
                    'Anaesthesia',
                    'Apex Trauma Center',
                    'Cardiology',
                    'Cardiovascular and Thora Surg',
                    'Endocrine Surgery',
                    'Endocrinology',
                    'Gastroenterology',
                    'General Hospital',
                    'Hematology',
                    'Immunology',
                    'Maternal And Reproductive Health',
                    'Medical Genetics',
                    'Microbiology',
                    'Neonatology',
                    'Nephrology',
                    'Neurology',
                    'Neurosurgery',
                    'Nuclear Medicine',
                    'Ophthalmology',
                    'Paediatric Gastroenterology',
                    'Paediatric Surgery'
                  ],
                  rowValues: [
                    // 0: THE HEADER ROW
                    [
                      TableText('Monday', color: Colors.white,),
                      TableText('Tuesday',color: Colors.white,),
                      TableText('Wednesday', color: Colors.white,),
                      TableText('Thursday', color: Colors.white,),
                      TableText('Friday', color: Colors.white,),
                      TableText('Saturday', color: Colors.white,),
                    ],
                    // 1: Anaesthesia
                    [
                      TableText('Sanjay Dhiraj() , Sujeet Kumar Singh Gautam()'),
                      TableText('Sanjay Dhiraj() , Sujeet Kumar Singh Gautam()'),
                      TableText('Sujeet Kumar Singh Gautam() , Sanjay Dhiraj()'),
                      TableText('Sanjay Dhiraj()'),
                      TableText('Sanjay Dhiraj() , Chetna Shamshery ()'),
                      TableText('Sanjay Dhiraj()'),
                    ],
                    // 2: Apex Trauma Center
                    [
                      TableText('Pulak Sharma (N,F) , Kuldeep VIshwakarma (N,F) , Siddharth Rai (N,F)'),
                      TableText('Pulak Sharma (N,F) , Kuldeep VIshwakarma (N,F) , Siddharth Rai (N,F)'),
                      TableText('Amit Kumar (N,F) , Kuldeep VIshwakarma (N,F) , Siddharth Rai (N,F)'),
                      TableText('Kumar Keshav(N,F) , Amit Kumar Singh(N,F) , Siddharth Rai (N,F)'),
                      TableText('Pulak Sharma (N,F) , Amit Kumar (N,F) , Kuldeep VIshwakarma (N,F) , Siddharth Rai (N,F)'),
                      TableText('Anurag Baghel (N,F) , Kumar Keshav(N,F) , Amit Kumar Singh(N,F) , Siddharth Rai (N,F)'),
                    ],
                    // 3: Cardiology
                    [
                      TableText('Sudeep Kumar(N,F)'),
                      TableText('Sudeep Kumar(N,F)'),
                      TableText('Neveen Garg(N,F)'),
                      TableText('Satyendra Tewari(N,F)'),
                      TableText('Roopali Khanna (N,F)'),
                      TableText('Ankit Kumar Sahu (N,F)'),
                    ],
                    // 4: Cardiovascular and Thora Surg
                    [
                      TableText('Shantanu Pande(N)'),
                      TableText('Shantanu Pande(N)'),
                      TableText('Surendra Kumar Agarwal(N)'),
                      TableText('Bipin Chandra(N)'),
                      TableText('VARUNA P VARMA (N)'),
                      TableText('--'),
                    ],
                    // 5: Endocrine Surgery
                    [
                      TableText('Gaurav Agarwal(N,F)'),
                      TableText('Gaurav Agarwal(N,F)'),
                      TableText('SABARETNAM Mayilvaganan (N) , Gaurav Agarwal(,F)'),
                      TableText('SABARETNAM Mayilvaganan (,F) , Gyan Chand(N)'),
                      TableText('Gaurav Agarwal(N) , Anjali Mishra(,F)'),
                      TableText('Anjali Mishra(N,F)'),
                    ],
                    // 6: Endocrinology
                    [
                      TableText('Preeti Dabadghao(N,F)'),
                      TableText('Preeti Dabadghao(N,F)'),
                      TableText('Preeti Dabadghao(N,F) , V L BHATIA(,F)'),
                      TableText('V L BHATIA(N,F) , Subhash Chandra Yadav(N,F)'),
                      TableText('Subhash Chandra Yadav(N,F) , Preeti Dabadghao(N,F) , Bibhuti Bhusan Mohanta(N,F)'),
                      TableText('V L BHATIA(N,F) , Bibhuti Bhusan Mohanta(N,F)'),
                    ],
                    // 7: Gastroenterology
                    [
                      TableText('Samir Mohindra(N,F)'),
                      TableText('Samir Mohindra(N,F)'),
                      TableText('Samir Mohindra(N,F) , Gaurav pande (N,F)'),
                      TableText('Gaurav pande(N,F)'),
                      TableText('Anshuman Elhence (N,F) , Praveer (N,F)'),
                      TableText('--'),
                    ],
                    // 8: General Hospital
                    [
                      TableText('Piyali Bhattacharya(N,F) , PRERNA KAPOOR (N,F) , Anju Kumari Rani(N,F) , Ajit Kumar(N,F)'),
                      TableText('Piyali Bhattacharya(N,F) , PRERNA KAPOOR (N,F) , Brajesh Singh(N,F) , Ajit Kumar(N,F)'),
                      TableText('Piyali Bhattacharya(N,F) , PRERNA KAPOOR (N,F) , Brajesh Singh(N,F) , Ajit Kumar(N,F)'),
                      TableText('Piyali Bhattacharya(N,F) , PRERNA KAPOOR (N,F) , Ajit Kumar(N,F)'),
                      TableText('Piyali Bhattacharya(N,F) , PRERNA KAPOOR (N,F) , Brajesh Singh(N,F) , Ajit Kumar(N,F)'),
                      TableText('Piyali Bhattacharya(N,F) , Brajesh Singh(N,F) , PRERNA KAPOOR (N,F) , Anju Kumari Rani(N,F)'),
                    ],
                    // 9: Hematology
                    [
                      TableText('Sanjeev (,F)'),
                      TableText('Rajesh Kashyap(N,F) , Sanjeev (N,F)'),
                      TableText('Sanjeev (,F)'),
                      TableText('Rajesh Kashyap(N,F) , Sanjeev (N,F)'),
                      TableText('Sanjeev (,F)'),
                      TableText('Sanjeev (,F)'),
                    ],
                    // 10: Immunology
                    [
                      TableText('Able Lawrence(N,F) , Immuno Clinic(,F)'),
                      TableText('Vikas Agarwal(N,F)'),
                      TableText('Amita Aggarwal(N,F) , Durga Prasanna Misra (N,F) , Immuno Clinic(,F)'),
                      TableText('Able Lawrence(N,F) , Immuno Clinic(,F)'),
                      TableText('Amita Aggarwal(,F) , Durga Prasanna Misra (N,F) , Immuno Clinic(,F)'),
                      TableText('Vikas Agarwal(N,F)'),
                    ],
                    // 11: Maternal And Reproductive Health
                    [
                      TableText('Mandakini Pradhan(N,F) , Sangeeta Yadav (N,F) , Dr. Neeta Singh (N,F)'),
                      TableText('Amrit Gupta(N,F) , INDU LATA (N,F)'),
                      TableText('Mandakini Pradhan(N,F) , Sangeeta Yadav (N,F) , Dr. Neeta Singh (N,F)'),
                      TableText('Amrit Gupta(N,F) , INDU LATA (N,F)'),
                      TableText('Mandakini Pradhan(N,F) , Sangeeta Yadav (N,F) , Dr. Neeta Singh (N,F)'),
                      TableText('Amrit Gupta(N,F) , INDU LATA (N,F)'),
                    ],
                    // 12: Medical Genetics
                    [
                      TableText('Subha Rajendra Phadke(N,F) , Amita Moirangthem ()'),
                      TableText('Kausik Mandal (N,F) , Deepti Saxena ()'),
                      TableText('Kausik Mandal (N,F) , Deepti Saxena (N,F)'),
                      TableText('Subha Rajendra Phadke(N,F) , Amita Moirangthem ()'),
                      TableText('Subha Rajendra Phadke(N,F) , Amita Moirangthem ()'),
                      TableText('Kausik Mandal (N,F) , Deepti Saxena (N,F)'),
                    ],
                    // 13: Microbiology
                    [
                      TableText('--'),
                      TableText('--'),
                      TableText('--'),
                      TableText('--'),
                      TableText('--'),
                      TableText('Rungmei Sk Marak(N,F)'),
                    ],
                    // 14: Neonatology
                    [
                      TableText('Kirti M Naranje (N,F)'),
                      TableText('Kirti M Naranje (N,F)'),
                      TableText('Kirti M Naranje (N,F)'),
                      TableText('Kirti M Naranje (N,F)'),
                      TableText('Kirti M Naranje (N,F)'),
                      TableText('--'),
                    ],
                    // 15: Nephrology
                    [
                      TableText('UNIT-1(N,F)'),
                      TableText('UNIT-D0010-02(N,F) , UNIT-D0010-03(N,F)'),
                      TableText('--'),
                      TableText('UNIT-1(N,F)'),
                      TableText('UNIT-D0010-02(N,F) , UNIT-D0010-03(N,F)'),
                      TableText('--'),
                    ],
                    // 16: Neurology
                    [
                      TableText('VINITA ELIZABETH MANI (N,F) , Mahesh Suresh Jadhav (N,F) , Vimal Kumar Paliwal(N,F) , Gutti Nagendra Babu.'),
                      TableText('Prakash Chandra Pandey(N,F) , Jayanti Kalita(N,F) , RUCHIKA TANDON (N,F) , Roopali Mahajan (N,F)'),
                      TableText('--'),
                      TableText('Prakash Chandra Pandey(N,F) , Jayanti Kalita(N,F) , RUCHIKA TANDON (N,F) , Roopali Mahajan (N,F)'),
                      TableText('VINITA ELIZABETH MANI (N,F) , Mahesh Suresh Jadhav (N,F) , Vimal Kumar Paliwal(N,F) , Gutti Nagendra Babu.'),
                      TableText('--'),
                    ],
                    // 17: Neurosurgery
                    [
                      TableText('AMIT KUMAR KESHRI (N,F) , KUNTAL KANTI DAS (N,F) , M Ravi Sankar ()'),
                      TableText('Ved Prakash Maurya(N,F) , KAMLESH SINGH BHAISORA ()'),
                      TableText('M Ravi Sankar (N,F) , ANANT MEHROTRA (N,F)'),
                      TableText('Awadhesh Kumar Jaiswal(N,F) , Pawan Kumar Verma(N,F)'),
                      TableText('AMIT KUMAR KESHRI (N,F) , Arun Kumar Srivastava(N,F) , Ashutosh Kumar ()'),
                      TableText('--'),
                    ],
                    // 18: Nuclear Medicine
                    [
                      TableText('Prasanta Kumar Pradhan(N,F) , Amitabh Arya(N,F) , Aftab Hasan Nazar (N,F)'),
                      TableText('Sukanta Barai(N,F) , Sanjay Gambhir(N,F) , Manish Ora (N,F)'),
                      TableText('Sanjay Gambhir(N,F) , Amitabh Arya(N,F) , Manish Ora (N,F)'),
                      TableText('Sanjay Gambhir(N,F) , Sukanta Barai(N,F) , Manish Ora (N,F)'),
                      TableText('Prasanta Kumar Pradhan(N,F) , Amitabh Arya(N,F) , Aftab Hasan Nazar (N,F)'),
                      TableText('Amitabh Arya(N,F) , Aftab Hasan Nazar (N,F)'),
                    ],
                    // 19: Ophthalmology
                    [
                      TableText('Vikas Kanaujia(N,F) , Rachana Agarwal (N,F)'),
                      TableText('Vikas Kanaujia(N,F)'),
                      TableText('Rachana Agarwal (N,F)'),
                      TableText('Vaibhav Kumar Jain (N,F)'),
                      TableText('Radha Krishan Dhiman (N,F) , Amit Goel (N,F) , Ajay Kumar Mishra(N,F) , Surender Singh (N,F)'),
                      TableText('--'),
                    ],
                    // 20: Paediatric Gastroenterology
                    [
                      TableText('MOINAK SEN SHARMA (N,F) , Anshu Srivastava(N,F) , Ujjal Poddar(N,F)'),
                      TableText('Ujjal Poddar(N,F) , Anshu Srivastava(N,F) , MOINAK SEN SHARMA (N,F)'),
                      TableText('MOINAK SEN SHARMA (N,F) , Ujjal Poddar(N,F) , Anshu Srivastava(N,F)'),
                      TableText('Ujjal Poddar(N,F) , Anshu Srivastava(N,F) , MOINAK SEN SHARMA (N,F)'),
                      TableText('--'),
                      TableText('Laxmi Kant Bharti(N,F)'),
                    ],
                    // 21: Paediatric Surgery
                    [
                      TableText('Vijai Datta Upadhyaya(N,F)'),
                      TableText('Basant Kumar(N,F)'),
                      TableText('Vijai Datta Upadhyaya(N,F)'),
                      TableText('Ankur Mandelia (N,F)'),
                      TableText('Basant Kumar(N,F)'),
                      TableText('Ankur Mandelia (N,F)'),
                    ]
                  ],
                ),
                const SizedBox(height: 40),
              ],

            )),


          ],
        ),
      ),



    );
  }




}