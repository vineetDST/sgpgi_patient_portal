import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// --- DATA MODELS ---
class BodyPartZone {
  final String name;
  final Rect rect; // Changed from Offset to exact Rect bounds
  BodyPartZone(this.name, this.rect);
}

class AnnotationMark {
  final String id;
  final String partName;
  final String note;
  final Color color;
  final Rect rect; // Store the exact bounds of the part for the outline box
  final String viewType;

  AnnotationMark({
    required this.id,
    required this.partName,
    required this.note,
    required this.color,
    required this.rect,
    required this.viewType,
  });
}

class ImageAnnotationScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ImageAnnotationScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ImageAnnotationScreen> createState() => _ImageAnnotationScreenState();
}

class _ImageAnnotationScreenState extends State<ImageAnnotationScreen> {
  String _currentView = 'Frontal'; // 'Frontal' or 'Dorsal'
  List<AnnotationMark> _annotations = [];

  // Define a color palette for multiple problems
  final List<Color> _markerColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.brown,
  ];

  // --- PREDEFINED BODY PARTS (Exact Rect Bounds: Left, Top, Right, Bottom from 0.0 to 1.0) ---
  final List<BodyPartZone> _frontalParts = [
    BodyPartZone("Head", const Rect.fromLTRB(0.40, 0.03, 0.60, 0.15)),
    BodyPartZone(
      "Right Shoulder",
      const Rect.fromLTRB(0.30, 0.15, 0.45, 0.25),
    ), // Patient's right
    BodyPartZone("Left Shoulder", const Rect.fromLTRB(0.55, 0.15, 0.70, 0.25)),
    BodyPartZone("Right Chest", const Rect.fromLTRB(0.35, 0.25, 0.50, 0.38)),
    BodyPartZone("Left Chest", const Rect.fromLTRB(0.50, 0.25, 0.65, 0.38)),
    BodyPartZone("Stomach", const Rect.fromLTRB(0.38, 0.38, 0.62, 0.50)),
    BodyPartZone(
      "Groin",
      const Rect.fromLTRB(0.42, 0.50, 0.58, 0.62),
    ), // Explicitly defined, distinct from Stomach
    BodyPartZone("Right Palm", const Rect.fromLTRB(0.25, 0.50, 0.35, 0.60)),
    BodyPartZone("Left Palm", const Rect.fromLTRB(0.65, 0.50, 0.75, 0.60)),
    BodyPartZone("Right Knee", const Rect.fromLTRB(0.40, 0.68, 0.50, 0.78)),
    BodyPartZone("Left Knee", const Rect.fromLTRB(0.51, 0.68, 0.61, 0.78)),
    BodyPartZone("Right Toe", const Rect.fromLTRB(0.41, 0.90, 0.505, 1.0)),
    BodyPartZone("Left Toe", const Rect.fromLTRB(0.51, 0.90, 0.60, 1.0)),
  ];

  final List<BodyPartZone> _dorsalParts = [
    BodyPartZone("Back Skull", const Rect.fromLTRB(0.35, 0.0, 0.65, 0.15)),
    BodyPartZone("Upper Back", const Rect.fromLTRB(0.40, 0.15, 0.60, 0.30)),
    BodyPartZone("Lower Back", const Rect.fromLTRB(0.38, 0.30, 0.62, 0.45)),
    BodyPartZone("Waist", const Rect.fromLTRB(0.35, 0.45, 0.65, 0.55)),
    BodyPartZone(
      "Left Shoulder Blade",
      const Rect.fromLTRB(0.25, 0.15, 0.40, 0.30),
    ), // Patient's left
    BodyPartZone(
      "Right Shoulder Blade",
      const Rect.fromLTRB(0.60, 0.15, 0.75, 0.30),
    ),
    BodyPartZone("Left Heel", const Rect.fromLTRB(0.35, 0.90, 0.48, 1.0)),
    BodyPartZone("Right Heel", const Rect.fromLTRB(0.52, 0.90, 0.65, 1.0)),
  ];

  @override
  Widget build(BuildContext context) {
    return ClinicalBaseScaffold(
      title: "Image Annotations",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Image Annotations',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Image Annotation",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // --- VIEW TOGGLE BUTTONS ---
          Row(
            children: [
              Expanded(child: _buildViewToggle('Frontal')),
              const SizedBox(width: 16),
              Expanded(child: _buildViewToggle('Dorsal')),
            ],
          ),
          const SizedBox(height: 16),

          // --- INTERACTIVE BODY MAP AREA ---
          Container(
            height: 450,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  onTapUp: (details) =>
                      _handleMapTap(details, constraints.biggest),
                  child: Stack(
                    children: [
                      // Base Body Image
                      Center(
                        child: Image.asset(
                          _currentView == 'Frontal'
                              ? 'assets/frontal_view.png' // Replace with your actual image path
                              : 'assets/dorsal_view.png',
                          fit: BoxFit.contain,
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          errorBuilder: (context, error, stackTrace) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.accessibility_new,
                                  size: 64,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "$_currentView View\n(Image Missing)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Draw Colored Outline Boxes for saved annotations in this view
                      ..._annotations
                          .where((a) => a.viewType == _currentView)
                          .map(
                            (annotation) =>
                                _buildMarker(annotation, constraints.biggest),
                          ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Action Buttons (Standard Save/Cancel at bottom)
          SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- LOGIC: HANDLE TAPS ---
  void _handleMapTap(TapUpDetails details, Size containerSize) {
    // 1. Calculate relative coordinates (0.0 to 1.0)
    double relX = details.localPosition.dx / containerSize.width;
    double relY = details.localPosition.dy / containerSize.height;
    Offset tapOffset = Offset(relX, relY);

    // 2. Find the exact body part clicked
    BodyPartZone? clickedZone = _getClickedPart(tapOffset, _currentView);

    // 3. Open Add Note Modal if a valid zone was clicked
    if (clickedZone != null) {
      _showAddNoteModal(clickedZone);
    }
  }

  BodyPartZone? _getClickedPart(Offset tap, String view) {
    List<BodyPartZone> zones = view == 'Frontal' ? _frontalParts : _dorsalParts;
    // Check which exact rectangle the tap falls inside
    for (var zone in zones) {
      if (zone.rect.contains(tap)) {
        return zone;
      }
    }
    return null; // Ignore taps outside of defined body parts
  }

  // --- UI: VIEW TOGGLE ---
  Widget _buildViewToggle(String viewName) {
    bool isActive = _currentView == viewName;
    return GestureDetector(
      onTap: () => setState(() => _currentView = viewName),
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF117A7A) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isActive ? const Color(0xFF117A7A) : Colors.grey.shade300,
          ),
        ),
        child: Text(
          viewName,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // --- UI: OUTLINE BOX ON IMAGE ---
  Widget _buildMarker(AnnotationMark annotation, Size containerSize) {
    // Calculate absolute position & dimensions for the outline box
    double left = annotation.rect.left * containerSize.width;
    double top = annotation.rect.top * containerSize.height;
    double width = annotation.rect.width * containerSize.width;
    double height = annotation.rect.height * containerSize.height;

    return Positioned(
      left: left,
      top: top,
      width: width,
      height: height,
      child: GestureDetector(
        onTap: () => _showViewNoteModal(annotation),
        child: Container(
          decoration: BoxDecoration(
            color: annotation.color.withOpacity(0.3), // Highlight fill
            border: Border.all(
              color: annotation.color,
              width: 2.5,
            ), // Colored outline
            borderRadius: BorderRadius.circular(
              8,
            ), // Organic slightly rounded edges
          ),
        ),
      ),
    );
  }

  // --- MODALS ---

  // UPDATED: Now uses a centered Dialog with Cancel and Save buttons on the same line
  void _showAddNoteModal(BodyPartZone zone) {
    TextEditingController noteCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Note (${zone.name})",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Note Input Area
              SharedComponents.buildTextField(
                controller: noteCtrl,
                hintText: "Describe the problem here...",
                maxLines: 5,
                // height: 120,
              ),
              const SizedBox(height: 24),

              // Save & Cancel Buttons on the same line
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (noteCtrl.text.trim().isNotEmpty) {
                          setState(() {
                            // Remove any existing annotation for this exact part to replace it
                            _annotations.removeWhere(
                              (a) =>
                                  a.partName == zone.name &&
                                  a.viewType == _currentView,
                            );

                            _annotations.add(
                              AnnotationMark(
                                id: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                                partName: zone.name,
                                note: noteCtrl.text.trim(),
                                color:
                                    _markerColors[_annotations.length %
                                        _markerColors.length],
                                rect: zone.rect, // Pass the exact boundaries
                                viewType: _currentView,
                              ),
                            );
                          });
                        }
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF117A7A),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Save Note",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showViewNoteModal(AnnotationMark annotation) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: annotation.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        annotation.partName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  annotation.note,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(
                          () => _annotations.removeWhere(
                            (a) => a.id == annotation.id,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Delete Note",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
