import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'details_reservation.dart';
import 'nouvelle_reservation.dart';

class Reservations extends StatelessWidget {
  //
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade900, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Stack(
                  children: [
                    QRView(
                      key: qrKey,
                      onQRViewCreated: (QRViewController controller) {
                        controller.scannedDataStream.listen((scanData) {
                          print(scanData.code);
                          Get.to(DetailsReservation(scanData.code!));
                        });
                      },
                    ),
                    Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Colors.red.shade900,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
