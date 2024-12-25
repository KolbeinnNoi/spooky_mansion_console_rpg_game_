import 'display_text_delayed.dart';
import 'file_paths.dart';
import 'dart:io';
import 'get_room_name.dart';
import 'console_colors.dart';
import 'handle_lockbox_code.dart';

// void main() async {
//   String currentRoom = EntrywayFilePath;
//   bool isIntro = true; // Handle intro text separately
//   Map<String, bool> visitedRooms = {}; // Tracks if a room has been visited

//   while (true) {
//     // Check if the room has been visited before
//     bool isFirstVisit = !(visitedRooms[currentRoom] ?? false);

//     // Mark the room as visited
//     visitedRooms[currentRoom] = true;

//     // Display the room name only for main room entries
//     if (!isFirstVisit) {
//       print('${blue}\nYou are now in ${getRoomName(currentRoom)}.${end}');
//       print("-----------------------------------------");
//     }

//     // Display room description only on the first visit
//     final choices = await displayTextWithChoices(
//       currentRoom,
//       Duration(milliseconds: 50),
//       isFirstVisit
//     );

//     if (choices.isEmpty) {
//       print('No actions available. Game over.');
//       break;
//     }

//     // Display choices
//     print('${yellow}\nWhat do you want to do?${end}');
//     print("----------------------------------------");
//     choices.forEach((key, value) => print('${cyan}$key. ${value['text']}${end}'));

//     // Get player input
//     final input = stdin.readLineSync();
//     final choice = int.tryParse(input ?? '');
//     print("----------------------------------------");

//     if (choice != null && choices.containsKey(choice)) {
//       // Update the currentRoom
//       currentRoom = choices[choice]!['path']!;
//     } else {
//       print('${red}Invalid choice. Try again.${end}');
//     }
//   }
// }

void main() async {
  String currentRoom = EntrywayFilePath;
  List<String> inventory = []; // Track player's items
  Map<String, bool> visitedRooms = {}; // Tracks if a room has been visited

  while (true) {
    // Check if the currentRoom is a main room
    bool isMain = isMainRoom(currentRoom);
    bool isFirstVisit = !(visitedRooms[currentRoom] ?? false);

    // Mark the room as visited
    visitedRooms[currentRoom] = true;

    // Display the room name only for main rooms
    if (isMain) {
      if (!isFirstVisit || currentRoom != EntrywayFilePath) {
        print('${blue}\nYou are now in ${getRoomName(currentRoom)}.${end}');
        print("-----------------------------------------");
      }
    }

    // Ensure sub-elements always show their text and options
    final choices = await displayTextWithChoices(
      currentRoom,
      Duration(milliseconds: 50),
      isMain ? isFirstVisit : true // Main rooms follow first-visit logic; sub-elements always display text
    );

    if (choices.isEmpty) {
      print('No actions available. Game over.');
      break;
    }

    // Display choices
    print('${yellow}\nWhat do you want to do?${end}');
    print("----------------------------------------");
    choices.forEach((key, value) => print('${cyan}$key. ${value['text']}${end}'));

    // Get player input
    final input = stdin.readLineSync();
    final choice = int.tryParse(input ?? '');
    print("----------------------------------------");

    if (choice != null && choices.containsKey(choice)) {
      // Update the currentRoom
      currentRoom = choices[choice]!['path']!;
    } else {
      print('${red}Invalid choice. Try again.${end}');
    }
  }
}






