import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_application_1/service/feedback_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  Map<String, dynamic>? _feedbackData;
  bool _isLoading = true;
  bool _isDeleting = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadFeedback();
  }

  Future<void> _loadFeedback() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final result = await FeedbackService.getMyFeedback();

      if (result['success'] == true) {
        setState(() {
          _feedbackData = result['data'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Gagal memuat feedback';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan: $e';
        _isLoading = false;
      });
    }
  }

  // Method untuk menampilkan dialog tambah/edit feedback
  void _showFeedbackDialog({Map<String, dynamic>? existingFeedback}) {
    final formKey = GlobalKey<FormState>();
    final reviewController = TextEditingController();
    double rating = 5.0;

    if (existingFeedback != null) {
      rating = existingFeedback['feedback']['rating'].toDouble();
      reviewController.text = existingFeedback['feedback']['review'];
    }

    final pageContext = context;

    showDialog(
      context: pageContext,
      barrierDismissible: false,
      builder: (dialogContext) {
        bool isSubmitting = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return WillPopScope(
              onWillPop: () async => !isSubmitting,
              child: AlertDialog(
                backgroundColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                ),
                title: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.commentDots,
                          color: Theme.of(context).primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      existingFeedback != null
                          ? "Edit Feedback"
                          : "Tambah Feedback",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rating",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: RatingStars(
                          value: rating,
                          onValueChanged: (v) {
                            setDialogState(() => rating = v);
                          },
                          starBuilder: (_, color) => Icon(
                            FontAwesomeIcons.solidStar,
                            color: color,
                            size: 32,
                          ),
                          starCount: 5,
                          starSize: 32,
                          maxValue: 5,
                          starColor: Theme.of(context).primaryColor,
                          starOffColor: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.3),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Review",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: reviewController,
                        maxLines: 5,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Review tidak boleh kosong';
                          }
                          if (v.length < 10) {
                            return 'Review minimal 10 karakter';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).cardColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      if (isSubmitting) ...[
                        const SizedBox(height: 16),
                        Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      ]
                    ],
                  ),
                ),
                actions: isSubmitting
                    ? []
                    : [
                        TextButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onSurface,
                          ),
                          child: const Text("Batal"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) return;

                            setDialogState(() => isSubmitting = true);

                            final result = existingFeedback != null
                                ? await FeedbackService.updateFeedback(
                                    rating: rating.toInt(),
                                    review: reviewController.text,
                                  )
                                : await FeedbackService.addFeedback(
                                    rating: rating.toInt(),
                                    review: reviewController.text,
                                  );

                            if (!mounted) return;

                            Navigator.pop(dialogContext);

                            await _loadFeedback();

                            ScaffoldMessenger.of(pageContext).showSnackBar(
                              SnackBar(
                                content: Text(result['message']),
                                backgroundColor: result['success'] == true
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            existingFeedback != null ? "Simpan" : "Tambah",
                          ),
                        )
                      ],
              ),
            );
          },
        );
      },
    );
  }

  // Method untuk menampilkan dialog konfirmasi hapus
  void _showDeleteConfirmation() {
    if (_isDeleting) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        bool _isDeletingLocal = false;

        return WillPopScope(
          onWillPop: () async => !_isDeletingLocal,
          child: StatefulBuilder(
            builder: (context, setDialogState) {
              return AlertDialog(
                backgroundColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                ),
                title: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.red,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.trash,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Hapus Feedback",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Apakah Anda yakin ingin menghapus feedback?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Tindakan ini tidak dapat dibatalkan.",
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    if (_isDeletingLocal) ...[
                      const SizedBox(height: 16),
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ],
                ),
                actions: _isDeletingLocal
                    ? []
                    : [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color:
                                    Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          child: const Text("Batal"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            setDialogState(() {
                              _isDeletingLocal = true;
                            });

                            final result = await FeedbackService.deleteFeedback();

                            Navigator.pop(context);

                            if (!mounted) return;

                            if (result['success'] == true) {
                              setState(() {
                                _isDeleting = false;
                              });
                              await _loadFeedback();

                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result['message']),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            } else {
                              setState(() {
                                _isDeleting = false;
                              });
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(result['message']),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Hapus"),
                        ),
                      ],
              );
            },
          ),
        );
      },
    );
  }

  // Widget untuk menampilkan card feedback
  Widget _buildFeedbackCard() {
    final feedback = _feedbackData!['feedback'];
    final pengguna = feedback['pengguna'];

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan nama user dan edit icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pengguna['nama_lengkap'],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      pengguna['email'],
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showFeedbackDialog(existingFeedback: _feedbackData);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.edit,
                      color: Theme.of(context).primaryColor,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Rating
          Row(
            children: [
              RatingStars(
                value: feedback['rating'].toDouble(),
                starBuilder: (index, color) => Icon(
                  FontAwesomeIcons.solidStar,
                  color: color,
                  size: 20,
                ),
                starCount: 5,
                starSize: 20,
                maxValue: 5,
                starSpacing: 4,
                maxValueVisibility: false,
                valueLabelVisibility: false,
                starColor: Theme.of(context).primaryColor,
                starOffColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(width: 8),
              Text(
                "${feedback['rating']}.0",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Review
          Text(
            feedback['review'],
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 16),

          // Tanggal
          Row(
            children: [
              Icon(
                FontAwesomeIcons.calendar,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                "Dibuat: ${_formatDate(feedback['created_at'])}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget untuk tampilan tidak ada feedback
  Widget _buildNoFeedback() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
            child: Center(
              child: Icon(
                FontAwesomeIcons.commentDots,
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Belum Ada Feedback",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Bagikan pengalaman Anda menggunakan aplikasi ini untuk membantu kami menjadi lebih baik",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.8),
                  Theme.of(context).primaryColor.withOpacity(0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                _showFeedbackDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                shadowColor: Colors.transparent,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.plus,
                    size: 20,
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Buat Feedback",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk format tanggal
  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          "Feedback Pengguna",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        actions: [
          if (_feedbackData == null && !_isLoading)
            IconButton(
              onPressed: () {
                _showFeedbackDialog();
              },
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : RefreshIndicator(
                color: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).cardColor,
                onRefresh: _loadFeedback,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      /// ================= ERROR MESSAGE =================
                      if (_errorMessage.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.exclamationTriangle,
                                color: Colors.red,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _errorMessage,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _errorMessage = '';
                                  });
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.times,
                                  color: Colors.red,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),

                      /// ================= CONTENT =================
                      if (_feedbackData != null)
                        Column(
                          children: [
                            _buildFeedbackCard(),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: _isDeleting
                                  ? Container(
                                      height: 56,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Theme.of(context).cardColor,
                                      ),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: _showDeleteConfirmation,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        minimumSize: const Size(double.infinity, 56),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.trash,
                                            size: 20,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            "Hapus Feedback",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        )
                      else
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: _buildNoFeedback(),
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}