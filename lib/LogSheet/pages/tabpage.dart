import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/Sign_Up_Page.dart';
import '../detaill.dart';

bool loadingde = false;
DateTime dateTime = DateTime.now();

bool chipselected1 = false;
bool chipselected2 = false;
bool chipselected3 = false;
bool chipselected4 = false;
DateTime start = DateTime.now()
    .copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
DateTime today = DateTime.now();

class TabPage extends StatefulWidget {
  final String title;
  final bool mystock;
  const TabPage({
    Key? key,
    required this.title,
    required this.mystock,
  }) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  void dispose() {
    stockItems.clear();
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      loadingde = true;
      chipselected2 = false;
      chipselected3 = false;
      chipselected4 = false;
      chipselected1 = true;
      start = DateTime.now().copyWith(
          hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
      today = DateTime.now();
    });

    stock();
    //  loadingde = false;
    super.initState();
  }

  String? selectedStock;

  Future ss() => showDialog(
      barrierDismissible: false,
      barrierLabel: 'data',
      context: context,
      builder: (context) => WillPopScope(
            onWillPop: () async {
              setState(() {
                loadingde = false;
              });
              return true;
            },
            child: StatefulBuilder(
              builder: (context, setStat) => Center(
                child: AlertDialog(
                  title: Column(
                    children: [
                      if (widget.mystock == false)
                        StreamBuilder<QuerySnapshot>(
                            stream: ref1.snapshots(),
                            builder: (context, snapshots) {
                              List<DropdownMenuItem> stockItems = [];

                              if (!snapshots.hasData) {
                                const CircularProgressIndicator();
                              } else {
                                final stock = snapshots.data?.docs.toList();

                                stockItems.add(const DropdownMenuItem(
                                    value: "0",
                                    child: Text(
                                      'All Users',
                                      style: TextStyle(color: Colors.black87),
                                    )));

                                if (stock!.isNotEmpty) {
                                  for (var stocks in stock) {
                                    stockItems.add(
                                      DropdownMenuItem(
                                        value: stocks.get('email'),
                                        child: Text(
                                          stocks['email'],
                                          style: const TextStyle(
                                              color: Colors.black87),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              }
                              return DropdownButton(
                                hint: const Text('All Users'),
                                dropdownColor: Colors.white,
                                items: stockItems,
                                onChanged: (StockValue) {
                                  setStat(
                                    () {
                                      selectedStock = StockValue;
                                      emailid = StockValue;
                                    },
                                  );
                                },
                                value: selectedStock,
                                isExpanded: true,
                              );
                            }),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ChoiceChip(
                              elevation: 2,
                              pressElevation: 4,
                              labelPadding: EdgeInsets.all(4),
                              label: Text(
                                'Today',
                              ),
                              // backgroundColor: Colors.black,
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              // shadowColor: Colors.white,
                              selected: chipselected1,
                              // selectedColor: Colors.white,
                              onSelected: (val) {
                                setStat(() {
                                  chipselected1 = val;
                                  today = DateTime.now();
                                  start = DateTime.now().copyWith(
                                      hour: 0,
                                      minute: 0,
                                      second: 0,
                                      millisecond: 0,
                                      microsecond: 0);

                                  if (val) {
                                    chipselected2 = false;
                                    chipselected3 = false;
                                    chipselected4 = false;
                                  }
                                });
                              },
                            ),

                            ChoiceChip(
                              elevation: 2,
                              pressElevation: 4,
                              labelPadding: EdgeInsets.all(4),
                              label: Text(
                                'week',
                              ),
                              // backgroundColor: Colors.black,
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              // shadowColor: Colors.white,
                              selected: chipselected2,
                              // selectedColor: Colors.white,
                              onSelected: (val) {
                                setStat(() {
                                  chipselected2 = val;

                                  today = DateTime.now();
                                  start = DateTime.now()
                                      .subtract(Duration(days: 7));
                                  if (val) {
                                    chipselected1 = false;
                                    chipselected3 = false;
                                    chipselected4 = false;
                                  }
                                });
                              },
                            ),
                            // SizedBox(width: 14),
                            ChoiceChip(
                              elevation: 2,
                              pressElevation: 4,
                              labelPadding: EdgeInsets.all(4),
                              label: Text(
                                'Month',
                              ),
                              // backgroundColor: Colors.black,
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              // shadowColor: Colors.white,
                              selected: chipselected3,
                              // selectedColor: Colors.white,
                              onSelected: (val) {
                                setStat(() {
                                  chipselected3 = val;
                                  today = DateTime.now();
                                  start = DateTime.now()
                                      .subtract(Duration(days: 30));
                                  if (val) {
                                    chipselected1 = false;
                                    chipselected2 = false;
                                    chipselected4 = false;
                                  }
                                });
                              },
                            ),

                            ChoiceChip(
                              elevation: 2,
                              pressElevation: 4,
                              labelPadding: EdgeInsets.all(4),
                              label: Text(
                                'custom',
                              ),
                              // backgroundColor: Colors.black,
                              labelStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              // shadowColor: Colors.white,
                              selected: chipselected4,
                              // selectedColor: Colors.white,
                              onSelected: (val) async {
                                if (val) {
                                  try {
                                    DateTimeRange? newDateTimeRange =
                                        await showDateRangePicker(
                                            context: context,
                                            firstDate: DateTime(2023, 07, 01),
                                            lastDate: DateTime.now());
                                    setStat(() {
                                      start = newDateTimeRange!.start;
                                      today = newDateTimeRange.end
                                          .add(Duration(days: 1));
                                    });
                                  } catch (e) {}
                                  chipselected1 = false;
                                  chipselected2 = false;
                                  chipselected3 = false;
                                }
                                setStat(() {
                                  chipselected4 = val;
                                });

                                //${newDateTimeRange!.start}   ${newDateTimeRange.end}');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            loadingde = false;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Done'))
                  ],
                ),
              ),
            ),
          ));

  stock() async {
    if (widget.mystock) {
      User? user = FirebaseAuth.instance.currentUser;

      var collection = FirebaseFirestore.instance
          .collection('All Users Data')
          .doc(user!.uid)
          .collection('operations');

      var snap = await collection.get();

      for (var doc1 in snap.docs) {
        stockItems.add(doc1.data());
      }

      setState(() {
        emailid = user.email;
        loadingde = false;
      });
    } else {
      var collection = FirebaseFirestore.instance.collection('All Users Data');
      var snaps = await collection.get();

      for (var doc in snaps.docs) {
        var collection1 = FirebaseFirestore.instance
            .collection('All Users Data')
            .doc(doc.id)
            .collection('operations');
        var snap = await collection1.get();

        for (var doc1 in snap.docs) {
          stockItems.add(doc1.data());
        }
      }

      setState(() {
        emailid = '0';
        loadingde = false;
      });
    }
  }

  final List<Widget> tabs = const [
    Tab(
      text: "All Data",
    ),
    Tab(
      text: 'Add Product',
    ),
    Tab(
      text: 'Consume Product',
    ),
    Tab(
      text: 'Edit Product',
    ),
    Tab(
      text: 'Delete Product',
    ),
    Tab(
      text: 'Add Quantity',
    ),
    Tab(
      text: 'Add Category',
    ),
    Tab(
      text: 'Edit Category',
    ),
    Tab(
      text: 'Delete Category',
    ),
  ];

  final List<Widget> tabBarViews = [
    const MyWidget(
      operation: 'All',
    ),
    const MyWidget(
      operation: 'Add',
    ),
    const MyWidget(
      operation: 'Consume',
    ),
    const MyWidget(
      operation: 'Edit',
    ),
    const MyWidget(
      operation: 'Delete',
    ),
    const MyWidget(
      operation: 'Add Qty',
    ),
    const MyWidget(
      operation: 'Add C',
    ),
    const MyWidget(
      operation: 'edit C',
    ),
    const MyWidget(
      operation: 'delete C',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 9,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.sort),
        ),
        appBar: AppBar(
          // backgroundColor: Colors.black87,
          title: Text(
            widget.title,
            style:
                const TextStyle(fontWeight: FontWeight.w400, letterSpacing: 8),
          ),
          bottom: TabBar(
            physics: BouncingScrollPhysics(),
            tabAlignment: TabAlignment.start,
            tabs: tabs,
            isScrollable: true,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    loadingde = true;
                  });

                  ss();
                  // setState(() {
                  //   emailid = selectedStock.toString();
                  // });
                },
                icon: const Icon(Icons.filter_alt)),
            IconButton(
                onPressed: () {
                  excel_op();
                  // setState(() {
                  //   emailid = selectedStock.toString();
                  // });
                },
                icon: const Icon(Icons.table_view_sharp))
          ],
        ),
        body: loadingde
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.black54,
              ))
            : TabBarView(
                children: tabBarViews,
              ),
        /* DefaultTabController(
          initialIndex: 0,
          length: 7,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black87),
                tabs: tabs,
                isScrollable: true,
              ),
              const Divider(
                thickness: 0.5,
              ),
              SizedBox(
                height: 735,
                child: load
                    ? Scaffold()
                    : TabBarView(
                        children: tabBarViews,
                      ),
              ),
            ],
          ),
        ),*/
      ),
    );
  }
}

enum Calendar { day, week, month, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
            value: Calendar.day,
            label: Text('Day'),
            icon: Icon(Icons.calendar_view_day)),
        ButtonSegment<Calendar>(
            value: Calendar.week,
            label: Text('Week'),
            icon: Icon(Icons.calendar_view_week)),
        ButtonSegment<Calendar>(
            value: Calendar.month,
            label: Text('Month'),
            icon: Icon(Icons.calendar_view_month)),
        ButtonSegment<Calendar>(
            value: Calendar.year,
            label: Text('Year'),
            icon: Icon(Icons.calendar_today)),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
}
