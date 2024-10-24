import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pudez_plogging/main.dart';
import 'package:pudez_plogging/src/common/image.family.dart';
import 'package:pudez_plogging/src/views/home/complete.bottomsheet.dart';
import 'package:pudez_plogging/src/views/home/info.dialog.dart';
import 'package:pudez_plogging/src/views/home/qr.dialog.dart';

class HomeController extends GetxController {
  @override
  onReady() {
    super.onReady();

    if (character == null) Get.offNamed('/');

    _initLocation();

    Future.delayed(const Duration(seconds: 1), onPressedMission);

    ever(progress, (value) {
      Future.delayed(
        const Duration(milliseconds: 500),
        value < 3
            ? () {
                onPressedMission();
                _updateMarkers();
              }
            : onComplete,
      );
    });
  }

  /// 진행도
  ///
  /// 0 : 집게 찾기, 1: 봉투 찾기, 2: 플로깅 진행, 3: 완료
  RxInt progress = 0.obs;

  /// 미션 버튼 클릭 이벤트 -> dialog 노출
  onPressedMission() {
    Get.dialog(
      InfoDialog(
        progress: progress.value,
      ),
    );
  }

  /// QR 인증 버튼 이벤트 -> dialog 노출
  onPressedQr() async {
    final value = await Get.dialog(
      const QrDialog(),
    );

    if (value != null) {
      final completeCode = "pudez:${progress.value}";

      if (value == completeCode) {
        progress(progress.value + 1);
      } else {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => Get.snackbar(
            "QR 인증 실패",
            "QR 코드가 일치하지 않습니다.",
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            backgroundColor: Colors.white,
          ),
        );
      }
    }
  }

  // 미션 완료 dialog 노출 함수
  onComplete() {
    Get.bottomSheet(
      const CompleteBottomSheet(),
      isScrollControlled: true,
      isDismissible: false,
    );
  }

  /// 0. 집게 위치
  late final _mark0 = Marker(
    markerId: const MarkerId('0'),
    position: const LatLng(37.55628805421761, 126.92925454322459),
    onTap: onPressedMission,
  );

  /// 1. 봉투 위치
  late final _mark1 = Marker(
    markerId: const MarkerId('1'),
    position: const LatLng(37.556045082385985, 126.92975273958169),
    onTap: onPressedMission,
  );

  /// 2. 최종 부스 위치
  late final _mark2 = Marker(
    markerId: const MarkerId('2'),
    position: const LatLng(37.55558828846465, 126.93053406587038),
    onTap: onPressedMission,
  );

  /// 마커 목록
  late RxSet<Marker> markers = <Marker>{}.obs;

  /// 마커 업데이트 함수
  _updateMarkers() async {
    if (progress.value == 3) return;

    markers.clear();

    // 현재 위치 마커
    if (_currentPosition.value != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('current'),
          position: LatLng(_currentPosition.value!.latitude, _currentPosition.value!.longitude),
          icon: await BitmapDescriptor.asset(
            ImageConfiguration.empty,
            ImageFamily.locatioinCharacterList[character!],
            width: 60,
            height: 70,
          ),
        ),
      );
    }

    switch (progress.value) {
      case 0:
        markers.add(_mark0);
        break;
      case 1:
        markers.add(_mark1);
        break;
      case 2:
        markers.add(_mark2);
        break;
    }
  }

  final Rxn<Position> _currentPosition = Rxn<Position>();

  /// 위치 기능 설정
  _initLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    _currentPosition.value = await Geolocator.getCurrentPosition();
    moveCameraToCurrentPosition();
    Geolocator.getPositionStream().listen((Position position) {
      _currentPosition.value = position;

      moveCameraToCurrentPosition();
    });
  }

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  /// 현재 위치로 카메라 이동 함수
  moveCameraToCurrentPosition() async {
    _updateMarkers();

    final GoogleMapController controller = await mapController.future;

    if (_currentPosition.value != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(_currentPosition.value!.latitude, _currentPosition.value!.longitude),
          zoom: 18,
        ),
      ));
    }
  }
}
