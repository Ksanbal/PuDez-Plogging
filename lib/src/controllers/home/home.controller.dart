import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pudez_plogging/main.dart';
import 'package:pudez_plogging/src/common/image.family.dart';
import 'package:pudez_plogging/src/views/home/code.bottomsheet.dart';
import 'package:pudez_plogging/src/views/home/complete.bottomsheet.dart';
import 'package:pudez_plogging/src/views/home/info.dialog.dart';
import 'package:pudez_plogging/src/views/home/qr.dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  @override
  onReady() async {
    super.onReady();

    final prefs = await SharedPreferences.getInstance();
    progress(prefs.getInt('progress') ?? 0);

    if (character == null) Get.offNamed('/');

    await _initLocation();
    await _startListener();

    if (progress.value < 2) {
      Future.delayed(const Duration(seconds: 1), onPressedMission);

      ever(progress, (value) async {
        await prefs.setInt('progress', value);

        Future.delayed(
          const Duration(milliseconds: 500),
          value < 2
              ? () {
                  onPressedMission();
                  _updateMarkers();
                }
              : onComplete,
        );
      });
    } else {
      onComplete();
    }
  }

  /// 진행도
  ///
  /// ~~0 : 집게 찾기, 1: 봉투 찾기, 2: 플로깅 진행, 3: 완료~~
  /// 0 : 집게 찾기, 1: 집게 & 봉투 찾기, 2: 완료
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
    if (progress.value == 0) {
      final value = await Get.bottomSheet(
        const CodeBottomsheet(),
        isScrollControlled: true,
      );

      if (value != null) {
        // firestored에서 해당 값의 문서 검색
        // 있으면 takne을 true로 변경
        // 없으면 에러 메시지 출력
        final data = await db.collection('items').doc(value).get();
        if (data.exists) {
          if (data.data()!['taken']) {
            Get.snackbar(
              "인증 실패",
              "이미 인증된 코드입니다.",
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              backgroundColor: Colors.white,
            );
          } else {
            db.collection('items').doc(value).update({'taken': true});
            progress(progress.value + 1);
          }
        } else {
          Get.snackbar(
            "인증 실패",
            "코드가 일치하지 않습니다.",
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            backgroundColor: Colors.white,
          );
        }
      }
    } else {
      final value = await Get.dialog(
        const QrDialog(),
      );

      if (value != null) {
        final completeCode = "pudez:${progress.value}"; // pudez:1

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
  }

  // 미션 완료 dialog 노출 함수
  onComplete() {
    Get.bottomSheet(
      CompleteBottomSheet(),
      isScrollControlled: true,
      isDismissible: false,
    );
  }

  /// 1. 봉투 위치 A
  late final _markA = Marker(
    markerId: const MarkerId('1'),
    position: const LatLng(37.558637, 126.925487),
    onTap: onPressedMission,
  );

  /// 2. 최종 부스 위치 B
  late final _markB = Marker(
    markerId: const MarkerId('2'),
    position: const LatLng(37.560502, 126.923994),
    onTap: onPressedMission,
  );

  /// 마커 목록
  late RxSet<Marker> markers = <Marker>{}.obs;

  /// 마커 업데이트 함수
  _updateMarkers() async {
    if (progress.value == 2) return;

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
        // 집게 & 봉투 마커
        for (var item in _items) {
          final data = item.data() as Map<String, dynamic>?;
          if (data != null && !data['taken']) {
            final coordinate = data['coordinate'] as GeoPoint;

            markers.add(
              Marker(
                markerId: MarkerId(item.id),
                position: LatLng(coordinate.latitude, coordinate.longitude),
                onTap: onPressedMission,
              ),
            );
          }
        }
        break;
      case 1:
        // 부스 마커
        markers.add(_markA);
        markers.add(_markB);
        break;
    }
  }

  final Rxn<Position> _currentPosition = Rxn<Position>();

  /// 위치 기능 설정
  _initLocation() async {
    try {
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
          // return Future.error('Location permissions are denied');
          return print('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        // return Future.error(
        //   'Location permissions are permanently denied, we cannot request permissions.',
        // );
        return print('Location permissions are permanently denied, we cannot request permissions.');
      }

      _currentPosition.value = await Geolocator.getCurrentPosition();
      moveCameraToCurrentPosition();
      Geolocator.getPositionStream().listen((Position position) {
        _currentPosition.value = position;
        _updateMarkers();
      });
    } catch (error) {
      print('Error: $error');
    }
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

  /// 현재 사용가능한 집게 & 봉투 목록 listener
  final List<QueryDocumentSnapshot<Object?>> _items = [];
  _startListener() {
    try {
      if (progress.value == 0) {
        Stream<QuerySnapshot> itemsStream = db.collection('items').snapshots();
        itemsStream.listen((QuerySnapshot snapshot) {
          _items.clear();
          _items.addAll(snapshot.docs);

          // 마커로 추가
          if (progress.value == 0) {
            _updateMarkers();
          }
        }, onError: (error) {
          print('Error: $error');
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
