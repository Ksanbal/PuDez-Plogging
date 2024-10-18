import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrDialog extends StatefulWidget {
  const QrDialog({super.key});

  @override
  State<QrDialog> createState() => _QrDialogState();
}

class _QrDialogState extends State<QrDialog> with WidgetsBindingObserver {
  final MobileScannerController controller = MobileScannerController(
    autoStart: true,
    torchEnabled: true,
    useNewCameraSelector: true,
  );

  Barcode? _barcode;
  StreamSubscription<Object?>? _subscription;

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      _barcode = barcodes.barcodes.firstOrNull;
    }

    if (_barcode != null && _barcode?.rawValue != null) {
      final value = _barcode?.rawValue;
      log(value.toString(), name: "QR");
      Get.back(result: value);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscription = controller.barcodes.listen(_handleBarcode);

    unawaited(controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!controller.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        _subscription = controller.barcodes.listen(_handleBarcode);

        unawaited(controller.start());
      case AppLifecycleState.inactive:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(controller.stop());
    }
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    await controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      insetPadding: const EdgeInsets.all(28),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "미션 인증 QR",
              style: TextStyle(
                color: Color(0xff303538),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(8),
            const Text(
              "다음 퀘스트 진행을 위해\nQR코드를 촬영해 주세요.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff636C73),
                fontSize: 14,
              ),
            ),
            const Gap(8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: MobileScanner(
                  controller: controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
