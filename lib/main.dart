import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator2',
      home: RandomWords(),
    );
  }
}

// Stateful Widget は State クラスの作成が主な作業
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

// State<RandomWords> は RandomWords で使うことを指定している
class RandomWordsState extends State<RandomWords> {
  final List<WordPair> _suggestions = <WordPair>[];
  // 保存した単語の組み合わせ
  final Set<WordPair> _saved = Set<prefix0.WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18);
  @override                                  // Add from this line ...
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator3'),
        actions: <Widget>[      // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }                                          // ... to this line.

  void _pushSaved() {
    // Route の構築、ナビゲーターのスタックに Route が push される
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
              (WordPair pair) {
                return ListTile(
                  title: Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
          );
          final List<Widget> divided = ListTile
            .divideTiles(
              tiles: tiles,
              context: context,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },  // builder
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          // 奇数行は「仕切りウィジェット」
          // 高さは1pxの仕切り
          if (i.isOdd) {
            return Divider();
          }
          // i ~/ 2 : 2 で除算した商
          // 例) 1, 2, 3, 4, 5 => 0, 1, 1, 2, 2
          // 実際の単語のペアリングを表している
          // ListView の仕切りウィジェットを差し引いている
          final int index = i ~/ 2;
          // もし最後の index まで到達したら
          if (index >= _suggestions.length) {
            // 候補を追加する
            _suggestions.addAll(prefix0.generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    // すでに保存されている単語の組み合わせかどうかを確認するために、最初に呼び出し
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
