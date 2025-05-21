showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Padding(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Search',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),

                            //! User TextForm Field
                            TextFormField(
                              decoration: InputDecoration(
                                isDense: false,
                                hintText: 'Type here..',
                                filled: true,
                                fillColor: Colors.grey[300],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(90), 
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(5),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey[600],
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                         // Your Action
                                        },
                                        child: Text('Search', style: TextStyle(color: Colors.blue)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              autofocus: true, //! Open keyboard
                            ),
                          ],
                        ),
                      ));
