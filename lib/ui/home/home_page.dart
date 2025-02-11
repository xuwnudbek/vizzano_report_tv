import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vizzano_report_tv/ui/home/provider/home_provider.dart';
import 'package:vizzano_report_tv/utils/extensions/datetime_extension.dart';
import 'package:vizzano_report_tv/utils/extensions/time_of_day_extension.dart';
import 'package:vizzano_report_tv/utils/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider()..initialize(),
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            body: LayoutBuilder(builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: provider.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        spacing: 8,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: constraints.maxWidth - 16,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: provider.motivations.isEmpty
                                    ? Center(
                                        child: Text("Charchamanglar!"),
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            flex: 11,
                                            child: DefaultTextStyle(
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                                              ),
                                              child: AnimatedTextKit(
                                                repeatForever: true,
                                                animatedTexts: [
                                                  ...provider.motivations.map(
                                                    (motivation) => FadeAnimatedText(
                                                      motivation['title'] ?? "Unknown",
                                                      fadeOutBegin: 0.6,
                                                      fadeInEnd: 0.3,
                                                      textAlign: TextAlign.center,
                                                      duration: const Duration(seconds: 10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                          provider.sewingOutputs.isEmpty
                              ? Center(
                                  child: Text("Ma'lumotlar topilmadi!"),
                                )
                              : Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.light,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Table(
                                      border: TableBorder.all(
                                        color: AppColors.dark.withValues(alpha: 0.2),
                                        width: 1,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      columnWidths: {
                                        0: FixedColumnWidth(100),
                                        1: FlexColumnWidth(1),
                                        2: FlexColumnWidth(3),
                                        3: FlexColumnWidth(1),
                                        4: FlexColumnWidth(1),
                                      },
                                      children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Center(
                                                child: Text(
                                                  "#",
                                                  style: textTheme.titleLarge,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                    "Guruh",
                                                    style: textTheme.titleLarge,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                                child: Text(
                                                  "Maxsulot",
                                                  style: textTheme.titleLarge,
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                    "Miqdor",
                                                    style: textTheme.titleLarge,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                    "Jami",
                                                    style: textTheme.titleLarge,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ...provider.sewingOutputs.map((sewingOutput) {
                                          int index = provider.sewingOutputs.indexOf(sewingOutput);

                                          String emoji = ["🥇", "🥈", "🥉"].elementAtOrNull(index) ?? "";

                                          return TableRow(
                                            decoration: BoxDecoration(
                                              color: index.isEven ? AppColors.light : AppColors.dark.withValues(alpha: 0.1),
                                            ),
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                    "${index < 3 ? emoji : index + 1}",
                                                    style: textTheme.bodyLarge,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                    sewingOutput['group']?['name'] ?? "Unknown",
                                                    style: textTheme.bodyLarge,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                child: Text.rich(
                                                  TextSpan(text: sewingOutput['model']?['name'] ?? "Unknown", style: textTheme.bodyLarge?.copyWith(), children: [
                                                    TextSpan(
                                                      text: " — ",
                                                      style: textTheme.bodyLarge,
                                                    ),
                                                    TextSpan(
                                                      text: sewingOutput['submodel']?['name'] ?? "Unknown",
                                                      style: textTheme.bodyLarge?.copyWith(),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                    "${sewingOutput['today_quantity'] ?? 0}",
                                                    style: textTheme.bodyLarge,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                child: Center(
                                                  child: Text(
                                                    "${sewingOutput['total_quantity'] ?? 0}",
                                                    style: textTheme.bodyLarge,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                          Container(
                            width: constraints.maxWidth - 16,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.light,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "Oxirgi yangilanish:",
                                    style: textTheme.bodySmall?.copyWith(color: AppColors.dark),
                                    children: [
                                      TextSpan(
                                        text: " ${provider.updatedAt?.stringTime}",
                                        style: textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // current real time
                                Text(
                                  provider.time,
                                  style: textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              );
            }),
          );
        },
      ),
    );
  }
}
