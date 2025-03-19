import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../application/ble_provider.dart';
import '../widget/ble_device_list.dart';
import 'ble_disconnect_page.dart'; // 引入新頁面

class BleConnectPage extends StatelessWidget {
  const BleConnectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bleProvider = Provider.of<BleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('藍牙裝置連線')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: bleProvider.startScan,
            child: const Text('開始搜尋'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bleProvider.devices.length,
              itemBuilder: (context, index) {
                final device = bleProvider.devices[index].device;
                return ListTile(
                  title: Text(device.name.isNotEmpty ? device.name : '未知裝置'),
                  subtitle: Text(device.id.toString()),
                  onTap: () async {
                    try {
                      await bleProvider.connectToDevice(device);
                      final services = await device.discoverServices();
                      for (var service in services) {
                        for (var characteristic in service.characteristics) {
                          if (characteristic.uuid.toString().toLowerCase().contains("1a01")) {
                            await characteristic.setNotifyValue(true);
                            characteristic.value.listen((value) {
                              print('收到 ${characteristic.uuid}: $value');
                              if ( value.isNotEmpty )
                                bleProvider.addReceivedData(value);
                            });
                          }
                        }
                      }

                      // 連線成功後跳轉到 BleDisconnectPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ble_disconnect_page(device: device),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('連線失敗: $e')),
                      );
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
