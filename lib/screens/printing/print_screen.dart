import 'dart:typed_data';
import '../../model/pdf_models/invoice.dart';
import '../../model/pdf_models/supplier.dart';
import '../../service/pdf/pdf_invoice_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../../model/pdf_models/customer.dart';

class PrintScreen extends StatelessWidget {
  const PrintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PdfPreview(
        build: (format) => _generatePdf(),
      ),
    );
  }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    final date = DateTime.now();
    final dueDate = date.add(const Duration(days: 7));

    final invoice = Invoice(
      supplier: const Supplier(
        name: 'Dinarkom',
        address: 'Sarah Street 9, Beijing, China',
        paymentInfo: 'https://paypal.me/sarahfieldzz',
      ),
      customer: const Customer(
        name: 'Kareem Muhammad',
        address: 'Apple Street, Cupertino, CA 95014',
      ),
      info: InvoiceInfo(
        date: date,
        dueDate: dueDate,
        description: 'My description...',
        number: '${DateTime.now().year}-9999',
      ),
      items: [
        InvoiceItem(
          description: 'Digital Photo',
          date: DateTime.now(),
          quantity: 3,
          vat: 0.19,
          unitPrice: 5.99,
        ),
      ],
    );

    await PdfInvoiceApi.generate(invoice,pdf);

    return pdf.save();
  }
}
