import Qt 4.7
import "colibri"

Rectangle {
    id: page

    property variant widgets

    width: 800
    height: 480

    Grid {
        id: grid
        columns: 2
        anchors.centerIn: parent
        spacing: 10

        Row {
            CLButton { text: "←"; onClicked: { controller.prev(page) } }
            CLButton { text: "→"; onClicked: { controller.next(page) } }
        }

        Text { id: position; text: " " }

        Text { text: "Model:" }

        CLLineEdit { id: model }

        Text { text: "Brand:" }

        CLLineEdit { id: brand }

        Text { text: "Year:" }

        Column {
            spacing: 10
            CLSlider {
                id: year
                minimum: 1900
                maximum: 2010
            }
            Text {
                text: year.value
            }
        }

        Text { text: " " }

        Row {
            spacing: 10
            CLCheckBox { id: inStock }
            Text { text: "In Stock" }
        }
    }

    Component.onCompleted: {
        widgets = {
            'position': position,
            'model': model,
            'brand': brand,
            'year': year,
            'inStock': inStock,
        }
        controller.init(page)
    }
}
