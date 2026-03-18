import 'package:flutter/material.dart';
 
class BusinessTypeSelectionScreen extends StatelessWidget {
  const BusinessTypeSelectionScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D), // רקע שחור יוקרתי
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "בחר סוג עסק",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBusinessButton(context, "מספרה"),
            const SizedBox(height: 16),
            _buildBusinessButton(context, "קוסמטיקה"),
            const SizedBox(height: 16),
            _buildBusinessButton(context, "טיפולי יופי"),
            const SizedBox(height: 16),
            _buildBusinessButton(context, "עיסויים"),
            const SizedBox(height: 16),
            _buildBusinessButton(context, "אחר"),
          ],
        ),
      ),
    );
  }
 
  Widget _buildBusinessButton(BuildContext context, String title) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        // מעבר למסך הראשי
        Navigator.pushNamed(context, "/dashboard");
      },
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
 