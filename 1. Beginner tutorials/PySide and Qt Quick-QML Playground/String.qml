import QtQuick 1.0

Item {
    id: my_container
    width: 30
    height: 10
    property alias text: my_text.text
    property alias color: my_text.color

    Text {
        id: my_text
        anchors.fill: parent
    }
}
