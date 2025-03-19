import 'package:brelax/core/widgets/nav_list.dart';
import 'package:brelax/features/breathing/presentation/pages/breathing_end.dart';
import 'package:flutter/material.dart';

class BreathingAnimation extends StatefulWidget {
  final int inhale;
  final int hold;
  final int exhale;
  final int duration;

  const BreathingAnimation({
    super.key,
    required this.inhale,
    required this.hold,
    required this.exhale,
    required this.duration,
  });

  @override
  State<BreathingAnimation> createState() => _BreathingAnimation();
}

class _BreathingAnimation extends State<BreathingAnimation> {
  int _seconds = 1; // 預設秒數
  int _totalSeconds = 0;
  String _phase = "inhale"; // 初始狀態：吸氣
  double _cloudOffset = 0.6; // 初始雲朵位置
  String selectedPage = 'BREATHING';

  bool _isStopped = false;
  bool showNavList =false;

  // 各階段的時間
  Map<String, Map<String, int>> breathingPatterns = {
    '4-7-8': {"inhale": 4, "hold": 7, "exhale": 8},
    '4-2-6': {"inhale": 4, "hold": 2, "exhale": 6},
    '盒式呼吸': {"inhale": 4, "hold": 4, "exhale": 4},
    '3-3-3': {"inhale": 3, "hold": 3, "exhale": 3},
  };
  
  void ontapSelected(String label) {
    setState(() {
      selectedPage = label;
    });
    print('選擇頁面: $label');
  }

  @override
  void initState() {
    super.initState();
    _totalSeconds = widget.duration * 60; // 把分鐘數轉換成秒數
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startBreathingCycle();
    });
  }

  // 切換呼吸階段並控制動畫
  void _startBreathingCycle() async {
    
    // 5 秒準備時間
    for (int i = 5; i > 0; i--) {
      if (!mounted) return;
      setState(() {
        _phase = "準備"; 
        _seconds = i;//更新倒數秒數
      });
      await Future.delayed(const Duration(seconds: 1));
    }

    int totalElapsed = 0;
    while (mounted && totalElapsed < _totalSeconds) {
      for (var phase in ["inhale", "hold", "exhale"]) {
        if (_isStopped) return; // 如果停止動畫則返回
        int maxSeconds = _getPhaseDuration(phase);
        setState(() {
          _phase = phase;
          _seconds = 1;
          _cloudOffset = (phase == "inhale")
              ? 0
              : (phase == "exhale")
                  ? 0.6
                  : _cloudOffset;
        });

        totalElapsed += maxSeconds; // 更新總計時
        for (int i = 1; i <= maxSeconds; i++) {
         if (!mounted || _isStopped) return;  // 如果停止動畫則返回
          setState(() {
            _seconds = i;// 更新當前的秒數，讓 UI 顯示計時變化
          });
          await Future.delayed(const Duration(seconds: 1));
        }

        if (totalElapsed >= _totalSeconds) {
          _navigateToBreathingEnd(); // 時間到回上一頁
          return;
        }
      }
    }
  }

  void _stopAnimation() {
    setState(() {
      _isStopped = true; // 停止動畫
      showNavList = true;
    });
  }

  void _navigateToBreathingEnd() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BreathingEnd(),
      ),
    );
  }

  int _getPhaseDuration(String phase) {
    switch (phase) {
      case "inhale":
        return widget.inhale;
      case "hold":
        return widget.hold;
      case "exhale":
        return widget.exhale;
      default:
        return 1;
    }
  }

  //Breathing UI
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFFC2E9FF), Color(0xFFD8F0FF), Color(0xFFC2E9FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
          ),
          
          Positioned(
            top: 100,
            child: _phase == '準備'
                ? const Text(
                    "準備 ",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                             color: Color.fromARGB(115, 0, 0, 0),
                            offset: Offset(0, 0),
                            blurRadius: 15,
                          ),
                        ],
                        ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPhaseText('吸氣', _phase == 'inhale'),
                      const SizedBox(
                        width: 20,
                      ),
                      _buildPhaseText('屏氣', _phase == 'hold'),
                      const SizedBox(
                        width: 20,
                      ),
                      _buildPhaseText('吐氣', _phase == 'exhale'),
                    ],
                  ),
          ),
          Positioned(
              top: 160,
              child: Text(
                '$_seconds',
                style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    shadows: [
                          Shadow(
                            color: Color.fromARGB(115, 0, 0, 0),
                            offset: Offset(0, 0),
                            blurRadius: 15,
                          ),
                        ],
                    ),
              )),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/sun.png',
                width: 200,
              )
            ],
          ),
          AnimatedPositioned(
            duration: Duration(seconds: _getPhaseDuration(_phase)),
            left: screenWidth * _cloudOffset,
            top: screenHeight * 0.35,
            child: Image.asset(
              'assets/images/cloudright.png',
              width: 500,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: _getPhaseDuration(_phase)),
            right: screenWidth * _cloudOffset,
            top: screenHeight * 0.35,
            child: Image.asset(
              'assets/images/cloudleft.png',
              width: 500,
              height: 500,
            ),
          ),
       Positioned(
              bottom: 50,
              child: TextButton(
                  onPressed: _stopAnimation,
                  child: const Text(
                    '停止',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8D8D8D)),
                  )
                  )
                  ),
        if (showNavList)
        Positioned(top: 50,child: NavList(selectedPage: selectedPage,
              onItemSelected: ontapSelected,),)
       ],
      ),
    );
  }

  _buildPhaseText(String text, bool isActive) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          shadows: [
                          Shadow(
                            color: isActive
                            ? const Color.fromARGB(115, 0, 0, 0)
                            : const Color.fromARGB(0, 0, 0, 0),
                            offset: const Offset(0, 0),
                            blurRadius: 15,
                          ),
                        ],
          color: isActive
              ? const Color(0xFFFFFFFF)
              : const Color(0xFFFFFFFF)
                  .withValues(alpha: 153), // 153 表示 50% 透明度,
          ),
    );
  }
}
