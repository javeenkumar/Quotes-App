import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes_app/services/Quotes.dart';
import 'package:quotes_app/services/models/QuotesModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<QuotesModel?> _quotesFuture;

  @override
  void initState() {
    super.initState();
    _refreshQuotes();
  }

  void _refreshQuotes() {
    setState(() {
      _quotesFuture = Quotes().getQuotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          // toolbarHeight: 200, // Allow full height
          title: Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: Image.asset(
              'assets/logo.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
        ),


        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<QuotesModel?>(
              future: _quotesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: SpinKitCircle(
                    size: 50,
                    color: Colors.black,
                  ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Failed to load quote'),
                        Text(
                          snapshot.error.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _refreshQuotes,
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No quotes available'));
                } else {
                  final quote = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                quote.quote.toString(),
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontStyle: FontStyle.italic),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '- ${quote.author}',
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,

                        ),
                        onPressed: () {
                          _refreshQuotes();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.refresh,color: Colors.black,),
                            SizedBox(width: 5),
                            Text('Refresh', textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 16),),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
