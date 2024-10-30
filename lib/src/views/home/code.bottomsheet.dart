import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pudez_plogging/src/common/components/text-button.comp.dart';

class CodeBottomsheet extends StatefulWidget {
  const CodeBottomsheet({super.key});

  @override
  State<CodeBottomsheet> createState() => _CodeBottomsheetState();
}

class _CodeBottomsheetState extends State<CodeBottomsheet> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "미션 인증",
            style: TextStyle(
              color: Color(0xff303538),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(8),
          const Text(
            "집게에 적힌 코드를 입력해주세요.",
            style: TextStyle(
              color: Color(0xff636C73),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Gap(22),
          Row(
            children: [
              // 입력 필드
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: _controller,
                  onChanged: (value) => setState(() {}),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    color: Color(0xff303538),
                    fontWeight: FontWeight.w700,
                  ),
                  cursorColor: const Color(0xff303538),
                  decoration: const InputDecoration(
                    hintText: "코드를 입력하세요",
                    hintStyle: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffE9EBEE),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffE9EBEE),
                        width: 4,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffE9EBEE),
                        width: 4,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffE9EBEE),
                        width: 4,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(10),
              // 버튼
              Flexible(
                flex: 1,
                child: TextButtonComp(
                  onPressed: () => {
                    if (_controller.text.isNotEmpty) Get.back(result: _controller.text),
                  },
                  text: "인증하기",
                  backgroundColor:
                      _controller.text.isEmpty ? const Color(0xffE9EBEE) : const Color(0xff00CD80),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
