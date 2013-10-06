import QtQuick 1.0

Rectangle {
    id: main_window
    width: 200
    height: 200

    Grid {
        columns: 3
        spacing: 2

        String {text: "One"; color: "red"}
        String {text: "Two"; color: "green"}
        String {text: "Three"; color: "blue"}
        String {text: "Four"; color: "black"}
        String {text: "Five"; color: "yellow"}
        String {text: "Six"; color: "pink"}
     }
}
