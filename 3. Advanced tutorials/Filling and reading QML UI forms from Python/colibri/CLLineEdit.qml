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

/* TODO:
 * Next releases of Qt will change the usage of selectionStart and selectionEnd properties.
 * Properties are to be change to read only properties.
 * For selection functionalities, there will be select (start, end) -function.
 * When these changes are made, this component's selectionStart & selectionEnd- functionalities
 * has to be changed corresponding selection funtionality.
 */

Rectangle {
    id: rectangle

    property CLStyle style: CLStyle {}
    property bool activeStateOn: style.activeStateOn
    property color borderColor: style.borderColor
    property color borderColorWhenActive: style.borderColorWhenActive
    property color borderColorWhenHovered: style.borderColorWhenHovered
    property int borderWidth: style.borderWidth
    property color colorWhenDefault: style.colorWhenDefault
    property color colorWhenActive: style.colorWhenDefault
    property color colorWhenHovered: style.colorWhenHovered
    property string fontFamily: style.fontFamily
    property real fontSize: style.fontSize
    property variant fontWeight: style.fontWeight
    property bool gradientActiveOn: style.gradientActiveOn
    property bool gradientDefaultOn: style.gradientDefaultOn
    property bool gradientHoveredOn: style.gradientHoveredOn
    property Gradient gradientWhenActive: style.gradientWhenDefault
    property Gradient gradientWhenDefault: style.gradientWhenDefault
    property Gradient gradientWhenHovered: style.gradientWhenHovered
    property bool hoveredStateOn: style.hoveredStateOn
    property real roundness: style.itemRoundness
    property color textColor: style.textColor
    property color textColorWhenSelected: style.selectedTextColor
    property color textAreaColorWhenSelected: style.selectionColor
    property int maxLength: -1
    property bool cursorVisible: false
    property alias selectionStart: lineEdit.selectionStart
    property alias selectionEnd: lineEdit.selectionEnd
    property alias cursorPosition: lineEdit.cursorPosition
    property bool setFocus: false
    property alias text: lineEdit.text
    property Gradient nullGradient: Gradient{}

    signal clicked()
    signal textChange()

    width: 150
    height: 30
    color: rectangle.colorWhenDefault
    smooth: false
    radius: Functions.countRadius(roundness,width,height,0,1)
    border.color: rectangle.borderColor
    border.width: rectangle.borderWidth


    Component.onCompleted: {
        if (!rectangle.hoveredStateOn) stateHovered.destroy();
        if (!rectangle.activeStateOn) stateActive.destroy();
        if (maxLength != -1 && lineEdit.text.length >= maxLength) {
            lineEdit.text = lineEdit.text.slice(0,maxLength);
            lineEdit.cursorPosition = maxLength;
        }
    }

    /**
     * Function which can be used to insert text in lineEdit.
     *
     * @param insert Text to insert.
     * @return nothing
     */
    function insertText(insert) {
        var selection = lineEdit.selectedText;
        var selectionStart = lineEdit.selectionStart;
        var selectionEnd = lineEdit.selectionEnd;
        if (selection == "") {
            var cursor = lineEdit.cursorPosition;
            var start = lineEdit.text.substring(0,cursor);
            var end = lineEdit.text.substring(cursor,lineEdit.text.length);
            var resultText = ""+start+insert+end;
            lineEdit.text = resultText;
            lineEdit.cursorPosition = cursor+1;
        }
        else {
            var start = lineEdit.text.substring(0,selectionStart);
            var end = lineEdit.text.substring(selectionEnd,lineEdit.text.length);
            var resultText = ""+start+insert+end;
            lineEdit.text = resultText;
            lineEdit.cursorPosition = selectionEnd;
        }
    }

    /**
     * Function which is used to remove text in text lineEdit.
     */
    function removeText() {
        var selection = lineEdit.selectedText;
        var selectionStart = lineEdit.selectionStart;
        var selectionEnd = lineEdit.selectionEnd;
        if (selection == "") {
            var cursor = lineEdit.cursorPosition;
            if (cursor > 0) {
                var cursor = lineEdit.cursorPosition;
                var start = lineEdit.text.substring(0,cursor-1);
                var end = lineEdit.text.substring(cursor,lineEdit.text.length);
                var resultText = ""+start+end;
                lineEdit.text = resultText;
                lineEdit.cursorPosition = cursor-1;
            }
            else {
                lineEdit.cursorPosition = 0;
            }
        }
        else {
            var start = lineEdit.text.substring(0,selectionStart);
            var end = lineEdit.text.substring(selectionEnd,lineEdit.text.length);
            var resultText = ""+start+end;
            lineEdit.text = resultText;
            lineEdit.cursorPosition = selectionStart;
        }
    }

    /**
     * Makes text selection between given parameters
     *
     * @param start where selection starts.
     * @param end where selection ends.
     *
     */
    function selectText (start,end){
        lineEdit.cursorPosition = start;
        lineEdit.moveCursorSelection(end);
        return;
    }

    Rectangle {
        id: gradientContainer

        anchors.fill: rectangle
        color: rectangle.colorWhenDefault
        gradient: (rectangle.gradientDefaultOn)?rectangle.gradientWhenDefault:rectangle.nullGradient
        radius: rectangle.radius
    }

    MouseArea {
        id: mouseArea

        anchors.fill: rectangle
        onClicked: rectangle.clicked()
        hoverEnabled: true;
    }

    TextInput {
        id: lineEdit

        onTextChanged: {
            rectangle.textChange()
            if (maxLength != -1 && lineEdit.text.length >= maxLength) {
                lineEdit.text = lineEdit.text.slice(0,maxLength);
                lineEdit.cursorPosition = maxLength;
            }
        }
        text: ""
        x: roundness*5+2
        focus: rectangle.setFocus
        cursorVisible: rectangle.cursorVisible
        width: rectangle.width - x *2
        height: rectangle.height * 0.5
        font.family: fontFamily
        font.pointSize: lineEdit.height * 0.6
        font.weight: fontWeight
        color: textColor
        anchors.verticalCenter: rectangle.verticalCenter
        selectedTextColor: textColorWhenSelected
        selectionColor: textAreaColorWhenSelected
        selectByMouse:true
    }
    states: [
    State {
        id: stateActive
        name: "active"; when: lineEdit.focus
        PropertyChanges { target: gradientContainer; gradient: (rectangle.gradientActiveOn)?rectangle.gradientWhenActive:rectangle.nullGradient;}
        PropertyChanges { target: rectangle; border.color: rectangle.borderColorWhenActive }
        PropertyChanges { target: rectangle; color: rectangle.colorWhenActive}

    },
    State {
        id: stateHovered
        name: "entered"; when: mouseArea.containsMouse
        PropertyChanges { target: gradientContainer; gradient: (rectangle.gradientHoveredOn)?rectangle.gradientWhenHovered:rectangle.nullGradient;}
        PropertyChanges { target: rectangle; border.color: rectangle.borderColorWhenHovered }
        PropertyChanges { target: rectangle; color: rectangle.colorWhenHovered}
    }
    ]
}
