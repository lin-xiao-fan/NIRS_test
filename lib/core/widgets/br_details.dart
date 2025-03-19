import 'package:brelax/core/constants/font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BrDetails extends StatelessWidget {
  final String title;
  final String shortID;
  final String detailed;
  final String inhale;
  final String hold;
  final String exhale;

  const BrDetails({
    super.key,
    this.title = '',
    this.shortID = '',
    this.detailed = '',
    this.inhale = '',
    this.exhale = '',
    this.hold = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xC4FFFFFF),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6,),
          Container(
            width: 290,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFCDEDFF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              shortID,
              textAlign: TextAlign.center,
              style: FontStyles.text15,
            ),
          ),
          const SizedBox(height: 6,),
          Text(
            detailed,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Breathstep(text: inhale, iconPath: 'assets/images/breath.svg'),
              Breathstep(text: hold, iconPath: 'assets/images/hold.svg'),
              Breathstep(text: exhale, iconPath: 'assets/images/breath.svg'),
            ],
          )
        ],
      ),
    );
  }
}

class Breathstep extends StatelessWidget {
  final String text;
  final String iconPath; //圖片路徑

  const Breathstep({super.key, required this.text, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85,
      height: 30,
      decoration: BoxDecoration(color: const Color(0xFFCDEDFF),borderRadius: BorderRadius.circular(10)),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center, // 子元素水平從左到右排列
  crossAxisAlignment: CrossAxisAlignment.center, // 子元素在垂直方向居中對齊
      children: [
        SvgPicture.asset(iconPath, width: 14, height: 14, fit: BoxFit.contain),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
           textAlign: TextAlign.center,
        )
      ],
    ),
    );
  }
}
