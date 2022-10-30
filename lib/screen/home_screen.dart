import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_row.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int maxNumber = 1000;

  List<int> randomNumbers = [123, 456, 789];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PRIMARY_COLOR,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(onPressed: onSettingsPop),
                _Body(randomNumbers: randomNumbers,),
                _Footter(onPressed: onRandomNumberGenerate)
              ],
            ),
          ),
        ));
  }

  // 설정되어 있는 maxNumber 를 이용하여 list 생성
  void onRandomNumberGenerate(){
    // 랜덤숫자 생성 함수
    final rand = Random();

    // 중복 제거를 위해 set 사용
    final Set<int> newNumbers = {};
    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxNumber);
      newNumbers.add(number);
    }
    setState(() {
      randomNumbers = newNumbers.toList();
      }
    );
  }

  void onSettingsPop () async {
    // list -> add
    // 다음 페이지에서 전달해주는 값을 받은 후 로직을 실행 시키기 위해서 동시 상태의 async await 사용
    final int? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(builder: (BuildContext context){
        return SettingScreen(maxNumber: maxNumber,); // 파라미터를 다음화면으로 넘겨준다.
      },
      ),
    );
    if(result != null){
      // 넘겨받은 값이 null 이 아닐경우 받아온 값을 이용하여 위젯를 다시 Build
        setState(() {
            maxNumber = result;
        });
      }
  }
}


class _Header extends StatelessWidget {

  final VoidCallback onPressed;

  const _Header({Key? key, required this.onPressed,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('랜덤숫자 생성기',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 30.0)),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        )
      ],
    );
  }
}

class _Body extends StatelessWidget {

  final List<int> randomNumbers;

  const _Body({Key? key, required this.randomNumbers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: randomNumbers
            .asMap() // 생성된 random list 를 맵으로 변경
            .entries
            .map(
              (e) => Padding(
            padding: // padding 을 이용하여 줄 사이사이 간격을 띄워준다.
            EdgeInsets.only(bottom: e.key == 2 ? 0 : 16.0),
            // NumberRow 함수를 이용하여 숫자를 이미지 파일로 변경
            child: NumberRow(
              number: e.value,
            ),
          ),
        ).toList(),
      ),
    );
  }
}


class _Footter extends StatelessWidget {

  final VoidCallback onPressed;

  const _Footter({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: RED_COLOR),
        onPressed: onPressed,
        child: Text('생성하기'),
      ),
    );
  }
}
