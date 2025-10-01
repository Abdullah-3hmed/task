import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.body,
    required this.title,
    required this.subTitle,
    required this.save,
    required this.finish,
  });

  final Widget body;
  final String title;
  final String subTitle;
  final void Function() save;
  final void Function() finish;

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
                          child: MaterialButton(
                            height: 50.0,
                            color: const Color(0xFF292929),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: save,
                            child: const Text(
                              "حفظ  التغيرات",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFEFC),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            height: 50.0,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Color(0xFF5B8C51)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: finish,
                            child: const Text(
                              "الغاء",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF5B8C51),
                              ),
                            ),
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
