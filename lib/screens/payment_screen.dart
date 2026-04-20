import 'package:flutter/material.dart';
import '../state/mock_appointments.dart';

class PaymentScreen extends StatelessWidget {
  final Appointment appointment;

  const PaymentScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            MockAppointments.pay(appointment);
            Navigator.pop(context);
          },
          child: Text("Pay ₪${appointment.price}"),
        ),
      ),
    );
  }
}