import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  final Function(String, Map<String, dynamic>) navigation;
  const StartScreen({
    super.key,
    required this.navigation,
  });

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009688),
        title: const Text(
          'はじめに',
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
            const SizedBox(height: 16.0),
            const Text(
              '当アプリでは英文解釈の練習ができます。\n'
              '英文解釈は長文を正確にスムーズに読めるようになる為に必要で、文法と長文の橋渡しをするとても重要な学習です。\n'
              '文ポン単元ごとに例文を用意しています。下記の要領で学習を進めてください。\n\n'
              '１．各語句の４つの品詞を意識する（名詞、動詞、形容詞、副詞）\n'
              '２．主語、動詞、目的語、補語、修飾関係を捉えて文型を判別\n'
              '３．上記の構文解析の結果、文の意味をつかむ\n\n'
              '語彙は英検２級レベルの語彙を使用し、重要語リストも掲載。和訳練習の成果を様々なトピックの長文で確認することもできます。\n'
              '当アプリで英検2級、一般的な大学受験レベルの長文がスラスラ読めるようになるはずです。',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16.0),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                      text: '解説の記載について\n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: '[]：名詞ブロック（句、節）\n'),
                  TextSpan(text: '()：形容詞ブロック（句、節）\n'),
                  TextSpan(text: '<>：副詞ブロック（句、節）\n\n'),
                  TextSpan(
                    text: '【品詞の役割】\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '名詞：主語(S)、目的語(O)、補語(C)になれる\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '(S)The boy /(V) play /(O) the piano.\n'
                        '→名詞the boyは主語、名詞the pianoは目的語\n\n'
                        '(S)He /(V) is /(C) a student.\n'
                        '→名詞a studentは補語\n\n',
                  ),
                  TextSpan(
                    text: '形容詞：名詞を修飾、補語(C)になれる\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '(S)She /(V) is /(C) beautiful.\n'
                        '→形容詞beautifulは補語\n\n'
                        'The beautiful women is his sister.\n'
                        '→形容詞beautifulは名詞womenを修飾、美しい女性\n'
                        '※修飾とはどんな内容か説明すること\n\n',
                  ),
                  TextSpan(
                    text: '副詞：名詞以外を修飾、SVOCどれにもなれない\n',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'He is very kind.\n'
                        '→副詞veryは形容詞kindを修飾、とても親切だ\n\n'
                        'He can run fast.\n'
                        '→副詞fastは動詞runを修飾、速く走る',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
