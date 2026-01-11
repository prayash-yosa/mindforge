
class Homework {
  final String id;
  final String subject;
  final String title;
  final String description;
  final DateTime assignedDate;
  final DateTime dueDate;
  final String status; // 'pending', 'completed', 'overdue'
  final int totalQuestions;
  final int completedQuestions;
  final double progress;

  Homework({
    required this.id,
    required this.subject,
    required this.title,
    required this.description,
    required this.assignedDate,
    required this.dueDate,
    required this.status,
    required this.totalQuestions,
    required this.completedQuestions,
  }) : progress = totalQuestions > 0 ? completedQuestions / totalQuestions : 0;

  bool get isOverdue => dueDate.isBefore(DateTime.now()) && status != 'completed';

  // Get questions for this homework
  List<HomeworkQuestion> getQuestions() {
    switch (id) {
      case '1': // Mathematics - Quadratic Equations
        return [
          HomeworkQuestion(
            id: '${id}_1',
            homeworkId: id,
            questionText: 'Solve the quadratic equation: x² - 5x + 6 = 0',
            questionType: 'text',
            isCompleted: completedQuestions >= 1,
          ),
          HomeworkQuestion(
            id: '${id}_2',
            homeworkId: id,
            questionText: 'Find the roots of: 2x² + 5x - 3 = 0 using quadratic formula',
            questionType: 'text',
            isCompleted: completedQuestions >= 2,
          ),
          HomeworkQuestion(
            id: '${id}_3',
            homeworkId: id,
            questionText: 'What is the value of discriminant in x² - 4x + 4 = 0?',
            questionType: 'mcq',
            options: ['0', '4', '8', '16'],
            studentAnswer: completedQuestions >= 3 ? '0' : null,
            isCompleted: completedQuestions >= 3,
          ),
          HomeworkQuestion(
            id: '${id}_4',
            homeworkId: id,
            questionText: 'True or False: A quadratic equation always has two distinct real roots.',
            questionType: 'true_false',
            studentAnswer: completedQuestions >= 4 ? 'False' : null,
            isCompleted: completedQuestions >= 4,
          ),
          HomeworkQuestion(
            id: '${id}_5',
            homeworkId: id,
            questionText: 'If α and β are roots of x² - 7x + 12 = 0, find α² + β²',
            questionType: 'text',
            isCompleted: completedQuestions >= 5,
          ),
          HomeworkQuestion(
            id: '${id}_6',
            homeworkId: id,
            questionText: 'Solve by factorization: x² - 8x + 15 = 0',
            questionType: 'text',
            isCompleted: completedQuestions >= 6,
          ),
          HomeworkQuestion(
            id: '${id}_7',
            homeworkId: id,
            questionText: 'Which method is most efficient for solving x² + 6x + 9 = 0?',
            questionType: 'mcq',
            options: ['Quadratic Formula', 'Factorization', 'Completing Square', 'All are equal'],
            studentAnswer: completedQuestions >= 7 ? 'Factorization' : null,
            isCompleted: completedQuestions >= 7,
          ),
          HomeworkQuestion(
            id: '${id}_8',
            homeworkId: id,
            questionText: 'Find the nature of roots for 3x² - 2x + 1 = 0',
            questionType: 'text',
            isCompleted: completedQuestions >= 8,
          ),
          HomeworkQuestion(
            id: '${id}_9',
            homeworkId: id,
            questionText: 'True or False: Discriminant determines the number of real roots.',
            questionType: 'true_false',
            studentAnswer: completedQuestions >= 9 ? 'True' : null,
            isCompleted: completedQuestions >= 9,
          ),
          HomeworkQuestion(
            id: '${id}_10',
            homeworkId: id,
            questionText: 'Solve: 4x² - 12x + 9 = 0',
            questionType: 'text',
            isCompleted: completedQuestions >= 10,
          ),
        ];

      case '2': // Science - Light and Reflection
        return [
          HomeworkQuestion(
            id: '${id}_1',
            homeworkId: id,
            questionText: 'Explain the law of reflection with a diagram.',
            questionType: 'text',
            isCompleted: completedQuestions >= 1,
          ),
          HomeworkQuestion(
            id: '${id}_2',
            homeworkId: id,
            questionText: 'What is the focal length of a concave mirror?',
            questionType: 'text',
            isCompleted: completedQuestions >= 2,
          ),
          HomeworkQuestion(
            id: '${id}_3',
            homeworkId: id,
            questionText: 'Which mirror always forms virtual image?',
            questionType: 'mcq',
            options: ['Concave', 'Convex', 'Plane', 'Both convex and plane'],
            studentAnswer: completedQuestions >= 3 ? 'Convex' : null,
            isCompleted: completedQuestions >= 3,
          ),
          HomeworkQuestion(
            id: '${id}_4',
            homeworkId: id,
            questionText: 'Define principal focus of a concave mirror.',
            questionType: 'text',
            isCompleted: completedQuestions >= 4,
          ),
          HomeworkQuestion(
            id: '${id}_5',
            homeworkId: id,
            questionText: 'True or False: Real images can be obtained on a screen.',
            questionType: 'true_false',
            studentAnswer: completedQuestions >= 5 ? 'True' : null,
            isCompleted: completedQuestions >= 5,
          ),
          HomeworkQuestion(
            id: '${id}_6',
            homeworkId: id,
            questionText: 'Calculate magnification when object is at center of curvature.',
            questionType: 'text',
            isCompleted: completedQuestions >= 6,
          ),
          HomeworkQuestion(
            id: '${id}_7',
            homeworkId: id,
            questionText: 'Difference between real and virtual image.',
            questionType: 'text',
            isCompleted: completedQuestions >= 7,
          ),
          HomeworkQuestion(
            id: '${id}_8',
            homeworkId: id,
            questionText: 'Applications of concave mirrors.',
            questionType: 'text',
            isCompleted: completedQuestions >= 8,
          ),
        ];

      case '3': // English - Merchant of Venice
        return [
          HomeworkQuestion(
            id: '${id}_1',
            homeworkId: id,
            questionText: 'Describe the character of Shylock in Act I.',
            questionType: 'text',
            isCompleted: completedQuestions >= 1,
          ),
          HomeworkQuestion(
            id: '${id}_2',
            homeworkId: id,
            questionText: 'What is the main conflict introduced in Act I?',
            questionType: 'text',
            isCompleted: completedQuestions >= 2,
          ),
          HomeworkQuestion(
            id: '${id}_3',
            homeworkId: id,
            questionText: 'Who is Antonio in the play?',
            questionType: 'mcq',
            options: ['A Merchant', 'A Lawyer', 'A Jew', 'A Prince'],
            studentAnswer: completedQuestions >= 3 ? 'A Merchant' : null,
            isCompleted: completedQuestions >= 3,
          ),
          HomeworkQuestion(
            id: '${id}_4',
            homeworkId: id,
            questionText: 'True or False: Bassanio is poor and needs money.',
            questionType: 'true_false',
            studentAnswer: completedQuestions >= 4 ? 'True' : null,
            isCompleted: completedQuestions >= 4,
          ),
          HomeworkQuestion(
            id: '${id}_5',
            homeworkId: id,
            questionText: 'Explain the bond story in your own words.',
            questionType: 'text',
            isCompleted: completedQuestions >= 5,
          ),
        ];

      case '4': // Computer Science - Java Methods
        return [
          HomeworkQuestion(
            id: '${id}_1',
            homeworkId: id,
            questionText: 'What is a method in Java?',
            questionType: 'text',
            isCompleted: completedQuestions >= 1,
          ),
          HomeworkQuestion(
            id: '${id}_2',
            homeworkId: id,
            questionText: 'Difference between parameter and argument.',
            questionType: 'text',
            isCompleted: completedQuestions >= 2,
          ),
          HomeworkQuestion(
            id: '${id}_3',
            homeworkId: id,
            questionText: 'Which keyword is used for methods that dont return value?',
            questionType: 'mcq',
            options: ['void', 'null', 'empty', 'none'],
            studentAnswer: completedQuestions >= 3 ? 'void' : null,
            isCompleted: completedQuestions >= 3,
          ),
          HomeworkQuestion(
            id: '${id}_4',
            homeworkId: id,
            questionText: 'Write a method to calculate factorial of a number.',
            questionType: 'text',
            isCompleted: completedQuestions >= 4,
          ),
          HomeworkQuestion(
            id: '${id}_5',
            homeworkId: id,
            questionText: 'True or False: Main method can be overloaded.',
            questionType: 'true_false',
            studentAnswer: completedQuestions >= 5 ? 'True' : null,
            isCompleted: completedQuestions >= 5,
          ),
          HomeworkQuestion(
            id: '${id}_6',
            homeworkId: id,
            questionText: 'What is method signature?',
            questionType: 'text',
            isCompleted: completedQuestions >= 6,
          ),
        ];

      case '5': // Social Studies - Indian Constitution
        return [
          HomeworkQuestion(
            id: '${id}_1',
            homeworkId: id,
            questionText: 'When was Indian Constitution adopted?',
            questionType: 'text',
            isCompleted: completedQuestions >= 1,
          ),
          HomeworkQuestion(
            id: '${id}_2',
            homeworkId: id,
            questionText: 'List any three Fundamental Rights.',
            questionType: 'text',
            isCompleted: completedQuestions >= 2,
          ),
          HomeworkQuestion(
            id: '${id}_3',
            homeworkId: id,
            questionText: 'Who was the chairman of Drafting Committee?',
            questionType: 'mcq',
            options: ['Jawaharlal Nehru', 'B.R. Ambedkar', 'Rajendra Prasad', 'Sardar Patel'],
            studentAnswer: completedQuestions >= 3 ? 'B.R. Ambedkar' : null,
            isCompleted: completedQuestions >= 3,
          ),
          HomeworkQuestion(
            id: '${id}_4',
            homeworkId: id,
            questionText: 'True or False: Right to Property is a Fundamental Right.',
            questionType: 'true_false',
            studentAnswer: completedQuestions >= 4 ? 'False' : null,
            isCompleted: completedQuestions >= 4,
          ),
          HomeworkQuestion(
            id: '${id}_5',
            homeworkId: id,
            questionText: 'What is the Preamble of Constitution?',
            questionType: 'text',
            isCompleted: completedQuestions >= 5,
          ),
          HomeworkQuestion(
            id: '${id}_6',
            homeworkId: id,
            questionText: 'Explain Directive Principles of State Policy.',
            questionType: 'text',
            isCompleted: completedQuestions >= 6,
          ),
          HomeworkQuestion(
            id: '${id}_7',
            homeworkId: id,
            questionText: 'How many articles in original constitution?',
            questionType: 'mcq',
            options: ['395', '448', '500', '350'],
            studentAnswer: completedQuestions >= 7 ? '395' : null,
            isCompleted: completedQuestions >= 7,
          ),
        ];

      default:
        return [
          HomeworkQuestion(
            id: '${id}_1',
            homeworkId: id,
            questionText: 'Answer the following question...',
            questionType: 'text',
            isCompleted: completedQuestions >= 1,
          ),
        ];
    }
  }
}

