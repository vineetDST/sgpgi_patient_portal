import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Sidesheet/side_sheet_helper.dart';


class RightSwipeCloseWrapper extends StatefulWidget {
  final Widget child;
  const RightSwipeCloseWrapper({super.key, required this.child});

  @override
  State<RightSwipeCloseWrapper> createState() =>
      _RightSwipeCloseWrapperState();
}

class _RightSwipeCloseWrapperState extends State<RightSwipeCloseWrapper> {
  double _dragX = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.82;

    return GestureDetector(
      onHorizontalDragUpdate: (d) => _dragX += d.delta.dx,
      onHorizontalDragEnd: (_) {
        if (_dragX > 100) {
          closeSideSheet(context); // ✅ SAFE CLOSE
        }
        _dragX = 0;
      },
      child: Material(
        color: Colors.white,

        borderRadius:
        const BorderRadius.horizontal(left: Radius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: width,
          height: double.infinity,
          child: widget.child,
        ),
      ),
    );
  }
}
