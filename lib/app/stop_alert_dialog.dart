import 'dart:math';

import 'package:flutter/material.dart';

class StopAlertDialog extends StatefulWidget {
  const StopAlertDialog({
    super.key,
    required this.response,
  });
  final Function(bool) response;

  @override
  State<StopAlertDialog> createState() => StopAlertDialogState();
}

class StopAlertDialogState extends State<StopAlertDialog> {
  bool isStopSelected = true;

  // ignore: avoid_positional_boolean_parameters
  void changeStopSelected(bool value) {
    setState(() {
      isStopSelected = value;
    });
  }

  void sendResponse({bool? response}) {
    widget.response(response ?? isStopSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 32,
      ),
      padding: const EdgeInsets.all(16),
      height: max(
        250,
        MediaQuery.of(context).size.height * 0.25,
      ),
      width: max(
        600,
        MediaQuery.of(context).size.width * 0.6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Confirmation',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Do you wish to cancel the recording? If so, none of the program will be retained in your Saved Shows.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: isStopSelected ? Colors.red : null,
                ),
                onPressed: () => sendResponse(response: true),
                child: Text(
                  'Stop Recording',
                  style: TextStyle(
                    fontSize: 12,
                    color: isStopSelected ? Colors.white : Colors.grey,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      !isStopSelected ? Colors.grey.shade400 : null,
                ),
                onPressed: () => sendResponse(response: false),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 12,
                    color: !isStopSelected ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
