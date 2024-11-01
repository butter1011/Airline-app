import 'package:airline_app/provider/selected_counter_provider.dart';
import 'package:airline_app/screen/reviewsubmission/question_first_screen.dart';
import 'package:airline_app/utils/airport_list_json.dart';
import 'package:airline_app/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailFirstScreen extends ConsumerWidget {
  const DetailFirstScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selections = ref.watch(itemSelectionProvider);
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final String singleAspect = args?['singleAspect'] ?? '';

  

    // Ensure itemListForSingleAspect is not null
    final List itemListForSingleAspect =
        aspectsForElevation[singleAspect]['items'] ?? [];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.3,
        flexibleSpace: buildQuestionHeader(), // Assuming this method exists
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              _buildBackButton(context),
              SizedBox(height: 10),
              _buildHeaderContainer(
                  context, singleAspect, selections.where((s) => s).length),
              SizedBox(height: 16),
              _buildFeedbackOptions(ref, itemListForSingleAspect),
              SizedBox(height: 12),
              _buildOptionalText(),
              SizedBox(height: 6),
              _buildTextField(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
        SizedBox(width: 2),
        Text('Go Back', style: AppStyles.textStyle_16_600),
      ],
    );
  }

  Widget _buildHeaderContainer(
      BuildContext context, String singleAspect, int length) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: AppStyles.cardDecoration.copyWith(
        borderRadius: BorderRadius.circular(24),
        color: AppStyles.mainColor,
      ),
      child: Row(
        children: [
          Container(
            height: 32,
            width: 32,
            decoration: AppStyles.iconDecoration,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                "assets/icons/review_icon_boarding.png",
                width: 18,
                height: 18,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(singleAspect, style: AppStyles.textStyle_14_600),
          ),
          Container(
            height: 20,
            width: 20,
            decoration: AppStyles.badgeDecoration,
            child: Center(
              child: Text(
                length.toString(),
                style: AppStyles.textStyle_13_600,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackOptions(WidgetRef ref, List itemListForSingleAspect) {
    List isSelectedList = ref.watch(itemSelectionProvider);

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: List.generate(itemListForSingleAspect.length, (index) {
        return GestureDetector(
          onTap: () {
            ref.read(itemSelectionProvider.notifier).toggleSelection(index);
          },
          child: IntrinsicWidth(
            child: Container(
              height: 40,
              decoration: AppStyles.cardDecoration.copyWith(
                  borderRadius: BorderRadius.circular(16),
                  color: isSelectedList[index]
                      ? AppStyles.mainColor
                      : Colors.white),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    itemListForSingleAspect[index].toString(),
                    style: AppStyles.textStyle_14_600,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOptionalText() {
    return Row(
      children: [
        Text("Others ", style: AppStyles.textStyle_14_600),
        Text(
          " (Optional)",
          style: AppStyles.textStyle_14_600.copyWith(color: Color(0xff97A09C)),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Expanded(
      child: Container(
        decoration: AppStyles.cardDecoration.copyWith(
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextFormField(
          maxLines: null, // Allows unlimited lines
          decoration: InputDecoration(
            hintText: "What did you also like?",
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
