import 'package:calculator/models/history.dart';
import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  final List<ExpressionHistory> history;

  HistoryList({this.history});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      height: mediaQuery.height * 0.8,
      width: mediaQuery.width * 0.9,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: history.isEmpty
          ? NoItems()
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                int listIndex = index;
                return ListTile(
                  dense: true,
                  title: Text(
                    history[listIndex].expression,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Text(
                    history[listIndex].dateCreated.toString().split(' ')[0],
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              },
            ),
    );
  }
}

class NoItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.error_outline),
                color: Colors.white,
                onPressed: () => null,
                iconSize: 80,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'No items...',
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
