import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LSAnswerScreen extends StatefulWidget {
  final String questionId;
  final Function(String, Map<String, dynamic>) navigation;
  final int questionNumber;

  const LSAnswerScreen({
    super.key,
    required this.questionId,
    required this.navigation,
    required this.questionNumber,
  });

  @override
  _LSAnswerScreenState createState() => _LSAnswerScreenState();
}

class _LSAnswerScreenState extends State<LSAnswerScreen> {
  late TextEditingController _controller;
  late TextEditingController _japaneseController; // 日本語訳用コントローラー
  late TextEditingController _kaisetuController; // 日本語訳用コントローラー
  String? chapterTitle;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _japaneseController = TextEditingController(); // _japaneseControllerの初期化
    _kaisetuController = TextEditingController(); // _japaneseControllerの初期化
    getlongsentence(widget.questionNumber); // データを初期化時に取得
    getlongsentencejapan(widget.questionNumber); // データを初期化時に取得
    getlongsentencekaisetu(widget.questionNumber); // データを初期化時に取得
  }

  @override
  void dispose() {
    _controller.dispose();
    _japaneseController.dispose(); // _japaneseControllerの破棄
    super.dispose();
  }

  Future<void> getlongsentence(int question) async {
    var box = await Hive.openBox('longsentenceBox');
    var longsentences = box.get('longsentence') as List<dynamic>?;

    if (longsentences != null) {
      for (var longsentenceData in longsentences) {
        if (longsentenceData['問題番号'] == question) {
          _controller.text = longsentenceData['構文'];
          break;
        }
      }
    }
  }

  Future<void> getlongsentencejapan(int question) async {
    var box = await Hive.openBox('longsentenceBox');
    var longsentences = box.get('longsentence') as List<dynamic>?;
    if (longsentences != null) {
      for (var longsentenceData in longsentences) {
        if (longsentenceData['問題番号'] == question) {
          _japaneseController.text = longsentenceData['訳']; // 和訳を設定
          break;
        }
      }
    }
  }

  Future<void> getlongsentencekaisetu(int question) async {
    var box = await Hive.openBox('longsentenceBox');
    var longsentences = box.get('longsentence') as List<dynamic>?;
    if (longsentences != null) {
      for (var longsentenceData in longsentences) {
        if (longsentenceData['問題番号'] == question) {
          _kaisetuController.text = longsentenceData['解説']; // 解説を設定
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    bool isFromAnswer = false;
    if (args is Map<String, dynamic>) {
      isFromAnswer = args.containsKey('questionNumber');
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009688),
        title: const Text(
          '解説',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.navigation('/top', {});
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            if (chapterTitle != null) const SizedBox(height: 16.0),
            Text(
              '問題番号: ${isFromAnswer ? widget.questionNumber : widget.questionId}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4B5),
                border: Border.all(color: Colors.black),
              ),
              child: const Text(
                '構文：',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextFormField(
              controller: _controller,
              readOnly: true,
              minLines: 1,
              maxLines: null,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xFF00695C)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xFF00695C)),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4B5),
                border: Border.all(color: Colors.black),
              ),
              child: const Text(
                '解説：',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _kaisetuController, // 和訳用のコントローラーを設定
              readOnly: true,
              minLines: 1,
              maxLines: null,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xFF00695C)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xFF00695C)),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4B5),
                border: Border.all(color: Colors.black),
              ),
              child: const Text(
                '和訳：',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _japaneseController, // 和訳用のコントローラーを設定
              readOnly: true,
              minLines: 1,
              maxLines: null,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xFF00695C)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xFF00695C)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    backgroundColor: const Color(0xFF009688),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    '戻る',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
