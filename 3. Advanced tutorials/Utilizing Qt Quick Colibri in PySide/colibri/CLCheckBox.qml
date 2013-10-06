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
    id: structure;

    property CLStyle style: CLStyle {}
    property color colorWhenHovered: style.colorWhenHovered
    property color colorWhenDefault: style.colorWhenDefault
    property color textColor: style.textColor
    property real roundness: style.roundness
    property color borderColor: style.borderColor
    property int borderWidth: style.borderWidth
    property int fontSize: style.fontSize
    property string fontFamily: style.fontFamily
    property variant fontWeight: style.fontWeight
    property color borderColorWhenHovered : style.borderColorWhenHovered
    property bool gradientDefaultOn: style.gradientDefaultOn
    property bool gradientHoveredOn: style.gradientHoveredOn
    property bool gradientCheckedOn:  true
    property bool hoveredStateOn: style.hoveredStateOn
    property Gradient gradientWhenDefault: style.gradientWhenDefault
    property Gradient gradientWhenHovered: style.gradientWhenHovered
    property Gradient gradientWhenChecked: style.gradientWhenChecked
    property bool checked: false
    property string checkMark: "\u2717"
    property bool useTick: false
    property color borderColorWhenChecked: style.borderColorWhenChecked
    property color colorWhenChecked: style.colorWhenChecked

    /* Properties for background images
     * --------------------------------
     * This solution is temporary. Remember performance.
     */

    property Image nullImage: Image { //this property is "private" don't write it to documentation
        id: "null"

        source: ""
        width: structure.width
        height: structure.height
    }
    property Gradient nullGradient: Gradient{}
    property Image checkedImage: nullImage

    signal clicked( bool checked )

    Component.onCompleted: {
        if (!hoveredStateOn) stateHovered.destroy();

        if (checkedImage.source == "") image.destroy();
        else propertyChangeCheckMark.destroy();

        if (useTick) text.text = "\u2713"
        else text.text = checkMark

        //structure.width = Functions.returnBigger(text.width,text.height) + 5;
        //structure.height = Functions.returnBigger(text.width,text.height)+ 5;

        if (!checked) text.text = ""
    }

    width: Functions.returnBigger(text.width,text.height) + 5
    height: Functions.returnBigger(text.width,text.height) + 5
    color: colorWhenDefault
    gradient: (gradientDefaultOn)?gradientWhenDefault:nullGradient
    border.width: borderWidth
    border.color: borderColor
    radius: Functions.countRadius(roundness,width,height,0,1)
    smooth: true

    Image {
        id: image

        source: if(checkedImage.id != "null") checkedImage.source
        width: checkedImage.width
        height: checkedImage.height
        scale: checkedImage.scale
        anchors.verticalCenter: structure.verticalCenter
        anchors.horizontalCenter: structure.horizontalCenter
        visible: (checked)?true:false;
        smooth: structure.smooth
    }

    Text {
        id: text

        anchors.verticalCenter: structure.verticalCenter
        anchors.horizontalCenter: structure.horizontalCenter
        font.pointSize: 0.001+fontSize
        color: textColor
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        onClicked: {
            checked = !checked
            structure.clicked( checked )
        }

        hoverEnabled: true
    }

    states: [
    State {
        id: stateChecked

        name: "checked"; when: checked

        PropertyChanges {
            id: propertyChangeCheckMark

            target: text
            text: {
               if (useTick) "\u2713"
               else checkMark
            }
        }
        PropertyChanges { target: structure; border.color: borderColorWhenChecked; color: colorWhenChecked; gradient: (gradientCheckedOn)?gradientWhenChecked:nullGradient }
    },
    State {
        id: stateHovered

        name: "entered"; when: mouseArea.containsMouse

        PropertyChanges { target: structure; border.color: borderColorWhenHovered; color: colorWhenHovered; gradient: (gradientHoveredOn)?gradientWhenHovered:nullGradient }
    }
    ]
}
