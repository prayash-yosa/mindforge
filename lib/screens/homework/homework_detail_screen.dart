import 'package:flutter/material.dart';
import 'package:mindforge_app/data/models/homework.dart';
import 'package:mindforge_app/screens/homework/ai_help_screen.dart';
import 'package:mindforge_app/widgets/premium_app_bar.dart';

class HomeworkDetailScreen extends StatefulWidget {
  final Homework homework;

  const HomeworkDetailScreen({super.key, required this.homework});

  @override
  State<HomeworkDetailScreen> createState() => _HomeworkDetailScreenState();
}

class _HomeworkDetailScreenState extends State<HomeworkDetailScreen> {
  // Mock questions data
  final List<HomeworkQuestion> _questions = [
    HomeworkQuestion(
      id: '1',
      homeworkId: 'hw1',
      questionText: 'Solve the quadratic equation: x² - 5x + 6 = 0',
      questionType: 'text',
    ),
    HomeworkQuestion(
      id: '2',
      homeworkId: 'hw1',
      questionText:
          'Find the roots of: 2x² + 5x - 3 = 0 using the quadratic formula',
      questionType: 'text',
    ),
    HomeworkQuestion(
      id: '3',
      homeworkId: 'hw1',
      questionText: 'What is the value of discriminant in x² - 4x + 4 = 0?',
      questionType: 'mcq',
      options: ['0', '4', '8', '16'],
      studentAnswer: '0',
    ),
    HomeworkQuestion(
      id: '4',
      homeworkId: 'hw1',
      questionText:
          'True or False: A quadratic equation always has two distinct real roots.',
      questionType: 'true_false',
      studentAnswer: 'False',
    ),
    HomeworkQuestion(
      id: '5',
      homeworkId: 'hw1',
      questionText: 'If α and β are roots of x² - 7x + 12 = 0, find α² + β²',
      questionType: 'text',
    ),
  ];

  final Map<String, TextEditingController> _answerControllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for text questions
    for (var question in _questions) {
      if (question.questionType == 'text' && question.studentAnswer == null) {
        _answerControllers[question.id] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _answerControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitHomework() {
    // Show submission dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Submit Homework'),
        content: const Text(
          'Are you sure you want to submit your answers? You cannot edit after submission.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // In real app, save to backend
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Homework submitted successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subjectColor = _getSubjectColor(widget.homework.subject);

    return Scaffold(
      appBar: PremiumAppBar(title: widget.homework.title, showBackButton: true),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70), // Space above submit button
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AIHelpScreen(
                  subject: widget.homework.subject,
                  topic: widget.homework.title,
                ),
              ),
            );
          },
          backgroundColor: const Color(0xFF0A2F69),
          foregroundColor: Colors.white,
          elevation: 4,
          icon: const Icon(Icons.live_help_outlined),
          label: const Text('Ask MindForge AI'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Homework Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: subjectColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: subjectColor.withOpacity(0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: subjectColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.homework.subject,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: subjectColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Due: ${_formatDate(widget.homework.dueDate)}',
                          style: TextStyle(
                            fontSize: 13,
                            color: widget.homework.isOverdue
                                ? Colors.red
                                : Colors.grey.shade700,
                            fontWeight: widget.homework.isOverdue
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.homework.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.homework.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: widget.homework.progress,
                            backgroundColor: Colors.grey.shade200,
                            color: subjectColor,
                            minHeight: 6,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${(widget.homework.progress * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: subjectColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${widget.homework.completedQuestions}/${widget.homework.totalQuestions} questions completed',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Questions List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Questions (${_questions.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return _buildQuestionCard(_questions[index], index + 1);
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _submitHomework,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A2F69),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Submit Homework',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(HomeworkQuestion question, int questionNumber) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A2F69).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '$questionNumber',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A2F69),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.questionText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildAnswerInput(question),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerInput(HomeworkQuestion question) {
    switch (question.questionType) {
      case 'mcq':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...?question.options?.map(
              (option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: question.studentAnswer,
                onChanged: (value) {
                  setState(() {});
                },
                contentPadding: EdgeInsets.zero,
                dense: true,
              ),
            ),
          ],
        );

      case 'true_false':
        return Row(
          children: [
            ChoiceChip(
              label: const Text('True'),
              selected: question.studentAnswer == 'True',
              onSelected: (selected) {
                setState(() {});
              },
              selectedColor: Colors.green.withOpacity(0.2),
              labelStyle: TextStyle(
                color: question.studentAnswer == 'True'
                    ? Colors.green
                    : Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 12),
            ChoiceChip(
              label: const Text('False'),
              selected: question.studentAnswer == 'False',
              onSelected: (selected) {
                setState(() {});
              },
              selectedColor: Colors.red.withOpacity(0.2),
              labelStyle: TextStyle(
                color: question.studentAnswer == 'False'
                    ? Colors.red
                    : Colors.grey.shade700,
              ),
            ),
          ],
        );

      default: // text answer
        return TextField(
          controller: _answerControllers[question.id],
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Type your answer here...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF0A2F69),
                width: 1.5,
              ),
            ),
          ),
        );
    }
  }

  Color _getSubjectColor(String subject) {
    switch (subject.toLowerCase()) {
      case 'mathematics':
        return Colors.blue;
      case 'science':
        return Colors.green;
      case 'english':
        return Colors.orange;
      case 'computer science':
        return Colors.teal;
      case 'social studies':
        return Colors.purple;
      case 'hindi':
        return Colors.red;
      default:
        return const Color(0xFF0A2F69);
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Tomorrow';
    } else if (difference.inDays > 1 && difference.inDays <= 7) {
      return 'In ${difference.inDays} days';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
