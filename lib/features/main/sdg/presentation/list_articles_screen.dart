import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ipqaia/app/themes/colors.dart';
import 'package:ipqaia/core/extensions/theme_extensions.dart';
import 'package:ipqaia/core/shared/app_custom_button.dart';
import 'package:ipqaia/core/shared/dropdownfield.dart';
import 'package:ipqaia/core/shared/search_bar.dart';

@RoutePage()
class ListArticlesScreen extends StatefulWidget {
  const ListArticlesScreen({super.key});

  @override
  State<ListArticlesScreen> createState() => _ListArticlesScreenState();
}

class _ListArticlesScreenState extends State<ListArticlesScreen> {
  TextEditingController searchController = TextEditingController();
  String? selectedValue;
  List<String> dropdownOptions = [
    "Technology",
    "Health",
    "Finance",
    "Education"
  ];

  // Sample Data
  List<Map<String, String>> articles = [
    {
      "sdg": "4",
      "title": "Quality Education",
      "link": "https://example.com/education"
    },
    {
      "sdg": "3",
      "title": "Good Health & Well-Being",
      "link": "https://example.com/health"
    },
    {
      "sdg": "9",
      "title": "Industry & Innovation",
      "link": "https://example.com/industry"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundSecondary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20),
              width: 350,
              child: CustomSearchBar(
                controller: searchController,
                onChanged: (String value) {
                  log("Search query: $value");
                },
              ),
            ),
            Row(
              children: [
                DropdownField<String>(
                  title: "Category",
                  options: dropdownOptions,
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  optionLabel: (option) => option,
                ),
                Gap(20),
                AppCustomButton(
                  ontab: () {},
                  backgroundColor: AppColors.primary,
                  text: "Add New Category",
                )
              ],
            )
          ],
        ),
      ),
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
                                      "Link",
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
                                            article["link"]!,
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          onTap: () {
                                            log("Opening link: ${article['link']}");
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
