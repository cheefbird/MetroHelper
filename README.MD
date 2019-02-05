[![Build Status](https://app.bitrise.io/app/34dd5af89cbae174/status.svg?token=NxVlykzbLw0HNRFFulV5jw&branch=master)](https://app.bitrise.io/app/34dd5af89cbae174)

# Metro Helper

The Metro Helper is a native iOS app that is meant to help Los Angeles-based Metro riders solve the constant question of "When is the next train coming??" In the case of the red and purple lines, it might be more like "When is this train leaving??"

The default LA Metro app tends to be pretty much garbage, and teh Google Maps implementation can be hard to understand for some users. Instead, Metro Helper is both accurate and easy to use!

## Core Metro Helper Features

- Add or remove Metro stops from your very own list.
- For any stop, get accurate predictions of when the next train will arrive.
- For any resulting prediction, tap it to find out it's _exact location_ on a map.

## Predicton Accuracy

This app uses geolocation data provided by trackers that are built into every train in service. This allows Metro Helper to get accurate and up-to-the-second predictions for how far away the next train(s) are, AND their exact GPS coordinates.

# Installation

To install and run locally, follow these steps:

1. Clone this repo using the **master** branch
2. Using the command line, navigate to the project's root directory. (You're in the right place when you see "MetroHelper.xcworkspace")
3. From the command line, run "pod install"
4. Open the "MetroHelper.xcworkspace" file using XCode.

Once XCode is open, you can build the project and start modifying it, OR select a target device to run it using Simulator.
