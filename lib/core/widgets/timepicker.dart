import 'package:flutter/material.dart';

class Timepicker extends StatefulWidget {
  final Function(int) onTimeSelected;

  const Timepicker({
    super.key,
    required this.onTimeSelected
  });

  @override
  State<Timepicker> createState() => _TimepickerState();
}

class _TimepickerState extends State<Timepicker>{
  int selectedMinute = 1; // 初始選擇 1 分鐘
  final PageController _pageController = PageController(viewportFraction: 0.18);//

 @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // 控制高度
      child: Stack(
        alignment: Alignment.center,
        children: [
          // **中間選取的圓圈**
          Positioned(
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white, 
                shape: BoxShape.circle,
              ),
            ),
          ),
          // **橫向滾輪**
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal, // 設定橫向滾動
            itemCount: 10, // **1~10 分鐘**
            onPageChanged: (index) {
              setState(() {
                selectedMinute = index + 1;
                widget.onTimeSelected(selectedMinute); // 回傳選中的數值
              });
            },
            itemBuilder: (context, index) {
              final isSelected = (index + 1) == selectedMinute;
              return Center(
                child: AnimatedContainer(
                  width: 40,
                  height: 40,
                  duration: const Duration(milliseconds: 300),
                  alignment: Alignment.center,
                  child:Transform.scale(scale: isSelected ? 1.2 : 1,
                  child: Text(
                    "${index + 1} ",
                    style: TextStyle(
                      fontSize: isSelected ? 20 : 18, // **選中的字變大**
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ?  const Color(0xFF4B4B4B) : Colors.grey,
                    ),
                    textAlign: TextAlign.center, // 文字置中對齊
                  ),
                  ),
                  
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}