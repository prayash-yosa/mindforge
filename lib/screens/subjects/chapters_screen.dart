import 'package:flutter/material.dart';
import '../../widgets/premium_app_bar.dart';

class ChaptersScreen extends StatelessWidget {
  final String subjectName;
  final Color subjectColor;
  final IconData icon;
  final double progress;
  final int totalChapters;

  const ChaptersScreen({
    super.key,
    required this.subjectName,
    required this.subjectColor,
    required this.icon,
    required this.progress,
    required this.totalChapters,
  });

  // Function to get chapters based on subject
  List<Map<String, dynamic>> _getChaptersForSubject() {
    switch (subjectName) {
      case 'Mathematics':
        return [
          {"title": "Commercial Mathematics", "completed": true, "duration": "4 hours"},
          {"title": "Quadratic Equations", "completed": true, "duration": "3 hours"},
          {"title": "Ratio and Proportion", "completed": true, "duration": "2.5 hours"},
          {"title": "Factorisation", "completed": true, "duration": "3 hours"},
          {"title": "Matrices", "completed": true, "duration": "2.5 hours"},
          {"title": "Arithmetic & Geometric Progression", "completed": false, "duration": "3.5 hours"},
          {"title": "Co-ordinate Geometry", "completed": false, "duration": "4 hours"},
          {"title": "Similarity", "completed": false, "duration": "3 hours"},
          {"title": "Circles", "completed": false, "duration": "4 hours"},
          {"title": "Trigonometry", "completed": false, "duration": "5 hours"},
          {"title": "Statistics", "completed": false, "duration": "3 hours"},
          {"title": "Probability", "completed": false, "duration": "2.5 hours"},
        ];
      
      case 'Science':
        return [
          {"title": "Force, Work & Energy", "completed": true, "duration": "4 hours"},
          {"title": "Light", "completed": true, "duration": "5 hours"},
          {"title": "Sound", "completed": true, "duration": "3 hours"},
          {"title": "Electricity & Magnetism", "completed": true, "duration": "6 hours"},
          {"title": "Heat", "completed": false, "duration": "4 hours"},
          {"title": "Modern Physics", "completed": false, "duration": "3 hours"},
          {"title": "Chemical Reactions", "completed": false, "duration": "4 hours"},
          {"title": "Acids, Bases & Salts", "completed": false, "duration": "3.5 hours"},
          {"title": "Metals & Non-Metals", "completed": false, "duration": "3 hours"},
          {"title": "Periodic Classification", "completed": false, "duration": "3 hours"},
        ];
      
      case 'English':
        return [
          {"title": "Grammar: Tenses & Modals", "completed": true, "duration": "3 hours"},
          {"title": "Grammar: Prepositions & Conjunctions", "completed": true, "duration": "2.5 hours"},
          {"title": "Composition: Letter Writing", "completed": true, "duration": "3 hours"},
          {"title": "Composition: Essay Writing", "completed": true, "duration": "4 hours"},
          {"title": "The Merchant of Venice - Act I", "completed": false, "duration": "3 hours"},
          {"title": "The Merchant of Venice - Act II", "completed": false, "duration": "3 hours"},
          {"title": "The Merchant of Venice - Act III", "completed": false, "duration": "3 hours"},
          {"title": "The Merchant of Venice - Act IV", "completed": false, "duration": "3 hours"},
          {"title": "The Merchant of Venice - Act V", "completed": false, "duration": "3 hours"},
          {"title": "Poetry: Comprehension & Analysis", "completed": false, "duration": "4 hours"},
        ];
      
      case 'Social Studies':
        return [
          {"title": "The Indian National Movement", "completed": true, "duration": "5 hours"},
          {"title": "World War I & II", "completed": true, "duration": "4 hours"},
          {"title": "The Indian Constitution", "completed": true, "duration": "4 hours"},
          {"title": "Union Executive & Legislature", "completed": false, "duration": "4 hours"},
          {"title": "The Judiciary", "completed": false, "duration": "3 hours"},
          {"title": "Indian Geography: Climate", "completed": false, "duration": "3 hours"},
          {"title": "Indian Geography: Resources", "completed": false, "duration": "3 hours"},
          {"title": "Transport & Communication", "completed": false, "duration": "2.5 hours"},
        ];
      
      case 'Computer Science':
        return [
          {"title": "Revision of Class 9 Concepts", "completed": true, "duration": "3 hours"},
          {"title": "Class as Basis of Computation", "completed": true, "duration": "4 hours"},
          {"title": "User-Defined Methods", "completed": true, "duration": "5 hours"},
          {"title": "Constructors", "completed": false, "duration": "4 hours"},
          {"title": "Library Classes", "completed": false, "duration": "3 hours"},
          {"title": "Encapsulation", "completed": false, "duration": "3 hours"},
          {"title": "Arrays", "completed": false, "duration": "5 hours"},
          {"title": "String Handling", "completed": false, "duration": "4 hours"},
        ];
      
      case 'Hindi':
        return [
          {"title": "व्याकरण: काल", "completed": true, "duration": "3 hours"},
          {"title": "व्याकरण: वाच्य", "completed": true, "duration": "2.5 hours"},
          {"title": "रचना: पत्र लेखन", "completed": true, "duration": "2.5 hours"},
          {"title": "रचना: निबंध लेखन", "completed": false, "duration": "3 hours"},
          {"title": "कहानी: बड़े घर की बेटी", "completed": false, "duration": "2 hours"},
          {"title": "कहानी: धुली-धपड़ी सड़कें", "completed": false, "duration": "2 hours"},
          {"title": "कविता: अक्षर-ज्ञान", "completed": false, "duration": "2 hours"},
          {"title": "कविता: मेरी माँ", "completed": false, "duration": "2 hours"},
        ];
      
      default:
        // Fallback chapters if subject not listed
        return [
          {"title": "Introduction", "completed": true, "duration": "2 hours"},
          {"title": "Basic Concepts", "completed": true, "duration": "3 hours"},
          {"title": "Advanced Topics", "completed": true, "duration": "4 hours"},
          {"title": "Practice Exercises", "completed": false, "duration": "2 hours"},
          {"title": "Revision", "completed": false, "duration": "1.5 hours"},
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final chapters = _getChaptersForSubject();

    return Scaffold(
      appBar: PremiumAppBar(
        title: subjectName,
        showBackButton: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: subjectColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: subjectColor.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: subjectColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        icon,
                        color: subjectColor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subjectName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Progress: ${(progress * 100).toInt()}% • ${chapters.length} Chapters",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: subjectColor,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Chapter Title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Chapters",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Complete chapters to improve your score",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            
            // Scrollable Chapters List
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  itemCount: chapters.length,
                  itemBuilder: (context, index) {
                    final chapter = chapters[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          // Chapter Number
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: subjectColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: subjectColor,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Chapter Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chapter["title"],
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Duration: ${chapter["duration"]}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Completion Status
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: chapter["completed"]
                                  ? Colors.green.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              chapter["completed"] ? "Completed" : "Pending",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: chapter["completed"]
                                    ? Colors.green
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}