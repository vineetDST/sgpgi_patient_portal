import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';


class AppDownload extends StatelessWidget {

  final VoidCallback? onDownloadConfirmed;

  final double iconSize;

  const AppDownload({
    Key? key,
    this.onDownloadConfirmed,
    this.iconSize = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        onDownloadConfirmed?.call();
      },
      child: Container(

        color: Colors.transparent,
        child: Image.asset(
          'assets/download.png',
          height: iconSize,
          width: iconSize,
          color: Colors.black,
        ),
      ),
    );
  }
}