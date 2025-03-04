import 'package:flutter/material.dart';
//import 'package:practice/pdf_with_api/pdf_viewer.dart';

import 'pdf_viewer.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  final List<Map<String, String>> books = [
    {
      'title': 'Test PDF 1',
      'url': 'https://onlinetestcase.com/wp-content/uploads/2023/06/1.5-MB.pdf',
    },
    {
      'title': 'Test PDF 2',
      'url': 'https://onlinetestcase.com/wp-content/uploads/2023/06/1.5-MB.pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book List')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: const Icon(Icons.picture_as_pdf, color: Colors.green, size: 30),
            title: Text(books[index]['title']!),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfViewer(url: books[index]['url']!),
              ),
            ),
          );
        },
      ),
    );
  }
}
