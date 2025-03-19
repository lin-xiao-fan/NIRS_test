import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart'; // 用於格式化時間字串

class BleDataProcessor {
  final List<List<int>> rawData = [];
  final List<List<double>> parsedData = [];
  final List<List<double>> lastData = [];

  List<List<double>> convertData(List<int> data) {
    rawData.add(data);  // 儲存原始數據
    print( 'data : ${data}') ;
    print("111") ;
    // 開始數據轉換
    List<double> rowVal = [];
    
    // 解析前 4 個字節為時間戳
    int timestamp = _bytesToInt32(data.sublist(0, 4));
    //rowVal.add(timestamp.toDouble());
    print("333") ;
    // 將其餘字節每 3 個一組，轉換為 int32 數值
    List<int> valuesRaw = data.sublist(4);
    List<double> values = [];
    print("444") ;
    for (int i = 0; i < valuesRaw.length; i += 3) {
      int end = min(i + 3, valuesRaw.length); // 避免超過數據範圍
      List<int> group = valuesRaw.sublist(i, end);
      // 確保每組有三個字節，不足時填充 0
      while(group.length < 4) {
        group = [0] + group;  // 用 0 填充
      }
      
      // 將 3 字節轉換為 32 位整數

      int int32Value = _bytesToInt32(group);

      double value = (int32Value << 10) / (2 << 10);
      values.add(value);

    }

    // 添加處理過的數值到結果中
    rowVal.addAll(values);
    parsedData.add(rowVal);

    // 進行展平、重塑和縮放
    List<List<double>> reshapedData = _flattenAndReshape(parsedData, 12);
    print("666") ;
    

    int numChannels = reshapedData[0].length;
    for (int channelIndex = 0; channelIndex < numChannels; channelIndex++) {
      List<double> channelData = [];

      // 遍歷 reshapedData 的每行，將每行中對應 column 的數據存入 channelData
      for (int rowIndex = 0; rowIndex < reshapedData.length; rowIndex++) {
        channelData.add(reshapedData[rowIndex][channelIndex]);
      }

      // 將每個 channel 的數據存儲到 lastdata 中
      lastData.add(channelData);
    }



    // 返回處理後的數據
    return reshapedData;
  }

  // 將字節列表轉換為 32 位整數
  int _bytesToInt32(List<int> bytes) {
    return (bytes[0] << 24) | (bytes[1] << 16) | (bytes[2] << 8) | bytes[3];
  }

  // 展平、重塑和縮放
  List<List<double>> _flattenAndReshape(List<List<double>> data, int rows) {
    // 1. 展平數據
    List<double> flattenedData = data.expand((e) => e).toList();

    // 2. 重新塑形
    int columns = (flattenedData.length / rows).ceil();  // 使用向上取整，確保每行的數據能夠均勻分配
    List<List<double>> reshapedData = [];
    for (int i = 0; i < rows; i++) {
      reshapedData.add(flattenedData.sublist(i * columns, min((i + 1) * columns, flattenedData.length)));
    }

    // 3. 轉換為 ADC 數據
    for (var row in reshapedData) {
      for (int i = 0; i < row.length; i++) {
        row[i] = row[i] / (2 << 22) * 1.2;
      }
    }

    print("Reshaped data: $reshapedData");
    return reshapedData;
  }

  // 濾波器：Butterworth帶通濾波器
  List<double> butterBandpassFilter(List<double> data, double lowcut, double highcut, double fs, int order) {
    final nyquist = 0.5 * fs;
    final low = lowcut / nyquist;
    final high = highcut / nyquist;

    // 計算濾波器的係數
    List<double> b = _butterworthCoefficients(low, high, order);
    List<double> filteredData = _applyFilter(data, b);

    return filteredData;
  }

  // 計算Butterworth濾波器的係數
  List<double> _butterworthCoefficients(double low, double high, int order) {
    // 使用數字濾波器設計方法計算係數
    List<double> coefficients = [];
    // 計算係數的具體邏輯，可以利用數字濾波器設計算法
    // 這裡僅為範例，具體實現可根據需求進行調整

    // 此處簡單返回一些係數作為範例
    for (int i = 0; i < order; i++) {
      coefficients.add(sin(2 * pi * low * i) + cos(2 * pi * high * i));
    }
    return coefficients;
  }

  // 濾波：將計算出的濾波器係數應用到數據
  List<double> _applyFilter(List<double> data, List<double> coefficients) {
    List<double> filteredData = [];
    // 使用濾波器係數進行濾波，這部分可以根據濾波器的具體數學公式進行調整
    for (int i = 0; i < data.length; i++) {
      double filteredValue = data[i];  // 假設直接使用係數濾波，實際應用數學公式進行計算
      filteredData.add(filteredValue);
    }
    return filteredData;
  }

  Future<void> saveToFile() async {
    try {
      // 獲取當前時間並格式化為字串
      String timeStamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

      // 儲存原始與轉換資料
      final dir = await getApplicationDocumentsDirectory();
      
      // 設定 CSV 檔案路徑
      final rawFile = File('${dir.path}/${timeStamp}_raw_data.csv'); 
      final parsedFile = File('${dir.path}/${timeStamp}_parsed_data.csv'); 

      // 將原始資料儲存為 CSV 格式
      await rawFile.writeAsString(rawData.map((e) => e.join(',')).join('\n'));

      // 將解析後的資料儲存為 CSV 格式
      await parsedFile.writeAsString(lastData.map((e) => e.join(',')).join('\n'));

      print("Saving files to: ");
      print("Raw Data File Path: ${rawFile.path}");
      print("Parsed Data File Path: ${parsedFile.path}");

      print("Files saved successfully: ${timeStamp}_raw_data.csv and ${timeStamp}_parsed_data.csv");
    } catch (e) {
      print("Error writing to file: $e");
    }

    clear() ;
  }

  void clear() {
    rawData.clear();
    parsedData.clear();
  }
}
