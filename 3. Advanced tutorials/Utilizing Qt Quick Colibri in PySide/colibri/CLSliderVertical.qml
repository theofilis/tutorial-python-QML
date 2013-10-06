/**
 *  Copyright © 2010 Digia Plc
 *  Copyright © 2010 Nokia Corporation
 *
 *  All rights reserved.
 *
 *  Nokia and Nokia Connecting People are registered trademarks of
 *  Nokia Corporation.
 *  Java and all Java-based marks are trademarks or registered
 *  trademarks of
 *  Sun Microsystems, Inc. Other product and company names
 *  mentioned herein may be
 *  trademarks or trade names of their respective owners.
 *
 *
 *  Subject to the conditions below, you may, without charge:
 *
 *  ·  Use, copy, modify and/or merge copies of this software and
 *     associated documentation files (the "Software")
 *
 *  ·  Publish, distribute, sub-licence and/or sell new software
 *     derived from or incorporating the Software.
 *
 *
 *  This file, unmodified, shall be included with all copies or
 *  substantial portions
 *  of the Software that are distributed in source code form.
 *
 *  The Software cannot constitute the primary value of any new
 *  software derived
 *  from or incorporating the Software.
 *
 *  Any person dealing with the Software shall not misrepresent
 *  the source of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
 *  KIND, EXPRESS OR IMPLIED,
 *  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 *  MERCHANTABILITY, FITNESS FOR A
 *  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT
 *  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 *  WHETHER IN AN ACTION
 *  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *  CONNECTION WITH THE
 *  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
import Qt 4.7
import "javascripts/functions.js" as Functions

Rectangle {
    id: structure

    property CLStyle style: CLStyle {}
    property color bgColor: style.bgColor
    property color colorWhenDefault: style.colorWhenDefault
    property color colorWhenPressed: style.colorWhenPressed
    property color colorWhenHovered: style.colorWhenHovered
    property real roundness: style.roundness
    property int borderWidth: style.borderWidth
    property color borderColor: style.borderColor
    property color borderColorWhenHovered: style.borderColorWhenHovered
    property color borderColorWhenPressed: style.borderColorWhenPressed
    property int borderWidthInner: style.borderWidthInner
    property color borderColorInner: style.borderColorInner
    property color borderColorInnerWhenHovered: style.borderColorInnerWhenHovered
    property color borderColorInnerWhenPressed: style.borderColorInnerWhenPressed
    property real minimum: 0
    property real maximum: 100
    property real pixelValue: (maximum - minimum) / (structure.height - (margin*2) - sled.height);
    property real value: 0
    property int sliderSize: structure.width - 2*margin
    property int margin: 2
    property Gradient gradientBg: style.gradientBg
    property Gradient gradientWhenDefault: style.gradientWhenDefault
    property Gradient gradientWhenHovered: style.gradientWhenHovered
    property Gradient gradientWhenPressed: style.gradientWhenPressed
    property bool gradientDefaultOn: style.gradientDefaultOn
    property bool gradientHoveredOn: style.gradientHoveredOn
    property bool gradientPressedOn: style.gradientPressedOn
    property bool gradientBgOn: style.gradientBgOn
    property bool hoveredStateOn: style.hoveredStateOn
    property bool pressedStateOn: style.pressedStateOn
    property int sledHeight: sliderSize*2
    property int sledWidth: (structure.width - (margin*2))
    /* Properties for background images
     * --------------------------------
     * This solution is temporary. Remember performance.
     */
    property Image nullImage: Image { //this property is "private" don't write it to documentation
        id: "null"
        source: ""
    }
    property Gradient nullGradient: Gradient{}
    property Image backgroundImage: nullImage
    property Image sledImage: nullImage
    property Image sledImageWhenHovered: nullImage
    property Image sledImageWhenPressed: nullImage
    property Image currentImage: sledImage //this property is "private" don't write it to documentation
    property bool allowScale : false

    signal clicked(int value)

    /**
     * Sets sliders value
     *
     * @param insertValue The new value
     * @return Nothing
     */
    function setValue (insertValue) {
        if (insertValue <= minimum) {
            sled.y = mouseArea.drag.minimumY;
            return;
        }
        if (insertValue > minimum) {
            if (insertValue > maximum) insertValue = maximum;
            sled.y = Math.round( mouseArea.drag.minimumY + ((insertValue - minimum)/pixelValue) );
        }
    }

    onWidthChanged: {
        if (allowScale) {
            if ((value + 0.00001) < maximum) {
                setValue(value + 0.00001);
                setValue(value - 0.00001);
            } else {
                setValue(value - 0.00001);
                setValue(value + 0.00001);
            }
        }
    }

    onHeightChanged: {
        if (allowScale) {
            if ((value + 0.00001) < maximum) {
                setValue(value + 0.00001);
                setValue(value - 0.00001);
            } else {
                setValue(value - 0.00001);
                setValue(value + 0.00001);
            }
        }
    }

    Component.onCompleted: {
        if (!hoveredStateOn) stateHovered.destroy();
        if (!pressedStateOn) statePressed.destroy();
        allowScale = true;
    }

    height: 200
    width: 16
    smooth: true
    radius: (structure.width/2)*roundness
    border.color: borderColor
    border.width: borderWidth
    color: bgColor
    gradient: (gradientBgOn)?gradientBg:nullGradient

    Image {
        id: image2

        source:  if (backgroundImage.id != "null") backgroundImage.source;
        width: parent.width
        height: parent.height
        fillMode: if (backgroundImage.id != "null") backgroundImage.fillMode;
        anchors.centerIn: parent
        smooth: true
    }

    Rectangle {
        id: sled

        height: sledHeight
        width: sledWidth
        y: mouseArea.drag.minimumY
        smooth: true
        radius: ((structure.width - (margin*2)) / 2)*roundness
        color: colorWhenDefault
        gradient: (gradientDefaultOn)?gradientWhenDefault:nullGradient
        border.color: borderColorInner
        border.width: borderWidthInner
        anchors.horizontalCenter: structure.horizontalCenter

        onYChanged: {
            structure.value = Math.round(minimum+(structure.pixelValue * (sled.y - structure.margin)));
        }

        MouseArea {
            id: mouseArea

            onClicked: structure.clicked(structure.value);
            hoverEnabled: true
            anchors.fill: parent
            drag.target: sled
            drag.axis: Drag.YAxis
            drag.minimumY: margin
            drag.maximumY: structure.height - margin - sled.height
        }

        Image {
            id: image

            source: if (currentImage.id != "null") currentImage.source;
            width: parent.width
            height: parent.height
            fillMode: if (currentImage.id != "null") currentImage.fillMode;
            anchors.centerIn: parent
            smooth: true
        }
    }

    states: [
    State {
        id: statePressed

        name: "pressed"; when: mouseArea.pressed

        PropertyChanges { target: sled; color: colorWhenPressed; gradient: (gradientPressedOn)?gradientWhenPressed:nullGradient; border.color: borderColorInnerWhenPressed; }
        PropertyChanges { target: structure; border.color: borderColorWhenPressed; currentImage: sledImageWhenPressed }
    },
    State {
        id: stateHovered

        name: "entered"; when: mouseArea.containsMouse

        PropertyChanges { target: sled; color: colorWhenHovered; gradient: (gradientHoveredOn)?gradientWhenHovered:nullGradient; border.color: borderColorInnerWhenHovered; }
        PropertyChanges { target: structure; border.color: borderColorWhenHovered; currentImage: sledImageWhenHovered }
    }
    ]
}
