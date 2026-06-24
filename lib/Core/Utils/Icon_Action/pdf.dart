import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';


class AppPdfIcon extends StatelessWidget {

  final VoidCallback? onDeleteConfirmed;

  final double iconSize;

  final BuildContext? parentContext;

  const AppPdfIcon({
    Key? key,
    this.onDeleteConfirmed,
    this.iconSize = 15.0,
    this.parentContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.transparent,
      child: Image.asset(
        'assets/pdf.png',
        height: iconSize,
        width: iconSize,
        color: Colors.red,
      ),
    );
  }
}