import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView(
        children: [
          FAQItem(
            question: 'Question 1',
            answer: 'Answer 1',
          ),
          FAQItem(
            question: 'Question 2',
            answer: 'Answer 2',
          ),
          FAQItem(
            question: 'Question 3',
            answer: 'Answer 3',
          ),
          FAQItem(
            question: 'Question 4',
            answer: 'Answer 4',
          ),
          FAQItem(
            question: 'Question 5',
            answer: 'Answer 5',
          ),
          // Add more FAQ items as needed
        ],
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(widget.answer),
          ),
        ],
        onExpansionChanged: (value) {
          setState(() {
            _expanded = value;
          });
        },
        initiallyExpanded: _expanded,
      ),
    );
  }
}
