import 'package:cab_rider/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:cab_rider/repository/models/prediction.dart';
import 'package:cab_rider/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PredictionListItem extends StatelessWidget {
  final PredictionModel predict;
  const PredictionListItem(this.predict, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 1, spreadRadius: 0.5, color: Colors.black26)
      ]),
      child: ListTile(
        onTap: () {
          BlocProvider.of<MainScreenBloc>(context)
              .add(GetSelectedPlaceDetailsEvent(placeId: predict.placeId!));
        },
        leading: const Icon(
          Icons.location_on,
          color: MyColors.colorDimText,
        ),
        title: Text(
          predict.mainText!,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          predict.secondaryText!,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
