import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'info_user.dart';

class CheckInfo extends StatefulWidget {
  const CheckInfo({super.key});

  @override
  State<CheckInfo> createState() => _CheckInfoState();
}

class _CheckInfoState extends State<CheckInfo> {
  var _currentStep = 0;
  List<Step> stepList() => [
        Step(
            state: _currentStep == 0 ? StepState.indexed : StepState.complete,
            isActive: _currentStep >= 0,
            title: Text(
              'Kiểm tra',
              style: TextStyle(fontSize: 12),
            ),
            content: InfoUser()),
        Step(
            state: _currentStep == 1 ? StepState.indexed : StepState.complete,
            isActive: _currentStep >= 1,
            title: Text(
              'Xác nhận',
              style: TextStyle(fontSize: 12),
            ),
            content: Center(
              child: Text('Address'),
            )),
        Step(
            isActive: _currentStep >= 2,
            title: Text(
              'Thanh toán',
              style: TextStyle(fontSize: 12),
            ),
            content: Center(
              child: Text('Confirm'),
            )),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          'Kiểm tra thông tin',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Stepper(
        controlsBuilder: (context, controls) {
          return Row(
            children: [
              ElevatedButton(
                onPressed: controls.onStepContinue,
                child: const Text('NEXT'),
              ),
              if (_currentStep != 0)
                TextButton(
                  onPressed: controls.onStepCancel,
                  child: const Text(
                    'BACK',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
            ],
          );
        },
        type: StepperType.horizontal,
        onStepTapped: (step) => setState(() => _currentStep = step),
        onStepContinue: () {
          setState(() {
            if (_currentStep < stepList().length - 1) {
              _currentStep += 1;
            } else {
              _currentStep = 0;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep -= 1;
            } else {
              _currentStep = 0;
            }
          });
        },
        currentStep: _currentStep,
        steps: stepList(),
      ),
    );
  }
}
