import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../model/search_data.dart';
import '../service/search_address.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  bool _showClearIcon = false;
  List<SearchData> _searchData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _searchController.addListener(() {
      setState(() {
        _showClearIcon = _searchController.text.isNotEmpty;
      });
    });
    _searchController.addListener(_onSearchTextChange);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChange);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchTextChange() async {
    final text = _searchController.text;
    if (text.isEmpty) {
      setState(() {
        _searchData.clear();
      });
      return;
    }
    final searchData = await SearchCity().fetchSearchData(text);
    //_searchData = searchData;
    if (!mounted) return;
    setState(() {
      _searchData = searchData;
    });
  }

  String ResultsearchData = 'Nhập điểm đến';
  void _onSearchResultTap(int index) {
    ResultsearchData = _searchData[index].name ?? 'n';
    print(ResultsearchData);
    Navigator.pop(context, ResultsearchData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    hoverColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 3, color: Colors.amber)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(width: 3, color: Colors.amber)),
                    prefixIcon: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, ResultsearchData);
                      },
                      child: Icon(
                        Icons.chevron_left_outlined,
                        size: 45,
                      ),
                    ),
                    prefixIconColor: Colors.black54,
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_showClearIcon)
                          IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _showClearIcon = false;
                              });
                            },
                          ),
                      ],
                    ),
                    hintText: 'Nhập điểm đến'),
              ),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _searchData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                      height: 80,
                      width: 60.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: _searchData[index].image ?? '',
                            fit: BoxFit.cover,
                          )
                          /* Image.network(_searchData[index].image ?? '',
                            fit: BoxFit.cover), */
                          ),
                    ),
                    title: Text(_searchData[index].name ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                      '${_searchData[index].subName}\n${_searchData[index].hotelsCount} chỗ nghỉ',
                    ),
                    onTap: () {
                      _onSearchResultTap(index);
                    },
                  ),
                );
              },
            ))
          ]),
        ),
      ),
    );
  }
}
