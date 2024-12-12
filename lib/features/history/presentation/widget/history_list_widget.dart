import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';
import 'package:ricecare_mobile/features/history/domain/entities/detection_history.dart';
import 'package:ricecare_mobile/features/history/presentation/bloc/history_bloc.dart';
import 'package:ricecare_mobile/features/history/presentation/pages/history_detection_page.dart';
import 'package:intl/intl.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is HistoryLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HistoryLoadedState) {
          Map<String, List<DetectionHistory>> groupedHistory = {};
          for (var item in state.history) {
            DateTime detectionDate = DateTime.parse(item.detection_date);
            String date = DateFormat('dd MMMM yyyy').format(detectionDate);
            groupedHistory.putIfAbsent(date, () => []).add(item);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: groupedHistory.keys.length,
            itemBuilder: (context, index) {
              String date = groupedHistory.keys.elementAt(index);
              List<DetectionHistory> items = groupedHistory[date]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      date,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.darkBackgroundColor,
                      ),
                    ),
                  ),
                  // Card untuk menampung item
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1), // Warna redup
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1), // Outline tipis
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: items.map((item) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryDetectionPage(
                                      historyDetails: item),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 2, // Elevation untuk card dalam card
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              item.image_path,
                                              width: 45,
                                              height: 45,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.disease.name_disease,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  item.disease.symptoms,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          DateFormat('dd MMM').format(
                                              DateTime.parse(
                                                  item.detection_date)),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('HH:mm').format(
                                              DateTime.parse(
                                                  item.detection_date)),
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else if (state is HistoryErrorState) {
          return Center(child: Text(state.message));
        }
        return const Center(child: Text('No history available'));
      },
    );
  }
}
