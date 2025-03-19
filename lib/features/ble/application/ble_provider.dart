import 'package:brelax/features/ble/application/ble_data_processor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../infrastructure/ble_service.dart';
import 'package:provider/provider.dart';


class BleProvider with ChangeNotifier {
  List<ScanResult> devices = [];
  BluetoothDevice? connectedDevice;
  List<List<int>> rawData = [];
  List<List<double>> processedData = []; // 儲存處理後的數據
  final BleDataProcessor dataProcessor = BleDataProcessor();

  Future<void> startScan() async {
    devices.clear();
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    FlutterBluePlus.scanResults.listen((results) {
      devices = results;
      notifyListeners();
    });
  }

  // 接收資料
  void addReceivedData(List<int> value) {
    rawData.add(value);
    List<List<double>> processedData_temp = []; // 儲存處理後的數據
    //print( "size : ${rawData.length}") ;
    processedData_temp = dataProcessor.convertData(value);
    //print('size : ${processedData_temp.length}') ;
    for(int i = 0 ; i < processedData_temp.length ; i++ ){
      processedData.add( processedData_temp[i] ) ;
      //print('size : ${processedData_temp[i].length}') ;
    }


    notifyListeners();
  }
  


  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    connectedDevice = device;
    notifyListeners();
  }

  Future<void> disconnectFromDevice() async {
    if (connectedDevice != null) {
      await connectedDevice!.disconnect();
      await dataProcessor.saveToFile();
      connectedDevice = null;
      notifyListeners();
    }
  }

  Future<void> discoverServices(BluetoothDevice device) async {
    await device.discoverServices();
  }



}
