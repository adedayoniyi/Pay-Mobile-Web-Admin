// import 'package:fl_chart/fl_chart.dart';

// class LineChartSample extends StatelessWidget {
//   final List<Transactions> transactions;

//   LineChartSample({required this.transactions});

//   @override
//   Widget build(BuildContext context) {
//     final spots = transactions
//         .asMap()
//         .map((index, transaction) => MapEntry(
//             index,
//             FlSpot(transaction.createdAt.millisecondsSinceEpoch.toDouble(),
//                 index.toDouble())))
//         .values
//         .toList();

//     return LineChart(
//       LineChartData(
//         minX: transactions.first.createdAt.millisecondsSinceEpoch.toDouble(),
//         maxX: transactions.last.createdAt.millisecondsSinceEpoch.toDouble(),
//         minY: 0,
//         maxY: transactions.length.toDouble(),
//         lineBarsData: [
//           LineChartBarData(
//             spots: spots,
//             isCurved: true,
//             color: Colors.blue,
//             barWidth: 2,
//           ),
//         ],
//         titlesData: FlTitlesData(
//           bottomTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 22,
//             margin: 10,
//             getTitles: (value) {
//               final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
//               return date.day % 30 == 0 ? '${date.month}/${date.day}' : '';
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
