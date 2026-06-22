import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';


class AppDeleteIcon extends StatelessWidget {

  final VoidCallback? onDeleteConfirmed;

  final double iconSize;

  final BuildContext? parentContext;

  const AppDeleteIcon({
    Key? key,
    this.onDeleteConfirmed,
    this.iconSize = 15.0,
    this.parentContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

        final dialogContext = parentContext ?? context;

        final result = await showDeleteDialog(dialogContext);

        if (result == true) {

          onDeleteConfirmed?.call();
        } else {

          print("Cancel");
        }
      },
      child: Container(
        padding: EdgeInsets.all(12),
        color: Colors.transparent,
        child: Image.asset(
          'assets/deleteicon.png',
          height: iconSize,
          width: iconSize,
          color: Colors.red,
        ),
      ),
    );
  }
}