Wrap(
   spacing: 8,
   runSpacing: 8,
   children: (snapshot.data!.docs[index]['project_ownership'] as List<dynamic>)
                  .map((ownership) => Chip(label: Text(ownership)))
                  .toList(),),
