import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class QuestionScreen extends StatefulWidget {
  final String questionId; // 質問ID
  final String englishSentence; // 英訳
  final Function(String, Map<String, dynamic>) navigation;
  final int chapterNumber; // 章番号
  final int questionNumber; // 問題番号

  const QuestionScreen({
    super.key,
    required this.questionId,
    required this.englishSentence,
    required this.navigation,
    required this.chapterNumber,
    required this.questionNumber,
  });

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late TextEditingController _controller;
  String? chapterTitle; // 章題を格納する変数

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.englishSentence);
    // 章題を取得する
    fetchChapterTitle(widget.chapterNumber);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchChapterTitle(int chapter) async {
    var box = await Hive.openBox('titleBox');
    var titles = box.get('title') as List<dynamic>?;

    if (titles != null) {
      for (var titleData in titles) {
        if (titleData['章番号'] == chapter) {
          setState(() {
            chapterTitle = titleData['章題']; // 章題を取得
          });
          break;
        }
      }
    }
  }

  Future<String?> getEnglishSentence(int chapter, int question) async {
    var box = await Hive.openBox('questionsBox');
    var questions = box.get('questions') as List<dynamic>?;

    if (questions != null) {
      for (var questionData in questions) {
        if (questionData['章番号'] == chapter &&
            questionData['問題番号'] == question) {
          return questionData['英訳']; // 英訳を返す
        }
      }
    }
    return null; // データが見つからなかった場合
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    bool isFromAnswer = false;
    if (args is Map<String, dynamic>) {
      isFromAnswer = args.containsKey('questionNumber'); // answer.dartからの遷移かどうか
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009688),
        title: const Text(
          '問題',
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
      body: FutureBuilder<String?>(
        // FutureBuilderで英訳を取得
        future: isFromAnswer
            ? getEnglishSentence(
                widget.chapterNumber, widget.questionNumber) // answer.dartからの遷移
            : Future.value(widget.englishSentence), // それ以外
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            String displayedEnglishSentence =
                snapshot.data ?? widget.englishSentence;
            _controller.text = displayedEnglishSentence;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  if (chapterTitle != null) // 章題が取得できた場合に表示
                    Text(
                      '章題: $chapterTitle',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF424242), // グレー
                      ),
                    ),
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

                  TextField(
                    controller: _controller,
                    readOnly: true,
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 12.0), // 上下と左右の余白を調整
                    ),
                    minLines: 1, // 最低3行表示
                    maxLines: 3, // 最大5行表示
                    scrollPhysics: ClampingScrollPhysics(), // スクロール可能にする
                  ),
                  const SizedBox(height: 30),
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
                          widget.navigation('/answer', {
                            'chapterNumber': widget.chapterNumber,
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
                          '解答',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // フッタースペース
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
