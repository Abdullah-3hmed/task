import 'package:flutter/material.dart';
import 'package:task/core/widgets/primary_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.body,
    required this.title,
    required this.subTitle,
    required this.onSave,
  });

  final Widget body;
  final String title;
  final String subTitle;
  final Function() onSave;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20.0),
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsetsDirectional.all(20.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Text(
                      subTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0,
                      ),
                    ),
                    body,
                    const SizedBox(height: 30.0),
                    Row(
                      spacing: 10.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            text: "حفظ التغيرات",
                            onPressed: onSave,
                          ),
                        ),
                        Expanded(
                          child: PrimaryButton(
                            text: "الغاء",
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            borderColor: const Color(0xFF5B8C51),
                            backgroundColor: Colors.white,
                            textColor: const Color(0xFF5B8C51),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: 26.0,
            end: 26.0,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
