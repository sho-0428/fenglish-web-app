import 'package:flutter/material.dart';
import 'package:hive/hive.dart'; // Hiveをインポート
import 'package:hive_flutter/hive_flutter.dart';
import 'top.dart';
import 'question.dart'; // QuestionScreenのファイルをインポート
import 'answer.dart'; // AnswerScreenのファイルをインポート
import 'LSquestion.dart';
import 'LSanswer.dart';
import 'start.dart';
import 'Randomques.dart';
import 'Randomans.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // boxの宣言
  late Box box;
  //
  try {
    // 'questionsBox'という名前のボックスを開く
    box = await Hive.openBox('questionsBox');
    //await box.clear();
    // デバッグコード: ボックスの中身を確認
  } catch (e) {
    print('Error in opening Hive box: $e');
  }

  try {
    // デフォルトデータを追加するかどうか
    if (box.isEmpty) {
      // nullの場合はtrueとして処理
      await box.put('questions', [
        {
          '章番号': 1,
          '問題番号': 1,
          '英訳': 'the number of traffic accidents decreased dramatically.',
          '構文':
              '(S) the number of traffic accidents / (V) decreased < dramatically >.',
          '和訳': '交通事故の数は劇的に減少した。',
          '解説': 'the number of traffic accidentsの名詞句が主語(S)\n'
              'decreasedが自動詞(V)\n'
              'dramaticallyは副詞で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 1,
          '問題番号': 2,
          '英訳': 'The phone rang constantly during the meeting.',
          '構文':
              '(S) The phone / (V) rang  < constantly > < during the meeting >.',
          '和訳': '会議の間、電話が絶えず鳴った。',
          '解説': 'The phoneが主語(S)\n'
              'rangが自動詞(V)\n'
              'constantlyと during the meeting は副詞句で文の要素にならない。',
          'チェック': 1,
          '最終学習日': null
        },
        {
          '章番号': 1,
          '問題番号': 3,
          '英訳': 'Employees gathered quickly in the grocery.',
          '構文': '(S) Employees / (V) gathered < quickly > < in the grocery > .',
          '和訳': '従業員は直ちに食料品店に集まった。',
          '解説': 'Employeesが主語(S)\n'
              'gatheredが自動詞(V)\n'
              'quicklyと in the grocery は副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 2,
          '問題番号': 1,
          '英訳': 'She felt exhausted after the boring conference.',
          '構文':
              '(S) She / (V) felt / (C) exhasted  < after the boring conference >.',
          '和訳': '彼女は退屈な会議の後、疲労を感じた。',
          '解説': 'Sheが主語(S)\n'
              'feltが自動詞(V)\n'
              'exhaustedが補語(C)\n'
              'after the boring conferenceは副詞句で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 2,
          '問題番号': 2,
          '英訳': 'She remained skeptical about the plan.',
          '構文': '(S) She / (V) remained / (C) skeptical < about the plan >.',
          '和訳': '彼女はその計画に懐疑的なままだった。',
          '解説': 'Sheが主語(S)\n'
              'remainedが自動詞(V)\n'
              'skepticalが補語(C)\n'
              'about the planは副詞句で文の要素にならない',
          'チェック': 1,
          '最終学習日': null
        },
        {
          '章番号': 2,
          '問題番号': 3,
          '英訳': 'The situation seemed complicated at first.',
          '構文':
              '(S) The situation / (V)  seemed / (C) complicated < at first >.',
          '和訳': 'その状況は最初は複雑に思えた。',
          '解説': 'The situationが主語(S)\n'
              'seemedが自動詞(V)\n'
              'complicatedが補語(C)\n'
              'at firstは副詞句で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 3,
          '問題番号': 1,
          '英訳': 'He discovered a solution to the complex problem.',
          '構文':
              '(S) He / (V) discovered / (O) a solution < to the complex problem >.',
          '和訳': '彼はその複雑な問題に対する解決策を発見した。',
          '解説': 'Heが主語(S)\n'
              'discoveredが他動詞(V)\n'
              'a solutionが目的語(O)\n'
              'to the complex problemは副詞句で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 3,
          '問題番号': 2,
          '英訳': 'He acknowledged the contribution of his peers.',
          '構文':
              '(S) He / (V) acknowledged / (O) the contribution of his peers.',
          '和訳': '彼は仲間の貢献を認めた。',
          '解説': 'Heが主語(S)\n'
              'acknowledgedが他動詞(V)\n'
              'the contribution of his peersが目的語(O)\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 3,
          '問題番号': 3,
          '英訳': 'She investigated the cause of the delay.',
          '構文': '(S) She / (V) investigated / (O) the cause of the delay.',
          '和訳': '彼女は遅延の原因を調査した。',
          '解説': 'Sheが主語(S)\n'
              'discoveredが他動詞(V)\n'
              'the cause of the delayが目的語(O)\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 4,
          '問題番号': 1,
          '英訳': 'She explained the students a sophisticated concept.',
          '構文':
              '(S) She / (V) explained / (O) the students / (O) a sophisticated concept.',
          '和訳': '彼女は生徒たちに洗練された概念を説明した。',
          '解説': 'Sheが主語(S)\n'
              'explainedが他動詞(V)\n'
              'the studentsが目的語(O1)\n'
              'ta sophisticated conceptが目的語(O2)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 4,
          '問題番号': 2,
          '英訳': 'I sent my colleague a detailed report.',
          '構文': '(S) I / (V) sent / (O) my colleague / (O) a detailed report.',
          '和訳': '私は同僚に詳細な報告書を送った。',
          '解説': 'Iが主語(S)\n'
              'sentが他動詞(V)\n'
              'my colleagueが目的語(O1)\n'
              'a detailed reportが目的語(O2)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 4,
          '問題番号': 3,
          '英訳':
              'She bought her parents a luxurious gift for their anniversary.',
          '構文':
              '(S) She / (V) bought / (O) her parents / (O) a luxurious gift < for their anniversary >.',
          '和訳': '彼女は両親の記念日のために豪華な贈り物を買った。',
          '解説': ' Sheが主語(S)\n'
              'boughtが他動詞(V)\n'
              'her parentsが目的語(O1)\n'
              'a luxurious giftが目的語(O2)'
              'for their anniversaryは副詞句で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 5,
          '問題番号': 1,
          '英訳': 'The manager viewed the new strategy beneficial for growth.',
          '構文':
              '(S) The manager / (V) viewed / (O) the new strategy / (C) beneficial < for growth >.',
          '和訳': 'そのマネージャーは新しい戦略が成長に有益であると見なした。',
          '解説': 'The managerが主語(S)\n'
              'viewedが他動詞(V)\n'
              'the new strategyが目的語(O)\n'
              'beneficialが補語(C)\n'
              'for growthは副詞句で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 5,
          '問題番号': 2,
          '英訳':
              'The author described his novel a reflection of contemporary literature.',
          '構文':
              '(S) The author / (V) described / (O) his novel / (C) a reflection of contemporary literature.',
          '和訳': 'その著者は自分の小説を現代文学の反映だと説明した。',
          '解説': 'The authorが主語(S)\n'
              'describedが他動詞(V)\n'
              'the new strategyが目的語(O)\n'
              'a reflection of contemporary literatureが補語(C)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 5,
          '問題番号': 3,
          '英訳':
              'They found the explanation exceedingly clear and comprehensive.',
          '構文':
              '(S) They / (V)  found / (O)  the explanation  / < exceedingly > (C) clear and comprehensive.',
          '和訳': '彼らはその説明が非常に明確で包括的だと感じた。',
          '解説': 'Theyが主語(S)\n'
              'foundが他動詞(V)\n'
              'the explanationが目的語(O)\n'
              'clear and comprehensiveが補語(C)\n'
              'exceedinglyは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 6,
          '問題番号': 1,
          '英訳': 'They endeavored to achieve their ambitious goals.',
          '構文':
              'They  / (V) endeavored / (O) to achieve their ambitious goals.',
          '和訳': '彼らは野心的な目標を達成しようと努力した。',
          '解説': 'Theyが主語(S)\n'
              'endeavoredが他動詞(V)\n'
              'to achieve their ambitious goalsが不定詞名詞的用法で目的語(O)\n'
              'clear and comprehensiveが補語(C)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 6,
          '問題番号': 2,
          '英訳': 'They hesitated to disclose the confidential information.',
          '構文':
              '(S) They  / (V) hesitated / (O) to disclose the confidential information.',
          '和訳': '彼らは機密情報を開示するのをためらった。',
          '解説': 'Theyが主語(S)\n'
              'hesitatedが他動詞(V)\n'
              'to disclose the confidential informationが不定詞名詞的用法で目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 6,
          '問題番号': 3,
          '英訳': 'She vowed to overcome any obstacles in her path.',
          '構文':
              '(S) She  / (V) vowed / (O) to overcome any obstacles in her path.',
          '和訳': '彼女は自分の道にあるどんな障害も克服することを誓った。',
          '解説': 'Sheが主語(S)\n'
              'vowedが他動詞(V)\n'
              'to overcome any obstacles in her pathが不定詞名詞的用法で目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 7,
          '問題番号': 1,
          '英訳':
              'The company launched a campaign to promote environmental awareness.',
          '構文':
              '(S) The company / (V)  launched / (O) a campaign ( to promote environmental awareness ).',
          '和訳': 'その会社は環境意識を高めるためのキャンペーンを開始しました。',
          '解説': 'The companyが主語(S)\n'
              'launchedが他動詞(V)\n'
              'a campaignが目的語(O)\n'
              'to promote environmental awarenessが不定詞形容詞的用法で a campaignを修飾',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 7,
          '問題番号': 2,
          '英訳': 'This is a great opportunity to gain valuable experience.',
          '構文':
              '(S) This / (V) is / (C) a great opportunity ( to gain valuable experience ).',
          '和訳': 'これは貴重な経験を得るための素晴らしい機会です。',
          '解説': 'Thisが主語(S)\n'
              'isが自動詞(V)\n'
              'a great opportunityが補語(C)\n'
              'to gain valuable experienceが不定詞形容詞的用法で a great opportunityを修飾',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 7,
          '問題番号': 3,
          '英訳': 'She showed me a technique to enhance my writing skills.',
          '構文':
              '(S) She / (V) showed / (O) me / (O) a technique ( to enhance my writing skills ).',
          '和訳': '彼女は私に文章力を向上させるための技術を教えてくれました。',
          '解説': 'Sheが主語(S)\n'
              'showedが他動詞(V)\n'
              'meが目的語(O1)\n'
              'a techniqueが目的語(O2)\n'
              'to enhance my writing skillsが不定詞形容詞的用法で a techniqueを修飾',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 8,
          '問題番号': 1,
          '英訳':
              'The speaker emphasized the importance of education to motivate the audience.',
          '構文':
              '(S) The speaker / (V) emphasized / (O) the importance of education  < to motivate the audience >.',
          '和訳': '話者は聴衆をやる気にさせるために教育の重要性を強調した。',
          '解説': 'The speakerが主語(S)\n'
              'emphasizedが他動詞(V)\n'
              'the importance of educationが目的語(O)\n'
              'to motivate the audienceが不定詞副詞的用法で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 8,
          '問題番号': 2,
          '英訳':
              'He attended seminars to broaden his knowledge of international relations.',
          '構文':
              '(S) He / (V)  attended / (O) seminars < to broaden his knowledge of international relations >.',
          '和訳': '彼は国際関係の知識を広げるためにセミナーに参加した。',
          '解説': 'Heが主語(S)\n'
              'attendedが他動詞(V)\n'
              'seminarsが目的語(O)\n'
              'to broaden his knowledge of international relationsが不定詞副詞的用法で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 8,
          '問題番号': 3,
          '英訳':
              'She wrote a letter to express her gratitude for their support.',
          '構文':
              '(S) She / (V)  wrote / (O) a letter < to express her gratitude for their support >.',
          '和訳': '彼女は彼らの支援に感謝を表すために手紙を書いた。',
          '解説': 'Sheが主語(S)\n'
              'wroteが他動詞(V)\n'
              'a letterが目的語(O)\n'
              'to express her gratitude for their supportが不定詞副詞的用法で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 9,
          '問題番号': 1,
          '英訳':
              'It is essential to maintain a balanced diet for overall health.',
          '構文':
              '(S) It / (V)  is / (C) essential [ to maintain a balanced diet < for overall health > ].',
          '和訳': '健康全般のためにはバランスの取れた食事を維持することが不可欠です。',
          '解説': 'Itが形式主語(S)\n'
              'isが自動詞(V)\n'
              'essentialが補語(C)\n'
              'to maintain a balanced diet  for overall healthが真主語',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 9,
          '問題番号': 2,
          '英訳':
              'It is necessary for students to study consistently to achieve academic success.',
          '構文':
              '(S) It / (V)  is / (C) necessary [ for students to study < consistently to achieve academic success > ].',
          '和訳': '学業の成功を収めるためには、学生が一貫して勉強することが必要です。',
          '解説': 'Itが形式主語(S)\n'
              'isが自動詞(V)\n'
              'necessaryが補語(C)\n'
              'for students to study consistently to achieve academic successが真主語',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 9,
          '問題番号': 3,
          '英訳':
              'It is vital for young people to engage in community service to develop empathy.',
          '構文':
              '(S) It / (V)  is / (C)  vital [ for young people to engage in community service < to develop empathy > ].',
          '和訳': '若者が共感を育むために地域社会に参加することは重要です。',
          '解説': 'Itが形式主語(S)\n'
              'isが自動詞(V)\n'
              'vitalが補語(C)\n'
              'for young people to engage in community service  to develop empathyが真主語',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 10,
          '問題番号': 1,
          '英訳':
              'Embracing change can lead to new opportunities and experiences.',
          '構文':
              '(S) Embracing change / (V)  can lead to  / (O) new opportunities and experiences.',
          '和訳': '変化を受け入れることは、新しい機会や経験につながる。',
          '解説': 'Embracing changeが主語(S)\n'
              'can lead toが他動詞(V)\n'
              'new opportunities and experiencesが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 10,
          '問題番号': 2,
          '英訳': 'Acknowledging your limitations can lead to personal growth.',
          '構文':
              '(S) Acknowledging your limitations / (V)  can lead to  / (O) personal growth.',
          '和訳': '自分の限界を認識することは、個人の成長につながる。',
          '解説': 'Acknowledging your limitationsが主語(S)\n'
              'can lead toが他動詞(V)\n'
              'personal growthが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 10,
          '問題番号': 3,
          '英訳':
              'Analyzing historical events provides valuable insights into current affairs.',
          '構文':
              '(S) Analyzing historical events / (V)  provides  / (O)valuable insights < into current affairs >.',
          '和訳': '歴史的な出来事を分析することは、現在の事態について貴重な洞察を提供する。',
          '解説': 'Analyzing historical eventsが主語(S)\n'
              'valuable insightsが目的語(O)\n'
              'into current affairsは副詞句で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 11,
          '問題番号': 1,
          '英訳':
              'The organization promoting cultural exchange hosted an international event.',
          '構文':
              '(S) The organization ( promoting cultural exchange ) / (V)  hosted / (O) an international event.',
          '和訳': '文化交流を促進している団体が国際イベントを開催しました。',
          '解説': 'The organizationが主語(S)\n'
              'promoting cultural exchangeが分詞句でThe organizationを修飾\n'
              'hostedが他動詞(V)\n'
              'an international eventが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 11,
          '問題番号': 2,
          '英訳':
              'The program providing financial aid for low-income families has been expanded.',
          '構文':
              '(S) The program ( providing financial aid for low-income families )/ (V)   has been expanded.',
          '和訳': '低所得家庭に経済支援を提供しているプログラムが拡充されました。',
          '解説': 'The programが主語(S)\n'
              'providing financial aid for low-income familiesが分詞句でThe programを修飾\n'
              'has been expandedが受動態動詞(V)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 11,
          '問題番号': 3,
          '英訳':
              'The students participating in the debate showed remarkable insight.',
          '構文':
              '(S) The students ( participating in the debate ) / (V)   showed / (O) remarkable insight.',
          '和訳': 'ディベートに参加している学生たちは優れた洞察力を見せました。',
          '解説': 'The studentsが主語(S)\n'
              'participating in the debateが分詞句でThe studentsを修飾\n'
              'showedが他動詞(V)\n'
              'remarkable insightが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 12,
          '問題番号': 1,
          '英訳':
              'The products manufactured in this factory are exported worldwide.',
          '構文':
              '(S) The products ( manufactured in this factory ) / (V)   are exported / < worldwide >.',
          '和訳': 'この工場で製造された製品は世界中に輸出されています。',
          '解説': 'The productsが主語(S)\n'
              'manufactured in this factoryが分詞句でThe productsを修飾\n'
              'are exportedが受動態動詞(V)\n'
              'worldwide副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 12,
          '問題番号': 2,
          '英訳': 'The equipment installed in the new office is very advanced.',
          '構文':
              '(S) The equipment ( installed in the new office ) / (V)  is < very > advanced.',
          '和訳': '新しいオフィスに設置された機器はとても先進的です。',
          '解説': 'The equipmentが主語(S)\n'
              'installed in the new officeが分詞句でThe equipmentを修飾\n'
              'isが自動詞(V)\n'
              'advancedが補語(C)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 12,
          '問題番号': 3,
          '英訳': 'The rules established for this competition are very strict.',
          '構文':
              '(S) The rules ( established for this competition ) / (V)  are < very >  / (C) strict.',
          '和訳': 'この大会のために設けられたルールはとても厳しいです。',
          '解説': 'The rulesが主語(S)\n'
              'established for this competitionが分詞句でThe rulesを修飾\n'
              'areが自動詞(V)\n'
              'strictが補語(C)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 13,
          '問題番号': 1,
          '英訳':
              'Feeling overwhelmed by the workload, he asked his supervisor for support.',
          '構文':
              '< Feeling overwhelmed by the workload, > / (S) he / (V) asked / (O) his supervisor < for support >.',
          '和訳': '仕事量に圧倒され、彼は上司に支援を求めました。',
          '解説': 'Feeling overwhelmed by the workloadが分詞構文で副詞句\n'
              'heが主語(S)\n'
              'askedが他動詞(V)\n'
              ' his supervisorが目的語(O)\n'
              'for supportは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 13,
          '問題番号': 2,
          '英訳':
              'Noticing a sudden decline in sales, the company implemented new strategies.',
          '構文':
              '< Noticing a sudden decline in sales , >  / (S)  the company / (V) implemented / (O) new strategies.',
          '和訳': '売上の急激な減少に気づき、会社は新しい戦略を導入しました。',
          '解説': 'Noticing a sudden decline in salesが分詞構文で副詞句\n'
              'the companyが主語(S)\n'
              'implementedが他動詞(V)\n'
              'new strategiesが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 13,
          '問題番号': 3,
          '英訳':
              'Being equipped with advanced technology, the new system improves efficiency.',
          '構文':
              '< Being equipped with advanced technology, >  / (S) the new system  / (V) improves / (O) efficiency.',
          '和訳': '先進技術が備わっているため、新しいシステムは効率を向上させます。',
          '解説': 'Being equipped with advanced technologyが分詞構文で副詞句\n'
              'the new systemが主語(S)\n'
              'improvesが他動詞(V)\n'
              'efficiencyが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 14,
          '問題番号': 1,
          '英訳':
              'The room was silent with everyone waiting for the announcement.',
          '構文':
              '(S) The room  / (V)  was/ (C)  silent <with everyone waiting for the announcement.>',
          '和訳': '部屋は静かで、皆が発表を待っていた。',
          '解説': 'The roomが主語(S)\n'
              'wasが自動詞(V)\n'
              'silentが補語(C)\n'
              'with everyone waiting for the announcementは付帯状況のwithで現在分詞 副詞句で文の要素にならない。\n'
              'With 名詞 + 現在分詞 名詞がdoする',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 14,
          '問題番号': 2,
          '英訳':
              'She walked through the park with the sun shining brightly above.',
          '構文':
              '(S) She  / (V)  walked < through the park > < with the sun shining brightly above.>',
          '和訳': '彼女は、頭上で太陽が明るく輝く中、公園を歩いた。',
          '解説': 'Sheが主語(S)\n'
              'walkedが自動詞(V)\n'
              'through the parkは副詞句で文の要素にならない。\n'
              'with the sun shining brightly aboveは付帯状況のwithで現在分詞 副詞句で文の要素にならない。\n'
              'With 名詞 + 現在分詞 名詞がdoする',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 14,
          '問題番号': 3,
          '英訳':
              'The meeting continued with everyone focused on the presentation.',
          '構文':
              '(S) The meeting  / (V)  continued < with everyone focused on the presentation. >',
          '和訳': '会議は続き、全員がプレゼンテーションに集中していた。',
          '解説': 'The meetingが主語(S)\n'
              'continuedが自動詞(V)\n'
              'with everyone focused on the presentationは付帯状況のwithで過去分詞 副詞句で文の要素にならない。\n'
              'With 名詞 + 過去分詞 名詞がdoした',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 15,
          '問題番号': 1,
          '英訳':
              'The CEO confirmed that the company would expand into international markets.',
          '構文':
              '(S) The CEO  / (V)  confirmed /(O) that [ (S) the company /(V) would expand < into international markets.> ]',
          '和訳': 'CEOは、その会社が国際市場に進出することを確認した。',
          '解説': 'The CEOが主語(S)\n'
              'confirmedが他動詞(V)\n'
              'that節が目的語(O)\n'
              'the companyがthat節内の主語(S)\n'
              'would expandがthat節内の自動詞(V)\n'
              'into international markets.は副詞句で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 15,
          '問題番号': 2,
          '英訳':
              'The manager explained that the budget had been allocated for next year’s initiatives.',
          '構文':
              '(S) The manager / (V)  explained /(O) that  { (S) the budget /(V) had been allocated < for next year’s initiatives.>]',
          '和訳': 'マネージャーは、来年度の施策のために予算が配分されたことを説明した。',
          '解説': 'The managerが主語(S)\n'
              'explainedが他動詞(V)\n'
              'that節が目的語(O)\n'
              'the budgetがthat節内の主語(S)\n'
              'had been allocatedがthat節内の他動詞の受動態(V)\n'
              'for next year’s initiatives.は副詞句で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 15,
          '問題番号': 3,
          '英訳':
              'The director stated that the movie would be released worldwide next summer.',
          '構文':
              '(S) The director/ (V)  stated /(O)  that [ (S) the movie /(V) would be released < worldwide > <next summer.>]',
          '和訳': '監督は、その映画が来年の夏に世界中で公開されることを述べた。',
          '解説': 'The directorが主語(S)\n'
              'statedが他動詞(V)\n'
              'that節が目的語(O)\n'
              'the movieがthat節内の主語(S)\n'
              'would be releasedがthat節内の他動詞の受動態(V)\n'
              'worldwideとnext summerは副詞で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 16,
          '問題番号': 1,
          '英訳':
              'Although the training program was intensive, he gained valuable skills by the end.',
          '構文':
              '< Although (S) the training program /(V) was /(C) intensive,>  (S) he / (V) gained / (O) valuable skills < by the end.>',
          '和訳': 'トレーニングプログラムは厳しかったが、彼は最終的に貴重なスキルを身につけた。',
          '解説': 'Althoughが従属接続詞でintensiveまでが副詞節\n'
              'the training programが副詞節主語(S)\n'
              'wasが副詞節自動詞(V)\n'
              'intensiveが副詞節補語(C)\n'
              'heが主節主語(S)\n'
              'gainedが主節他動詞(V)\n'
              'valuable skillsが主節目的語(O)\n'
              'by the endは副詞で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 16,
          '問題番号': 2,
          '英訳':
              'He worked overtime so that he could finish the project before the deadline.',
          '構文':
              '(S)He / (V) worked <overtime> <so that (S) he / (V) could finish / (O) the project <before the deadline.>>',
          '和訳': '彼は締め切り前にプロジェクトを終えるために残業をした。',
          '解説': 'so thatが従属接続詞でdeadlineまでが副詞節\n'
              'heが副詞節主語(S)\n'
              'could finishが副詞節他動詞(V)\n'
              'the projectが副詞節目的語(O)\n'
              'before the deadlineは副詞で文の要素にならない。\n'
              'heが主節主語(S)\n'
              'workedが主節自動詞(V)\n'
              'overtimeは副詞で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 16,
          '問題番号': 3,
          '英訳':
              'If she receives the scholarship, she will be able to study abroad next year.',
          '構文':
              '<If (S) she (V) receives (O) the scholarship,>  (S) she / (V) will be able to study <abroad next year>.',
          '和訳': '彼女が奨学金を受け取れれば、来年留学できるだろう。',
          '解説': 'Ifが従属接続詞でintensiveまでが副詞節\n'
              'sheが副詞節主語(S)\n'
              'receivesが副詞節他動詞(V)\n'
              'the scholarshipが副詞節目的語(O)\n'
              'sheが主節主語(S)\n'
              'will be able to studyが主節自動詞(V)\n'
              'abroad next yearは副詞で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 17,
          '問題番号': 1,
          '英訳':
              'It is unfortunate that the event had to be postphoned due to the weather.',
          '構文':
              '(S)It / (V) is /(C) unfortunate [that (S) the event / (V) had to be postphoned <due to the weather.>]',
          '和訳': '天候のためにイベントが延期にならざるを得なかったのは残念だ。',
          '解説': 'Itが仮主語(S)\n'
              'isが自動詞(V)\n'
              'unfortunateが補語(C)\n'
              'that～weatherが新主語\n'
              'the eventがthat節主語(S)\n'
              'had to be postphonedがthat節受動態の動詞(V)\n'
              'due to the weatherは副詞で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 17,
          '問題番号': 2,
          '英訳':
              'It is essential that we address climate change as soon as possible.',
          '構文':
              '(S)It / (V) is /(C) essential [that (S) we / (V) address / (O) climate change <as soon as possible.>',
          '和訳': 'できるだけ早く気候変動に対処することが不可欠だ。',
          '解説': 'Itが仮主語(S)\n'
              'isが自動詞(V)\n'
              'essentialが補語(C)\n'
              'that～possibleが真主語\n'
              'weがthat節主語(S)\n'
              'addressがthat節他動詞(V)\n'
              'climate changeがthat節目的語(O)\n'
              'as soon as possibleは副詞で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 17,
          '問題番号': 3,
          '英訳':
              'It is obvious that his decision had a positive impact on the company.',
          '構文':
              '(S)It / (V) is /(C) obvious [that (S) his decision / (V) had / (O) a positive impact <on the company.>',
          '和訳': '彼の決定が会社に良い影響を与えたのは明らかだ。',
          '解説': 'Itが仮主語(S)\n'
              'isが自動詞(V)\n'
              'obviousが補語(C)\n'
              'that～companyが真主語\n'
              'his decisionがthat節主語(S)\n'
              'hadがthat節他動詞(V)\n'
              'a positive impactがthat節目的語(O)\n'
              'on the companyは副詞で文の要素にならない。',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 18,
          '問題番号': 1,
          '英訳':
              'He thought it strange to see the street so empty at that hour.',
          '構文':
              '(S)He / (V) thought / (O) it / (C) strange [to see the street so empty <at that hour.>]',
          '和訳': '彼はその時間に通りがこんなに空いているのを奇妙だと思った。',
          '解説': 'Heが主語(S)\n'
              'thoughtが他動詞(V)\n'
              'itが形式目的語(O)\n'
              'strangeが補語(C)\n'
              'to see the street so empty at that hourが真目的語(C)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 18,
          '問題番号': 2,
          '英訳': 'They thought it wise to delay the project until next year.',
          '構文':
              '(S)They / (V) thought / (O) it / (C) wise [to delay the project <until next year.>]',
          '和訳': '彼らはプロジェクトを来年まで延期するのが賢明だと考えた。',
          '解説': 'Theyが主語(S)\n'
              'thoughtが他動詞(V)\n'
              'itが形式目的語(O)\n'
              'wiseが補語(C)\n'
              'to delay the project until next yearが真目的語(C)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 18,
          '問題番号': 3,
          '英訳':
              'She made it clear to her colleagues to avoid discussing personal matters at work.',
          '構文':
              '(S)She / (V) made / (O) it / (C) clear [to her colleagues to avoid discussing personal matters <at work.>]',
          '和訳': '彼女は職場で個人的な話を避けるよう同僚に明確に伝えた。',
          '解説': 'Sheが主語(S)\n'
              'madeが他動詞(V)\n'
              'itが形式目的語(O)\n'
              'clearが補語(C)\n'
              'to her colleagues to avoid discussing personal matters at workが真目的語(C)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 19,
          '問題番号': 1,
          '英訳':
              'The scientist who discovered the new species was awarded a prestigious prize.',
          '構文':
              '(S)The scientist (who / (V) discovered / (O) the new species) / (V) was awarded / (O) a prestigious prize.',
          '和訳': '新しい種を発見した科学者は権威ある賞を受賞した。',
          '解説': 'The scientistが主語(S)\n'
              'whoが関係代名詞でThe scientistを修飾\n'
              '関係代名詞はwho～speciesまで Sが抜けた不完全文\n'
              'discoveredが関係詞節他動詞(V)\n'
              'the new speciesが関係詞節目的語(O)\n'
              'was awardedが受動態他動詞(V)\n'
              'a prestigious prizeが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 19,
          '問題番号': 2,
          '英訳':
              'The chef who created this innovative dish has received numerous culinary awards.',
          '構文':
              '(S)The chef (who / (V) created / (O) this innovative dish ) / (V) has received / (O) numerous culinary awards.',
          '和訳': 'この革新的な料理を作ったシェフは、多くの料理賞を受賞した。',
          '解説': 'The chefが主語(S)\n'
              'whoが関係代名詞でThe chefを修飾\n'
              '関係代名詞はwho～dishまで Sが抜けた不完全文\n'
              'createdが関係詞節他動詞(V)\n'
              'this innovative dishが関係詞節目的語(O)\n'
              'has receivedが他動詞(V)\n'
              'numerous culinary awardsが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 19,
          '問題番号': 3,
          '英訳': 'The man whom I hired last week is an experienced engineer.',
          '構文':
              '(S)The man (whom (S) I  /(V) hired  <last week>) / (V) is / (C) an experienced engineer.',
          '和訳': '私が先週雇った男は経験豊富なエンジニアです。',
          '解説': 'The manが主語(S)\n'
              'whoが関係代名詞でThe chefを修飾\n'
              '関係代名詞はwhom～weekまで Oが抜けた不完全文\n'
              'Iが関係詞節主語(S)\n'
              'hiredが関係詞節他動詞(V)\n'
              'isが自動詞(V)\n'
              'an experienced engineerが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 20,
          '問題番号': 1,
          '英訳': 'The idea which was suggested by the team was very innovative.',
          '構文':
              '(S)The idea (which / (V) was suggested <by the team>) / (V) was / (C) <very> innovative.',
          '和訳': 'チームによって提案されたアイデアはとても革新的でした。',
          '解説': 'The ideaが主語(S)\n'
              'whichが関係代名詞でThe ideaを修飾\n'
              '関係代名詞はwhich～teamまで Sが抜けた不完全文\n'
              'was suggestedが関係詞節受動態他動詞(V)\n'
              'wasが自動詞(V)\n'
              'innovativeが補語(C)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 20,
          '問題番号': 2,
          '英訳': 'The article which he wrote received a lot of praise.',
          '構文':
              '(S)The article (which (S) he / (V) wrote) / (V) received / (O) a lot of praise.',
          '和訳': '彼が書いた記事は多くの賞賛を受けました。',
          '解説': 'The articleが主語(S)\n'
              'whichが関係代名詞でThe articleを修飾\n'
              '関係代名詞はwhom～weekまで Oが抜けた不完全文\n'
              'heが関係詞節主語(S)\n'
              'wroteが関係詞節他動詞(V)\n'
              'receivedが他動詞(V)\n'
              'a lot of praiseが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 20,
          '問題番号': 3,
          '英訳': 'The solution which you suggested worked perfectly.',
          '構文':
              '(S)The solution (which (S) you  / (V) suggested)  / (V) worked <perfectly.>',
          '和訳': 'あなたが提案した解決策は完璧に機能しました。',
          '解説': 'The solutionが主語(S)\n'
              'whichが関係代名詞でThe solutionを修飾\n'
              '関係代名詞はwhich～suggestedまで Oが抜けた不完全文\n'
              'youが関係詞節主語(S)\n'
              'が関係詞節他動詞(V)\n'
              'workedが自動詞(V)\n'
              'perfectlyは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 21,
          '問題番号': 1,
          '英訳':
              'The research that was conducted last year revealed critical data about public health.',
          '構文':
              '(S)The research (that / (V) was conducted< last year >) / (V) revealed / (O) critical data <about public health.>',
          '和訳': '昨年行われた研究は、公衆衛生に関する重要なデータを明らかにしました。',
          '解説': 'The researchが主語(S)\n'
              'thatが関係代名詞でThe researchを修飾\n'
              '関係代名詞節はthat～last yearまで Sが抜けた不完全文\n'
              'was conductedが関係詞節他動詞(V)\n'
              'last yearは副詞で文の要素にならない\n'
              'revealedが他動詞(V)\n'
              'critical dataが目的語(O)\n'
              'about public healthは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 21,
          '問題番号': 2,
          '英訳':
              'The workshop that I attended enhanced my understanding of digital marketing.',
          '構文':
              '(S)The workshop (that  (S) I / (V) attended) / (V) enhanced / (O) my understanding <of digital marketing.>',
          '和訳': '彼らが提案した解決策は、関係者の主要な懸念に対応していました。',
          '解説': 'The workshopが主語(S)\n'
              'thatが関係代名詞でThe researchを修飾\n'
              '関係代名詞節はthat～attendedまで Oが抜けた不完全文\n'
              'Iが関係詞節主語(S)\n'
              'attendedが関係詞節他動詞(V)\n'
              'enhancedが他動詞(V)\n'
              'my understandingが目的語(O)\n'
              'of digital marketingは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 21,
          '問題番号': 3,
          '英訳':
              'The report he prepared included comprehensive analysis and valuable recommendations.',
          '構文':
              '(S)The report ((S) he / (V) prepared) / (V) included / (O) comprehensive analysis and valuable recommendations.',
          '和訳': '彼が作成した報告書には、包括的な分析と貴重な提言が含まれていました。',
          '解説': 'The reportが主語(S)\n'
              'The reportの直後に関係代名詞thatが省略されThe reportを修飾\n'
              '関係代名詞は(that)～ preparedまで Oが抜けた不完全文\n'
              'heが関係詞節主語(S)\n'
              'preparedが関係詞節他動詞(V)\n'
              'includedが他動詞(V)\n'
              'comprehensive analysis and valuable recommendationsが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 22,
          '問題番号': 1,
          '英訳':
              'The topic about which she spoke was both complex and fascinating.',
          '構文':
              '(S)The topic (about which (S) she / (V) spoke) / (V) was / (C) both complex and fascinating.',
          '和訳': '彼女が話した話題は複雑でありながら魅力的でした。',
          '解説': 'The topicが主語(S)\n'
              'about whichが関係代名詞でThe topicを修飾\n'
              '関係代名詞節はabout which～spokeまで 完全文\n'
              'sheが関係詞節主語(S)\n'
              'spokeが関係詞節自動詞(V)\n'
              'wasが自動詞(V)\n'
              'both complex and fascinatingが補語(C)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 22,
          '問題番号': 2,
          '英訳':
              'The organization to which she belongs focuses on environmental conservation.',
          '構文':
              '(S)The organization (to which (S) she / (V) belongs) / (V) focuses on / (O) environmental conservation.',
          '和訳': '彼女が所属している組織は環境保護に焦点を当てています。',
          '解説': 'The organizationが主語(S)\n'
              'to whichが関係代名詞でThe organizationを修飾\n'
              '関係代名詞節はto which～belongsまで 完全文\n'
              'sheが関係詞節主語(S)\n'
              'belongsが関係詞節自動詞(V)\n'
              'focuses onが他動詞(V)\n'
              'environmental conservationが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 22,
          '問題番号': 3,
          '英訳':
              'The colleague from whom I received valuable advice has now moved to another company.',
          '構文':
              '(S)The colleague (from whom (S) I / (V) received / (O) valuable advice) / (V) has now moved <to another company.>',
          '和訳': '私が貴重なアドバイスを受けた同僚は今では別の会社に移りました。',
          '解説': 'The colleagueが主語(S)\n'
              'from whomが関係代名詞でThe colleagueを修飾\n'
              '関係代名詞節はfrom whom～adviceまで 完全文\n'
              'Iが関係詞節主語(S)\n'
              'received が関係詞節他動詞(V)\n'
              'valuable advice が関係詞節目的語(O)\n'
              'has now movedが自動詞(V)\n'
              'to another companyは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 23,
          '問題番号': 1,
          '英訳':
              'The company whose products are eco-friendly has seen a rise in sales.',
          '構文':
              '(S)The company (whose (S) products / (V) are / (C) eco-friendly ) / (V) has seen / (O) a rise <in sales.>',
          '和訳': '製品が環境に優しい会社は売上が伸びています。',
          '解説': 'The companyが主語(S)\n'
              'whoseが関係代名詞でThe companyを修飾\n'
              '関係代名詞節はThe company～eco-friendlyまで 完全文\n'
              'productsが関係詞節主語(S)\n'
              'are が関係詞節自動詞(V)\n'
              'eco-friendlyが関係詞節補語(C)\n'
              'has seenが自動詞(V)\n'
              'a riseが目的語(O)\n'
              'in salesは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 23,
          '問題番号': 2,
          '英訳':
              'The chef whose restaurant has received multiple awards is opening a new branch.',
          '構文':
              '(S)The chef (whose (S) restaurant / (V) has received / (O) multiple awards ) / (V)is opening / (O) a new branch.',
          '和訳': 'レストランが多くの賞を受賞したシェフが新しい支店をオープンします。',
          '解説': 'The chefが主語(S)\n'
              'whoseが関係代名詞でThe chefを修飾\n'
              '関係代名詞節はwhose～awardsまで 完全文\n'
              'restaurantが関係詞節主語(S)\n'
              'has receivedが関係詞節他動詞(V)\n'
              'multiple awardsが関係詞節目的語(O)\n'
              'is openingが他動詞(V)\n'
              'a new branchが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 23,
          '問題番号': 3,
          '英訳':
              'The painter whose artwork was exhibited in the museum received international acclaim.',
          '構文':
              '(S)The painter (whose (S) artwork / (V) was exhibited <in the museum >) / (V) received / (O) international acclaim.',
          '和訳': '美術館で作品が展示された画家は国際的な賞賛を受けました。',
          '解説': 'The painterが主語(S)\n'
              'whoseが関係代名詞でThe painterを修飾\n'
              '関係代名詞節はwhose～awardsまで 完全文\n'
              'artworkが関係詞節主語(S)\n'
              'was exhibitedが関係詞節他動詞受動態(V)\n'
              'in the museumは副詞で文の要素にならない\n'
              'multiple awardsが関係詞節目的語(O)\n'
              'receivedが他動詞(V)\n'
              'international acclaimが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 24,
          '問題番号': 1,
          '英訳':
              'The concert, which was held outdoors, was a huge success despite the rain.',
          '構文':
              '(S)The concert (, which was held outdoors,)  / (V) was / (C) a huge success <despite the rain.>',
          '和訳': '屋外で行われたそのコンサートは、雨にもかかわらず大成功でした。',
          '解説': 'The concertが主語(S)\n'
              ', whichが非制限用法関係代名詞でThe concertを修飾\n'
              '関係代名詞節は, which～outdoorsまで Sが抜けた不完全文\n'
              'was heldが関係詞節他動詞受動態(V)\n'
              'outdoorsは副詞で文の要素にならない\n'
              'wasが自動詞(V)\n'
              'a huge successが補語(C)\n'
              'despite the rainは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 24,
          '問題番号': 2,
          '英訳':
              'The team won the championship, which was a huge achievement for them.',
          '構文':
              '(S)The team  / (V) won / (O) the championship(, which / (V) was / (C) a huge achievement <for them.>)',
          '和訳': 'チームは優勝を果たし、それは彼らにとって大きな成果でした。',
          '解説': 'The teamが主語(S)\n'
              'wonが他動詞(V)\n'
              'the championshipが目的語(O)\n'
              ', whichが非制限用法関係代名詞で前文全体を修飾\n'
              '関係代名詞節は, which～themまで Sが抜けた不完全文\n'
              'was が関係詞節自動詞(V)\n'
              'a huge achievementが関係詞節補語(C)\n'
              'for themは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 24,
          '問題番号': 3,
          '英訳':
              'he company implemented new policies, which improved employee satisfaction.',
          '構文':
              '(S)His company  / (V) implemented / (O) new policies(, which  / (V) improved / (O) employee satisfaction.)',
          '和訳': '会社は新しい方針を実施し、それが従業員の満足度を向上させました。',
          '解説': 'His companyが主語(S)\n'
              'implementedが他動詞(V)\n'
              'new policiesが目的語(O)\n'
              ', whichが非制限用法関係代名詞で前文全体を修飾\n'
              '関係代名詞節は, which～themまで Sが抜けた不完全文\n'
              'improvedが関係詞節他動詞(V)\n'
              'employee satisfactionが関係詞節目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 25,
          '問題番号': 1,
          '英訳':
              'What he proposed was an ambitious plan to tackle the global climate crisis.',
          '構文':
              '(S)[What (S) he / (V) proposed] / (V) was / (C) an ambitious plan (to tackle the global climate crisis.)',
          '和訳': '彼が提案したのは、世界的な気候危機に対処するための野心的な計画でした。',
          '解説': 'Whatは関係代名詞で名詞節を形成して文の主語(S)\n'
              '関係代名詞節はWhat～proposedまで Oが抜けた不完全文\n'
              'heが関係詞節主語(S)\n'
              'proposedが関係詞節他動詞(V)\n'
              'wasが自動詞(V)\n'
              'an ambitious planが目的語(O)\n'
              'to tackle the global climate crisisが不定詞形容詞用法でan ambitious planを修飾',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 25,
          '問題番号': 2,
          '英訳':
              'What the team accomplished in such a short time was extraordinary.',
          '構文':
              '(S)[What (S) the team / (V) accomplished <in such a short time>] / (V) was / (C) extraordinary.',
          '和訳': 'チームが短期間で達成したことは、非凡なものでした。',
          '解説': 'Whatは関係代名詞で名詞節を形成して文の主語(S)\n'
              '関係代名詞節はWhat～timeまで Oが抜けた不完全文\n'
              'the teamが関係詞節主語(S)\n'
              'accomplishedが関係詞節他動詞(V)\n'
              'in such a short timeは副詞で文の要素にならない\n'
              'wasが自動詞(V)\n'
              'extraordinaryが補語(C)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 25,
          '問題番号': 3,
          '英訳':
              'I can not believe what they accomplished in such a short time.',
          '構文':
              '(S)I / (V) can not believe / (O) [what (S) they / (V) accomplished <in such a short time.>]',
          '和訳': '彼らがこんなに短い時間で成し遂げたことが信じられません。',
          '解説': 'Iが主語(S)\n'
              'can not believeが他動詞(V)\n'
              'Whatは関係代名詞で名詞節を形成して文の目的語(O)\n'
              '関係代名詞節はWhat～timeまで Oが抜けた不完全文\n'
              'theyが関係詞節主語(S)\n'
              'accomplishedが関係詞節他動詞(V)\n'
              'in such a short timeは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 26,
          '問題番号': 1,
          '英訳':
              'Do you understand the reason why the policy was changed so suddenly?',
          '構文':
              'Do (S)you / (V) understand / (O) the reason (why  (S) the policy / (V) was changed <so suddenly?>)',
          '和訳': 'なぜその政策が突然変更されたのか理由がわかりますか？',
          '解説': 'youが主語(S)\n'
              'understandが他動詞(V)\n'
              'the reasonが目的語(O)\n'
              'whyが関係副詞でthe reasonを修飾\n'
              '関係副詞節はwhy～suddenlyまで 完全文\n'
              'the policyが関係詞節主語(S)\n'
              'was changedが関係詞節他動詞受動態(V)\n'
              'so suddenlyは副詞で文の要素にならない\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 26,
          '問題番号': 2,
          '英訳':
              'This is the museum where ancient artifacts are displayed for visitors.',
          '構文':
              '(S)This / (V) is / (C) the museum (where (S) ancient artifacts / (V) are displayed <for visitors.>)',
          '和訳': 'ここは、来館者のために古代の遺物が展示されている博物館です。',
          '解説': 'Thisが主語(S)\n'
              'isが自動詞(V)\n'
              'the museumが補語(C)\n'
              'whereが関係副詞でthe museumを修飾\n'
              '関係副詞節はwhere～visitorsまで 完全文\n'
              'ancient artifactsが関係詞節主語(S)\n'
              'are displayedが関係詞節他動詞受動態(V)\n'
              'for visitorsは副詞で文の要素にならない\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 26,
          '問題番号': 3,
          '英訳':
              'The day when she launched her first business was a turning point in her life.',
          '構文':
              '(S)The day (when  (S) she / (V) launched / (O) her first business) / (V) was / (C)  a turning point <in her life.>',
          '和訳': '彼女が初めて事業を立ち上げた日は、彼女の人生の転機となりました。',
          '解説': 'The dayが主語(S)\n'
              'whenが関係副詞でThe dayを修飾\n'
              '関係副詞節はwhen～businessまで 完全文\n'
              'sheが関係詞節主語(S)\n'
              'launchedが関係詞節他動詞(V)\n'
              'her first businessが関係詞節目的語(O)\n'
              'wasが自動詞(V)\n'
              'a turning pointが補語(C)\n'
              'in her lifeは副詞で文の要素にならない\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 27,
          '問題番号': 1,
          '英訳':
              'Wherever they establish new branches, the company ensures quality service.',
          '構文':
              '<Wherever (S) they / (V) establish / (O)  new branches, >/ (S) the company / (V) ensures / (O) quality service.',
          '和訳': '彼らがどこに新しい支店を設置しても、その会社は質の高いサービスを保証します。',
          '解説': '複合関係副詞は副詞か名詞節を形成、今回は副詞節を形成\n'
              '関係詞節はWherever～branchesまで完全文\n'
              'theyが関係詞節主語(S)\n'
              'establishが関係詞節他動詞(V)\n'
              'establishnew branches関係詞節目的語(O)\n'
              'the companyが主語(S)\n'
              'ensuresが他動詞(V)\n'
              'quality serviceが目的語(O)\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 27,
          '問題番号': 2,
          '英訳':
              'Whoever makes the final decision will be held responsible for the outcome.',
          '構文':
              ' (S)[ (S)Whoever / (V) makes / (O) the final decision] / (V) will be held / (C) responsible <for the outcome.>',
          '和訳': '最終決定を下す人は誰でも、その結果について責任を負うことになります。',
          '解説': '複合関係代名詞は副詞か名詞節を形成、今回は名詞節を形成し文の主語(S)になっている\n'
              '関係詞節はWhoever～decisionまでSが抜けた不完全文\n'
              'makesが関係詞節他動詞(V)\n'
              'the final decision関係詞節目的語(O)\n'
              'will be heldが他動詞受動態(V)\n'
              'responsibleが補語(C)\n'
              'for the outcomeは副詞で文の要素にならない\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 27,
          '問題番号': 3,
          '英訳': 'Whatever you say, I will always trust my instincts.',
          '構文':
              '<Whatever (S)you / (V) say,> (S) I / (V) will< always > trust / (O) my instincts.',
          '和訳': 'あなたが何を言っても、私は常に自分の直感を信じます。',
          '解説': '複合関係代名詞は副詞か名詞節を形成、今回は副詞節を形成\n'
              '関係詞節はWhatever ～sayまでOが抜けた不完全文\n'
              'youが関係詞節主語(S)\n'
              'sayが関係詞節他動詞(V)\n'
              'Iが主語(S)\n'
              'trustが他動詞(V)\n'
              'my instinctsが目的語(O)\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 28,
          '問題番号': 1,
          '英訳':
              'The hypothesis that the project will be delayed due to funding issues is being taken seriously.',
          '構文':
              ' (S)The hypothesis (that (S) the project / (V) will be delayed <due to  funding issues> ) / (V) is being taken <seriously.>',
          '和訳': '資金の問題でプロジェクトが遅れるだろうという仮説は、真剣に受け止められています。',
          '解説': '同格thatは形容詞節を形成しThe hypothesisを修飾\n'
              '同格節はthat ～issuesまで完全文\n'
              'the projectが同格節主語(S)\n'
              'will be delayed が同格節他動詞受動態(V)\n'
              'due to  funding issuesは副詞で文の要素にならない\n'
              'The hypothesisが主語(S)\n'
              'is being takenが他動詞受動態(V)\n'
              'seriouslyは副詞で文の要素にならない\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 28,
          '問題番号': 2,
          '英訳':
              'The evidence that exercise improves mental health has been proven by numerous studies.',
          '構文':
              ' (S)The evidence (that (S) exercise / (V) improves / (O) mental health) / (V) has been proven <by numerous studies.>',
          '和訳': '運動が精神的健康を改善するという証拠は、多くの研究によって証明されています。',
          '解説': '同格thatは形容詞節を形成しThe evidenceを修飾\n'
              '同格節はthat ～healthまで完全文\n'
              'exerciseが同格節主語(S)\n'
              'improvesが同格節他動詞(V)\n'
              'mental health同格節目的語(O)\n'
              'The evidenceが主語(S)\n'
              'has been provenが他動詞受動態(V)\n'
              'by numerous studiesは副詞で文の要素にならない\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 28,
          '問題番号': 3,
          '英訳':
              'The conclusion that global warming is primarily caused by human activity has been supported by overwhelming scientific evidence.',
          '構文':
              ' (S)The conclusion ( (S) that global warming / (V) is <primarily> caused <by human activity>)  / (V) has been supported <by overwhelming scientific evidence.>',
          '和訳': '地球温暖化が主に人間の活動によって引き起こされているという結論は、圧倒的な科学的証拠によって支持されています。',
          '解説': '同格thatは形容詞節を形成しThe conclusionを修飾\n'
              '同格節はthat ～activityまで完全文\n'
              'global warmingが同格節主語(S)\n'
              'is causedが同格節他動詞受動態(V)\n'
              'primarily、by human activityは副詞で文の要素にならない\n'
              'The conclusionが主語(S)\n'
              'has been supportedが他動詞受動態(V)\n'
              'by overwhelming scientific evidenceは副詞で文の要素にならない\n',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 29,
          '問題番号': 1,
          '英訳':
              'It was his dedication that inspired the entire team to work harder.',
          '構文':
              'It was (S) his dedication that / (V)inspired / (O) the entire team to work harder.',
          '和訳': '彼の献身が、チーム全体にもっと頑張るようにインスピレーションを与えたのです。',
          '解説': 'it is ～ thatの強調構文は名詞か副詞を強調\n'
              '今回は his dedication名詞を強調\n'
              '名詞が強調される場合はthat以下が不完全文となる\n'
              'his dedicationが主語(S)\n'
              'inspiredが他動詞(V)\n'
              'the entire teamが目的語(O)\n'
              'to work harderは不定詞副詞用法',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 29,
          '問題番号': 2,
          '英訳':
              'It was the critical information that the reporter revealed in the article.',
          '構文':
              'It was / (O) the critical information that / (S) the reporter  / (V) revealed <in the article.>',
          '和訳': '記事で記者が明らかにしたのは、その重要な情報でした。',
          '解説': 'it is ～ thatの強調構文は名詞か副詞を強調\n'
              '今回は the critical information名詞を強調\n'
              '名詞が強調される場合はthat以下が不完全文となる\n'
              'the reporterが主語(S)\n'
              'revealedが他動詞(V)\n'
              'the critical informationが目的語(O)\n'
              'in the articleは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 29,
          '問題番号': 3,
          '英訳': 'It was extremely quickly that she solved the problem.',
          '構文':
              'It was <extremely quickly> that / (S) she / (V) solved / (O) the problem.',
          '和訳': '彼女はその問題を非常に速く解決しました。',
          '解説': 'it is ～ thatの強調構文は名詞か副詞を強調\n'
              '今回は the critical information副詞を強調\n'
              '副詞が強調される場合はthat以下が完全文となる\n'
              'sheが主語(S)\n'
              'solvedが他動詞(V)\n'
              'the critical informationが目的語(O)\n'
              'the problemは副詞で文の要素にならない',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 30,
          '問題番号': 1,
          '英訳': 'Never before have I encountered such a formidable challenge.',
          '構文':
              'Never before have / (S) I / (V) encountered / (O) such a formidable challenge.',
          '和訳': 'こんなに手強い挑戦に直面したことは今まで一度もありません。',
          '解説': '文頭に否定の語がある場合は倒置が発生する\n'
              'Never before否定語が来ているためIとhaveで倒置が発生\n'
              'Iが主語(S)\n'
              'have encounteredが他動詞(V)\n'
              'such a formidable challengeが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 30,
          '問題番号': 2,
          '英訳':
              'Only by addressing the root causes of the problem can we achieve lasting change.',
          '構文':
              '<Only by addressing the root causes of the problem> can  / (S) we / (V) achieve / (O) lasting change.',
          '和訳': '問題の根本原因に取り組むことだけが、持続的な変化を達成する方法です。',
          '解説': '文頭に否定の語がある場合は倒置が発生する\n'
              'Onlyは部分否定や限定で倒置が発生する条件に当てはまる weとcanで倒置が発生\n'
              'weが主語(S)\n'
              'achieveが他動詞(V)\n'
              'lasting changeが目的語(O)',
          'チェック': 0,
          '最終学習日': null
        },
        {
          '章番号': 30,
          '問題番号': 3,
          '英訳':
              'Hardly had the event started when an unexpected storm disrupted everything.',
          '構文':
              'Hardly had  / (S) the event / (V) started <when / (S) an unexpected storm / (V) disrupted / (O) everything.>',
          '和訳': 'イベントが始まった途端、予期しない嵐がすべてを中断させました。',
          '解説': '文頭に否定の語がある場合は倒置が発生する\n'
              'Hardly否定語が来ているためthe eventとhadで倒置が発生\n'
              'the eventが主語(S)\n'
              'had startedが自動詞(V)\n'
              'whenは従属接続詞で副詞節を形成\n'
              'an unexpected stormが従属節主語(S)\n'
              'disruptedが従属節他動詞(V)\n'
              'everythingが従属節目的語(O)',
          'チェック': 0,
          '最終学習日': null
        }
      ]);
      print('初回問題データが追加されました');
    } else {
      print('既存の問題データがあります');
    }
  } catch (e) {
    print('Error in putting default data: $e');
  }
  late Box box2;
  try {
    // 'wordsBox'という名前のボックスを開く
    box2 = await Hive.openBox('wordsBox');
  } catch (e) {
    print('Error in opening Hive box2: $e');
  }
  try {
    // デフォルトデータを追加するかどうか
    if (box2.isEmpty) {
      await box2.put('words', [
        {
          '章番号': 1,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'traffic',
          '品詞種別': '名詞',
          '和訳': '交通'
        },
        {
          '章番号': 1,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'accident',
          '品詞種別': '名詞',
          '和訳': '事故'
        },
        {
          '章番号': 1,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'decrease',
          '品詞種別': '動詞',
          '和訳': '減る、～を減らす'
        },
        {
          '章番号': 1,
          '問題番号': 1,
          '語彙番号': 4,
          '英訳': 'dramatically',
          '品詞種別': '副詞',
          '和訳': '劇的に'
        },
        {
          '章番号': 1,
          '問題番号': 1,
          '語彙番号': 5,
          '英訳': 'the number of',
          '品詞種別': '熟語',
          '和訳': '～の数'
        },
        {
          '章番号': 1,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'constantly',
          '品詞種別': '副詞',
          '和訳': '絶えず、しきりに'
        },
        {
          '章番号': 1,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'during',
          '品詞種別': '前置詞',
          '和訳': '～の間'
        },
        {
          '章番号': 1,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'employee',
          '品詞種別': '名詞',
          '和訳': '従業員'
        },
        {
          '章番号': 1,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'gather',
          '品詞種別': '動詞',
          '和訳': '集まる'
        },
        {
          '章番号': 1,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'quickly',
          '品詞種別': '副詞',
          '和訳': '素早く、直ちに'
        },
        {
          '章番号': 1,
          '問題番号': 3,
          '語彙番号': 4,
          '英訳': 'grocery',
          '品詞種別': '名詞',
          '和訳': '食料品店'
        },
        {
          '章番号': 2,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'exhasted',
          '品詞種別': '形容詞',
          '和訳': '疲れ果てた'
        },
        {
          '章番号': 2,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'boring',
          '品詞種別': '形容詞',
          '和訳': '退屈な'
        },
        {
          '章番号': 2,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'conference',
          '品詞種別': '名詞',
          '和訳': '会議'
        },
        {
          '章番号': 2,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'remain',
          '品詞種別': '動詞',
          '和訳': '～のままである'
        },
        {
          '章番号': 2,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'skeptical',
          '品詞種別': '形容詞',
          '和訳': '懐疑的な'
        },
        {
          '章番号': 2,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'complicate',
          '品詞種別': '形容詞',
          '和訳': '複雑な'
        },
        {
          '章番号': 2,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'at first',
          '品詞種別': '熟語',
          '和訳': '最初は'
        },
        {
          '章番号': 3,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'discover',
          '品詞種別': '動詞',
          '和訳': '発見する'
        },
        {
          '章番号': 3,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'solution',
          '品詞種別': '名詞',
          '和訳': '解決策'
        },
        {
          '章番号': 3,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'complex',
          '品詞種別': '形容詞',
          '和訳': '複雑な'
        },
        {
          '章番号': 3,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'acknowledge',
          '品詞種別': '動詞',
          '和訳': '認める'
        },
        {
          '章番号': 3,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'contribution',
          '品詞種別': '名詞',
          '和訳': '貢献'
        },
        {
          '章番号': 3,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'peer',
          '品詞種別': '名詞',
          '和訳': '仲間、同僚'
        },
        {
          '章番号': 3,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'investigate',
          '品詞種別': '動詞',
          '和訳': '調査する'
        },
        {
          '章番号': 3,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'cause',
          '品詞種別': '名詞',
          '和訳': '原因'
        },
        {
          '章番号': 3,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'delay',
          '品詞種別': '名詞',
          '和訳': '遅延'
        },
        {
          '章番号': 4,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'explain',
          '品詞種別': '動詞',
          '和訳': '説明する'
        },
        {
          '章番号': 4,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'sophisticate',
          '品詞種別': '形容詞',
          '和訳': '洗練された'
        },
        {
          '章番号': 4,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'concept',
          '品詞種別': '名詞',
          '和訳': '概念'
        },
        {
          '章番号': 4,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'colleague',
          '品詞種別': '名詞',
          '和訳': '同僚'
        },
        {
          '章番号': 4,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'detail',
          '品詞種別': '形容詞',
          '和訳': '詳細な'
        },
        {
          '章番号': 4,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'luxurious',
          '品詞種別': '形容詞',
          '和訳': '贅沢な'
        },
        {
          '章番号': 4,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'anniversary',
          '品詞種別': '名詞',
          '和訳': '記念日'
        },
        {
          '章番号': 5,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'view',
          '品詞種別': '動詞',
          '和訳': 'みなす'
        },
        {
          '章番号': 5,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'strategy',
          '品詞種別': '名詞',
          '和訳': '戦略'
        },
        {
          '章番号': 5,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'beneficial',
          '品詞種別': '形容詞',
          '和訳': '有益な'
        },
        {
          '章番号': 5,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'author',
          '品詞種別': '名詞',
          '和訳': '著者'
        },
        {
          '章番号': 5,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'describe',
          '品詞種別': '動詞',
          '和訳': '描写する'
        },
        {
          '章番号': 5,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'reflection',
          '品詞種別': '名詞',
          '和訳': '反映'
        },
        {
          '章番号': 5,
          '問題番号': 2,
          '語彙番号': 4,
          '英訳': 'contemporary',
          '品詞種別': '形容詞',
          '和訳': '現代の'
        },
        {
          '章番号': 5,
          '問題番号': 2,
          '語彙番号': 5,
          '英訳': 'literature',
          '品詞種別': '名詞',
          '和訳': '文学'
        },
        {
          '章番号': 5,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'explanation',
          '品詞種別': '名詞',
          '和訳': '説明する'
        },
        {
          '章番号': 5,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'exceedingly',
          '品詞種別': '副詞',
          '和訳': '非常に'
        },
        {
          '章番号': 5,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'comprehensive',
          '品詞種別': '形容詞',
          '和訳': '包括的な'
        },
        {
          '章番号': 6,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'endeavor',
          '品詞種別': '動詞',
          '和訳': '努力する'
        },
        {
          '章番号': 6,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'achieve',
          '品詞種別': '動詞',
          '和訳': '達成する'
        },
        {
          '章番号': 6,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'ambitious',
          '品詞種別': '形容詞',
          '和訳': '野心的な'
        },
        {
          '章番号': 6,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'hesitate',
          '品詞種別': '動詞',
          '和訳': 'ためらう'
        },
        {
          '章番号': 6,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'disclose',
          '品詞種別': '動詞',
          '和訳': '開示する'
        },
        {
          '章番号': 6,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'confidential',
          '品詞種別': '形容詞',
          '和訳': '機密の'
        },
        {'章番号': 6, '問題番号': 3, '語彙番号': 1, '英訳': 'vow', '品詞種別': '動詞', '和訳': '誓う'},
        {
          '章番号': 6,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'overcome',
          '品詞種別': '動詞',
          '和訳': '打ち勝つ'
        },
        {
          '章番号': 6,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'obstacle',
          '品詞種別': '名詞',
          '和訳': '障害'
        },
        {'章番号': 6, '問題番号': 3, '語彙番号': 4, '英訳': 'path', '品詞種別': '名詞', '和訳': '道'},
        {
          '章番号': 7,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'launch',
          '品詞種別': '動詞',
          '和訳': '開始する'
        },
        {
          '章番号': 7,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'promote',
          '品詞種別': '動詞',
          '和訳': '促進する'
        },
        {
          '章番号': 7,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'environmental',
          '品詞種別': '形容詞',
          '和訳': '環境の'
        },
        {
          '章番号': 7,
          '問題番号': 1,
          '語彙番号': 4,
          '英訳': 'awareness',
          '品詞種別': '名詞',
          '和訳': '意識'
        },
        {
          '章番号': 7,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'opportunity',
          '品詞種別': '名詞',
          '和訳': '機会'
        },
        {
          '章番号': 7,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'valuable',
          '品詞種別': '形容詞',
          '和訳': '価値のある'
        },
        {
          '章番号': 7,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'experience',
          '品詞種別': '名詞',
          '和訳': '経験'
        },
        {
          '章番号': 7,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'enhance',
          '品詞種別': '動詞',
          '和訳': '高める'
        },
        {
          '章番号': 8,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'emphasize',
          '品詞種別': '動詞',
          '和訳': '強調する'
        },
        {
          '章番号': 8,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'motivate',
          '品詞種別': '動詞',
          '和訳': 'やる気にさせる'
        },
        {
          '章番号': 8,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'broaden',
          '品詞種別': '動詞',
          '和訳': '広める'
        },
        {
          '章番号': 8,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'relation',
          '品詞種別': '名詞',
          '和訳': '関係'
        },
        {
          '章番号': 8,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'express',
          '品詞種別': '動詞',
          '和訳': '表現する'
        },
        {
          '章番号': 8,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'gratitude',
          '品詞種別': '名詞',
          '和訳': '感謝'
        },
        {
          '章番号': 9,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'essential',
          '品詞種別': '形容詞',
          '和訳': '不可欠な'
        },
        {
          '章番号': 9,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'maintain',
          '品詞種別': '動詞',
          '和訳': '維持する'
        },
        {
          '章番号': 9,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'diet',
          '品詞種別': '名詞',
          '和訳': '食事'
        },
        {
          '章番号': 9,
          '問題番号': 1,
          '語彙番号': 4,
          '英訳': 'overall',
          '品詞種別': '形容詞',
          '和訳': '全体の'
        },
        {
          '章番号': 9,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'consistently',
          '品詞種別': '副詞',
          '和訳': '一貫して'
        },
        {
          '章番号': 9,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'achieve',
          '品詞種別': '動詞',
          '和訳': '達成する'
        },
        {
          '章番号': 9,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'vital',
          '品詞種別': '形容詞',
          '和訳': '重要な'
        },
        {
          '章番号': 9,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'engage',
          '品詞種別': '動詞',
          '和訳': '従事する'
        },
        {
          '章番号': 9,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'empathy',
          '品詞種別': '名詞',
          '和訳': '共感'
        },
        {
          '章番号': 10,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'embrace',
          '品詞種別': '動詞',
          '和訳': '受け入れる'
        },
        {
          '章番号': 10,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'lead to',
          '品詞種別': '動詞',
          '和訳': '引き起こす'
        },
        {
          '章番号': 10,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'opportunity',
          '品詞種別': '名詞',
          '和訳': '機会'
        },
        {
          '章番号': 10,
          '問題番号': 1,
          '語彙番号': 4,
          '英訳': 'experience',
          '品詞種別': '名詞',
          '和訳': '経験'
        },
        {
          '章番号': 10,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'acknowledge',
          '品詞種別': '動詞',
          '和訳': '認める'
        },
        {
          '章番号': 10,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'limitation',
          '品詞種別': '名詞',
          '和訳': '限界'
        },
        {
          '章番号': 10,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'lead to',
          '品詞種別': '動詞',
          '和訳': '引き起こす'
        },
        {
          '章番号': 10,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'analyze',
          '品詞種別': '動詞',
          '和訳': '分析する'
        },
        {
          '章番号': 10,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'valuable',
          '品詞種別': '形容詞',
          '和訳': '価値のある'
        },
        {
          '章番号': 10,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'insights',
          '品詞種別': '名詞',
          '和訳': '洞察'
        },
        {
          '章番号': 10,
          '問題番号': 3,
          '語彙番号': 4,
          '英訳': 'current',
          '品詞種別': '形容詞',
          '和訳': '現在の'
        },
        {
          '章番号': 10,
          '問題番号': 3,
          '語彙番号': 5,
          '英訳': 'affairs',
          '品詞種別': '名詞',
          '和訳': '事態'
        },
        {
          '章番号': 11,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'organization',
          '品詞種別': '名詞',
          '和訳': '組織'
        },
        {
          '章番号': 11,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'promote',
          '品詞種別': '動詞',
          '和訳': '促進する'
        },
        {
          '章番号': 11,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'exchange',
          '品詞種別': '動詞',
          '和訳': '交換する'
        },
        {
          '章番号': 11,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'financial',
          '品詞種別': '形容詞',
          '和訳': '財政の'
        },
        {
          '章番号': 11,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'aid',
          '品詞種別': '名詞',
          '和訳': '援助'
        },
        {
          '章番号': 11,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'income',
          '品詞種別': '名詞',
          '和訳': '収入'
        },
        {
          '章番号': 11,
          '問題番号': 2,
          '語彙番号': 4,
          '英訳': 'expand',
          '品詞種別': '動詞',
          '和訳': '拡大する'
        },
        {
          '章番号': 11,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'participate',
          '品詞種別': '動詞',
          '和訳': '参加する'
        },
        {
          '章番号': 11,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'remarkable',
          '品詞種別': '形容詞',
          '和訳': '優れた'
        },
        {
          '章番号': 11,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'insight',
          '品詞種別': '名詞',
          '和訳': '洞察'
        },
        {
          '章番号': 12,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'product',
          '品詞種別': '名詞',
          '和訳': '製品'
        },
        {
          '章番号': 12,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'manufacture',
          '品詞種別': '動詞',
          '和訳': '製造する'
        },
        {
          '章番号': 12,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'export',
          '品詞種別': '動詞',
          '和訳': '輸出する'
        },
        {
          '章番号': 12,
          '問題番号': 1,
          '語彙番号': 4,
          '英訳': 'worldwide',
          '品詞種別': '副詞',
          '和訳': '世界中で'
        },
        {
          '章番号': 12,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'equipment',
          '品詞種別': '名詞',
          '和訳': '機器'
        },
        {
          '章番号': 12,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'install',
          '品詞種別': '動詞',
          '和訳': '設置する'
        },
        {
          '章番号': 12,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'advanced',
          '品詞種別': '形容詞',
          '和訳': '先進的な'
        },
        {
          '章番号': 12,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'establish',
          '品詞種別': '動詞',
          '和訳': '設立する'
        },
        {
          '章番号': 12,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'competition',
          '品詞種別': '名詞',
          '和訳': '大会'
        },
        {
          '章番号': 12,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'strict',
          '品詞種別': '形容詞',
          '和訳': '厳しい'
        },
        {
          '章番号': 13,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'overwhelm',
          '品詞種別': '形容詞',
          '和訳': '圧倒的な'
        },
        {
          '章番号': 13,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'workload',
          '品詞種別': '名詞',
          '和訳': '仕事量'
        },
        {
          '章番号': 13,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'supervisor',
          '品詞種別': '名詞',
          '和訳': '上司'
        },
        {
          '章番号': 13,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'notice',
          '品詞種別': '動詞',
          '和訳': '気づく'
        },
        {
          '章番号': 13,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'sudden',
          '品詞種別': '形容詞',
          '和訳': '突然の'
        },
        {
          '章番号': 13,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'decline',
          '品詞種別': '名詞',
          '和訳': '減少'
        },
        {
          '章番号': 13,
          '問題番号': 2,
          '語彙番号': 4,
          '英訳': 'implement',
          '品詞種別': '動詞',
          '和訳': '実行する'
        },
        {
          '章番号': 13,
          '問題番号': 2,
          '語彙番号': 5,
          '英訳': 'strategy',
          '品詞種別': '名詞',
          '和訳': '戦略'
        },
        {
          '章番号': 13,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'equip',
          '品詞種別': '動詞',
          '和訳': '設置する'
        },
        {
          '章番号': 13,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'improve',
          '品詞種別': '動詞',
          '和訳': '改善する'
        },
        {
          '章番号': 13,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'efficiency',
          '品詞種別': '名詞',
          '和訳': '効率'
        },
        {
          '章番号': 14,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'announcement',
          '品詞種別': '名詞',
          '和訳': '発表'
        },
        {
          '章番号': 14,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'brightly',
          '品詞種別': '副詞',
          '和訳': '明るく'
        },
        {
          '章番号': 14,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'above',
          '品詞種別': '前置詞',
          '和訳': '上で'
        },
        {
          '章番号': 14,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': ' focus',
          '品詞種別': '動詞',
          '和訳': '集中する'
        },
        {
          '章番号': 15,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'confirm',
          '品詞種別': '動詞',
          '和訳': '確認する'
        },
        {
          '章番号': 15,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'expand',
          '品詞種別': '動詞',
          '和訳': '広げる'
        },
        {
          '章番号': 15,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'explain',
          '品詞種別': '動詞',
          '和訳': '説明する'
        },
        {
          '章番号': 15,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'budget',
          '品詞種別': '名詞',
          '和訳': '予算'
        },
        {
          '章番号': 15,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'allocate',
          '品詞種別': '動詞',
          '和訳': '割り当てる'
        },
        {
          '章番号': 15,
          '問題番号': 2,
          '語彙番号': 4,
          '英訳': 'initiative',
          '品詞種別': '名詞',
          '和訳': '施策、主導権、新しい取り組み'
        },
        {
          '章番号': 15,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'state',
          '品詞種別': '動詞',
          '和訳': '述べる'
        },
        {
          '章番号': 15,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'release',
          '品詞種別': '動詞',
          '和訳': '公開する'
        },
        {
          '章番号': 16,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'although',
          '品詞種別': '接続詞',
          '和訳': '～だけれども、～にもかかわらず'
        },
        {
          '章番号': 16,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'intensive',
          '品詞種別': '形容詞',
          '和訳': '集中的な、強化された'
        },
        {
          '章番号': 16,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'valuable',
          '品詞種別': '形容詞',
          '和訳': '価値のある、有益な'
        },
        {
          '章番号': 16,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'so that',
          '品詞種別': '接続詞',
          '和訳': '～するために、～するように'
        },
        {
          '章番号': 16,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'deadline',
          '品詞種別': '名詞',
          '和訳': '締め切り、期日'
        },
        {
          '章番号': 16,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'scholarship',
          '品詞種別': '名詞',
          '和訳': '奨学金'
        },
        {
          '章番号': 17,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'unfortunate',
          '品詞種別': '形容詞',
          '和訳': '不運な、不幸な'
        },
        {
          '章番号': 17,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'postphone',
          '品詞種別': '動詞',
          '和訳': '延期する'
        },
        {
          '章番号': 17,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'essential',
          '品詞種別': '形容詞',
          '和訳': '不可欠な、必須の'
        },
        {
          '章番号': 17,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'address',
          '品詞種別': '動詞',
          '和訳': '対処する'
        },
        {
          '章番号': 17,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'as soon as possible',
          '品詞種別': '副詞',
          '和訳': 'できるだけ早く'
        },
        {
          '章番号': 17,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'obvious',
          '品詞種別': '形容詞',
          '和訳': '明らかな、明白な'
        },
        {
          '章番号': 17,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'decision',
          '品詞種別': '名詞',
          '和訳': '決定、判断'
        },
        {
          '章番号': 18,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'strange',
          '品詞種別': '形容詞',
          '和訳': '奇妙な、変な'
        },
        {
          '章番号': 18,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'empty',
          '品詞種別': '形容詞',
          '和訳': '空の、空っぽの'
        },
        {
          '章番号': 18,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'delay',
          '品詞種別': '動詞',
          '和訳': '遅らせる'
        },
        {
          '章番号': 18,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'until',
          '品詞種別': '前置詞',
          '和訳': '～まで'
        },
        {
          '章番号': 18,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'colleague',
          '品詞種別': '名詞',
          '和訳': '同僚'
        },
        {
          '章番号': 18,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'avoid',
          '品詞種別': '動詞',
          '和訳': '避ける'
        },
        {
          '章番号': 18,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'matter',
          '品詞種別': '名詞',
          '和訳': '問題、事柄'
        },
        {
          '章番号': 19,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'species',
          '品詞種別': '名詞',
          '和訳': '種（生物の）'
        },
        {
          '章番号': 19,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'award',
          '品詞種別': '動詞',
          '和訳': '授与する'
        },
        {
          '章番号': 19,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'prestigious',
          '品詞種別': '形容詞',
          '和訳': '名誉ある、権威のある'
        },
        {
          '章番号': 19,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'innovative',
          '品詞種別': '形容詞',
          '和訳': '革新的な'
        },
        {
          '章番号': 19,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'numerous',
          '品詞種別': '形容詞',
          '和訳': '多数の、たくさんの'
        },
        {
          '章番号': 19,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'culinary',
          '品詞種別': '形容詞',
          '和訳': '料理の、食事の'
        },
        {
          '章番号': 19,
          '問題番号': 2,
          '語彙番号': 4,
          '英訳': 'awards',
          '品詞種別': '名詞',
          '和訳': '賞、報酬'
        },
        {
          '章番号': 19,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'hire',
          '品詞種別': '動詞',
          '和訳': '雇う'
        },
        {
          '章番号': 19,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'experienced',
          '品詞種別': '形容詞',
          '和訳': '経験豊富な'
        },
        {
          '章番号': 20,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'suggest',
          '品詞種別': '動詞',
          '和訳': '提案する'
        },
        {
          '章番号': 20,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'innovative',
          '品詞種別': '形容詞',
          '和訳': '革新的な'
        },
        {
          '章番号': 20,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'article',
          '品詞種別': '名詞',
          '和訳': '記事、項目'
        },
        {
          '章番号': 20,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'praise',
          '品詞種別': '名詞',
          '和訳': '賞賛'
        },
        {
          '章番号': 20,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'solution',
          '品詞種別': '名詞',
          '和訳': '解決策、解答'
        },
        {
          '章番号': 20,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'suggest',
          '品詞種別': '動詞',
          '和訳': '提案する'
        },
        {
          '章番号': 20,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'perfectly',
          '品詞種別': '副詞',
          '和訳': '完璧に'
        },
        {
          '章番号': 21,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'conduct',
          '品詞種別': '動詞',
          '和訳': '実施する'
        },
        {
          '章番号': 21,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'reveal',
          '品詞種別': '動詞',
          '和訳': '明らかにする'
        },
        {
          '章番号': 21,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'critical',
          '品詞種別': '形容詞',
          '和訳': '重大な'
        },
        {
          '章番号': 21,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'attend',
          '品詞種別': '動詞',
          '和訳': '参加する'
        },
        {
          '章番号': 21,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'enhance',
          '品詞種別': '動詞',
          '和訳': '高める'
        },
        {
          '章番号': 21,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'comprehensive',
          '品詞種別': '形容詞',
          '和訳': '包括的な'
        },
        {
          '章番号': 21,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'analysis',
          '品詞種別': '名詞',
          '和訳': '分析'
        },
        {
          '章番号': 21,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'valuable',
          '品詞種別': '形容詞',
          '和訳': '貴重な'
        },
        {
          '章番号': 21,
          '問題番号': 3,
          '語彙番号': 4,
          '英訳': 'recommendation',
          '品詞種別': '名詞',
          '和訳': '推奨'
        },
        {
          '章番号': 22,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'complex',
          '品詞種別': '形容詞',
          '和訳': '複雑な'
        },
        {
          '章番号': 22,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'fascinating',
          '品詞種別': '形容詞',
          '和訳': '魅力的な'
        },
        {
          '章番号': 22,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'organization',
          '品詞種別': '名詞',
          '和訳': '組織'
        },
        {
          '章番号': 22,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'environmental',
          '品詞種別': '形容詞',
          '和訳': '環境の'
        },
        {
          '章番号': 22,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'conservation',
          '品詞種別': '名詞',
          '和訳': '保護'
        },
        {
          '章番号': 22,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'colleague',
          '品詞種別': '名詞',
          '和訳': '同僚'
        },
        {
          '章番号': 23,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'eco-friendly',
          '品詞種別': '形容詞',
          '和訳': '環境に優しい'
        },
        {
          '章番号': 23,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'multiple',
          '品詞種別': '形容詞',
          '和訳': '多くの'
        },
        {
          '章番号': 23,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'awards',
          '品詞種別': '名詞',
          '和訳': '賞'
        },
        {
          '章番号': 23,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'branch',
          '品詞種別': '名詞',
          '和訳': '支店'
        },
        {
          '章番号': 23,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'exhibit',
          '品詞種別': '動詞',
          '和訳': '展示する'
        },
        {
          '章番号': 23,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'international',
          '品詞種別': '形容詞',
          '和訳': '国際的な'
        },
        {
          '章番号': 23,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'acclaim',
          '品詞種別': '名詞',
          '和訳': '賞賛'
        },
        {
          '章番号': 24,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'huge',
          '品詞種別': '形容詞',
          '和訳': '大きな、巨大な'
        },
        {
          '章番号': 24,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'despite',
          '品詞種別': '前置詞',
          '和訳': 'にもかかわらず'
        },
        {
          '章番号': 24,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'huge',
          '品詞種別': '形容詞',
          '和訳': '大きな、巨大な'
        },
        {
          '章番号': 24,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'achievement',
          '品詞種別': '名詞',
          '和訳': '業績'
        },
        {
          '章番号': 24,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'implement',
          '品詞種別': '動詞',
          '和訳': '実施する'
        },
        {
          '章番号': 24,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'improve',
          '品詞種別': '動詞',
          '和訳': '改善する'
        },
        {
          '章番号': 24,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'employee',
          '品詞種別': '名詞',
          '和訳': '従業員'
        },
        {
          '章番号': 24,
          '問題番号': 3,
          '語彙番号': 4,
          '英訳': 'satisfaction',
          '品詞種別': '名詞',
          '和訳': '満足'
        },
        {
          '章番号': 25,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'ambitious',
          '品詞種別': '形容詞',
          '和訳': '野心的な'
        },
        {
          '章番号': 25,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'tackle',
          '品詞種別': '動詞',
          '和訳': '取り組む'
        },
        {
          '章番号': 25,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'global',
          '品詞種別': '形容詞',
          '和訳': '世界的な'
        },
        {
          '章番号': 25,
          '問題番号': 1,
          '語彙番号': 4,
          '英訳': 'crisis',
          '品詞種別': '名詞',
          '和訳': '危機'
        },
        {
          '章番号': 25,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'accomplish',
          '品詞種別': '動詞',
          '和訳': '成し遂げる'
        },
        {
          '章番号': 25,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'extraordinary',
          '品詞種別': '形容詞',
          '和訳': '並外れた'
        },
        {
          '章番号': 25,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'accomplish',
          '品詞種別': '動詞',
          '和訳': '成し遂げる'
        },
        {
          '章番号': 26,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'suddenly',
          '品詞種別': '副詞',
          '和訳': '突然'
        },
        {
          '章番号': 26,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'ancient',
          '品詞種別': '形容詞',
          '和訳': '古代の'
        },
        {
          '章番号': 26,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'artifact',
          '品詞種別': '名詞',
          '和訳': '遺物'
        },
        {
          '章番号': 26,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'turning point',
          '品詞種別': '名詞',
          '和訳': '転換点'
        },
        {
          '章番号': 27,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'establish',
          '品詞種別': '動詞',
          '和訳': '設立する'
        },
        {
          '章番号': 27,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'branch',
          '品詞種別': '名詞',
          '和訳': '支店'
        },
        {
          '章番号': 27,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'ensure',
          '品詞種別': '動詞',
          '和訳': '確保する'
        },
        {
          '章番号': 27,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'responsible',
          '品詞種別': '形容詞',
          '和訳': '責任がある'
        },
        {
          '章番号': 27,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'outcome',
          '品詞種別': '名詞',
          '和訳': '結果'
        },
        {
          '章番号': 27,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'instinct',
          '品詞種別': '名詞',
          '和訳': '本能、直観'
        },
        {
          '章番号': 28,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'hypothesis',
          '品詞種別': '名詞',
          '和訳': '仮説'
        },
        {
          '章番号': 28,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'delay',
          '品詞種別': '動詞',
          '和訳': '遅れる'
        },
        {
          '章番号': 28,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'funding',
          '品詞種別': '名詞',
          '和訳': '資金提供'
        },
        {
          '章番号': 28,
          '問題番号': 1,
          '語彙番号': 4,
          '英訳': 'issue',
          '品詞種別': '名詞',
          '和訳': '問題、課題'
        },
        {
          '章番号': 28,
          '問題番号': 1,
          '語彙番号': 5,
          '英訳': 'seriously',
          '品詞種別': '副詞',
          '和訳': '真剣に'
        },
        {
          '章番号': 28,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'evidence',
          '品詞種別': '名詞',
          '和訳': '証拠'
        },
        {
          '章番号': 28,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'improve',
          '品詞種別': '動詞',
          '和訳': '改善する'
        },
        {
          '章番号': 28,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'prove',
          '品詞種別': '動詞',
          '和訳': '証明する'
        },
        {
          '章番号': 28,
          '問題番号': 2,
          '語彙番号': 4,
          '英訳': 'numerous',
          '品詞種別': '形容詞',
          '和訳': 'たくさんの'
        },
        {
          '章番号': 28,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'conclusion',
          '品詞種別': '名詞',
          '和訳': '結論'
        },
        {
          '章番号': 28,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'primarily',
          '品詞種別': '副詞',
          '和訳': '主に'
        },
        {
          '章番号': 28,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'overwhelming',
          '品詞種別': '形容詞',
          '和訳': '圧倒的な'
        },
        {
          '章番号': 28,
          '問題番号': 3,
          '語彙番号': 4,
          '英訳': 'scientific',
          '品詞種別': '形容詞',
          '和訳': '科学的な'
        },
        {
          '章番号': 28,
          '問題番号': 3,
          '語彙番号': 5,
          '英訳': 'evidence',
          '品詞種別': '名詞',
          '和訳': '証拠'
        },
        {
          '章番号': 29,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'dedication',
          '品詞種別': '名詞',
          '和訳': '献身'
        },
        {
          '章番号': 29,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'inspire',
          '品詞種別': '動詞',
          '和訳': '鼓舞する'
        },
        {
          '章番号': 29,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'entire',
          '品詞種別': '形容詞',
          '和訳': '全体の'
        },
        {
          '章番号': 29,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'critical',
          '品詞種別': '形容詞',
          '和訳': '重大な'
        },
        {
          '章番号': 29,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'reveal',
          '品詞種別': '動詞',
          '和訳': '明らかにする'
        },
        {
          '章番号': 29,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'article',
          '品詞種別': '名詞',
          '和訳': '記事'
        },
        {
          '章番号': 29,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'extremely',
          '品詞種別': '副詞',
          '和訳': '非常に'
        },
        {
          '章番号': 29,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'solve',
          '品詞種別': '動詞',
          '和訳': '解決する'
        },
        {
          '章番号': 30,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'encounter',
          '品詞種別': '動詞',
          '和訳': '出会う'
        },
        {
          '章番号': 30,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'formidable',
          '品詞種別': '形容詞',
          '和訳': '手ごわい'
        },
        {
          '章番号': 30,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'address',
          '品詞種別': '動詞',
          '和訳': '対処する'
        },
        {
          '章番号': 30,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'achieve',
          '品詞種別': '動詞',
          '和訳': '達成する'
        },
        {
          '章番号': 30,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'lasting',
          '品詞種別': '形容詞',
          '和訳': '長続きする'
        },
        {
          '章番号': 30,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'unexpected',
          '品詞種別': '形容詞',
          '和訳': '予期しない'
        },
        {
          '章番号': 30,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'disrupt',
          '品詞種別': '動詞',
          '和訳': '混乱する'
        },

        //長文
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 1,
          '英訳': 'issue',
          '品詞種別': '名詞',
          '和訳': '問題、課題'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 2,
          '英訳': 'increasingly',
          '品詞種別': '副詞',
          '和訳': 'ますます'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 3,
          '英訳': 'critical',
          '品詞種別': '形容詞',
          '和訳': '重大な'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 4,
          '英訳': 'various',
          '品詞種別': '形容詞',
          '和訳': '様々な'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 5,
          '英訳': 'challenge',
          '品詞種別': '名詞',
          '和訳': '課題、挑戦'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 6,
          '英訳': 'press',
          '品詞種別': '動詞',
          '和訳': '押す、圧力をかける'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 7,
          '英訳': 'fossil',
          '品詞種別': '名詞',
          '和訳': '化石'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 8,
          '英訳': 'fuel',
          '品詞種別': '名詞',
          '和訳': '燃料'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 9,
          '英訳': 'deforestation',
          '品詞種別': '名詞',
          '和訳': '森林伐採'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 10,
          '英訳': 'greenhouse gases',
          '品詞種別': '名詞',
          '和訳': '温室効果ガス'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 11,
          '英訳': 'atmosphere',
          '品詞種別': '名詞',
          '和訳': '大気、空気'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 12,
          '英訳': 'temperature',
          '品詞種別': '名詞',
          '和訳': '気温、温度'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 13,
          '英訳': 'severe',
          '品詞種別': '形容詞',
          '和訳': '深刻な、厳しい'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 14,
          '英訳': 'significant',
          '品詞種別': '名詞',
          '和訳': '重要な、意義のある'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 15,
          '英訳': 'pollution',
          '品詞種別': '名詞',
          '和訳': '汚染'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 16,
          '英訳': 'soil',
          '品詞種別': '名詞',
          '和訳': '土壌'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 17,
          '英訳': 'not only A but also B',
          '品詞種別': '熟語',
          '和訳': 'AだけでなくBも'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 18,
          '英訳': 'disease',
          '品詞種別': '名詞',
          '和訳': '病気'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 19,
          '英訳': 'individual',
          '品詞種別': '名詞',
          '和訳': '個人'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 20,
          '英訳': 'government',
          '品詞種別': '名詞',
          '和訳': '政府'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 21,
          '英訳': 'renewable',
          '品詞種別': '形容詞',
          '和訳': '再生可能な'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 22,
          '英訳': 'source',
          '品詞種別': '名詞',
          '和訳': '供給源、源'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 23,
          '英訳': 'essential',
          '品詞種別': '形容詞',
          '和訳': '必須の、不可欠な'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 24,
          '英訳': 'additionally',
          '品詞種別': '副詞',
          '和訳': 'さらに、加えて'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 25,
          '英訳': 'awareness',
          '品詞種別': '名詞',
          '和訳': '意識、自覚'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 26,
          '英訳': 'conservation',
          '品詞種別': '名詞',
          '和訳': '保護、保存'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 27,
          '英訳': 'encourage',
          '品詞種別': '動詞',
          '和訳': '奨励する、促す'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 28,
          '英訳': 'participate',
          '品詞種別': '動詞',
          '和訳': '参加する'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 29,
          '英訳': 'sustainable',
          '品詞種別': '形容詞',
          '和訳': '持続可能な'
        },
        {
          '章番号': 100,
          '問題番号': 1,
          '語彙番号': 30,
          '英訳': 'generation',
          '品詞種別': '名詞',
          '和訳': '世代'
        },
        {
          '章番号': 100,
          '問題番号': 2,
          '語彙番号': 1,
          '英訳': 'dedication',
          '品詞種別': '名詞',
          '和訳': '献身'
        },
        {
          '章番号': 100,
          '問題番号': 2,
          '語彙番号': 2,
          '英訳': 'extra',
          '品詞種別': '形容詞',
          '和訳': '追加の'
        },
        {
          '章番号': 100,
          '問題番号': 2,
          '語彙番号': 3,
          '英訳': 'loyalty',
          '品詞種別': '名詞',
          '和訳': '忠誠'
        },
        {
          '章番号': 100,
          '問題番号': 2,
          '語彙番号': 4,
          '英訳': 'employee',
          '品詞種別': '名詞',
          '和訳': '従業員'
        },
        {
          '章番号': 100,
          '問題番号': 2,
          '語彙番号': 5,
          '英訳': 'struggle',
          '品詞種別': '動詞',
          '和訳': '苦労する'
        },
        {
          '章番号': 100,
          '問題番号': 2,
          '語彙番号': 6,
          '英訳': 'In contrast',
          '品詞種別': '副詞',
          '和訳': '対照的に'
        },
        {
          '章番号': 100,
          '問題番号': 2,
          '語彙番号': 7,
          '英訳': 'interests',
          '品詞種別': '名詞',
          '和訳': '興味'
        },
        {
          '章番号': 100,
          '問題番号': 2,
          '語彙番号': 8,
          '英訳': 'effort',
          '品詞種別': '名詞',
          '和訳': '努力'
        },
        {
          '章番号': 100,
          '問題番号': 2,
          '語彙番号': 9,
          '英訳': 'encourage',
          '品詞種別': '動詞',
          '和訳': '奨励する、促す'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 1,
          '英訳': 'essential',
          '品詞種別': '形容詞',
          '和訳': '不可欠な'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 2,
          '英訳': 'several',
          '品詞種別': '形容詞',
          '和訳': 'いくつかの'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 3,
          '英訳': 'issue',
          '品詞種別': '名詞',
          '和訳': '問題、課題'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 4,
          '英訳': 'addiction',
          '品詞種別': '名詞',
          '和訳': '中毒'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 5,
          '英訳': 'especially',
          '品詞種別': '副詞',
          '和訳': '特に、とりわけ'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 6,
          '英訳': 'affect',
          '品詞種別': '動詞',
          '和訳': '影響を与える'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 7,
          '英訳': 'relationship',
          '品詞種別': '名詞',
          '和訳': '関係、つながり'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 8,
          '英訳': 'excessive',
          '品詞種別': '形容詞',
          '和訳': '過度の、過剰な'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 9,
          '英訳': 'strain',
          '品詞種別': '名詞',
          '和訳': '緊張、負担、ストレス'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 10,
          '英訳': 'disorder',
          '品詞種別': '名詞',
          '和訳': '障害、異常、混乱'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 11,
          '英訳': 'harmful',
          '品詞種別': '形容詞',
          '和訳': '有害な'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 12,
          '英訳': 'properly',
          '品詞種別': '副詞',
          '和訳': '適切に、正しく'
        },
        {
          '章番号': 100,
          '問題番号': 3,
          '語彙番号': 13,
          '英訳': 'solution',
          '品詞種別': '名詞',
          '和訳': '解決策、解決方法'
        },
        {
          '章番号': 100,
          '問題番号': 4,
          '語彙番号': 1,
          '英訳': 'bullying',
          '品詞種別': '名詞',
          '和訳': 'いじめ'
        },
        {
          '章番号': 100,
          '問題番号': 4,
          '語彙番号': 2,
          '英訳': 'serious',
          '品詞種別': '形容詞',
          '和訳': '深刻な'
        },
        {
          '章番号': 100,
          '問題番号': 4,
          '語彙番号': 3,
          '英訳': 'affect',
          '品詞種別': '動詞',
          '和訳': '影響を与える'
        },
        {
          '章番号': 100,
          '問題番号': 4,
          '語彙番号': 4,
          '英訳': 'verbal',
          '品詞種別': '形容詞',
          '和訳': '言葉の、口頭の'
        },
        {
          '章番号': 100,
          '問題番号': 4,
          '語彙番号': 5,
          '英訳': 'victim',
          '品詞種別': '名詞',
          '和訳': '被害者'
        },
        {
          '章番号': 100,
          '問題番号': 4,
          '語彙番号': 6,
          '英訳': 'suffer',
          '品詞種別': '動詞',
          '和訳': '苦しむ'
        },
        {
          '章番号': 100,
          '問題番号': 4,
          '語彙番号': 7,
          '英訳': 'recognize',
          '品詞種別': '動詞',
          '和訳': '認識する、認める'
        },
        {
          '章番号': 100,
          '問題番号': 4,
          '語彙番号': 8,
          '英訳': 'trust',
          '品詞種別': '動詞',
          '和訳': '信頼する'
        },
        {
          '章番号': 100,
          '問題番号': 4,
          '語彙番号': 9,
          '英訳': 'alone',
          '品詞種別': '形容詞',
          '和訳': 'ひとり'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 1,
          '英訳': 'globalization',
          '品詞種別': '名詞',
          '和訳': 'グローバル化'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 2,
          '英訳': 'process',
          '品詞種別': '名詞',
          '和訳': '過程'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 3,
          '英訳': 'through',
          '品詞種別': '前置詞',
          '和訳': '～を通じて、～を通して'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 4,
          '英訳': 'product',
          '品詞種別': '名詞',
          '和訳': '製品、商品'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 5,
          '英訳': 'exchange',
          '品詞種別': '名詞',
          '和訳': '交換、取引'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 6,
          '英訳': 'incredible',
          '品詞種別': '形容詞',
          '和訳': '信じられない、素晴らしい'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 7,
          '英訳': 'benefit',
          '品詞種別': '名詞',
          '和訳': '利益、恩恵'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 8,
          '英訳': 'economic',
          '品詞種別': '形容詞',
          '和訳': '経済的な'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 9,
          '英訳': 'improve',
          '品詞種別': '動詞',
          '和訳': '改善する、向上させる'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 10,
          '英訳': 'ignore',
          '品詞種別': '動詞',
          '和訳': '無視する'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 11,
          '英訳': 'challenge',
          '品詞種別': '名詞',
          '和訳': '挑戦、課題 '
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 12,
          '英訳': 'inequality',
          '品詞種別': '名詞',
          '和訳': '不平等'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 13,
          '英訳': 'issue',
          '品詞種別': '名詞',
          '和訳': '問題'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 14,
          '英訳': 'address',
          '品詞種別': '動詞',
          '和訳': '取り組む、対応する'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 15,
          '英訳': 'for instance',
          '品詞種別': '副詞',
          '和訳': '例えば'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 16,
          '英訳': 'promote',
          '品詞種別': '動詞',
          '和訳': '推進する、促進する'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 17,
          '英訳': 'tradition',
          '品詞種別': '名詞',
          '和訳': '伝統'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 18,
          '英訳': 'despite',
          '品詞種別': '前置詞',
          '和訳': '～にもかかわらず'
        },
        {
          '章番号': 100,
          '問題番号': 5,
          '語彙番号': 19,
          '英訳': 'collaborate',
          '品詞種別': '動詞',
          '和訳': '協力する、共同で作業する'
        },
      ]);
      print('初回データが追加されました');
    } else {
      print('既存のデータがあります');
    }
  } catch (e) {
    print('Error in putting default data: $e');
  }
  late Box box3;
  try {
    // 'titleBox'という名前のボックスを開く
    box3 = await Hive.openBox('titleBox');
  } catch (e) {
    print('Error in opening Hive box3: $e');
    return; // オープンに失敗した場合、処理を終了
  }

  try {
    // 'title'キーにデータが保存されているか確認
    if (!box3.containsKey('title')) {
      // 初回データを追加
      await box3.put('title', [
        {'章番号': 1, '章題': '第一文型'},
        {'章番号': 2, '章題': '第ニ文型'},
        {'章番号': 3, '章題': '第三文型'},
        {'章番号': 4, '章題': '第四文型'},
        {'章番号': 5, '章題': '第五文型'},
        {'章番号': 6, '章題': '不定詞名詞的用法'},
        {'章番号': 7, '章題': '不定詞形容詞的用法'},
        {'章番号': 8, '章題': '不定詞副詞的用法'},
        {'章番号': 9, '章題': '不定詞形式主語構文'},
        {'章番号': 10, '章題': '動名詞'},
        {'章番号': 11, '章題': '現在分詞'},
        {'章番号': 12, '章題': '過去分詞'},
        {'章番号': 13, '章題': '分詞構文'},
        {'章番号': 14, '章題': '付帯状況with'},
        {'章番号': 15, '章題': '接続詞that'},
      ]);
      print('初回titleデータが追加されました');
    } else {
      print('既存titleのデータがあります');
    }
  } catch (e) {
    print('Error in putting default data: $e');
  }
  late Box box4;
  try {
    // 'longsentenceBox'という名前のボックスを開く
    box4 = await Hive.openBox('longsentenceBox');
  } catch (e) {
    print('Error in opening Hive box4: $e');
  }
  try {
    // デフォルトデータを追加するかどうか
    if (box4.isEmpty) {
      await box4.put('longsentence', [
        {
          '問題番号': 1,
          '長文': 'Environmental issues are becoming increasingly critical as our planet faces various challenges. One of the most pressing problems is climate change, which is largely caused by human activities, such as burning fossil fuels and deforestation. These actions release greenhouse gases into the atmosphere, leading to rising temperatures and severe weather events.\n'
              'Another significant concern is pollution. Air, water, and soil pollution affect not only wildlife but also human health. For example, dirty water can lead to diseases, while air pollution can cause health problems like coughing and breathing difficulties. To combat these issues, individuals and governments must take action.\n'
              'Recycling and using renewable energy sources, like solar and wind power, are essential steps. Additionally, raising awareness about environmental conservation can encourage more people to participate in protecting our planet. By working together, we can create a sustainable future for generations to come.\n',
          '構文': '第一段落\n'
              '(S) Environmental issues / (V) are becoming / < increasingly > / (C) critical / < as (S) our planet / (V) faces / (O) various challenges. > (S) One of the most pressing problems / (V) is / (C) climate change , ( which / (V) is / < largely > / (C) caused / < by human activities > < such as burning fossil fuels and deforestation. >)(S) These actions / (V) release / (O) greenhouse gases / < into the atmosphere >,< leading / (O) to rising temperatures and severe weather events. >\n'
              '第ニ段落\n'
              '(S) Another significant concern / (V) is / (C) pollution. (S) Air, water, and soil pollution / (V) affect / (O) not only wildlife but also human health. < For example >, / (S) dirty water / (V) can lead / < to diseases ,> < while (S) air pollution / (V) can cause / (O) health problems >< like coughing and breathing difficulties. >< To combat these issues >, / (S) individuals and governments / (V) must take / (O) action. \n'
              '第三段落\n'
              '(S) Recycling and using renewable energy sources / (V) are / (C) essential steps < like solar and wind power. > < Additionally >, / (S) raising awareness about environmental conservation / (V) can encourage / (O) more people < to participate in protecting our planet. >< By working together >, / (S) we / (V) can create / (O) a sustainable future / < for generations to come. >\n',
          '訳': '第一段落\n'
              '環境問題は、私たちの地球がさまざまな課題に直面する中で、ますます重要になっています。最も緊急の問題の一つは気候変動であり、これは主に化石燃料の燃焼や森林伐採などの人間の活動によって引き起こされています。これらの行動は温室効果ガスを大気中に放出し、気温の上昇や深刻な気象現象につながっています。\n'
              '第ニ段落\n'
              'もう一つの重要な懸念は汚染です。大気、水、土壌の汚染は野生生物だけでなく、人間の健康にも影響を与えます。たとえば、汚れた水は病気を引き起こし、大気汚染はせきや呼吸の問題を引き起こす可能性があります。これらの問題に対処するために、個人と政府が行動を起こす必要があります。\n'
              '第三段落\n'
              'リサイクリングや太陽光発電や風力発電などの再生可能エネルギー源の使用は重要なステップです。また、環境保護に関する意識を高めることで、より多くの人々が地球を守ることへの参加を促すことができます。協力することで、私たちは将来の世代のために持続可能な未来を築くことができます。\n',
          '解説': '第一段落\n'
              'which: 関係代名詞の非制限用法。前の名詞「climate change」を修飾\n'
              'leading to rising temperatures and severe weather events：分詞構文で副詞節、結果（気温の上昇と激しい天候）が述べられている。\n'
              '第ニ段落\n'
              'To combat these issues: 不定詞の副詞句。「これらの問題に対処するために」\n'
              'Recycling and using renewable energy sources: 動名詞で主語。「リサイクルと再生可能エネルギー源の使用」\n'
              '第三段落\n'
              'encourage more people to participate in protecting our planet: encourage O to doの構文「より多くの人々が地球を守ることへの参加を促す」\n'
              'By working together: 前置詞 + 動名詞の副詞句。「共に働くことで」\n'
        },
        {
          '問題番号': 2,
          '長文': 'In Japan, working long hours is seen as a way to show dedication. Many people work overtime, and some even stay late without extra pay. To be successful in a Japanese company, showing loyalty by working hard is often important. However, this lifestyle can cause stress, and some employees may struggle to find a balance between work and personal life.\n'
              'In contrast, Americans tend to value their time outside work, often focusing on family, hobbies, or personal interests. In the United States, it is common for people to leave the office as soon as their shift ends, which allows them to relax and recharge. To keep their employees motivated, American companies are more likely to offer flexible schedules and paid vacations.\n'
              'Recently, Japan has been making efforts to reduce overwork, with some companies encouraging employees to leave on time. By doing this, Japan hopes to improve work-life balance and create a healthier work environment for its employees.\n',
          '構文': '第一段落\n'
              '< In Japan, > / (S) working long hours / (V) is seen / (C) as a way ( to show dedication. ) (S) Many people / (V) work < overtime, >  and / (S) some / (V) even stay < late > < without extra pay >. < To be successful in a Japanese company, >  (S) showing loyalty < by working hard > / (V) is < often > / (C) important.< However, >  (S) this lifestyle / (V) can cause / (O) stress, /  and / (S) some employees / (V) may struggle / (O)  to find  a balance  < between work and personal life.>\n'
              '第ニ段落\n'
              '< In contrast, > (S) Americans / (V) tend / (O)  to value  their time outside work, /  < often focusing  on family,hobbies, or personal interests. > / <In the United States, > / (S) it / (V) is / (C) common [ for people to leave the office < as soon as their shift ends,>] / ( which / (V) allows / (O) them /  to relax and recharge.)< To keep their employees motivated, >/ (S) American companies / (V) are more likely to offer / (O) flexible schedules and paid vacations.\n'
              '第三段落\n'
              '< Recently, > (S) Japan / (V) has been making / (O) efforts ( to reduce  overwork,) < with some companies  encouraging  employees <  to leave  on time. >><By doing this, > (S) Japan / (V) hopes / (O) to improve  work-life balance /  and /  (V) create / (O) a healthier work environment < for its employees. >\n',
          '訳': '第一段落\n'
              '日本では、長時間働くことが献身を示す方法と見なされています。多くの人が残業をし、中には追加の給与なしで遅くまで残る人もいます。日本の会社で成功するためには、懸命に働くことで忠誠心を示すことが重要とされることがよくあります。しかし、このような生活はストレスを引き起こし、仕事と私生活のバランスを見つけるのに苦労する社員もいるかもしれません\n'
              '第ニ段落\n'
              '一方、アメリカ人は仕事以外の時間を大切にし、家族や趣味、個人的な興味に焦点を当てることが多いです。アメリカでは、勤務時間が終わるとすぐにオフィスを離れることが一般的で、それによりリラックスして英気を養うことができます。アメリカの会社は社員のやる気を維持するために、柔軟な勤務時間や有給休暇を提供することが多いです。\n'
              '第三段落\n'
              '最近、日本では過労を減らすための取り組みが行われており、いくつかの会社は社員に定時退社を奨励しています。このようにすることで、日本は仕事と生活のバランスを改善し、社員にとってより健康的な職場環境を作りたいと考えています。\n',
          '解説': '第一段落\n'
              'working long hours (動名詞句: 主語)\n'
              'to show dedication (不定詞句: 形容詞的用法)\n'
              'to be successful in a Japanese company (不定詞句: 副詞的用法)\n'
              'struggle to find：struggle to doの構文「見つけるのに苦労する」\n'
              '第ニ段落\n'
              'tend to value：tend to doの構文「重視する傾向がある」\n'
              'often focusing on family, hobbies, or personal interests：分詞構文で副詞節 追加情報の提供\n'
              'for people to leave the office：形式主語構文で真主語(Itが仮主語)\n'
              ', which：関係代名詞非制限用法 前の文全体を補足している\n'
              'allows them to relax and recharge：allow O to doの構文「彼らがリラックスして英気を養うことを許す（直訳）」\n'
              'To keep their employees motivated (不定詞: 副詞的用法)\n'
              'with some companies encouraging employees to leave on time.：付帯状況のwithの分詞　副詞句 with S doing 「いくつかの企業は従業員に定時で帰ることを奨励している。」\n'
              '第三段落\n'
              'By doing this : 前置詞 + 動名詞の副詞句。「こうすることによって」\n'
        },
        {
          '問題番号': 3,
          '長文': 'Smartphones have become an essential part of our daily lives, but they also bring several problems. One of the biggest issues is addiction. Many people, especially young adults, spend too much time on their phones, which can affect their studies, work, and even personal relationships. There are also health problems that come with excessive smartphone use, such as eye strain, poor posture, and sleep disorders. It is important that people find a balance between using their phones and other activities.\n'
              'It is clear that smartphones can be very useful tools, but they can also be harmful if not used properly. The problem is that many people find it difficult to stop using their phones, even when they know it’s bad for them. A solution to this issue is setting limits on screen time and taking regular breaks. This will help reduce the negative effects that smartphones have on our health and well-being.\n',
          '構文': '第一段落\n'
              '(S)Smartphones / (V) have become /  (O) an essential part of our daily lives, / but / (S) they / <also> (V) bring / (O) several problems. / (S) One of the biggest issues / (V) is / (O) addiction. (S) Many people, / (especially young adults,) / (V) spend / <too  much> / (O) time / <on their phones,> /( which / (V) can affect / (O) their studies, work, and even personal relationships. / There / (V) are / <also> (S) health problems / ( that / (V) come with / excessive smartphone use,)  / (such as eye strain, poor posture, and sleep disorders.) / (S) It / (V) is /(C) important / [ that /(S)  people / (V) find / (O) a balance / <between using their phones / and / other activities.>]\n'
              '第ニ段落\n'
              '(S) It / (V) is / (C) clear / [ that / (S) smartphones / (V) can be / <very> (C) useful / tools,] / but / (S) they / (V) can <also> be /  (C) harmful / <if / (V) not used <properly.>> / (S) The problem / (V) is / [that / (S) many people / (V) find / (O) it / (C) difficult / [to stop using their phones,]] / <even when (S) they / (V) know / [(S) (V) it’s / (C) bad <for them.>]> (S) A solution to this issue / (V) is / (C) setting  limits <on screen time> / and / (C) taking regular breaks. (S) This / (V) will help / (O) reduce the negative effects / ( that / (S) smartphones /  (V) have / <on our health / and well-being.>)\n',
          '訳': '第一段落\n'
              'スマートフォンは私たちの日常生活に欠かせないものとなっていますが、同時にいくつかの問題ももたらしています。その中でも最も大きな問題のひとつは中毒です。多くの人、特に若者はスマートフォンに多くの時間を費やしすぎており、それが学業や仕事、さらには人間関係にまで影響を及ぼすことがあります。また、スマートフォンの過度な使用には目の疲れ、姿勢の悪化、睡眠障害といった健康問題も伴います。人々がスマートフォンの使用と他の活動の間でバランスを見つけることが重要です。\n'
              '第ニ段落\n'
              'スマートフォンが非常に便利なツールであることは明らかですが、適切に使用しなければ有害にもなり得ます。問題は、多くの人がそれが悪影響を及ぼすと知っていても、スマートフォンを使用するのをやめられないことです。この問題の解決策としては、画面を見る時間に制限を設け、定期的に休憩を取ることが挙げられます。これにより、スマートフォンが健康や幸福に与える悪影響を軽減することができます。\n',
          '解説': '第一段落\n'
              '挿入 especially young adultsで many peopleを詳しく説明\n'
              'which: 関係代名詞の非制限用法。「多くの人がスマホに時間を費やす」という文全体を受けて、それが「影響を及ぼす」ことを示す。\n'
              '関係代名詞: thatはhealth problems" を修飾\n'
              'sIt is important that 形式主語構文 itが形式主語でthat～activitiesが新主語 that～が重要だ。\n'
              '第ニ段落\n'
              'It is clear that 形式主語構文 itが形式主語でthat～ toolsが新主語 that～が明らかだ。\n'
              'if not used properly"は省略構文（主語と動詞they areの省略)\n'
              'The problem is that～は接続詞that\n'
              'it形式目的語: find it difficult to～の it は形式目的語で、後続の to stop using their phones を指している。\n'
              'A solution to this issue is setting limits on screen time and taking   settingは動名詞でandは同じ動名詞 takingと二つの動名詞句を接続\n'
              'the negative effects that smartphones have～ 関係代名詞: that は negative effectsを修飾\n'
        },
        {
          '問題番号': 4,
          '長文': 'Bullying is a serious problem that affects many students around the world. What makes bullying even worse is that it often happens in schools, where children should feel safe. There are many forms of bullying, such as physical, verbal, and online bullying. It is important to understand that it is not only the victim who suffers, but also the bully. In many cases, bullies may have problems at home or have been bullied themselves.\n'
              'There are several ways to deal with bullying. First, schools must create an environment where students find it easy to speak out. Teachers and parents should also work together to recognize signs of bullying. One of the best ways to stop bullying is for everyone to take action. For example, when a student sees someone being bullied, they should report it to a teacher or a trusted adult. Those who are bullied must know they are not alone, and support can make a big difference.\n',
          '構文': '第一段落\n'
              '(S)Bullying  / (V) is / (C) a serious problem ( that / (V) affects / (O) many students <around the world.>) [What / (V) makes / (O) bullying / (C) even worse] / (V) is / [(C)that / (S) it <often> /  (V) happens <in schools>(, where / (S) children  / (V) should feel / (C) safe.) There / (V) are / (S) many forms <of bullying>,( such as physical, verbal, and online bullying.) (S) It / (V) is / (C) important [to understand [that / (S) it / (V) is not only / (C) the victim (who / (V) suffers,) but also / (C) the bully.] <In many cases,> (S) bullies / (V) may have / (O) problems <at home> or  / (V) have been bullied <themselves.>\n'
              '第ニ段落\n'
              'There / (V) are / (S) several ways (to deal with bullying.) <First,> / (S) schools / (V) must create / (O) an environment (where / (S) students / (V) find / (O) it / (C) easy [to speak out]) (S)Teachers and parents / (V) should also work <together>< to recognize signs of bullying.> (S)One of the best ways to stop bullying / (V) is [(C) for everyone to take action.] <For example,>< when / (S) a student / (V) sees / (O) someone (being bullied),> / (S) they / (V) should report / (O) it <to a teacher or a trusted adult.> (S)Those (who / (V) are bullied) / (V) must know (O)[(S)they / (V) are not / (C) alone, and / (S) support / (V) can make / (O) a big difference.\n',
          '訳': '第一段落\n'
              'いじめは世界中の多くの学生に影響を与える深刻な問題です。いじめをさらに悪化させるのは、それがしばしば学校で起こることであり、学校は子どもたちが安全に感じるべき場所であるべきだという点です。いじめには、身体的、言葉による、そしてオンラインでのいじめなど、さまざまな形態があります。重要なのは、いじめの被害者だけでなく、加害者もまた苦しんでいるということです。多くの場合、いじめっ子は家庭に問題を抱えていたり、過去にいじめを受けたことがある場合があります。\n'
              '第ニ段落\n'
              'いじめに対処する方法はいくつかあります。まず、学校は、生徒たちが発言しやすい環境を作らなければならないです。教師や保護者は、いじめの兆候を認識するために協力するべきです。いじめを止めるための最良の方法の一つは、皆が行動を起こすことです。例えば、生徒が誰かがいじめられているのを見たときには、それを教師や信頼できる大人に報告すべきです。いじめられている人は、自分が一人ではないことを知る必要があり、支援が大きな違いを生むことがあります。\n',
          '解説': '第一段落\n'
              'that affects many students around the world: 「that」は関係代名詞で、「problem」を修飾\n'
              'What makes bullying even worse: 疑問詞の名詞節で、主語(S)の役割\n'
              'that it often happens in schools: 「that」は名詞節を導く接続詞で補語(C)の役割\n'
              'where children should feel safe: 「where」は関係副詞で、前述の「schools」を修飾\n'
              'It is important to understand that: Itが形式主語でto understand thatは真主語、「that」は名詞節を導く接続詞でto understandの目的語(O)\n'
              'the victim who suffers: 「who」は関係代名詞で、「victim」を修飾\n'
              '「not only...but also...」の形で「victim」と「bully」を対比\n'
              '第ニ段落\n'
              'ways to deal with bullying.: 形容詞の不定詞句としてwaysを修飾\n'
              'an environment where students find it easy to speak out: 「where」は関係副詞で、「environment」を修飾、「it」は形式目的語で、実際には「to speak out」を指す\n'
              'together to recognize signs of bullying.: 副詞の不定詞句\n'
              'ways to stop bullying: 形容詞の不定詞で「ways」を修飾\n'
              'when a student sees someone being bullied: 「when」は時を示す従属接続詞、being bulliedは現在分詞の受動態でsomeoneを修飾\n'
              'Those who are bullied:「who」は関係代名詞で、「Those」を修飾\n'
        },
        {
          '問題番号': 5,
          '長文': 'Globalization is a process that connects people and countries across the world. It is through globalization that people can share ideas, products, and cultures more easily. This exchange has led to incredible benefits, such as economic growth and improved communication. However, we must not ignore the challenges that globalization brings, such as the loss of local cultures and increased inequality between nations.\n'
              'Believing that these issues need to be addressed, people around the world are working to create a more balanced form of globalization. For instance, promoting fair trade and cultural exchange can help protect local traditions while supporting global connections. The idea that globalization can unite people despite their differences is an important goal for the future. By respecting each other’s cultures and collaborating globally, we can make the world a better place for everyone.\n',
          '構文': '第一段落\n'
              '(S)Globalization / (V) is / (C) a process (that (V) connects  / (O) people and countries <across the world.>) It is / <through globalization> / that / (S) people / (V) can share / (O) ideas, products, and cultures <more easily. >/ (S) This exchange  / (V) has led to / (O) incredible benefits, (such as economic growth and improved communication.) However, / (S) we / (V) must not ignore / (O) the challenges (that / (S) globalization / (V) brings, (such as the loss of local cultures and increased inequality between nations.)\n'
              '第ニ段落\n'
              '<Believing (that / (S) these issues / (V) need to be addressed,>  / (S) people <around the world>) / (V) are working <to create a more balanced form of globalization.>< For instance,> / (S) promoting fair trade and cultural exchange  / (V) can help / (O) protect local traditions <while supporting global connections.>  / (S)The idea (that / (S) globalization / (V) can / (O) unite people <despite their differences>) / (V) is / (C) an important goal <for the future.> <By respecting each other’s cultures and collaborating globally,> / (S) we / (V) can make / (O) the world / (C) a better place <for everyone.>\n',
          '訳': '第一段落\n'
              'グローバル化は、人々や国々を世界中で結びつけるプロセスです。私たちがアイデア、製品、文化をより簡単に共有できるのは、グローバル化のおかげです。この交流は、経済成長やコミュニケーションの向上といった大きな利益をもたらしました。しかし、グローバル化がもたらす課題、例えば地域文化の喪失や国間の不平等の増加を無視してはなりません。\n'
              '第ニ段落\n'
              'これらの問題に対処する必要があると信じて、世界中の人々がよりバランスの取れたグローバル化を目指して取り組んでいます。例えば、公平貿易や文化交流を推進することで、地域の伝統を守りながらグローバルなつながりを支えることができます。グローバル化が違いを超えて人々を結びつけるという考えは、未来において重要な目標です。お互いの文化を尊重し、世界的に協力することで、すべての人にとってより良い世界を築くことができるでしょう。\n',
          '解説': '第一段落\n'
              'that connects people and countries across the world:関係代名詞 that による形容詞節（process を修飾）\n'
              'It is through globalization that:副詞句through globalizationを強調する強調構文\n'
              'the challenges that globalization brings: challenges を修飾する関係代名詞 that \n'
              'such asは形容詞句でchallenges を修飾\n'
              '第ニ段落\n'
              'Believing that...: 分詞構文で副詞句を形成、Believing thatは接続詞のthat\n'
              'promoting fair trade and cultural exchange: 動名詞句で主語(S)\n'
              'whileの主語は主節と同じpromoting fair trade and cultural exchangeで省略されている\n'
              'The idea that:that 以下は同格の that 節で形容詞節でThe ideaを修飾、同格のthat内は完全文\n'
              'By respecting... and collaborating globally: 前置詞 byと動名詞で副詞句\n'
        }
      ]);
      print('初回データが追加されました');
    } else {
      print('既存のデータがあります');
    }
  } catch (e) {
    print('Error in putting default data: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      Hive.close(); // アプリ終了時にHiveを閉じる
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Hive.close(); // 念のためdisposeでもHiveを閉じる
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // 初期ルートを設定
      routes: {
        '/': (context) => Top(
              navigation: (String routeName, Map<String, dynamic> args) {
                Navigator.pushNamed(context, routeName, arguments: args);
              },
            ),
        '/question': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          final questionId = args != null && args.containsKey('questionId')
              ? args['questionId']
              : 'defaultQuestionId'; // デフォルトのIDを設定

          final englishSentence =
              args != null && args.containsKey('englishSentence')
                  ? args['englishSentence']
                  : 'defaultEnglishSentence'; // デフォルトの英訳を設定

          final chapterNumber =
              args != null && args.containsKey('chapterNumber')
                  ? args['chapterNumber']
                  : 1; // デフォルトの章番号を設定

          final questionNumber =
              args != null && args.containsKey('questionNumber')
                  ? args['questionNumber']
                  : 1; // デフォルトの問題番号を設定

          return QuestionScreen(
            questionId: questionId,
            englishSentence: englishSentence, // englishSentenceを渡す
            navigation: (String routeName, Map<String, dynamic> args) {
              Navigator.pushNamed(context, routeName, arguments: args);
            }, // navigation引数を渡す
            chapterNumber: chapterNumber, // 章番号を渡す
            questionNumber: questionNumber, // 問題番号を渡す
          );
        },
        '/answer': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          final chapterNumber =
              args != null && args.containsKey('chapterNumber')
                  ? args['chapterNumber']
                  : 1; // デフォルトの章番号を設定

          final questionNumber =
              args != null && args.containsKey('questionNumber')
                  ? args['questionNumber']
                  : 1; // デフォルトの問題番号を設定

          return AnswerScreen(
            chapterNumber: chapterNumber,
            questionNumber: questionNumber,
          );
        },
        '/LSquestion': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          final questionId = args != null && args.containsKey('questionId')
              ? args['questionId']
              : 'defaultQuestionId'; // デフォルトのIDを設定

          final questionNumber =
              args != null && args.containsKey('questionNumber')
                  ? args['questionNumber']
                  : 1; // デフォルトの問題番号を設定

          return LSQuestionScreen(
            questionId: questionId,
            navigation: (String routeName, Map<String, dynamic> args) {
              Navigator.pushNamed(context, routeName, arguments: args);
            }, // navigation引数を渡す
            questionNumber: questionNumber, // 問題番号を渡す
          );
        },
        '/LSanswer': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          final questionId = args != null && args.containsKey('questionId')
              ? args['questionId']
              : 'defaultQuestionId'; // デフォルトのIDを設定

          final questionNumber =
              args != null && args.containsKey('questionNumber')
                  ? args['questionNumber']
                  : 1; // デフォルトの問題番号を設定

          return LSAnswerScreen(
            questionId: questionId,
            navigation: (String routeName, Map<String, dynamic> args) {
              Navigator.pushNamed(context, routeName, arguments: args);
            }, // navigation引数を渡す
            questionNumber: questionNumber, // 問題番号を渡す
          );
        },
        '/start': (context) {
          return StartScreen(
            // クラス名をStartScreenに変更
            navigation: (String routeName, Map<String, dynamic> args) {
              Navigator.pushNamed(context, routeName, arguments: args);
            }, // navigation引数を渡す
          );
        },
        '/Randomques': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          final filteredQuestions =
              args != null && args.containsKey('filteredQuestions')
                  ? args['filteredQuestions']
                  : 1; // デフォルトの問題番号を設定
          final i = args != null && args.containsKey('i') ? args['i'] : 1;
          return RandomquesScreen(
            // クラス名をStartScreenに変更
            filteredQuestions: filteredQuestions, // 必須パラメータを渡す
            i: i,
            navigation: (String routeName, Map<String, dynamic> args) {
              Navigator.pushNamed(context, routeName, arguments: args);
            }, // navigation引数を渡す
          );
        },
        '/Randomans': (context) {
          final args = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;
          final filteredQuestions =
              args != null && args.containsKey('filteredQuestions')
                  ? args['filteredQuestions']
                  : 1; // デフォルトの問題番号を設定
          final i = args != null && args.containsKey('i') ? args['i'] : 1;
          return RandomansScreen(
            // クラス名をStartScreenに変更
            filteredQuestions: filteredQuestions, // 必須パラメータを渡す
            i: i,
            navigation: (String routeName, Map<String, dynamic> args) {
              Navigator.pushNamed(context, routeName, arguments: args);
            }, // navigation引数を渡す
          );
        },
        '/top': (context) => Top(
              // Topへのルートを追加
              navigation: (String routeName, Map<String, dynamic> args) {
                Navigator.pushNamed(context, routeName, arguments: args);
              },
            ),
      },
    );
  }
}
