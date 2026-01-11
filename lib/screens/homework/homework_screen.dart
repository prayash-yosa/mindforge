import 'package:flutter/material.dart';
import 'package:mindforge_app/data/models/homework.dart';
import 'package:mindforge_app/screens/homework/homework_detail_screen.dart';
import 'package:mindforge_app/widgets/premium_app_bar.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key});

  @override
  State<HomeworkScreen> createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  String _filter = 'all'; // 'all', 'pending', 'completed', 'overdue'
  
  // Mock homework data
  final List<Homework> _allHomework = [
    Homework(
      id: '1',
      subject: 'Mathematics',
      title: 'Quadratic Equations Practice',
      description: 'Solve quadratic equations using different methods',
      assignedDate: DateTime(2024, 2, 10),
      dueDate: DateTime(2024, 2, 15),
      status: 'pending',
      totalQuestions: 10,
      completedQuestions: 4,
    ),
    Homework(
      id: '2',
      subject: 'Science',
      title: 'Light and Reflection',
      description: 'Problems on reflection of light and mirrors',
      assignedDate: DateTime(2024, 2, 12),
      dueDate: DateTime(2024, 2, 14),
      status: 'completed',
      totalQuestions: 8,
      completedQuestions: 8,
    ),
    Homework(
      id: '3',
      subject: 'English',
      title: 'The Merchant of Venice - Act I',
      description: 'Comprehension questions and character analysis',
      assignedDate: DateTime(2024, 2, 11),
      dueDate: DateTime(2024, 2, 13),
      status: 'overdue',
      totalQuestions: 5,
      completedQuestions: 2,
    ),
    Homework(
      id: '4',
      subject: 'Computer Science',
      title: 'Java Methods Practice',
      description: 'Create user-defined methods for given problems',
      assignedDate: DateTime(2024, 2, 13),
      dueDate: DateTime(2024, 2, 18),
      status: 'pending',
      totalQuestions: 6,
      completedQuestions: 0,
    ),
    Homework(
      id: '5',
      subject: 'Social Studies',
      title: 'Indian Constitution',
      description: 'Short answer questions on fundamental rights',
      assignedDate: DateTime(2024, 2, 14),
      dueDate: DateTime(2024, 2, 17),
      status: 'pending',
      totalQuestions: 7,
      completedQuestions: 3,
    ),
  ];

  List<Homework> get _filteredHomework {
    if (_filter == 'all') return _allHomework;
    return _allHomework.where((hw) => hw.status == _filter).toList();
  }

  Map<String, int> get _homeworkStats {
    return {
      'total': _allHomework.length,
      'pending': _allHomework.where((hw) => hw.status == 'pending').length,
      'completed': _allHomework.where((hw) => hw.status == 'completed').length,
      'overdue': _allHomework.where((hw) => hw.status == 'overdue').length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PremiumAppBar(
        title: 'Homework',
        showBackButton: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Row
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A2F69).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF0A2F69).withOpacity(0.1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Total', _homeworkStats['total'].toString(), Icons.assignment),
                    _buildStatItem('Pending', _homeworkStats['pending'].toString(), Icons.access_time),
                    _buildStatItem('Completed', _homeworkStats['completed'].toString(), Icons.check_circle),
                    _buildStatItem('Overdue', _homeworkStats['overdue'].toString(), Icons.warning),
                  ],
                ),
              ),
            ),

            // Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All', 'all'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Pending', 'pending'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Completed', 'completed'),
                    const SizedBox(width: 8),
                    _buildFilterChip('Overdue', 'overdue'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Homework List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                itemCount: _filteredHomework.length,
                itemBuilder: (context, index) {
                  final homework = _filteredHomework[index];
                  return _buildHomeworkCard(homework, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF0A2F69).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF0A2F69)),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0A2F69),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _filter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filter = value;
        });
      },
      backgroundColor: Colors.grey.shade100,
      selectedColor: const Color(0xFF0A2F69).withOpacity(0.1),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF0A2F69) : Colors.grey.shade700,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? const Color(0xFF0A2F69) : Colors.grey.shade300,
          width: 1,
        ),
      ),
    );
  }

  Widget _buildHomeworkCard(Homework homework, BuildContext context) {
    // Determine colors based on status
    Color statusColor;
    String statusText;
    
    if (homework.isOverdue) {
      statusColor = Colors.red;
      statusText = 'Overdue';
    } else if (homework.status == 'completed') {
      statusColor = Colors.green;
      statusText = 'Completed';
    } else {
      statusColor = Colors.orange;
      statusText = 'Pending';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HomeworkDetailScreen(homework: homework),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with subject and status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getSubjectColor(homework.subject).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        homework.subject,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getSubjectColor(homework.subject),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: statusColor.withOpacity(0.2)),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Title and description
                Text(
                  homework.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  homework.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 16),

                // Progress bar and due date
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress: ${(homework.progress * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(
                          'Due: ${_formatDate(homework.dueDate)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: homework.isOverdue ? Colors.red : Colors.grey.shade700,
                            fontWeight: homework.isOverdue ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
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
                        widthFactor: homework.progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _getSubjectColor(homework.subject),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${homework.completedQuestions}/${homework.totalQuestions} questions',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        if (homework.isOverdue)
                          Row(
                            children: [
                              Icon(Icons.warning_amber, size: 12, color: Colors.red),
                              const SizedBox(width: 4),
                              Text(
                                'Submission closed',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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