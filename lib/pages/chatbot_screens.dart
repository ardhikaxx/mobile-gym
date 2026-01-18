import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../themes.dart';

class ChatbotScreens extends StatefulWidget {
  const ChatbotScreens({Key? key}) : super(key: key);

  @override
  State<ChatbotScreens> createState() => _ChatbotScreensState();
}

class Message {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class _ChatbotScreensState extends State<ChatbotScreens> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  // Responses untuk chatbot (Gen Z style)
  final List<Map<String, dynamic>> _botResponses = [
    {
      'keywords': ['hai', 'hello', 'halo', 'hi', 'hey', 'hallo'],
      'responses': [
        'Yow! 👋 Ada yang bisa gue bantu soal workout?',
        'Wassup bro! 💪 Ready to crush some gains?',
        'Halo! Gym time? Let\'s gooo! 🔥',
        'Hey there! Ada yang mau ditanyain soal gym?'
      ]
    },
    {
      'keywords': ['workout', 'latihan', 'olahraga', 'exercise'],
      'responses': [
        'Workout itu kunci! Mau yang cardio atau strength training? 🏋️‍♂️',
        'Gue recommend full body workout 3x seminggu buat pemula!',
        'Jangan lupa warm up dulu sebelum workout, bro!',
        'Consistency is key! Better 30 mins daily than 3 hours once a week 💯'
      ]
    },
    {
      'keywords': ['diet', 'makan', 'nutrisi', 'protein'],
      'responses': [
        'Protein is king! 🍗 Aim for 1.6-2.2g per kg berat badan',
        'Carbs bukan musuh! Mereka bahan bakar buat workout 💪',
        'Stay hydrated bro! Minum air putih itu wajib! 💧',
        'Meal prep bisa save time dan bantu diet lebih konsisten 📝'
      ]
    },
    {
      'keywords': ['cardio', 'lari', 'treadmill', 'sepeda'],
      'responses': [
        'Cardio mantap buat burning calories! 150 mins per week recommended 🏃‍♂️',
        'HIIT > steady state cardio buat fat loss! Try it!',
        'Jangan lupa cool down setelah cardio, bro!',
        'LISS cardio juga bagus buat recovery days 🤙'
      ]
    },
    {
      'keywords': ['strength', 'angkat', 'beban', 'dumbell'],
      'responses': [
        'Progressive overload itu wajib! Tambah berat atau reps setiap minggu 🏋️',
        'Form > ego lifting! Better safe than sorry bro!',
        'Compound movements FTW! Squat, deadlift, bench press 🚀',
        'Rest between sets penting banget! 1-3 minutes ideal 💤'
      ]
    },
    {
      'keywords': ['recovery', 'istirahat', 'tidur', 'pemulihan'],
      'responses': [
        'Sleep is non-negotiable! 7-9 hours per night, bro 😴',
        'Recovery sama pentingnya dengan workout! Listen to your body',
        'Foam rolling bisa bantu kurangi muscle soreness 🎯',
        'Active recovery > total rest! Coba jalan kaki atau stretching ringan'
      ]
    },
    {
      'keywords': ['motivasi', 'malas', 'bosan', 'semangat'],
      'responses': [
        'Don\'t stop when you\'re tired, stop when you\'re done! 💯',
        'Progress takes time! Trust the process bro 🌱',
        'Every expert was once a beginner! Keep grinding!',
        'The only bad workout is the one that didn\'t happen! 🚀'
      ]
    },
    {
      'keywords': ['bmi', 'berat', 'badan', 'ideal'],
      'responses': [
        'BMI cuma salah satu indikator! Muscle lebih berat daripada fat 💪',
        'Focus on body composition, not just weight!',
        'Progress pics > scale! Take photos setiap bulan 📸',
        'How you feel > how you look! Health is the real goal 🌟'
      ]
    },
  ];

  // Helper methods untuk mendapatkan warna berdasarkan tema
  Color _getBackgroundColor(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return themeProvider.currentTheme.scaffoldBackgroundColor;
  }

  Color _getCardBackgroundColor(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return themeProvider.currentTheme.cardTheme.color ??
        (themeProvider.themeMode == ThemeModeType.dark
            ? ThemeClass.cardBackgroundDark
            : ThemeClass.cardBackgroundLight);
  }

  Color _getPrimaryColor(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return themeProvider.currentTheme.primaryColor;
  }

  Color _getTextPrimaryColor(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return themeProvider.currentTheme.textTheme.bodyLarge?.color ??
        Colors.black;
  }

  Color _getTextSecondaryColor(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return themeProvider.currentTheme.textTheme.bodyMedium?.color ??
        Colors.grey;
  }

  Color _getDividerColor(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return themeProvider.currentTheme.dividerTheme.color ?? Colors.grey[300]!;
  }

