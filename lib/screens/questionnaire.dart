import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final PageController _pc = PageController();
  int _page = 0;
  Map<String, dynamic> answers = {};

  final List<Map<String, Object>> questions = [
    {'key': 'sleep', 'text': 'Are you an early riser or night owl?', 'options': ['Early', 'Night', 'Flexible']},
    {'key': 'clean', 'text': 'How tidy are you?', 'options': ['Very tidy', 'Somewhat tidy', 'Not tidy']},
    {'key': 'guests', 'text': 'Do you often have guests over?', 'options': ['Often', 'Sometimes', 'Rarely']},
    {'key': 'smoke', 'text': 'Do you smoke or vape?', 'options': ['No', 'Occasionally', 'Yes']},
    {'key': 'study', 'text': 'Are you mostly studying at home or outside?', 'options': ['At home', 'Outside', 'Both']},
  ];

  void _next() {
    if (_page < questions.length - 1) {
      _pc.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      final app = Provider.of<AppState>(context, listen: false);
      final user = app.user;
      if (user != null) {
        user.studentAnswers.addAll(answers);
        app.setUser(user);
      }
      // Clear navigation stack and go to home so back won't return to questionnaire
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Roommate compatibility')),
      body: Column(
        children: [
          LinearProgressIndicator(value: (_page + 1) / questions.length, minHeight: 6),
          Expanded(
            child: PageView.builder(
              controller: _pc,
              onPageChanged: (i) => setState(() => _page = i),
              itemCount: questions.length,
              itemBuilder: (_, i) {
                final q = questions[i];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(q['text'] as String, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      ...List.generate((q['options'] as List<String>).length, (idx) {
                        final opt = (q['options'] as List<String>)[idx];
                        final selected = answers[q['key']] == opt;
                        return Card(
                          color: selected ? Theme.of(context).primaryColor.withOpacity(0.12) : null,
                          child: ListTile(
                            title: Text(opt),
                            trailing: selected ? Icon(Icons.check, color: Theme.of(context).primaryColor) : null,
                            onTap: () => setState(() => answers[q['key'] as String] = opt),
                          ),
                        );
                      }),
                      SizedBox(height: 24),
                      ElevatedButton(onPressed: answers.containsKey(q['key']) ? _next : null, child: Text(i == questions.length - 1 ? 'Finish' : 'Next'))
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
