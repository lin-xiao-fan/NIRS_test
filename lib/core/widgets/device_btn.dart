import 'package:brelax/core/constants/font_style.dart';
import 'package:flutter/material.dart';

class DeviceBtn extends StatelessWidget {
  const DeviceBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(290, 30),
          backgroundColor: Colors.white, // 設定背景顏色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 設定圓角
            side: const BorderSide(
              color: Color.fromRGBO(184, 184, 184, 1), // 設定邊框顏色
              width: 1,
            ),
          ),
          shadowColor: Colors.transparent
        ),
        child: Text('nirs', style: FontStyles.smallContent),
      ),
    );
  }
}
