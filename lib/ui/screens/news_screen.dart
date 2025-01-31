import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SpaceXPage extends StatelessWidget {
  final String fetchLaunchesQuery = """
    {
              topStories(limit: 10) {
                title
                url
                score
              }
            }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SpaceX Launches')),
      body: Query(
        options: QueryOptions(
          document: gql(fetchLaunchesQuery),
          pollInterval: Duration(seconds: 60), // Refresh every 60 seconds
        ),
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.hasException) {
            return Center(child: Text('Error: ${result.exception.toString()}'));
          }

          final List<dynamic> stories = result.data?['topStories'];

          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];
              return ListTile(
                title: Text(story['title']),
                subtitle: Text('Score: ${story['score']}'),
                onTap: () {
                  // Handle tap
                },
              );
            },
          );
        },
      ),
    );
  }
}

class LaunchTile extends StatelessWidget {
  final dynamic launch;

  LaunchTile({required this.launch});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        title: Text(launch['mission_name'] ?? 'No Name'),
        subtitle: Text(launch['launch_date_utc'] ?? 'No Date'),
        trailing: Icon(Icons.launch),
        onTap: () {
          final articleUrl = launch['links']['article_link'];
          if (articleUrl != null) {
            _openLaunchUrl(context, articleUrl);
          }
        },
      ),
    );
  }

  void _openLaunchUrl(BuildContext context, String url) {
    launchUrl(Uri.parse(url)); // Open launch article
  }
}