class HomeworkQuestion {
  final String id;
  final String homeworkId;
  final String questionText;
  final String? studentAnswer;
  final bool isCompleted;
  final List<String> hintsUsed;
  final String questionType; // 'text', 'mcq', 'true_false'
  final List<String>? options;

  HomeworkQuestion({
    required this.id,
    required this.homeworkId,
    required this.questionText,
    this.studentAnswer,
    this.isCompleted = false,
    this.hintsUsed = const [],
    this.questionType = 'text',
    this.options,
  });

  // Get a hint for this question
  String getHint(int hintNumber) {
    if (homeworkId == '1') { // Mathematics hints
      final mathHints = [
        'Hint 1: Remember the standard form: ax² + bx + c = 0',
        'Hint 2: Identify values of a, b, and c in your equation',
        'Hint 3: Try factoring the quadratic expression',
        'Hint 4: Use quadratic formula: x = [-b ± √(b² - 4ac)] / 2a',
      ];
      return hintNumber <= mathHints.length ? mathHints[hintNumber - 1] : 'Try applying what you have learned!';
    }
    
    if (homeworkId == '2') { // Science hints
      final scienceHints = [
        'Hint 1: Recall the basic properties of light reflection',
        'Hint 2: Think about the difference between concave and convex mirrors',
        'Hint 3: Consider where images are formed in different mirrors',
      ];
      return hintNumber <= scienceHints.length ? scienceHints[hintNumber - 1] : 'Review your textbook notes!';
    }
    
    return 'Think carefully about the question. What do you already know about this topic?';
  }
}

