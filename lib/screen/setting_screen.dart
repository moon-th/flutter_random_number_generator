import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_row.dart';
import 'package:random_number_generator/constant/color.dart';

class SettingScreen extends StatefulWidget {
  final int maxNumber;

  const SettingScreen({Key? key, required this.maxNumber}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  double maxNumber = 1000;

  @override
  void initState() {
    super.initState();
    maxNumber = widget.maxNumber.toDouble();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _Body(maxNumber: maxNumber),
                _Footer(
                    maxNumber: maxNumber,
                    onSliderChanged: onSliderChanged,
                    onButtonPressed: onButtonPressed)
              ],
            ),
          ),
        ));
  }


  void onSliderChanged(double val){
    // setState 를 사용하여 숫자가 변경될 때 마다 Build 를 다시 해준다.
    setState(() {
        maxNumber= val;
    });
  }

  void onButtonPressed() {
    // 저장버튼을 눌렀을 때 pop 으로 이전 스택의 스크린으로 파라미터와 함께 돌아간다.
    Navigator.of(context).pop(maxNumber.toInt()); // 뒤로가기
  }
}

class _Body extends StatelessWidget {
  final double maxNumber;

  const _Body({Key? key, required this.maxNumber}) : super(key: key);

  // body 위젯을 만들어 선택한 값을 입력해 준다.
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NumberRow(
          number:maxNumber.toInt())
    );
  }
}

class _Footer extends StatelessWidget {
  final ValueChanged<double> onSliderChanged;
  final VoidCallback onButtonPressed;
  final double maxNumber;

  const _Footer(
      {Key? key,
      required this.maxNumber,
      required this.onSliderChanged,
      required this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 숫자 변경에 사용할 슬라이더 셋팅
        Slider(
          value: maxNumber,
          min: 1000,
          max: 100000,
          onChanged: onSliderChanged,
        ),
        ElevatedButton(
          onPressed: onButtonPressed,
          style: ElevatedButton.styleFrom(primary: RED_COLOR),
          child: Text('저장!'),
        ),
      ],
    );
  }
}
