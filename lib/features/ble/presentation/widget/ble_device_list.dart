import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import '/features/ble/application/ble_provider.dart';


class BleDeviceList extends StatelessWidget {
  final List<ScanResult> devices;

  const BleDeviceList({super.key, required this.devices});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index].device;

        return ListTile(
          title: Text(device.name.isNotEmpty ? device.name : '未知裝置'),
          subtitle: Text(device.id.toString()),
          onTap: () async {
            final bleProvider = Provider.of<BleProvider>(context, listen: false);
            await bleProvider.connectToDevice(device);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('已連線至 ${device.name}')),
            );
          },
        );
      },
    );
  }
}