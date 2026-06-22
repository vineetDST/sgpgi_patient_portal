import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// -----------------------------------------------------------------------------
// 1. NERVOUS SYSTEM
// -----------------------------------------------------------------------------
class NervousSystemScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const NervousSystemScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<NervousSystemScreen> createState() => _NervousSystemScreenState();
}

class _NervousSystemScreenState extends State<NervousSystemScreen> {
  final _hmfCtrl = TextEditingController();
  final _cnCtrl = TextEditingController();
  final _motorCtrl = TextEditingController();
  final _reflexCtrl = TextEditingController();
  final _ansCtrl = TextEditingController();
  final _sensoryCtrl = TextEditingController();
  final _otherCtrl =
      TextEditingController(); // --- ADDED: Controller for "Other"

  @override
  void dispose() {
    _hmfCtrl.dispose();
    _cnCtrl.dispose();
    _motorCtrl.dispose();
    _reflexCtrl.dispose();
    _ansCtrl.dispose();
    _sensoryCtrl.dispose();
    _otherCtrl.dispose(); // --- ADDED: Dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBaseScreen(
      context,
      widget.patientName,
      widget.crn,
      "Systemic Examination",
      "Nervous System",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormTile(
            "Nervous System",
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextArea("Higher Mental Function", _hmfCtrl),
                  _buildTextArea("Cranial Nerves", _cnCtrl),
                  _buildTextArea("Motor System", _motorCtrl),
                  _buildTextArea("Reflex", _reflexCtrl),
                  _buildTextArea("Automatic Nervous System", _ansCtrl),
                  _buildTextArea("Sensory System", _sensoryCtrl, isLast: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // --- ADDED: Other Textbox below the dropdown ---
          SharedComponents.buildFormLabel("Other"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _otherCtrl,
            hintText: "Other",
            maxLines: 5,
            // height: 130,
          ),
        ],
      ),
    );
  }

  Widget _buildTextArea(
    String label,
    TextEditingController ctrl, {
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedComponents.buildFormLabel(label),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          controller: ctrl,
          hintText: label,
          maxLines: 5,

        ),
        if (!isLast) const SizedBox(height: 24),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 2. RESPIRATORY SYSTEM (left lung.png)
// -----------------------------------------------------------------------------
class RespiratorySystemScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const RespiratorySystemScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<RespiratorySystemScreen> createState() =>
      _RespiratorySystemScreenState();
}

class _RespiratorySystemScreenState extends State<RespiratorySystemScreen> {
  final _rInspCtrl = TextEditingController();
  final _rPalpCtrl = TextEditingController();
  final _rPercCtrl = TextEditingController();
  final _rAuscCtrl = TextEditingController();
  final _lInspCtrl = TextEditingController();
  final _lPalpCtrl = TextEditingController();
  final _lPercCtrl = TextEditingController();
  final _lAuscCtrl = TextEditingController();
  final _remarksCtrl = TextEditingController();

