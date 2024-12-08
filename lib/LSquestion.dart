import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LSQuestionScreen extends StatefulWidget {
  final String questionId; // 質問ID
  final Function(String, Map<String, dynamic>) navigation;
  final int questionNumber; // 問題番号

  const LSQuestionScreen({
    super.key,
    required this.questionId,
    required this.navigation,
    required this.questionNumber,
  });

  @override
  _LSQuestionScreenState createState() => _LSQuestionScreenState();
}

class _LSQuestionScreenState extends State<LSQuestionScreen> {
  late TextEditingController _controller;
  String? chapterTitle; // 章題を格納する変数

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); // _controllerの初期化
    getlongsentence(widget.questionNumber); // データを初期化時に取得
  }

  @override
  void dispose() {
    _controller.dispose(); // _controllerの破棄
    super.dispose();
  }

  Future<void> getlongsentence(int question) async {
    var box = await Hive.openBox('longsentenceBox');
    var longsentences = box.get('longsentence') as List<dynamic>?;

    if (longsentences != null) {
      for (var longsentenceData in longsentences) {
        if (longsentenceData['問題番号'] == question) {
          _controller.text = longsentenceData['長文']; // データをTextFieldに設定
          break; // 一度見つけたらループを抜ける
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    bool isFromAnswer = false;
    if (args is Map<String, dynamic>) {
      isFromAnswer = args.containsKey('questionNumber'); // answer.dartからの遷移かどうか
    }
    // HiveからwordsBoxのデータを取得（語彙データ）
    final wordsBox = Hive.box('wordsBox');
    final words = wordsBox.get('words') as List<dynamic>?;

    // 該当する章番号と問題番号の語彙データを語彙番号順に取得
    final wordList = words
        ?.where((word) =>
            word['章番号'] == 100 && word['問題番号'] == widget.questionNumber)
        .toList();

    // 英訳、品詞種別、和訳をそれぞれリストに分けて抽出
    final englishWords = wordList
            ?.map((word) =>
                '${word['英訳'] ?? ''} 【${word['品詞種別'] ?? ''}】: ${word['和訳'] ?? ''}') // '品詞種別:和訳' の形式にする
            .toList() ??
        [];
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009688),
        title: const Text(
          '長文',
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
        // ここでスクロール可能にする
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            if (chapterTitle != null) // 章題が取得できた場合に表示
              const SizedBox(height: 16.0),
            Text(
              '問題番号: ${isFromAnswer ? widget.questionNumber : widget.questionId}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242), // グレー
              ),
            ),
            const SizedBox(height: 8.0), // 章題のためのスペース

            TextFormField(
              controller: _controller,
              readOnly: true,
              minLines: 1, // 最小行数
              maxLines: null, // 行数を無制限に設定して高さを自動調整
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              decoration: InputDecoration(
                labelText: '次の英文を和訳してください',
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
            const SizedBox(height: 30),
            // 追加された横並びの表示
            Row(
              children: [
                // 子要素をリスト形式で渡す
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE4B5), // 薄いだいだい色の背景
                    border: Border.all(color: Colors.black), // 黒い外枠線
                  ),
                  child: const Text(
                    '重要語彙リスト:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 英訳
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        englishWords.join('\n'), // 英訳を改行で表示
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),

                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 8.0),
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
                    backgroundColor: const Color(0xFF009688), // 明るい緑
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    '戻る',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.navigation('/LSanswer', {
                      'questionNumber': widget.questionNumber,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    backgroundColor: const Color(0xFF009688), // 明るい緑
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    '次へ',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