// Helper class to generate mock homework data
class HomeworkData {
  static List<Homework> getMockHomework() {
    final now = DateTime.now();
    return [
      Homework(
        id: '1',
        subject: 'Mathematics',
        title: 'Quadratic Equations Practice',
        description: 'Solve quadratic equations using different methods',
        assignedDate: DateTime(now.year, now.month, now.day - 5),
        dueDate: DateTime(now.year, now.month, now.day + 2),
        status: 'pending',
        totalQuestions: 10,
        completedQuestions: 4,
      ),
      Homework(
        id: '2',
        subject: 'Science',
        title: 'Light and Reflection',
        description: 'Problems on reflection of light and mirrors',
        assignedDate: DateTime(now.year, now.month, now.day - 3),
        dueDate: DateTime(now.year, now.month, now.day + 1),
        status: 'completed',
        totalQuestions: 8,
        completedQuestions: 8,
      ),
      Homework(
        id: '3',
        subject: 'English',
        title: 'The Merchant of Venice - Act I',
        description: 'Comprehension questions and character analysis',
        assignedDate: DateTime(now.year, now.month, now.day - 4),
        dueDate: DateTime(now.year, now.month, now.day - 1),
        status: 'overdue',
        totalQuestions: 5,
        completedQuestions: 2,
      ),
      Homework(
        id: '4',
        subject: 'Computer Science',
        title: 'Java Methods Practice',
        description: 'Create user-defined methods for given problems',
        assignedDate: DateTime(now.year, now.month, now.day - 2),
        dueDate: DateTime(now.year, now.month, now.day + 5),
        status: 'pending',
        totalQuestions: 6,
        completedQuestions: 0,
      ),
      Homework(
        id: '5',
        subject: 'Social Studies',
        title: 'Indian Constitution',
        description: 'Short answer questions on fundamental rights',
        assignedDate: DateTime(now.year, now.month, now.day - 1),
        dueDate: DateTime(now.year, now.month, now.day + 4),
        status: 'pending',
        totalQuestions: 7,
        completedQuestions: 3,
      ),
    ];
  }
}