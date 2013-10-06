import QtQuick 1.1

Rectangle {
    width: 400
    height: 400
    color: C.Colors.Background

    Repeater {
        model: C.Items.Count

        Text {
            y: index * C.Step.Y
            x: index * C.Step.X
            color: C.Colors.Foreground
            font.bold: C.BoldText
            font.pointSize: C.FontSize
            text: C.CustomText + C.Items.Suffixes[index]
        }
    }
}
