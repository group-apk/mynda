import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:map_proj/new_api/test_api.dart';
import 'package:map_proj/new_model/test_model.dart';
import 'package:map_proj/new_notifier/test_notifier.dart';
import 'package:provider/provider.dart';

class QuestionPlay extends StatefulWidget {
  const QuestionPlay({Key? key, required this.testName}) : super(key: key);
  final String testName;
  
  @override
  State<QuestionPlay> createState() => _QuestionPlay();
}
int optionmarks = {0,1,2,3} as int;
int totalcollected = 0;
int totalMax=0;
bool answerTap =false;


class _QuestionPlay extends State<QuestionPlay> {
  final _formKey = GlobalKey<FormState>();

  late int optionSelected;

  
  @override
  Widget build(BuildContext context) {
    TestNotifier testNotifier =
        Provider.of<TestNotifier>(context, listen: false);
    TestModel _currentTestModel = testNotifier.currentTestModel;
    final testNameEditingController =
        TextEditingController(text: _currentTestModel.quizTitle);

    // int questionLength = 0;
    // _currentTestModel.questions?.forEach((element) { 
    //   questionLength++;
    // });

    Widget questionField(TestModel _currentTestModel) {
      return FutureBuilder(
      future: getQuestionFuture(_currentTestModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
          itemCount: _currentTestModel.questions?.length ?? 0,
          itemBuilder: ((context, i) => SizedBox(
            width:400,
            child: ListTile(
                  title: Text(
                    '\nQ${i + 1} ${_currentTestModel.questions![i].question}\n',
                    style:
                    TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.8)),
                    
                    ),
                  subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                          _currentTestModel.questions![i].option!
                              .map((e) => 
                              GestureDetector(
                                
                                onTap:(){
                                    setState(() {
                                      answerTap=true;
                                    //optionSelected = answer[i];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(border:Border.all(
                                    color: !answerTap 
                                      ? Color.fromARGB(255, 1, 255, 115)
                                      :  Color.fromARGB(255, 4, 90, 160),
                                    width: 2, 
                                  ),
                                  borderRadius: const BorderRadius.all(Radius.circular(12))
                                  ),
                                  width:300,
                                  height: 50,
                                  padding: const EdgeInsets.all(10),
                                  child: 
                                    Text(e,
                                      textAlign: TextAlign.center,
                                      style:  TextStyle(fontSize: 20,color: Colors.black.withOpacity(1)),
                                    ),
                                ),
                              ),
                              ) 
                              .toList()
                    ),
                              
                ),
          )
              ),
        );
      },
    );
  }

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 27, 183, 255),
            child: const Icon(Icons.done),
            onPressed: () {

            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${widget.testName} Test"),
        titleTextStyle: const TextStyle(
            color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold),
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0069FE),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 5),
                    questionField(_currentTestModel),
                   
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
