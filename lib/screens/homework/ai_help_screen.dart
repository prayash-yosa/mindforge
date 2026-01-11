import 'package:flutter/material.dart';
import 'package:mindforge_app/widgets/premium_app_bar.dart';

class AIHelpScreen extends StatefulWidget {
  final String subject;
  final String topic;

  const AIHelpScreen({
    super.key,
    required this.subject,
    required this.topic,
  });

  @override
  State<AIHelpScreen> createState() => _AIHelpScreenState();
}

class _AIHelpScreenState extends State<AIHelpScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello! I'm your AI learning assistant. I can help you understand concepts and guide you through problems, but I won't give direct answers. What part are you finding difficult?",
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];
  int _hintCount = 0;
  final int _maxHints = 3;

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });

    _messageController.clear();

    // Simulate AI thinking
    Future.delayed(const Duration(seconds: 1), () {
      _addAIResponse(text);
    });
  }

  void _addAIResponse(String userMessage) {
    String response;
    
    // Check if user is asking for direct answer
    if (userMessage.toLowerCase().contains('answer') || 
        userMessage.toLowerCase().contains('solve') ||
        userMessage.toLowerCase().contains('tell me')) {
      
      if (_hintCount >= _maxHints) {
        response = "I've given you all the hints I can for now. Why don't you try applying what we've discussed? Remember, the learning is in the struggle!";
      } else {
        _hintCount++;
        response = _getHint();
      }
    } else {
      // General help response
      response = "I understand you're asking about $userMessage. Let me guide you: Have you tried breaking down the quadratic equation into its factors? What happens when you try to factor x² - 5x + 6?";
    }

    setState(() {
      _messages.add(ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }

  String _getHint() {
    final hints = [
      "Hint 1: Remember the quadratic formula? Try writing down the formula first.",
      "Hint 2: Identify the coefficients a, b, and c in your equation.",
      "Hint 3: What two numbers multiply to give you the constant term and add to give you the coefficient of x?",
      "Great effort! Now try applying the quadratic formula with those coefficients.",
    ];
    return _hintCount <= hints.length ? hints[_hintCount - 1] : hints.last;
  }

  void _requestHint() {
    if (_hintCount >= _maxHints) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum hints reached for this problem'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    _hintCount++;
    setState(() {
      _messages.add(ChatMessage(
        text: _getHint(),
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PremiumAppBar(
        title: 'AI Learning Assistant',
        showBackButton: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Info Banner
            Container(
              padding: const EdgeInsets.all(12),
              color: const Color(0xFF0A2F69).withOpacity(0.05),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.orange.shade700, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Subject: ${widget.subject} • Topic: ${widget.topic}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A2F69).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Hints: $_hintCount/$_maxHints',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0A2F69),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Chat Messages
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                reverse: false,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),

            // Input Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  // Hint Button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A2F69).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.lightbulb,
                        color: _hintCount >= _maxHints ? Colors.grey : const Color(0xFF0A2F69),
                        size: 20,
                      ),
                      onPressed: _requestHint,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Text Input
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Ask for guidance...',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send, color: Color(0xFF0A2F69)),
                            onPressed: _sendMessage,
                          ),
                        ),
                        onSubmitted: (value) => _sendMessage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.smart_toy, size: 18, color: Colors.blue),
            ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: message.isUser
                        ? const Color(0xFF0A2F69).withOpacity(0.1)
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(message.isUser ? 16 : 4),
                      bottomRight: Radius.circular(message.isUser ? 4 : 16),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: message.isUser ? const Color(0xFF0A2F69) : Colors.grey.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          if (message.isUser)
            const SizedBox(width: 8),
          if (message.isUser)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF0A2F69).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.person, size: 18, color: Color(0xFF0A2F69)),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}