import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// 独立したステートフルウィジェットとしてチェックボックスを定義
class CustomCheckbox extends StatefulWidget {
  final int check; // チェック状態を示すパラメータ
  final int chapterNumber; // 章番号
  final int questionNumber; // 問題番号

  const CustomCheckbox({
    super.key,
    required this.check,
    required this.chapterNumber,
    required this.questionNumber,
  });

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked; // チェックボックスの状態

  @override
  void initState() {
    super.initState();
    // 初期状態をHiveからの値に基づいて設定
    _isChecked = widget.check == 1;
  }

  // チェックボックスの値を更新するメソッド
  void _updateCheckValue(bool value) {
    final questionsBox = Hive.box('questionsBox');
    final questions = questionsBox.get('questions') as List<dynamic>?;

    if (questions != null) {
      // 更新対象のデータを探す
      final index = questions.indexWhere((question) =>
          question['章番号'] == widget.chapterNumber &&
          question['問題番号'] == widget.questionNumber);

      if (index != -1) {
        // チェックの値を更新
        questions[index]['チェック'] = value ? 1 : 0;
        questionsBox.put('questions', questions); // データを保存
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false; // 新しい状態を更新
              _updateCheckValue(_isChecked); // Hiveの値を更新
            });
          },
        ),
        const Text('チェック'),
      ],
    );
  }
}

// answer.dart
class AnswerScreen extends StatelessWidget {
  final int chapterNumber; // 章番号
  final int questionNumber; // 問題番号

  const AnswerScreen({
    super.key,
    required this.chapterNumber,
    required this.questionNumber,
  });

  @override
  Widget build(BuildContext context) {
    // HiveからquestionsBoxのデータを取得
    final questionsBox = Hive.box('questionsBox');
    final questions = questionsBox.get('questions') as List; // 質問のリストを取得

    // 指定された章番号と問題番号に基づいてデータを取得
    final questionData = questions.firstWhere(
      (question) =>
          question['章番号'] == chapterNumber &&
          question['問題番号'] == questionNumber,
      orElse: () => {'構文': '', '和訳': '', '解説': '', 'チェック': 0}, // デフォルト値
    );

    final englishTranslation = questionData['構文'];
    final japaneseTranslation = questionData['和訳'];
    final explanation = questionData['解説'];
    final check = questionData['チェック'] ?? 0; // チェックの値を取得

    // 現在の章番号における最大問題番号を取得
    final maxQuestionNumber = questions
        .where((question) => question['章番号'] == chapterNumber)
        .map((question) => question['問題番号'])
        .reduce((a, b) => a > b ? a : b);

    // HiveからwordsBoxのデータを取得（語彙データ）
    final wordsBox = Hive.box('wordsBox');
    final words = wordsBox.get('words') as List<dynamic>?;

    // 該当する章番号と問題番号の語彙データを語彙番号順に取得
    final wordList = words
        ?.where((word) =>
            word['章番号'] == chapterNumber && word['問題番号'] == questionNumber)
        .toList();

    // 英訳、品詞種別、和訳をそれぞれリストに分けて抽出
    final englishWords = wordList
            ?.map((word) =>
                '${word['英訳'] ?? ''} 【${word['品詞種別'] ?? ''}】: ${word['和訳'] ?? ''}') // '品詞種別:和訳' の形式にする
            .toList() ??
        [];

    // HiveからtitleBoxのデータを取得
    final titleBox = Hive.box('titleBox');
    final chapterTitle = titleBox.get('title')?.firstWhere(
          (title) => title['章番号'] == chapterNumber,
          orElse: () => {'章題': ''}, // デフォルト値
        )['章題'];
    String displayTitle = '$chapterTitle 問題番号: $questionNumber';

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD0), // クリーム色の背景
      appBar: AppBar(
        title: const Text(
          '解答',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF009688), // 明るい緑の背景色
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/top');
          },
        ),
      ),
      body: SingleChildScrollView(
        // スクロール可能に設定
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start, // 左揃えに設定
            children: [
              const SizedBox(height: 10),
              // 章題
              Text(
                displayTitle,
                style: const TextStyle(fontSize: 20),
              ),
              // チェックボックスの追加
              //CustomCheckbox(check: check), // チェックの値を渡す
              CustomCheckbox(
                check: check, // 例として1を渡しています。実際の値に変更してください。
                chapterNumber: chapterNumber, // 実際の章番号の変数を渡します
                questionNumber: questionNumber, // 実際の問題番号の変数を渡します
              ),
              const SizedBox(height: 20),
              // 英訳ラベル
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4B5), // 薄いだいだい色の背景
                  border: Border.all(color: Colors.black), // 黒い外枠線
                ),
                child: const Text(
                  '英訳:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              // 英訳
              Text(
                englishTranslation,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              // 和訳ラベル
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4B5), // 薄いだいだい色の背景
                  border: Border.all(color: Colors.black), // 黒い外枠線
                ),
                child: const Text(
                  '和訳:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              // 和訳
              Text(
                japaneseTranslation,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              // 解説ラベル
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE4B5), // 薄いだいだい色の背景
                  border: Border.all(color: Colors.black), // 黒い外枠線
                ),
                child: const Text(
                  '解説:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              // 解説
              Text(
                explanation,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              // 追加された横並びの表示
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
                ],
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      backgroundColor: const Color(0xFF009688), // 明るい緑
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // 戻るボタン: question.dartに戻る
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '戻る',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      backgroundColor: const Color(0xFF009688), // 明るい緑
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // 次へボタン: 現在の問題番号を+1した値を次の問題番号として渡す
                      if (questionNumber + 1 > maxQuestionNumber) {
                        // 最大問題番号を超えた場合、top.dartに遷移
                        Navigator.pushNamed(context, '/top'); // top.dartへの遷移
                      } else {
                        // 最大問題番号内の場合は通常の遷移
                        final nextQuestionNumber = questionNumber + 1;
                        Navigator.pushNamed(
                          context,
                          '/question',
                          arguments: {
                            'chapterNumber': chapterNumber,
                            'questionNumber': nextQuestionNumber,
                          },
                        );
                      }
                    },
                    child: const Text(
                      '次へ',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
