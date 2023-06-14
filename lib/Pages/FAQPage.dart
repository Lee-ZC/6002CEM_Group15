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
            question: 'How do I create an account?',
            answer: 'To create an account, simply click on the Sign Up button in the onBoarding and follow the prompts to provide your details',
          ),
          FAQItem(
            question: 'How can I contact customer support?',
            answer: 'You can reach our customer support team by clicking on the "Customer Support" section in the app. We provide multiple channels for communication, including live chat and phone support.',
          ),
          FAQItem(
            question: 'How do I book a trip?',
            answer: 'To book a trip, navigate to the appropriate section in the app (such as home page). Enter your travel details, including name, phone number and dates. Follow the prompts to complete the booking process.',
          ),
          FAQItem(
            question: 'Are there any loyalty programs or rewards?',
            answer: 'Some travel applications offer loyalty programs or partnerships with airlines, hotels, or other travel providers. Due to time constraint, in our application there is NO loyalty programs and rewards',
          ),
          FAQItem(
            question: 'How do I cancel my booking?',
            answer: 'If you need to cancel your booking, please go to the Customer Support section in the app and contact us, then our agent will assist you ',
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
