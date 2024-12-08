import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Top extends StatelessWidget {
  final Function(String, Map<String, dynamic>) navigation;

  const Top({super.key, required this.navigation});

  Future<Map<String, dynamic>?> getQuestion(int chapter, int question) async {
    var box = await Hive.openBox('questionsBox');
    var questions = box.get('questions');

    if (questions is List) {
      for (var questionData in questions) {
        if (questionData is Map) {
          try {
            // Map<String, dynamic> 型に変換
            final typedData = Map<String, dynamic>.from(questionData);
            if (typedData['章番号'] == chapter && typedData['問題番号'] == question) {
              return typedData; // データを返す
            }
          } catch (e) {
            print('データ変換中にエラーが発生しました: $e');
          }
        }
      }
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getRandomData() async {
    var box2 = await Hive.openBox('questionsBox');
    var questions = box2.get('questions') as List<dynamic>?;

    if (questions != null) {
      // チェックが1のデータをフィルタリングし、型を変換
      var filteredQuestions = questions
          .where((questionData) =>
              questionData is Map &&
              Map<String, dynamic>.from(questionData)['チェック'] == 1)
          .map((questionData) => Map<String, dynamic>.from(questionData))
          .toList();

      // ランダムな順序にシャッフル
      filteredQuestions.shuffle();

      // データを配列で返す
      return filteredQuestions;
    }

    // データが見つからなかった場合、空のリストを返す
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDD0), // クリーム色の背景
      appBar: AppBar(
        title: const Text(
          'トップページ',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF009688), // 明るい緑の背景色
      ),
      body: Container(
        constraints: BoxConstraints.expand(), // コンテナーのサイズを画面いっぱいにする
        child: Scrollbar(
          // Scrollbarを追加
          child: SingleChildScrollView(
            child: Center(
              // Centerを追加して中央に配置
              child: Padding(
                padding: const EdgeInsets.all(20.0), // パディングを追加
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 左端に寄せる
                  children: [
                    const SizedBox(height: 20),

                    // はじめにボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        navigation('/start', {});
                      },
                      child: const Text(
                        'はじめに',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // チェックをランダムボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        // フィルタリングされたデータを取得
                        List<Map<String, dynamic>> filteredQuestions =
                            await getRandomData();

                        // データを渡して遷移
                        navigation('/Randomques',
                            {'filteredQuestions': filteredQuestions, 'i': 0});
                      },
                      child: const Text(
                        'チェックをランダム',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 第一文型ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor: const Color(0xFFBBDEFB), // ボタンの背景色
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(1, 1); // 章番号1、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 1,
                            'questionId': '${questionData['問題番号']}', // 問題番号
                            'englishSentence': questionData['英訳'], // 英訳
                          });
                        }
                      },
                      child: const Text(
                        '第一文型',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // フォントスタイル
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 第二文型ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(2, 1); // 章番号3、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 2,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '第二文型',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 第三文型ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(3, 1); // 章番号3、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 3,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '第三文型',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 第四文型ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(4, 1); // 章番号4、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 4,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '第四文型',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 第五文型ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(5, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 5,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '第五文型',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 不定詞名詞的用法ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(6, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 6,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '不定詞名詞的用法',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 不定詞形容詞的用法ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(7, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 7,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '不定詞形容詞的用法',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 不定詞副詞的用法ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(8, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 8,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '不定詞副詞的用法',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 不定詞形式主語構文ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(9, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 9,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '不定詞形式主語構文',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 動名詞ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(10, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 10,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '動名詞',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 現在分詞ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(11, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 11,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '現在分詞',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 過去分詞ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(12, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 12,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '過去分詞',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 分詞構文ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(13, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 13,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '分詞構文',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 付帯状況withボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(14, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 14,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '付帯状況with',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 接続詞thatボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(15, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 15,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '接続詞that',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 従属接続詞ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(16, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 16,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '従属接続詞',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 形式主語thatボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(17, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 17,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '形式主語that',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 形式目的語ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(18, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 18,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '形式目的語',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 関係代名詞who(m)ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(19, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 19,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '関係代名詞who(m)',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 関係代名詞whichボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(20, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 20,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '関係代名詞which',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 関係代名詞thatボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(21, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 21,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '関係代名詞that',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 前置詞+関係代名詞ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(22, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 22,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '前置詞+関係代名詞',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 関係代名詞whoseボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(23, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 23,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '関係代名詞whose',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 関係代名詞非制限用法ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(24, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 24,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '関係詞非制限用法',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 関係代名詞whatボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(25, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 25,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '関係代名詞what',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 関係副詞ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(26, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 26,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '関係副詞',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 複合関係詞ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(27, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 27,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '複合関係詞',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 同格のthatボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(28, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 28,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '同格のthat',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 強調構文ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(29, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 29,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '強調構文',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 倒置ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        var questionData =
                            await getQuestion(30, 1); // 章番号5、問題番号1を取得
                        if (questionData != null) {
                          navigation('/question', {
                            'chapterNumber': 30,
                            'questionId': '${questionData['問題番号']}',
                            'englishSentence': questionData['英訳'],
                          });
                        }
                      },
                      child: const Text(
                        '倒置',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE4B5), // 薄いだいだい色の背景
                        border: Border.all(color: Colors.black), // 黒い外枠線
                      ),
                      child: const Text(
                        '長文',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 環境問題ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        navigation('/LSquestion', {
                          'questionNumber': 1,
                        });
                      },
                      child: const Text(
                        '環境問題',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // 日米比較ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        navigation('/LSquestion', {
                          'questionNumber': 2,
                        });
                      },
                      child: const Text(
                        '日米比較',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // スマートフォンボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        navigation('/LSquestion', {
                          'questionNumber': 3,
                        });
                      },
                      child: const Text(
                        'スマートフォン',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // いじめボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        navigation('/LSquestion', {
                          'questionNumber': 4,
                        });
                      },
                      child: const Text(
                        'いじめ',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                    const SizedBox(height: 20),
                    // グローバル化ボタン
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 40), // 最小サイズを指定
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20), // パディング調整
                        backgroundColor:
                            const Color(0xFFBBDEFB), // ボタンの背景色を明るい青に変更
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // ボタンの角を丸める
                        ),
                        elevation: 5, // ボタンに影をつける
                      ),
                      onPressed: () async {
                        navigation('/LSquestion', {
                          'questionNumber': 5,
                        });
                      },
                      child: const Text(
                        'グローバル化',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // フォントスタイル
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
