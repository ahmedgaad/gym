import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gym/core/extensions/sized_box.dart';
import 'package:gym/features/exercises/domain/entities/exercise.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: exercise.thumbnail,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ), 
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                8.ph,
                Row(
                  children: [
                    const Icon(Icons.access_time),
                    4.pw,
                    Text('${exercise.seconds} seconds'),
                  ],
                ),
                16.ph,
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('View Exercise'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
