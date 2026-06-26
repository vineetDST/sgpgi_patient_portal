import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/innner_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/Tab/switching_tab.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Core/Utils/scaffold_messenger.dart';

// --- Import the Base Shell to access the Master Drawer Key ---
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// --- Imports for the routed screens ---
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/clinical_history_screen.dart';
import 'package:qc_hospital/Screens/OP/clinical_summary_screen.dart';
import 'package:qc_hospital/Screens/OP/allergy/allergy_screen.dart';
import 'package:qc_hospital/Screens/OP/vital_signs/vital_signs_screen.dart';
import 'package:qc_hospital/Screens/OP/examinations/examination_screen.dart';
import 'package:qc_hospital/Screens/OP/cpoe_screen.dart';

class OnlinePayment extends StatefulWidget {
  final String patientName;
  final String crn;
  final int initialTabIndex;

  const OnlinePayment({
    super.key,
    required this.patientName,
    required this.crn,
    this.initialTabIndex = 0,
  });

  @override
  State<OnlinePayment> createState() => _OpConsultationState();
}

class _OpConsultationState extends State<OnlinePayment> {

  late int _currentTabIndex;

  @override
  void initState() {
    super.initState();
    // Screen load hote hi jo index pass hua hai, wo set ho jayega
    _currentTabIndex = widget.initialTabIndex;
  }

  final List<String> _myTabs = [
    "Payment Details",
    "General Tariff",
    "Investigation", // Example ke liye extra tabs
    "Part Payment",

  ];



  // Ek helper method tab switch karne ke liye
  void _switchTab(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Widget> _tabViews = [
      PaymentDetails(
        onVerifyClicked: () {
          // Part Payment tab index 3 par hai (0-based index)
          _switchTab(3);
        },
      ),
      GeneralTariff(),
      Investigation(),
      PartPayment(),
    ];
    return ClinicalBaseScaffold(
      title: "Make Online Payment",
      showDrawer: true,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Admission',

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchingTab(
            tabs: _myTabs,
            currentIndex: _currentTabIndex,
            fontSize: 12,
            onTabChanged: _switchTab, // Helper method call
          ),
          const SizedBox(height: 16,),

          // 🔥 FIX: Yahan se Expanded hata diya hai. Ab ye natural height lega.
          _tabViews[_currentTabIndex],
        ],
      ),
    );
  }

}
class PaymentDetails extends StatelessWidget {
  // Callback function receive karne ke liye variable
  final VoidCallback onVerifyClicked;

  // Constructor me callback required kar diya hai
  const PaymentDetails({super.key, required this.onVerifyClicked});

  @override
  Widget build(BuildContext context) {
    return DetailTableWrapper(
      children: [
        DetailRow(label: 'Transaction No', text: '056789'),
        DetailRow(label: 'SBI Ref No', text: '--'),
        DetailRow(label: 'Pay Type', text: 'Part Payment'),
        DetailRow(label: 'Transaction Date', text: 'Jun 8, 2026'),
        DetailRow(label: 'Amount', text: '2000.00'),

        DetailRow(
          label: 'Status',
          customWidget: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFFECB3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TableText('Pending'),
          ),
        ),

        DetailRow(
          label: 'SBI Verified',
          customWidget: GestureDetector(
            onTap: onVerifyClicked, // Click hone par tab switch trigger hoga
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF117A7A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TableText('Verify', color: Colors.white,),
            ),
          ),
          isLast: true,
        ),
      ],
    );
  }
}

class GeneralTariff extends StatefulWidget {
  @override
  State<GeneralTariff> createState() => _GeneralTariffState();
}

class _GeneralTariffState extends State<GeneralTariff> {

  bool _action_a = false ;
  bool _action_b = false ;

