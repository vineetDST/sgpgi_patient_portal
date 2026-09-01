import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/scaffold_messenger.dart';



class AppDeleteIcon extends StatelessWidget {

  final VoidCallback? onDeleteConfirmed;

  final double iconSize;

  final BuildContext? parentContext;

  final EdgeInsets padding ;

  const AppDeleteIcon({
    Key? key,
    this.onDeleteConfirmed,
    this.iconSize = 15.0,
    this.parentContext,
    this.padding = const EdgeInsets.all(12),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {

        final dialogContext = parentContext ?? context;

        final result = await showDeleteDialog(dialogContext);

        if (result == true) {

          onDeleteConfirmed?.call();
         // Show notification at bottom
          scaffoldMessenger(
            context,
            title: "Successfully Deleted",
            message: "Deleted Successfully",
            type: NotificationType.success,
          );
        
        }
      },
      child: Container(
        // padding: EdgeInsets.all(12),
        padding: padding,
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