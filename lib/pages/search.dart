import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  final List countryList;

  Search(this.countryList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? countryList
        : countryList
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 130,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey[100],
                  blurRadius: 10,
                  offset: Offset(0, 10)),
            ]),
            child: Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(suggestionList[index]['country'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Image.network(
                          suggestionList[index]['countryInfo']['flag'],
                          height: 50,
                          width: 60,
                        ),
                      ],
                    )),
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          'Confirmed:' +
                              suggestionList[index]['cases'].toString(),
                          style: TextStyle(
                              color: Colors.red[800],
                              fontWeight: FontWeight.bold)),
                      Text(
                          'Active:' +
                              suggestionList[index]['active'].toString(),
                          style: TextStyle(
                              color: Colors.yellow[800],
                              fontWeight: FontWeight.bold)),
                      Text(
                          'Recovered:' +
                              suggestionList[index]['recovered'].toString(),
                          style: TextStyle(
                              color: Colors.green[800],
                              fontWeight: FontWeight.bold)),
                      Text(
                          'Deaths:' +
                              suggestionList[index]['deaths'].toString(),
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ))
              ],
            ),
          );
        });
  }
}