  @override
  void dispose() {
    _rInspCtrl.dispose();
    _rPalpCtrl.dispose();
    _rPercCtrl.dispose();
    _rAuscCtrl.dispose();
    _lInspCtrl.dispose();
    _lPalpCtrl.dispose();
    _lPercCtrl.dispose();
    _lAuscCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBaseScreen(
      context,
      widget.patientName,
      widget.crn,
      "Systemic Examination",
      "Respiratory System",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormTile(
            "Right Lung",
            _buildTextTable([
              _TData("Inspection", _rInspCtrl),
              _TData("Palpation", _rPalpCtrl),
              _TData("Percussion", _rPercCtrl),
              _TData("Auscultation", _rAuscCtrl),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "Left Lung",
            _buildTextTable([
              _TData("Inspection", _lInspCtrl),
              _TData("Palpation", _lPalpCtrl),
              _TData("Percussion", _lPercCtrl),
              _TData("Auscultation", _lAuscCtrl),
            ]),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Other Remarks"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _remarksCtrl,
            hintText: "Other Remarks",
            maxLines: 5,
            // height: 130,
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. CIRCULATORY SYSTEM (circulary 1.png & circulary 2.png)
// -----------------------------------------------------------------------------
class CirculatorySystemScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const CirculatorySystemScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<CirculatorySystemScreen> createState() =>
      _CirculatorySystemScreenState();
}

class _CirculatorySystemScreenState extends State<CirculatorySystemScreen> {
  // Exam 1 States
  String? perPulse,
      rhythm,
      apex,
      rfDelay,
      allPulses,
      cardio,
      s1,
      s2,
      s2Split,
      s3,
      s4,
      rub;
  final _perPulseCtrl = TextEditingController();
  final _rhythmCtrl = TextEditingController();
  final _apexCtrl = TextEditingController();
  final _rfDelayCtrl = TextEditingController();
  final _allPulsesCtrl = TextEditingController();
  final _cardioCtrl = TextEditingController();
  final _s1Ctrl = TextEditingController();
  final _s2Ctrl = TextEditingController();
  final _s2SplitCtrl = TextEditingController();
  final _s3Ctrl = TextEditingController();
  final _s4Ctrl = TextEditingController();
  final _rubCtrl = TextEditingController();

  // Exam 2 States (Matrix)
  String? mitralSys,
      mitralDia,
      aorticSys,
      aorticDia,
      triSys,
      triDia,
      pulSys,
      pulDia;
  final _mitralComm = TextEditingController();
  final _aorticComm = TextEditingController();
  final _triComm = TextEditingController();
  final _pulComm = TextEditingController();

  @override
  void dispose() {
    _perPulseCtrl.dispose();
    _rhythmCtrl.dispose();
    _apexCtrl.dispose();
    _rfDelayCtrl.dispose();
    _allPulsesCtrl.dispose();
    _cardioCtrl.dispose();
    _s1Ctrl.dispose();
    _s2Ctrl.dispose();
    _s2SplitCtrl.dispose();
    _s3Ctrl.dispose();
    _s4Ctrl.dispose();
    _rubCtrl.dispose();
    _mitralComm.dispose();
    _aorticComm.dispose();
    _triComm.dispose();
    _pulComm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBaseScreen(
      context,
      widget.patientName,
      widget.crn,
      "Systemic Examination",
      "Circulatory System",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormTile(
            "Circulatory Examination 1",
            _buildRadioTextTable([
              _RTData(
                "Peripheral Pulse",
                [
                  "Normal",
                  "Hyperdynamic",
                  "Low",
                  "Collapsing",
                  "Parvus et tardus",
                ],
                perPulse,
                (v) => setState(() => perPulse = v),
                _perPulseCtrl,
              ),
              _RTData(
                "Rhythm",
                ["Regular", "Irregular"],
                rhythm,
                (v) => setState(() => rhythm = v),
                _rhythmCtrl,
              ),
              _RTData(
                "Apex",
                ["Normal", "Forceful Sustnd", "Tapping", "Forceful ||| Sustnd"],
                apex,
                (v) => setState(() => apex = v),
                _apexCtrl,
              ),
              _RTData(
                "R F Delay",
                ["Present", "Absent"],
                rfDelay,
                (v) => setState(() => rfDelay = v),
                _rfDelayCtrl,
              ),
              _RTData(
                "All Pulses",
                ["Equal", "Unequal"],
                allPulses,
                (v) => setState(() => allPulses = v),
                _allPulsesCtrl,
              ),
              _RTData(
                "Cardiomegaly",
                ["No", "60 - 80%", "55 - 60%", ">80%"],
                cardio,
                (v) => setState(() => cardio = v),
                _cardioCtrl,
              ),
              _RTData(
                "S1",
                ["Normal", "Loud", "Soft"],
                s1,
                (v) => setState(() => s1 = v),
                _s1Ctrl,
              ),
              _RTData(
                "S2",
                ["Normal", "Loud", "Soft"],
                s2,
                (v) => setState(() => s2 = v),
                _s2Ctrl,
              ),
              _RTData(
                "S2 Split",
                ["Normal", "Reverse", "Fixed", "Increased", "Decreased"],
                s2Split,
                (v) => setState(() => s2Split = v),
                _s2SplitCtrl,
              ),
              _RTData(
                "S3",
                ["Yes", "No"],
                s3,
                (v) => setState(() => s3 = v),
                _s3Ctrl,
              ),
              _RTData(
                "S4",
                ["Yes", "No"],
                s4,
                (v) => setState(() => s4 = v),
                _s4Ctrl,
              ),
              _RTData(
                "Rub",
                ["Yes", "No"],
                rub,
                (v) => setState(() => rub = v),
                _rubCtrl,
              ),
            ], radioWidth: 580),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "Circulatory Examination 2",
            _buildCirculatoryMatrixTable(),
          ),
        ],
      ),
    );
  }

  // Custom Matrix Builder for Circulatory 2
  Widget _buildCirculatoryMatrixTable() {
    const double rowHeight = 70.0;
    Widget buildHeader(String text) => Container(
      width: 180,
      height: rowHeight,
      padding: const EdgeInsets.all(12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.grey.shade300),
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
    );

    Widget buildCol(
      String header,
      String? sysVal,
      Function(String?) sysChange,
      String? diaVal,
      Function(String?) diaChange,
      TextEditingController ctrl, {
      bool isLast = false,
    }) {
      return Container(
        width: 180,
        decoration: BoxDecoration(
          border: Border(
            right: isLast
                ? BorderSide.none
                : BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: rowHeight,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Text(
                header,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
            Container(
              height: rowHeight,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: ["1", "2", "3"]
                    .map(
                      (v) => Radio<String>(
                        value: v,
                        groupValue: sysVal,
                        activeColor: const Color(0xFF117A7A),
                        visualDensity: VisualDensity.compact,
                        onChanged: sysChange,
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              height: rowHeight,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: ["1", "2", "3"]
                    .map(
                      (v) => Radio<String>(
                        value: v,
                        groupValue: diaVal,
                        activeColor: const Color(0xFF117A7A),
                        visualDensity: VisualDensity.compact,
                        onChanged: diaChange,
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              height: rowHeight,
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: ctrl,
                  style: const TextStyle(fontSize: 13),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Fixed Col
          Container(
            width: 150,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF9F9),
              border: Border(right: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                buildHeader("Murmer"),
                buildHeader("Systolic ESM PSM\nGd I-IV"),
                buildHeader("Diastolic ESM PSM\nGd I-IV"),
                buildHeader("Comments"),
              ],
            ),
          ),
          // Right Scroll Col
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildCol(
                    "Mitralvalve",
                    mitralSys,
                    (v) => setState(() => mitralSys = v),
                    mitralDia,
                    (v) => setState(() => mitralDia = v),
                    _mitralComm,
                  ),
                  buildCol(
                    "Aortaic",
                    aorticSys,
                    (v) => setState(() => aorticSys = v),
                    aorticDia,
                    (v) => setState(() => aorticDia = v),
                    _aorticComm,
                  ),
                  buildCol(
                    "Tricuspid",
                    triSys,
                    (v) => setState(() => triSys = v),
                    triDia,
                    (v) => setState(() => triDia = v),
                    _triComm,
                  ),
                  buildCol(
                    "Pulmonary",
                    pulSys,
                    (v) => setState(() => pulSys = v),
                    pulDia,
                    (v) => setState(() => pulDia = v),
                    _pulComm,
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. DIGESTIVE SYSTEM (digestive 1.png & digestive 2.png)
// -----------------------------------------------------------------------------
class DigestiveSystemScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const DigestiveSystemScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<DigestiveSystemScreen> createState() => _DigestiveSystemScreenState();
}

class _DigestiveSystemScreenState extends State<DigestiveSystemScreen> {
  String? liver, spleen, veins, rectal, tenderness, ascites, guarding, abdLump;
  final _liverCtrl = TextEditingController();
  final _spleenCtrl = TextEditingController();
  final _veinsCtrl = TextEditingController();
  final _rectalCtrl = TextEditingController();
  final _tenderCtrl = TextEditingController();
  final _ascitesCtrl = TextEditingController();
  final _guardCtrl = TextEditingController();
  final _abdLumpCtrl = TextEditingController();

  final _inspCtrl = TextEditingController();
  final _percCtrl = TextEditingController();
  final _palpCtrl = TextEditingController();
  final _auscCtrl = TextEditingController();
  final _remarksCtrl = TextEditingController();

  @override
  void dispose() {
    _liverCtrl.dispose();
    _spleenCtrl.dispose();
    _veinsCtrl.dispose();
    _rectalCtrl.dispose();
    _tenderCtrl.dispose();
    _ascitesCtrl.dispose();
    _guardCtrl.dispose();
    _abdLumpCtrl.dispose();
    _inspCtrl.dispose();
    _percCtrl.dispose();
    _palpCtrl.dispose();
    _auscCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBaseScreen(
      context,
      widget.patientName,
      widget.crn,
      "Systemic Examination",
      "Digestive System",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormTile(
            "Digestive Examination 1",
            _buildRadioTextTable([
              _RTData(
                "Liver",
                ["No", "Yes"],
                liver,
                (v) => setState(() => liver = v),
                _liverCtrl,
              ),
              _RTData(
                "Spleen",
                ["No", "Yes"],
                spleen,
                (v) => setState(() => spleen = v),
                _spleenCtrl,
              ),
              _RTData(
                "Veins",
                ["No", "Yes"],
                veins,
                (v) => setState(() => veins = v),
                _veinsCtrl,
              ),
              _RTData(
                "Rectal",
                ["No", "Yes"],
                rectal,
                (v) => setState(() => rectal = v),
                _rectalCtrl,
              ),
              _RTData(
                "Tenderness",
                ["No", "Yes"],
                tenderness,
                (v) => setState(() => tenderness = v),
                _tenderCtrl,
              ),
              _RTData(
                "Ascites",
                ["No", "Yes"],
                ascites,
                (v) => setState(() => ascites = v),
                _ascitesCtrl,
              ),
              _RTData(
                "Guarding",
                ["No", "Yes"],
                guarding,
                (v) => setState(() => guarding = v),
                _guardCtrl,
              ),
              _RTData(
                "Abdominal Lump",
                ["No", "Yes"],
                abdLump,
                (v) => setState(() => abdLump = v),
                _abdLumpCtrl,
              ),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "Digestive Examination 2",
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextArea("Inspection", _inspCtrl),
                  _buildTextArea("Percussion", _percCtrl),
                  _buildTextArea("Palpation", _palpCtrl),
                  _buildTextArea("Auscultation", _auscCtrl, isLast: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Other Remarks"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _remarksCtrl,
            hintText: "Other Remarks",
            maxLines: 5,
            // height: 130,
          ),
        ],
      ),
    );
  }

  Widget _buildTextArea(
    String label,
    TextEditingController ctrl, {
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedComponents.buildFormLabel(label),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          controller: ctrl,
          hintText: label,
          maxLines: 5,
          // height: 130,
        ),
        if (!isLast) const SizedBox(height: 24),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 5. MUSCULOSKELETAL SYSTEM (Upper Limb, Lower Limb, CLEFT, CMF)
// -----------------------------------------------------------------------------
class MusculoskeletalSystemScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const MusculoskeletalSystemScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<MusculoskeletalSystemScreen> createState() =>
      _MusculoskeletalSystemScreenState();
}

class _MusculoskeletalSystemScreenState
    extends State<MusculoskeletalSystemScreen> {
  // Upper
  final _uShoulder = TextEditingController();
  final _uElbow = TextEditingController();
  final _uWrist = TextEditingController();
  final _uMcp = TextEditingController();
  final _uPip = TextEditingController();
  final _uDip = TextEditingController();
  final _uSpecial = TextEditingController();
  final _uOther = TextEditingController();
  // Lower
  final _lHip = TextEditingController();
  final _lKnee = TextEditingController();
  final _lAnkle = TextEditingController();
  final _lFoot = TextEditingController();
  final _lSpine = TextEditingController();
  final _lSpecial = TextEditingController();
  final _lOther = TextEditingController();
  // CLEFT
  final _cLip = TextEditingController();
  final _cPalate = TextEditingController();
  final _cFacial = TextEditingController();
  final _cSpeech = TextEditingController();
  final _cEar = TextEditingController();
  final _cOther = TextEditingController();
  // CMF
  final _mFrontal = TextEditingController();
  final _mZygoma = TextEditingController();
  final _mMaxilla = TextEditingController();
  final _mNasal = TextEditingController();
  final _mOcclusion = TextEditingController();
  final _mTMJ = TextEditingController();
  final _mTeeth = TextEditingController();
  final _mSoft = TextEditingController();
  final _mOther = TextEditingController();
  final _remarksCtrl = TextEditingController();

  @override
  void dispose() {
    _uShoulder.dispose();
    _uElbow.dispose();
    _uWrist.dispose();
    _uMcp.dispose();
    _uPip.dispose();
    _uDip.dispose();
    _uSpecial.dispose();
    _uOther.dispose();
    _lHip.dispose();
    _lKnee.dispose();
    _lAnkle.dispose();
    _lFoot.dispose();
    _lSpine.dispose();
    _lSpecial.dispose();
    _lOther.dispose();
    _cLip.dispose();
    _cPalate.dispose();
    _cFacial.dispose();
    _cSpeech.dispose();
    _cEar.dispose();
    _cOther.dispose();
    _mFrontal.dispose();
    _mZygoma.dispose();
    _mMaxilla.dispose();
    _mNasal.dispose();
    _mOcclusion.dispose();
    _mTMJ.dispose();
    _mTeeth.dispose();
    _mSoft.dispose();
    _mOther.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBaseScreen(
      context,
      widget.patientName,
      widget.crn,
      "Systemic Examination",
      "Muscloskeletel System",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormTile(
            "UPPER LIMB",
            _buildTextTable([
              _TData("Shoulder", _uShoulder),
              _TData("Elbow", _uElbow),
              _TData("Wrist", _uWrist),
              _TData("MCP", _uMcp),
              _TData("PIP", _uPip),
              _TData("DIP", _uDip),
              _TData("Special Test", _uSpecial),
              _TData("Other Dfrmtys", _uOther),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "LOWER LIMB",
            _buildTextTable([
              _TData("Hip", _lHip),
              _TData("Knee", _lKnee),
              _TData("Ankle", _lAnkle),
              _TData("Foot", _lFoot),
              _TData("Spine", _lSpine),
              _TData("Special Test", _lSpecial),
              _TData("Other Dfrmtys", _lOther),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "CLEFT",
            _buildTextTable([
              _TData("Lip", _cLip),
              _TData("Palate", _cPalate),
              _TData("Facial Cleft", _cFacial),
              _TData("Speech", _cSpeech),
              _TData("External Ear", _cEar),
              _TData("Other Dfrmtys", _cOther),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "CMF",
            _buildTextTable([
              _TData("Frontal Bone", _mFrontal),
              _TData("Zyfoma", _mZygoma),
              _TData("Maxilla/Mndble", _mMaxilla),
              _TData("Nasal Bone", _mNasal),
              _TData("Occlusion", _mOcclusion),
              _TData("TMJ", _mTMJ),
              _TData("Teeth", _mTeeth),
              _TData("Soft Tissues", _mSoft),
              _TData("Other Dfrmtys", _mOther),
            ]),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Other Remarks"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _remarksCtrl,
            hintText: "Other Remarks",
            maxLines: 5,
            // height: 130,
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 6. REPRODUCTIVE SYSTEM
// -----------------------------------------------------------------------------
class ReproductiveSystemScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const ReproductiveSystemScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ReproductiveSystemScreen> createState() =>
      _ReproductiveSystemScreenState();
}

class _ReproductiveSystemScreenState extends State<ReproductiveSystemScreen> {
  // Urinary / Reproductive States
  String? uriAbdLump;
  String? uriRenalTenderness;
  String? uriBladderLump;
  String? uriAscites;
  String? uriLymph;
  String? uriSpine;
  String? uriOthers;
  final _uriAbdLumpCtrl = TextEditingController();
  final _uriRenalTendernessCtrl = TextEditingController();
  final _uriBladderLumpCtrl = TextEditingController();
  final _uriAscitesCtrl = TextEditingController();
  final _uriLymphCtrl = TextEditingController();
  final _uriSpineCtrl = TextEditingController();
  final _uriOthersCtrl = TextEditingController();

  // Rectal Exam States
  final _recAnalToneCtrl = TextEditingController();
  final _recPerinealCtrl = TextEditingController();
  final _recBcrCtrl = TextEditingController();
  final _recGrowthCtrl = TextEditingController();
  final _recOthersCtrl = TextEditingController();

  // Prostate States
  final _prosConsistencyCtrl = TextEditingController();
  final _prosNodularityCtrl = TextEditingController();
  final _prosSizeCtrl = TextEditingController();
  final _prosTendernessCtrl = TextEditingController();
  final _prosMucosaCtrl = TextEditingController();

  // Gait & Limb Deformity States
  String? gaitDeformity;
  String? limbDeformity;
  String? otherDeformity;
  final _gaitDeformityCtrl = TextEditingController();
  final _limbDeformityCtrl = TextEditingController();
  final _otherDeformityCtrl = TextEditingController();

  // Genital Examination States
  String? genPrepuce;
  String? genTestis;
  String? genMeatus;
  String? genVaricocele;
  String? genBxo;
  String? genOthers;
  final _genPrepuceCtrl = TextEditingController();
  final _genTestisCtrl = TextEditingController();
  final _genMeatusCtrl = TextEditingController();
  final _genVaricoceleCtrl = TextEditingController();
  final _genBxoCtrl = TextEditingController();
  final _genOthersCtrl = TextEditingController();

  // Vascular Access States
  String? vasAvf;
  String? vasCapd;
  String? vasSubclavian;
  final _vasAvfCtrl = TextEditingController();
  final _vasCapdCtrl = TextEditingController();
  final _vasSubclavianCtrl = TextEditingController();

  final _remarksCtrl = TextEditingController();

  @override
  void dispose() {
    _uriAbdLumpCtrl.dispose();
    _uriRenalTendernessCtrl.dispose();
    _uriBladderLumpCtrl.dispose();
    _uriAscitesCtrl.dispose();
    _uriLymphCtrl.dispose();
    _uriSpineCtrl.dispose();
    _uriOthersCtrl.dispose();
    _recAnalToneCtrl.dispose();
    _recPerinealCtrl.dispose();
    _recBcrCtrl.dispose();
    _recGrowthCtrl.dispose();
    _recOthersCtrl.dispose();
    _prosConsistencyCtrl.dispose();
    _prosNodularityCtrl.dispose();
    _prosSizeCtrl.dispose();
    _prosTendernessCtrl.dispose();
    _prosMucosaCtrl.dispose();
    _gaitDeformityCtrl.dispose();
    _limbDeformityCtrl.dispose();
    _otherDeformityCtrl.dispose();
    _genPrepuceCtrl.dispose();
    _genTestisCtrl.dispose();
    _genMeatusCtrl.dispose();
    _genVaricoceleCtrl.dispose();
    _genBxoCtrl.dispose();
    _genOthersCtrl.dispose();
    _vasAvfCtrl.dispose();
    _vasCapdCtrl.dispose();
    _vasSubclavianCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBaseScreen(
      context,
      widget.patientName,
      widget.crn,
      "Systemic Examination",
      "Urinary / Reproductive System",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormTile(
            "Urinary / Reproductive Examination",
            _buildRadioTextTable([
              _RTData(
                "Abdominal Lump",
                ["No", "Yes"],
                uriAbdLump,
                (v) => setState(() => uriAbdLump = v),
                _uriAbdLumpCtrl,
              ),
              _RTData(
                "Renal Angle Tenderness",
                ["No", "Yes"],
                uriRenalTenderness,
                (v) => setState(() => uriRenalTenderness = v),
                _uriRenalTendernessCtrl,
              ),
              _RTData(
                "Bladder Lump",
                ["No", "Yes"],
                uriBladderLump,
                (v) => setState(() => uriBladderLump = v),
                _uriBladderLumpCtrl,
              ),
              _RTData(
                "Ascites",
                ["No", "Yes"],
                uriAscites,
                (v) => setState(() => uriAscites = v),
                _uriAscitesCtrl,
              ),
              _RTData(
                "Lymphadenopathy",
                ["Normal", "Abnormal"],
                uriLymph,
                (v) => setState(() => uriLymph = v),
                _uriLymphCtrl,
              ),
              _RTData(
                "Spine",
                ["No", "Yes"],
                uriSpine,
                (v) => setState(() => uriSpine = v),
                _uriSpineCtrl,
              ),
              _RTData(
                "Others",
                ["No", "Yes"],
                uriOthers,
                (v) => setState(() => uriOthers = v),
                _uriOthersCtrl,
              ),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "Rectal Exam",
            _buildTextTable([
              _TData("Anal Tone", _recAnalToneCtrl),
              _TData("Perineal Sensation", _recPerinealCtrl),
              _TData("BCR", _recBcrCtrl),
              _TData("Rectal Growth", _recGrowthCtrl),
              _TData("Others", _recOthersCtrl),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "Prostate",
            _buildTextTable([
              _TData("Consistency", _prosConsistencyCtrl),
              _TData("Nodularity", _prosNodularityCtrl),
              _TData("Size", _prosSizeCtrl),
              _TData("Tenderness", _prosTendernessCtrl),
              _TData("Rectal Mucosa", _prosMucosaCtrl),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "Gait & Limb Deformity",
            _buildRadioTextTable([
              _RTData(
                "Gait Deformity",
                ["No", "Yes"],
                gaitDeformity,
                (v) => setState(() => gaitDeformity = v),
                _gaitDeformityCtrl,
              ),
              _RTData(
                "Limb Deformity",
                ["No", "Yes"],
                limbDeformity,
                (v) => setState(() => limbDeformity = v),
                _limbDeformityCtrl,
              ),
              _RTData(
                "Other Deformities",
                ["No", "Yes"],
                otherDeformity,
                (v) => setState(() => otherDeformity = v),
                _otherDeformityCtrl,
              ),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "Genital Examination",
            _buildRadioTextTable([
              _RTData(
                "Prepuce",
                ["Normal", "Abnormal"],
                genPrepuce,
                (v) => setState(() => genPrepuce = v),
                _genPrepuceCtrl,
              ),
              _RTData(
                "Testis",
                ["Normal", "Abnormal"],
                genTestis,
                (v) => setState(() => genTestis = v),
                _genTestisCtrl,
              ),
              _RTData(
                "Meatus",
                ["Normal", "Abnormal"],
                genMeatus,
                (v) => setState(() => genMeatus = v),
                _genMeatusCtrl,
              ),
              _RTData(
                "Varicocele",
                ["Normal", "Abnormal"],
                genVaricocele,
                (v) => setState(() => genVaricocele = v),
                _genVaricoceleCtrl,
              ),
              _RTData(
                "BXO Changes",
                ["No", "Yes"],
                genBxo,
                (v) => setState(() => genBxo = v),
                _genBxoCtrl,
              ),
              _RTData(
                "Others",
                ["No", "Yes"],
                genOthers,
                (v) => setState(() => genOthers = v),
                _genOthersCtrl,
              ),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "Vascular Access",
            _buildRadioTextTable([
              _RTData(
                "AVF",
                ["No", "Yes"],
                vasAvf,
                (v) => setState(() => vasAvf = v),
                _vasAvfCtrl,
              ),
              _RTData(
                "CAPD",
                ["No", "Yes"],
                vasCapd,
                (v) => setState(() => vasCapd = v),
                _vasCapdCtrl,
              ),
              _RTData(
                "Subclavian",
                ["No", "Yes"],
                vasSubclavian,
                (v) => setState(() => vasSubclavian = v),
                _vasSubclavianCtrl,
              ),
            ]),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Other Remarks"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _remarksCtrl,
            hintText: "Other Remarks",
            maxLines: 5,
            // height: 130,
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 7. ENDOCRINE & IMMUNE (Simple Remarks)
// -----------------------------------------------------------------------------
class EndocrineSystemScreen extends StatelessWidget {
  final String patientName;
  final String crn;
    EndocrineSystemScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  final TextEditingController _otherRemarksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _buildBaseScreen(
      context,
      patientName,
      crn,
      "Systemic Examination",
      "Endocrine System",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SharedComponents.buildFormLabel("Other Remarks"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: "Other Remarks",
            maxLines: 5,
            controller: _otherRemarksController,
          ),
        ],
      ),
    );
  }
}

class ImmuneSystemScreen extends StatelessWidget {
  final String patientName;
  final String crn;
    ImmuneSystemScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  final TextEditingController _otherRemarksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _buildBaseScreen(
      context,
      patientName,
      crn,
      "Systemic Examination",
      "Immune System",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SharedComponents.buildFormLabel("Other Remarks"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: "Other Remarks",
            maxLines: 5,
            controller: _otherRemarksController
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 8. EYE EXAMINATION SYSTEM
// -----------------------------------------------------------------------------
class EyeSystemScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const EyeSystemScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<EyeSystemScreen> createState() => _EyeSystemScreenState();
}

class _EyeSystemScreenState extends State<EyeSystemScreen> {
  // Eye Exam 1 Controllers
  final _headPostureCtrl = TextEditingController();
  final _positionOfEyeCtrl = TextEditingController();
  final _proptosisCtrl = TextEditingController();
  final _visionRtCtrl = TextEditingController();
  final _visionLtCtrl = TextEditingController();
  final _antSegmentCtrl = TextEditingController();
  final _pupilSizeCtrl = TextEditingController();
  final _pupilReactionCtrl = TextEditingController();
  final _fundusDiscCtrl = TextEditingController();
  final _bloodVesselsCtrl = TextEditingController();
  final _mascularAreaCtrl = TextEditingController();
  final _restOfFundusCtrl = TextEditingController();
  String? fieldsRadioValue;

  // Cranial Nerves Controllers
  final _cn1Ctrl = TextEditingController();
  final _cn2Ctrl = TextEditingController();
  final _cn3Ctrl = TextEditingController();
  final _cn4Ctrl = TextEditingController();
  final _cn5Ctrl = TextEditingController();
  final _cn6Ctrl = TextEditingController();
  final _cn7Ctrl = TextEditingController();
  final _cn8Ctrl = TextEditingController();
  final _cn9Ctrl = TextEditingController();
  final _cn10Ctrl = TextEditingController();

  @override
  void dispose() {
    _headPostureCtrl.dispose();
    _positionOfEyeCtrl.dispose();
    _proptosisCtrl.dispose();
    _visionRtCtrl.dispose();
    _visionLtCtrl.dispose();
    _antSegmentCtrl.dispose();
    _pupilSizeCtrl.dispose();
    _pupilReactionCtrl.dispose();
    _fundusDiscCtrl.dispose();
    _bloodVesselsCtrl.dispose();
    _mascularAreaCtrl.dispose();
    _restOfFundusCtrl.dispose();
    _cn1Ctrl.dispose();
    _cn2Ctrl.dispose();
    _cn3Ctrl.dispose();
    _cn4Ctrl.dispose();
    _cn5Ctrl.dispose();
    _cn6Ctrl.dispose();
    _cn7Ctrl.dispose();
    _cn8Ctrl.dispose();
    _cn9Ctrl.dispose();
    _cn10Ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBaseScreen(
      context,
      widget.patientName,
      widget.crn,
      "Systemic Examination",
      "Eye Examination",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormTile(
            "Eye Examination 1",
            _buildTextTable([
              _TData("Head Posture", _headPostureCtrl),
              _TData("Position of Eye", _positionOfEyeCtrl),
              _TData("Proptosis", _proptosisCtrl),
              _TData("Vision C Glass -\nRt Eye", _visionRtCtrl),
              _TData("Vision C Glass\n- Lt Eye", _visionLtCtrl),
              _TData("Anterior Segment\nSlit Lamp", _antSegmentCtrl),
              _TData("Pupil Size", _pupilSizeCtrl),
              _TData("Pupil Reaction", _pupilReactionCtrl),
              _TData("Fundus Disc", _fundusDiscCtrl),
              _TData("Blood Vessels", _bloodVesselsCtrl),
              _TData("Mascular Area", _mascularAreaCtrl),
              _TData("Rest of Fundus", _restOfFundusCtrl),
              _TData(
                "Fields",
                null,
                customWidget: _buildRadioGroup(
                  ["Confirmation", "Goldmann", "Automated"],
                  fieldsRadioValue,
                  (v) => setState(() => fieldsRadioValue = v),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 16),

          _buildFormTile(
            "Cranial Nerves",
            _buildTextTable([
              _TData("I", _cn1Ctrl),
              _TData("II", _cn2Ctrl),
              _TData("III", _cn3Ctrl),
              _TData("IV", _cn4Ctrl),
              _TData("V", _cn5Ctrl),
              _TData("VI", _cn6Ctrl),
              _TData("VII", _cn7Ctrl),
              _TData("VIII", _cn8Ctrl),
              _TData("IX", _cn9Ctrl),
              _TData("X", _cn10Ctrl),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildRadioGroup(
    List<String> options,
    String? groupValue,
    Function(String?) onChanged,
  ) {
    // Wrapped in a FittedBox to smoothly scale down instead of throwing an overflow
    // error if the container width is slightly too small.
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: options
            .map(
              (opt) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: opt,
                      groupValue: groupValue,
                      activeColor: const Color(0xFF117A7A),
                      // Tighter visual density to save space naturally
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      onChanged: onChanged,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      opt,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
// =============================================================================
// REUSABLE BUILDERS & MODELS FOR FORMS
// =============================================================================

class _TData {
  final String label;
  final TextEditingController? controller;
  final Widget? customWidget;
  _TData(this.label, this.controller, {this.customWidget});
}

class _RTData {
  final String label;
  final List<String> options;
  final String? selected;
  final Function(String?) onChanged;
  final TextEditingController controller;
  _RTData(
    this.label,
    this.options,
    this.selected,
    this.onChanged,
    this.controller,
  );
}

Widget _buildFormTile(String title, Widget tableContent) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        children: [tableContent],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// UPDATED: Fixed-Left, Scrollable-Right Standard Text Table
// -----------------------------------------------------------------------------
Widget _buildTextTable(List<_TData> rows) {
  const double rowHeight = 64.0;

  return Container(
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Colors.grey.shade300)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FIXED LEFT COLUMN
        Container(
          width: 150,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF9F9),
            border: Border(right: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            children: rows
                .map(
                  (data) => Container(
                    height: rowHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: rows.last == data
                            ? BorderSide.none
                            : BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Text(
                      data.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        // SCROLLABLE RIGHT COLUMN
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rows
                  .map(
                    (data) => Container(
                      height: rowHeight,
                      width:
                          320, // Forces inputs to maintain nice width while allowing scroll
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: rows.last == data
                              ? BorderSide.none
                              : BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child:
                          data.customWidget ??
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: TextField(
                              controller: data.controller,
                              style: const TextStyle(fontSize: 13),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// UPDATED: Fixed-Left, Scrollable-Right Radio+Text Table
// -----------------------------------------------------------------------------
Widget _buildRadioTextTable(List<_RTData> rows, {double radioWidth = 220}) {
  // <-- ADDED: Default width that can be overridden
  const double rowHeight = 64.0;

  return Container(
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Colors.grey.shade300)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // FIXED LEFT COLUMN
        Container(
          width: 150,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF9F9),
            border: Border(right: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            children: rows
                .map(
                  (data) => Container(
                    height: rowHeight,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: rows.last == data
                            ? BorderSide.none
                            : BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Text(
                      data.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),

        // SCROLLABLE RIGHT COLUMN (Radios & Inputs)
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: rows
                  .map(
                    (data) => Container(
                      height: rowHeight,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: rows.last == data
                              ? BorderSide.none
                              : BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Radio Area
                          Container(
                            width:
                                radioWidth, // <--- UPDATED: Dynamic width ensures alignment
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: data.options
                                  .map(
                                    (opt) => Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Radio<String>(
                                          value: opt,
                                          groupValue: data.selected,
                                          activeColor: const Color(0xFF117A7A),
                                          visualDensity: VisualDensity.compact,
                                          onChanged: data.onChanged,
                                        ),
                                        Text(
                                          opt,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          // TextField Area
                          VerticalDivider(
                            width: 24,
                            thickness: 1,
                            color: Colors.grey.shade300,
                          ),

                          Container(
                            width: 280, // Input width
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: TextField(
                                controller: data.controller,
                                style: const TextStyle(fontSize: 13),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    ),
  );
}
// -----------------------------------------------------------------------------
// HELPER BUILDERS & BOILERPLATE
// -----------------------------------------------------------------------------

// Wrapper to avoid repeating the Scaffold, Appbar, PatientCard, QuickActions for every screen
Widget _buildBaseScreen(
  BuildContext context,
  String patientname,
  String crn,
  String appBarTitle,
  String sectionTitle, {
  required Widget child,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  return ClinicalBaseScaffold(
    title: appBarTitle,
    showDrawer: false,
    patientName: patientname,
    crn: crn,
    activeQuickAction: 'Systemic Details',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: MediaQuery.of(context).padding.top + kToolbarHeight + 10,
        // ),
        // SharedComponents.buildPatientCard(
        //   context,
        //   screenWidth,
        //   patientname,
        //   crn,
        // ),
        // const SizedBox(height: 24),
        // SharedComponents.buildQuickActions(
        //   context,
        //   screenWidth,
        //   patientname,
        //   crn,
        //   activeLabel: 'Systemic Details',
        // ),
        // const SizedBox(height: 24),
        Text(
          sectionTitle,
          style: AppTextStyles.RegH3.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        child, // The specific forms go here
        const SizedBox(height: 32),
        SharedComponents.buildActionButtons(context),
        const SizedBox(height: 20),
      ],
    ),

    // bottomNavigationBar: CustomCurvedNavigationBar(
    //   index: 1,
    //   height: 75.0,
    //   color: AppColor.white,
    //   buttonBackgroundColor: AppColor.color117A7A,
    //   backgroundColor: Colors.transparent,
    //   items: const <Widget>[
    //     Icon(Icons.home_filled, size: 26, color: Colors.white),
    //     Icon(Icons.medical_services, size: 26, color: Colors.white),
    //     Icon(Icons.add_business_outlined, size: 26, color: Colors.white),
    //     Icon(Icons.notifications, size: 26, color: Colors.white),
    //   ],
    //   onTap: (index) {},
    // ),
  );
}


// Helper models for Synchronized Radio Tables
class _RadioRowData {
  final String label;
  final List<String> options;
  _RadioRowData(this.label, this.options);
}



