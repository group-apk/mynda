// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mynda/provider/test_notifier.dart';
import 'package:mynda/services/api.dart';
import 'package:mynda/view/test/quiz_play2.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int i = 0;
  @override
  void initState() {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    getTest(testNotifier);
    super.initState();
  }

  int checkTestName(String name) {
    int index = 0;
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    for (int i = 0; i < testNotifier.testList.length; i++) {
      if (name == testNotifier.testList[i].quizTitle) {
        index = i;
      }
    }
    return index;
  }

  List<String> getQuizList() {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    List<String> quizList = [];
    for (int i = 0; i < testNotifier.testList.length; i++) {
      quizList.add(testNotifier.testList[i].quizTitle.toString());
    }
    return quizList;
  }

  @override
  Widget build(BuildContext context) {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    var testProvider = context.read<TestNotifier>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Mental Health Assessment'),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(getQuizList()));
              },
              icon: const Icon(Icons.search),
              color: Colors.blue)
        ],
      ),
      body: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: FutureBuilder(
            future: getTestFuture(testProvider),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              return Consumer<TestNotifier>(
                builder: (context, value, child) => GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: testProvider.testList
                      .map((e) => GestureDetector(
                            onTap: () {
                              testNotifier.currentTestModel = testNotifier
                                  .testList[checkTestName('${e.quizTitle}')];
                              // getQuestion(testNotifier.currentTestModel);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuestionPlay(
                                          testName: '${e.quizTitle}')));
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      '${e.quizImgurl}',
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${e.quizTitle}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [];
  CustomSearchDelegate(this.searchTerms);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var quiz in searchTerms) {
      if (quiz.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(quiz);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            query = result;
            TestNotifier testNotifier =
                Provider.of<TestNotifier>(context, listen: false);
            testNotifier.currentTestModel =
                testNotifier.testList[searchTerms.indexOf(query)];
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionPlay(testName: query)));
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var quiz in searchTerms) {
      if (quiz.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(quiz);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            query = result;
            TestNotifier testNotifier =
                Provider.of<TestNotifier>(context, listen: false);
            testNotifier.currentTestModel =
                testNotifier.testList[searchTerms.indexOf(query)];
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuestionPlay(testName: query)));
            // showResults(context);
          },
        );
      },
    );
  }
}
