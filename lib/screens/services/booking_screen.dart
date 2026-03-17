import 'package:flutter/material.dart';
 
class BookingScreen extends StatefulWidget {
  final String serviceName;
  final int price;
 
  const BookingScreen({
    super.key,
    required this.serviceName,
    required this.price,
  });
 
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}
 
class _BookingScreenState extends State<BookingScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
 
  Future<void> pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)),
      initialDate: now,
      locale: const Locale("he", "IL"),
    );
 
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }
 
  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
 
    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("קביעת תור - ${widget.serviceName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.serviceName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
 
            const SizedBox(height: 10),
 
            Text(
              "מחיר: ${widget.price} ₪",
              style: const TextStyle(fontSize: 18),
            ),
 
            const SizedBox(height: 30),
 
            ElevatedButton(
              onPressed: pickDate,
              child: Text(
                selectedDate == null
                    ? "בחר תאריך"
                    : "תאריך: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
            ),
 
            const SizedBox(height: 20),
 
            ElevatedButton(
              onPressed: pickTime,
              child: Text(
                selectedTime == null
                    ? "בחר שעה"
                    : "שעה: ${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}",
              ),
            ),
 
            const Spacer(),
 
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (selectedDate != null && selectedTime != null)
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("התור נקבע בהצלחה!"),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "אישור תור",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 