# PitchPerfect
Record and distort sounds with six pre-set options.

# Project Overview
An app that allows users to record their voice and modulate the recorded audio to sound like a Chipmunk or Darth Vader. This app also lets the user speed up or slow down the rate of playback, and experience fun echo and reverb effects. The app demonstrates use of:
+ Creating a new project from existing iOS app templates
+ Adding buttons, images, labels and create user interfaces for the app using the Storyboard
+ Leveraging the Model View Controller (MVC) design principles; this includes writing custom model code, and using UIViewController, and UIView
+ Creating Outlet and Action connections between the views and view controllers. Benefit from the power of Delegates by using them in code
+ Navigating between two scenes in the app using UINavigationController
+ Playing audio files using AVFoundation’s AVAudioEngine class
+ Running the iOS simulator and download the app on a physical device
+ Searching documentation, resolve bugs, and read other people’s code

# Specifications
+ The app contains two pages of content (one each for recording and playing audio), and uses UINavigationController to navigate between these two scenes.
+ UI elements are appropriately positioned on the screen for iPhone and iPad portrait and landscape layouts.
+ The app connects each button on the Storyboard to the correct IBAction method.
+ In the first scene, the Record and Stop buttons are enabled and disabled appropriately. When no recording is taking place, the Record button is enabled and the Stop button is disabled. When recording is taking place, the Record button is disabled and the Stop button is enabled.
+ The app successfully uses AVAudioRecorder to record audio.
+ The app uses the delegate pattern and implements the audioRecorderDidFinishRecording() method.
+ The app does not use a Storyboard segue hardcoded to the Stop button. A segue from the first scene to the second is programmatically triggered via performSegueWithIdentifier().
+ The app allows the user to re-record by navigating back to the first scene from the second.
+ The second scene of the app contains the following buttons for audio effects: Snail (slow), Rabbit (fast), Chipmunk (high pitch), Darth Vader (low pitch), Echo and Reverb. All six buttons work properly to play the associated sounds.
+ Potentially repetitive blocks of code are effectively abstracted into reusable methods.
+ Code adheres to Swift naming and style conventions.
+ Code is readable and easy to follow. Any code that may be hard to understand is commented effectively.
