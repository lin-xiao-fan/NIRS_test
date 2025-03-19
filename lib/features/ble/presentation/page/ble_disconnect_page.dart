import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../application/ble_provider.dart';

class ble_disconnect_page extends StatelessWidget {
  final device;

  const ble_disconnect_page({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    final bleProvider = Provider.of<BleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('結束連線並存檔')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await bleProvider.disconnectFromDevice();
              Navigator.pop(context); // 返回前一頁
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('結束連線失敗: $e')),
              );
            }
          },
          child: const Text('結束連線並存檔'),
        ),
      ),
    );
  }
}
