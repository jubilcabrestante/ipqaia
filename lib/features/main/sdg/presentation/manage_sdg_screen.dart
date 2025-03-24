import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';

@RoutePage()
class ManageSdgScreen extends StatefulWidget {
  const ManageSdgScreen({super.key});

  @override
  State<ManageSdgScreen> createState() => _ManageSdgScreenState();
}

class _ManageSdgScreenState extends State<ManageSdgScreen> {
  List<String> dropdownOptions = [
    "Technology",
    "Health",
    "Finance",
    "Education"
  ];

  // Sample Data
  List<Map<String, String>> articles = [
    {"sdg": "4", "title": "Quality Education", "word": "quality, education"},
    {
      "sdg": "3",
      "title": "Good Health & Well-Being",
      "word": "healthy, eat, diet"
    },
    {"sdg": "9", "title": "Industry & Innovation", "word": "improve, innovate"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.backgroundSecondary,
          title: Align(
            alignment: Alignment.topRight,
            child: AppCustomButton(
              ontab: () {},
              backgroundColor: AppColors.primary,
              text: "Add SDG",
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double columnWidth = constraints.maxWidth * 0.2;

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: constraints.maxWidth),
                      child: DataTable(
                        columnSpacing: constraints.maxWidth * 0.05,
                        headingRowColor:
                            WidgetStateProperty.all(AppColors.primary),
                        headingTextStyle: context.textTheme.titleSmall!
                            .copyWith(color: AppColors.textSecondary),
                        columns: [
                          DataColumn(
                              label: SizedBox(
                                  width: columnWidth * 0.5,
                                  child: Center(
                                    child: Text(
                                      "SDG",
                                      textAlign: TextAlign.center,
                                    ),
                                  ))),
                          DataColumn(
                              label: SizedBox(
                                  width: columnWidth * 1,
                                  child: Center(
                                    child: Text(
                                      "Title",
                                      textAlign: TextAlign.center,
                                    ),
                                  ))),
                          DataColumn(
                              label: SizedBox(
                                  width: columnWidth * 1,
                                  child: Center(
                                    child: Text(
                                      "Words",
                                      textAlign: TextAlign.center,
                                    ),
                                  ))),
                          DataColumn(
                              label: SizedBox(
                                  width: columnWidth * 0.8,
                                  child: Center(
                                    child: Text(
                                      "Action",
                                      textAlign: TextAlign.center,
                                    ),
                                  ))),
                        ],
                        rows: articles
                            .map(
                              (article) => DataRow(
                                cells: [
                                  DataCell(
                                    SizedBox(
                                      width: columnWidth *
                                          0.5, // Match DataColumn width
                                      child: Center(
                                        child: Text(article["sdg"]!),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: columnWidth *
                                          1, // Match DataColumn width
                                      child: Center(
                                        child: Text(article["title"]!),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: columnWidth *
                                          1, // Match DataColumn width
                                      child: Center(
                                        child: InkWell(
                                          child: Text(
                                            article["word"]!,
                                          ),
                                          onTap: () {
                                            log("Opening word: ${article['word']}");
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 0),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          AppCustomButton(
                                            ontab: () {
                                              setState(() {
                                                articles.remove(article);
                                              });
                                            },
                                            backgroundColor:
                                                AppColors.secondary,
                                            text: "edit",
                                          ),
                                          AppCustomButton(
                                            ontab: () {
                                              setState(() {
                                                articles.remove(article);
                                              });
                                            },
                                            backgroundColor: AppColors.delete,
                                            text: "delete",
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
