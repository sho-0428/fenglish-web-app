import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class RandomquesScreen extends StatefulWidget {
  final List<Map<String, dynamic>> filteredQuestions;
  final i;
  final Function(String, Map<String, dynamic>) navigation;
  const RandomquesScreen({
    super.key,
    required this.filteredQuestions,
    required this.i,
    required this.navigation,
  });

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<RandomquesScreen> {
  int i = 0; // クラスの状態として i を定義
  int cnt = 0;

  late TextEditingController _controller;
  String? chapterTitle; // 章題を格納する変数

  @override
  void initState() {
    super.initState();
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

  Future<String?> getEnglishSentence() async {
    return widget.filteredQuestions[i]['英訳']; // 英訳を返す
  }

  @override
  Widget build(BuildContext context) {
    if (widget.i == '') {
      i = 0;
    } else {
      i = widget.i;
    }
    cnt = i + 1;

    final maxNumber = widget.filteredQuestions.length;

    // filteredQuestions から英訳の値を取得して TextEditingController に設定
    String initialText = widget.filteredQuestions.isNotEmpty
        ? widget.filteredQuestions[i]['英訳'] ?? ''
        : ''; // 配列が空の場合は空文字列
    _controller = TextEditingController(text: initialText);
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
        future: getEnglishSentence(), // 適切なFutureを渡す
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    '問題数: $cnt / $maxNumber',
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
                    ),
                    minLines: 1, // 最低3行表示
                    maxLines: 3, // 最大5行表示
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
                          widget.navigation('/Randomans', {
                            'filteredQuestions': widget.filteredQuestions,
                            'i': i
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
