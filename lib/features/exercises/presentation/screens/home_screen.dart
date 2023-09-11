import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym/core/services/di.dart';
import 'package:gym/core/utils/svg.dart';
import 'package:gym/core/widgets/connectivity_builder.dart';
import 'package:gym/features/exercises/domain/entities/exercise.dart';
import 'package:gym/features/exercises/presentation/components/exercise_card.dart';
import 'package:gym/features/exercises/presentation/controller/exercises_cubit.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ExercisesCubit>()..fetchExercises(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(
                Icons.logout_outlined,
                color: CupertinoColors.systemRed,
                size: 30,
              ),
            ),
          ],
        ),
        body: ConnectivityBuilder(
          onlineBuilder: (context) =>
              BlocBuilder<ExercisesCubit, ExercisesStates>(
            builder: (context, state) {
              if (state is FetchExerciseDataLoadingState) {
                return _buildLoadingShimmer();
              } else if (state is FetchExerciseDataSuccessState) {
                return _buildExerciseList(state.exercises);
              } else if (state is FetchExerciseDataFailureState) {
                return _buildErrorState();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          offlineBuilder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      SvgUtils.noInternet,
                      height: 300,
                    ),
                    Text(
                      'لا يوجد اتصال بالانترنت',
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: const SizedBox(
            height: 300,
            width: double.infinity,
          ),
        );
      },
    );
  }

  Widget _buildExerciseList(List<Exercise> exercises) {
    return ListView.builder(
      itemCount: exercises.length,
      itemBuilder: (BuildContext context, int index) {
        Exercise exercise = exercises[index];
        return ExerciseCard(exercise: exercise);
      },
    );
  }

  Widget _buildErrorState() {
    return const Center(
      child: Text('Failed to fetch data. Please try again later.'),
    );
  }
}
