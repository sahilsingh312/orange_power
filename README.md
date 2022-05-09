# orange_power

A new Flutter project.

## Running and Testing the app

Just type `flutter run` in the command line of your IDE to run the app.
Type `flutter test` in the command line of your IDE to run the test cases.

## Video demo



https://user-images.githubusercontent.com/6002066/167493423-64fb1ba0-394c-4421-a22b-428e3f08d237.mp4

## Some points:

* I am using responsive_framework to scale and resize the app. I haven't targetted more bigger screens like 4k or web but it can easily be done.
* I am using get_it for dependency injection both in the app and test cases
* I am using http to make the network call and provider to use the data recieved from the api.
* The business logic is completely separate from the UI logic
* As charts were getting bigger, I divided them in dates to show multiple charts grouped by date and further more I divided those charts as well if they got cumbersome.
* I could had used 'next' in the api call to recieve more data and use inifinite scroll and more bar charts to display those data but I thought that it would be overkill but if its needed then I can definately do it.
* I am using `ValueNotifier` instead of `sestState` to rebuild only the part of the screen that needs rebuilding rather than the whole screen.
* I am doing unit testing to test bth of the function that calculates  the best “future” tariff and the cheapest consecutive 4-hour block 

