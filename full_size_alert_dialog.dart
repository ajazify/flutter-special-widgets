  Future<dynamic> fullSizeDialog({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero, // Remove default padding
          child: Material(
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Full Size Dialogue'),
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                body: const Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