  @override
  void initState() {
    super.initState();
    // Add initial bot message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addBotMessage(
          'Yo! Gue GymBro 🤖, personal AI trainer kamu! '
          'Ada yang mau ditanyain soal workout, diet, atau butuh motivasi? 🔥',
          false);
    });
  }

  void _addBotMessage(String text, bool isUser) {
    setState(() {
      _messages.add(Message(
        text: text,
        isUser: isUser,
        timestamp: DateTime.now(),
      ));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _getBotResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();
    for (var responseGroup in _botResponses) {
      for (var keyword in responseGroup['keywords'] as List<String>) {
        if (lowerMessage.contains(keyword)) {
          final responses = responseGroup['responses'] as List<String>;
          return responses[
              DateTime.now().millisecondsSinceEpoch % responses.length];
        }
      }
    }

    // Default responses
    final defaultResponses = [
      'Interesting question! Bisa jelasin lebih detail? 🤔',
      'Gue masih belajar nih! Coba tanya soal workout atau diet dulu! 💪',
      'Waduh, itu di luar expertise gue bro! Tanya trainer langsung mungkin?',
      'Try to ask about workout routines or nutrition tips! 🏋️‍♂️',
      'Good question! Mau gue cariin info lebih lanjut?',
      'Hold up! Let me think about that... 🧠',
      'That\'s deep bro! But honestly, consistency is the real answer 💯',
    ];

    return defaultResponses[
        DateTime.now().millisecondsSinceEpoch % defaultResponses.length];
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    // Add user message
    _addBotMessage(text, true);
    _messageController.clear();

    // Show loading
    setState(() {
      _isLoading = true;
    });

    // Simulate bot thinking
    Future.delayed(const Duration(seconds: 1), () {
      final response = _getBotResponse(text);
      _addBotMessage(response, false);
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _showQuickReplies(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _getCardBackgroundColor(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final quickQuestions = [
          'Workout buat pemula?',
          'Tips diet yang sehat?',
          'Cardio vs strength training?',
          'Butuh motivasi!',
          'Berapa kali workout per minggu?',
          'Protein sources terbaik?',
          'Cara kurangi muscle soreness?',
          'Workout tanpa equipment?',
        ];

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _getCardBackgroundColor(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Quick Questions 🤙',
                style: TextStyle(
                  color: _getTextPrimaryColor(context),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: quickQuestions.map((question) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _messageController.text = question;
                      _sendMessage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: _getPrimaryColor(context).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _getPrimaryColor(context).withOpacity(0.4),
                        ),
                      ),
                      child: Text(
                        question,
                        style: TextStyle(
                          color: _getPrimaryColor(context),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageBubble(BuildContext context, Message message) {
    final isUser = message.isUser;
    final primaryColor = _getPrimaryColor(context);
    final cardBackgroundColor = _getCardBackgroundColor(context);
    final textPrimaryColor = _getTextPrimaryColor(context);
    final textSecondaryColor = _getTextSecondaryColor(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(
                  FontAwesomeIcons.solidMessage,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          if (!isUser) const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isUser ? primaryColor : cardBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: isUser
                          ? const Radius.circular(16)
                          : const Radius.circular(4),
                      bottomRight: isUser
                          ? const Radius.circular(4)
                          : const Radius.circular(16),
                    ),
                    gradient: isUser
                        ? LinearGradient(
                            colors: [
                              primaryColor,
                              primaryColor.withOpacity(0.9),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              cardBackgroundColor.withOpacity(0.8),
                              cardBackgroundColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                    border: Border.all(
                      color: isUser
                          ? Colors.transparent
                          : _getDividerColor(context),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? Colors.white : textPrimaryColor,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(message.timestamp),
                  style: TextStyle(
                    color: textSecondaryColor.withOpacity(0.6),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (isUser) const SizedBox(width: 8),
          if (isUser)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(
                  FontAwesomeIcons.user,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);
    final backgroundColor = _getBackgroundColor(context);
    final cardBackgroundColor = _getCardBackgroundColor(context);
    final textPrimaryColor = _getTextPrimaryColor(context);
    final textSecondaryColor = _getTextSecondaryColor(context);
    final primaryColor = _getPrimaryColor(context);
    final dividerColor = _getDividerColor(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: cardBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          color: primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    primaryColor.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  FontAwesomeIcons.solidMessage,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GymBro AI',
                  style: TextStyle(
                    color: textPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online • Gen Z Style',
                  style: TextStyle(
                    color: textSecondaryColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.bolt),
            color: primaryColor,
            onPressed: () => _showQuickReplies(context),
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            color: textSecondaryColor,
            onPressed: () {
              // Show options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                primaryColor,
                                primaryColor.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text(
                              '🤖',
                              style: TextStyle(fontSize: 36),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'GymBro AI 🤖',
                          style: TextStyle(
                            color: textPrimaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Ask me anything about fitness!\nGen Z style answers guaranteed 🔥',
                          style: TextStyle(
                            color: textSecondaryColor,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: cardBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: primaryColor.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FontAwesomeIcons.lightbulb,
                                color: primaryColor,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Try: "Workout buat pemula?"',
                                style: TextStyle(
                                  color: textSecondaryColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageBubble(context, _messages[index]);
                    },
                  ),
          ),

          // Typing indicator
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        '🤖',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: cardBackgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildTypingDot(context, 0),
                        _buildTypingDot(context, 1),
                        _buildTypingDot(context, 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Input area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBackgroundColor,
              border: Border(
                top: BorderSide(color: dividerColor),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(color: textPrimaryColor),
                    decoration: InputDecoration(
                      hintText: 'Massukkan pesan anda',
                      hintStyle: TextStyle(
                        color: textSecondaryColor.withOpacity(0.6),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        primaryColor.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    icon: const Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: _getPrimaryColor(context).withOpacity(0.5),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
