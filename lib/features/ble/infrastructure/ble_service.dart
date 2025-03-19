import 'package:flutter_blue_plus/flutter_blue_plus.dart';


class BleService {


  // 開始掃描裝置
  Future<void> startScan() async {
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
  }

  // 停止掃描裝置
  void stopScan() {
    FlutterBluePlus.stopScan();
  }

  // 取得掃描結果
  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  // 連接到裝置
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
  }

  // 斷開裝置連接
  Future<void> disconnectFromDevice(BluetoothDevice device) async {
    await device.disconnect();
  }
}
