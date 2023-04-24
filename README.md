<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
# triangle_seekbar
A Simple triangle shape seekbar


## Features

User select a new value for the seekbar by dragging.
When a new value passed to the seekbar, The seekbar's thumb is drawn at a position that corresponds to this value

![example](https://drive.google.com/file/d/1QwqYWX-ZHl9Uy-jLrYWm874KhTZfQVr0/view?usp=share_link)
## Getting started
```
import 'package:triangle_seekbar/triangle_seekbar.dart';

  TriangleSeekbar(
                onChanged: (value) {
                  setState(() {
                    seekbarValue = value;
                  });
                },
                value: seekbarValue,
                height: 150,
                min: 1,
                max: 10,
              ),
```