  int _totalBalance = 150 ;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        DetailTableWrapper(children: [
          DetailRow(label: 'Tariff Name', text: 'CPP for Haemophilla -2 Unit'),
          DetailRow(label: 'Qty.', text: '1.0'),
          DetailRow(label: 'Price(Rs).', text: '$_totalBalance.00'),
          DetailRow(label: 'Paid Amount', text: '0.00'),
          DetailRow(label: 'Amount', text: '$_totalBalance.00'),


          DetailRow(


            label: "Total Balance (Rs.)",
            removePadding: true, // 🔥 important
            customWidget: Container(
              padding: EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: double.infinity,

              color: Colors.yellow,
              child: const Text(
                "150.00",
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide.none


              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // LEFT
                  Container(
                    width: 150,

                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F8F8),
                      border: Border(
                        right: BorderSide(color: Colors.grey.shade300,width: 2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(   // 🔥 FIX
                          child: Center(
                            child: GlobalCheckbox(
                              label: '', // Label blank hai kyunki hum text par alag action chahte hain
                              value: _action_a ?? false,
                              onChanged: (bool newValue) {
                                setState(() {
                                  _action_a = newValue;
                                  _action_b = newValue;

                                });
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  // RIGHT
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: false
                          ? EdgeInsets.zero
                          : const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      alignment: Alignment.centerLeft,
                      child: GlobalCheckbox(
                        label: '', // Label blank hai kyunki hum text par alag action chahte hain
                        value: _action_b ?? false,
                        onChanged: (bool newValue) {
                          setState(() {
                            _action_b = newValue;
                            _action_a = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )


        ],),
        const SizedBox(height: 16,),
        AppSaveButton(text: 'Make Payment',onPressed: (){

          if (_action_b) { // Aapki purani condition
            // Dialog ko dynamic values ke sath call kar rahe hain
            _showPaymentSummaryDialog(
              context: context,
              transactionForm: 'Billing Against General Tariff', // Ya jo bhi is tab ka naam ho
              payableNowAmount: _totalBalance, // Dynamic amount 1
              totalAmount: _totalBalance,     // Dynamic amount 2 (Yellow box wala)
            );
          } else {
            scaffoldMessenger(
                context,
                title: 'General Tariff',
                message: 'Please select checkbox',
                type: NotificationType.error);
          }
        },),
        const SizedBox(height: 16,),
      ],
    );
  }

  // Dialog open karne ka function (Image ke UI ke according)


}

class Investigation extends StatefulWidget {
  @override
  State<Investigation> createState() => _InvestigationState();
}

class _InvestigationState extends State<Investigation> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  bool _action_a = false;
  bool _action_b = false;
  bool _action_c = false;

  int _amount1 = 85;
  int _amount2 = 85;

  int _totalBalance = 0 ;

  // 🔥 Ye function Master checkbox aur Total Amount ko update karega
  void _updateState() {
    setState(() {
      // Agar dono right true hain, tabhi left true hoga
      _action_a = (_action_b && _action_c);

      // Amount calculate karo jo selected hain
      _totalBalance = 0;
      if (_action_b) _totalBalance += _amount1;
      if (_action_c) _totalBalance += _amount2;
    });
  }

  @override
  Widget build(BuildContext context) {
    _totalBalance = _amount1 + _amount2 ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date fields - Row (Horizontal Expanded theek hai, Vertical Expanded nahi)
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SharedComponents.buildFormLabel("From Date",  ),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: fromController,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: fromDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          fromDate = pickedDate;
                          fromController.text = formatDate(pickedDate);
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SharedComponents.buildFormLabel("To Date",  ),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: toController,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: toDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          toDate = pickedDate;
                          toController.text = formatDate(pickedDate);
                        });
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16,),

        // Search Button
        Center(
          child: SizedBox(
              width: 120,
              height: 40,
              child: AppSaveButton(text: 'Search',onPressed: (){},)),
        ),


        const SizedBox(height: 16,),

        // 🔥 FIX: Yahan table ke aas-paas se Expanded hata diya hai.
        // Ab table jitni lambi hogi, page utna lamba ho jayega aur Scaffold use scroll karega.
        ScrollableDataTable(
            tableLabels: [
              TableLabel(text: 'Requisition No.'),
              TableLabel(text: 'Requisition Date'),
              TableLabel(text: 'Investigation'),
              TableLabel(text: 'Order By'),
              TableLabel(text: 'To Location'),
              TableLabel(text: 'Amount(Rs.)'),
              TableLabel(text: 'Total Balance (Rs.)'),
              TableLabel(
                customWidget: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: GlobalCheckbox(
                          label: '',
                          value: _action_a,
                          onChanged: (bool newValue) {
                            setState(() {
                              _action_a = newValue;
                              // Master par click hua to dono child ko same value do
                              _action_b = newValue;
                              _action_c = newValue;
                              _updateState(); // Amount update karne ke liye call karo
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            rowValues: [
              [
                const TableText('ORDER_7654321'),
                const TableText('ORDER_7654321'),
              ],
              [
                const TableText('08-Jun-2026'),
                const TableText('08-Jun-2026'),
              ],
              [
                const TableText('05. S. Creatinine'),
                const TableText('05. S. Creatinine'),
              ],
              [
                const TableText('Admin'),
                const TableText('Admin'),
              ],
              [
                const TableText('Clinical History'),
                const TableText('Clinical History'),
              ],
              [
                  TableText('$_amount1.00'),
                 TableText('$_amount2.00'),
              ],
              [
                NoRightBorderCell(
                  child: NoPaddingCell(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.yellow,
                      child:   Text("$_totalBalance.00", style: TextStyle(color: Colors.black87, fontSize: 14)),
                    ),
                  ),
                ),
                NoPaddingCell(
                  child: Container(
                    padding: const EdgeInsets.only(left: 16),
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.yellow,

                  ),
                )
              ],
              [
                // RIGHT CHECKBOX 1
                GlobalCheckbox(
                  label: '',
                  value: _action_b,
                  onChanged: (bool newValue) {
                    setState(() {
                      _action_b = newValue;
                      _updateState(); // Check master and update amount
                    });
                  },
                ),
                // RIGHT CHECKBOX 2
                GlobalCheckbox(
                  label: '',
                  value: _action_c,
                  onChanged: (bool newValue) {
                    setState(() {
                      _action_c = newValue;
                      _updateState(); // Check master and update amount
                    });
                  },
                ),
              ]

            ]),
        const SizedBox(height: 16,),
        AppSaveButton(
          text: 'Make Payment',
          onPressed: () {
            // Agar ek bhi select kiya hai to aage badho
            if (_action_b || _action_c) {

              if(_action_b)
                 _totalBalance = _amount1;
              if(_action_c)
                _totalBalance = _amount2;
              if(_action_b && _action_c)
                _totalBalance = _amount1 + _amount2;
              _showPaymentSummaryDialog(
                context: context,
                transactionForm: 'Investigation Billing',
                payableNowAmount: _totalBalance,
                totalAmount: _totalBalance,
              );
            } else {
              scaffoldMessenger(
                  context,
                  title: 'Make Payment',
                  message: 'Please select at least one investigation item',
                  type: NotificationType.error);
            }
          },
        ),
        const SizedBox(height: 16,),
      ],
    );
  }
}

class PartPayment extends StatefulWidget {
  @override
  State<PartPayment> createState() => _PartPaymentState();
}

class _PartPaymentState extends State<PartPayment> {

  bool _action_a = false ;
  bool _action_b = false ;
  int _totalBalance = 2000 ;
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        DetailTableWrapper(children: [
          DetailRow(label: 'Head', text: 'Part Payment'),
          DetailRow(label: 'Date of Req.', text: '08-06-2026'),
          DetailRow(label: 'Req. No.', text: 'REQ9876'),
          DetailRow(label: 'Req. Department', text: 'Endrocine Surgery'),
          DetailRow(label: 'Requested By', text: 'Admin'),
          DetailRow(label: 'Requested Amount', text: '$_totalBalance.00'),


          DetailRow(


            label: "Total Balance (Rs.)",
            removePadding: true, // 🔥 important
            customWidget: Container(
              padding: EdgeInsets.only(left: 16),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: double.infinity,

              color: Colors.yellow,
              child:   Text(
                "$_totalBalance.00",
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide.none


              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // LEFT
                  Container(
                    width: 150,

                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F8F8),
                      border: Border(
                        right: BorderSide(color: Colors.grey.shade300,width: 2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(   // 🔥 FIX
                          child: Center(
                            child: GlobalCheckbox(
                              label: '', // Label blank hai kyunki hum text par alag action chahte hain
                              value: _action_a ?? false,
                              onChanged: (bool newValue) {
                                setState(() {

                                  _action_a = newValue; // Checkbox ka state update
                                  _action_b = newValue; // Checkbox ka state update
                                });
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),

                  // RIGHT
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: false
                          ? EdgeInsets.zero
                          : const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      alignment: Alignment.centerLeft,
                      child: GlobalCheckbox(
                        label: '', // Label blank hai kyunki hum text par alag action chahte hain
                        value: _action_b ?? false,
                        onChanged: (bool newValue) {
                          setState(() {
                            _action_a = newValue; // Checkbox ka state update
                            _action_b = newValue; // Checkbox ka state update
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )


        ],),
        const SizedBox(height: 16,),
        AppSaveButton(text: 'Make Payment',onPressed: (){
          if (_action_b) { // Aapki purani condition
            // Dialog ko dynamic values ke sath call kar rahe hain
            _showPaymentSummaryDialog(
              context: context,
              transactionForm: 'Billing Against General Tariff', // Ya jo bhi is tab ka naam ho
              payableNowAmount: _totalBalance, // Dynamic amount 1
              totalAmount: _totalBalance,     // Dynamic amount 2 (Yellow box wala)
            );
          } else {
            scaffoldMessenger(
                context,
                title: 'Part Payment',
                message: 'Please select checkbox',
                type: NotificationType.error);
          }
        },),
        const SizedBox(height: 16,),
      ],
    );
  }
}

// Function me ab required parameters add kar diye gaye hain
void _showPaymentSummaryDialog({
  required BuildContext context,
  required String transactionForm, // Tab ke hisaab se form ka naam
  required int payableNowAmount, // Payable amount
  required int totalAmount, // Yellow box wala amount
}) {
  String _card = 'CC(Credit Card)';

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.1),
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 24,
        ),
        child: StatefulBuilder(
          builder: (context, setSidebarState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dialog Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD0F0E8), // Light greenish background
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payment Details Summary',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                    child: DetailTableWrapper(
                      children: [
                        // 🔥 Dynamic Transaction Form Name
                        DetailRow(
                          label: 'Transaction Form',
                          text: transactionForm,
                        ),
                        DetailRow(
                          label: 'Payment Mode',
                          customWidget: InnnerDropdown(
                            value: _card,
                            items: ['CC(Credit Card)', 'DC(Debit Card)', 'Cash'],
                            onChanged: (val) {
                              setSidebarState(() {
                                _card = val;
                              });
                            },
                          ),
                        ),
                        // 🔥 Dynamic Payable Now Amount
                        DetailRow(
                          label: 'Payable Now',
                          text: '$payableNowAmount.00',
                        ),
                        DetailRow(
                          label: 'Action',
                          customWidget: AppDeleteIcon(parentContext: context,onDeleteConfirmed: (){
                            print("delete");
                             Navigator.pop(context);

                          },),
                          removePadding: true,
                        ),
                        DetailRow(
                          isLast: true,
                          label: 'Amount(Rs.)',
                          removePadding: true,
                          customWidget: Container(
                            padding: const EdgeInsets.only(left: 16),
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.yellow,
                            child: Text(
                              '$totalAmount.00', // 🔥 Dynamic Total Amount
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: 130,
                    height: 35,
                    child: AppSaveButton(
                      size: 12,
                      text: 'SBI Payment',
                      onPressed: () {
                        // Payment Logic yahan aayega
                      },
                    ),
                  ),
                  const SizedBox(height: 16,),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}







