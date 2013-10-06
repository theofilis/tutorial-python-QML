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

Rectangle{
    id:container

    property CLStyle style: CLStyle {}
    property string content: ""
    property bool readOnly: false
    property int maxLength: -1
    property bool horizontalScale: false
    property int scrollBarHeight: 0 //dont't write to documentation
    property alias cursorPosition: textArea.cursorPosition
    property alias selectionStart: textArea.selectionStart
    property alias selectionEnd: textArea.selectionEnd
    property real buttonRoundness: style.itemRoundness
    property real sledRoundness: style.roundness
    property color colorWhenDefault: style.colorWhenDefault
    property real roundness: style.roundness
    property int borderWidth: style.borderWidth
    property color borderColor: style.borderColor
    property int fontSize: style.fontSize
    property color textColor: style.textColor
    property color textColorWhenSelected: style.selectedTextColor
    property color textAreaColorWhenSelected: style.selectionColor
    property string fontFamily: style.fontFamily
    property variant fontWeight: style.fontWeight
    property color bgColor: "transparent"
    property color scrollBarBgColor: style.bgColor
    property color colorWhenPressed: style.colorWhenPressed
    property color colorWhenHovered: style.colorWhenHovered
    property color borderColorWhenHovered: style.borderColorWhenHovered
    property color borderColorWhenPressed: style.borderColorWhenPressed //menen tässä
    property int borderWidthInner: style.borderWidthInner
    property color borderColorInner: style.borderColorInner
    property color borderColorInnerWhenHovered: style.borderColorInnerWhenHovered
    property color borderColorInnerWhenPressed: style.borderColorInnerWhenPressed
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
    property Image upBackgroundImage: upImage
    property Image downBackgroundImage: downImage
    property Image leftBackgroundImage: leftImage
    property Image rightBackgroundImage: rightImage
    property Image sledImage: nullImage
    property Image sledImageWhenHovered: nullImage
    property Image sledImageWhenPressed: nullImage

    //next properties are private ones
    property Gradient nullGradient: Gradient{}
    property Image nullImage: Image { //this property is "private" don't write it to documentation
        id: "null"

        source: ""
    }
    property real contentHeight: 0
    property real contentWidth: 0
    property int margin: 5
    property real heightDifference: 0
    property real widthDifference: 0
    property real lineHeight: whatismyLineHeight.height
    property int lineWidth: 6
    property real linesNonVisible: 0
    property real columnsNonVisible: 0
    property bool freeForScale: false
    property int cursorX: 0
    property int cursorY: 0

    property Image upImage: Image { //this property is "private" don't write it to documentation
        id: picUp

        source: "images/arrow_up_50x50.png"
        smooth: true
        height: lineHeight*0.65
        width: lineHeight*0.65
    }

    property Image downImage: Image { //this property is "private" don't write it to documentation
        id: picDown

        source: "images/arrow_down_50x50.png"
        smooth: true
        height: lineHeight*0.65
        width: lineHeight*0.65
    }
    property Image leftImage: Image { //this property is "private" don't write it to documentation
        id: picLeft

        source: "images/arrow_left_50x50.png"
        smooth: true
        height: lineHeight*0.65
        width: lineHeight*0.65
    }

    property Image rightImage: Image { //this property is "private" don't write it to documentation
        id: picRight

        source: "images/arrow_right_50x50.png"
        smooth: true
        height: lineHeight*0.65
        width: lineHeight*0.65
    }    
    // READ ONLY ENDS

    signal textChange()
    signal cursorPositionChange()

    /**
     * Relocates the visible area
     *
     * @return Nothing
     */
    function reLocate() {
        var visibleWidth = (scrollBarVertical.visible)? (textAreaMargin.width-lineHeight) : textAreaMargin.width;
        var visibleHeight = (scrollBarHorizontal.visible)? (textAreaMargin.height-lineHeight) : textAreaMargin.height;
        var tx = -textArea.x;
        var tx2 = -textArea.x + visibleWidth;
        var ty = -textArea.y;
        var ty2 = -textArea.y + visibleHeight;
        if (cursorX < tx) {
            if (textArea.cursorPosition == 0) textArea.x = 0;
            else textArea.x = -cursorX-5;
        }
        if (cursorX >= tx2) {
            if (textArea.cursorPosition == 0) textArea.x = 0;
            else textArea.x = -cursorX + visibleWidth;
        }
        if (cursorY < ty) {
            if (textArea.cursorPosition == 0) textArea.y = 0;
            else textArea.y = -cursorY;

        }
        if (cursorY >= ty2) {
            if (textArea.cursorPosition == 0) textArea.y = 0;
            else textArea.y = -cursorY + visibleHeight - lineHeight;
        }
    }

    /**
     * Checks cursor position
     *
     * @return Nothing
     */
    function cursorPos() {
        var textClip = textArea.text;
        var lastNewLineIndex = 0;
        textClip = textClip.substring(0, textArea.cursorPosition);

        // y
        var clipArray = textClip.split('\n');
        var theYPos = ( clipArray.length - 1 ) * lineHeight;
        if (!container.horizontalScale) {
            var availableContent = textAreaMargin.width;
            availableContent = (scrollBarVertical.visible)?(textAreaMargin.width-lineHeight):textAreaMargin.width;
            for (var i=0; i < clipArray.length; ++i) {
                myWidth.text = clipArray[i];
                theYPos += ( Math.floor(myWidth.width / availableContent) * lineHeight);
            }
        }
        container.cursorY = theYPos;

        // x
        lastNewLineIndex = textClip.lastIndexOf('\n');
        whatismyLineHeight.text = textClip.substring((lastNewLineIndex+1), textArea.cursorPosition);
        if (!container.horizontalScale) {
            var visibleWidth = (scrollBarVertical.visible)? (textAreaMargin.width-lineHeight) : textAreaMargin.width;
            container.cursorX = whatismyLineHeight.width % visibleWidth;
        } else {
            container.cursorX = whatismyLineHeight.width;
        }
        reLocate();
    }

    /**
     * Updates component when some property has been changed
     *
     * @return Nothing
     */
    function updateInfo () {
        contentHeight = textArea.height;
        heightDifference =  contentHeight - textAreaMargin.height;
        if (maxLength != -1 && textArea.text.length >= maxLength) {
            textArea.text = textArea.text.slice(0,maxLength);
            textArea.cursorPosition = maxLength;
        }

        if (heightDifference <= 0) {
            textArea.y = 0;
            scrollBarVertical.visible = false;
        } else {
            linesNonVisible = (horizontalScale)?Math.round(heightDifference/lineHeight)+1:Math.round(heightDifference/lineHeight);
            scrollBarVertical.visible = true;
            scrollBarVertical.maximum = (linesNonVisible <= 0)?1:linesNonVisible;
            scrollBarVertical.value = linesNonVisible;
        }

        if (horizontalScale) {
            contentWidth = (scrollBarVertical.visible)?(textArea.width + lineHeight):textArea.width;
            widthDifference =  contentWidth - textAreaMargin.width;
            if (widthDifference <= 0) {
                scrollBarHorizontal.visible = false;
            } else {
                columnsNonVisible = widthDifference/lineWidth;
                scrollBarHorizontal.visible = true;
                scrollBarHorizontal.maximum = (columnsNonVisible <= 1)?widthDifference:columnsNonVisible;
            }
        }
        if (freeForScale && !horizontalScale) {
            textArea.width = textAreaMargin.width;
            if (scrollBarVertical.visible) textArea.width = textAreaMargin.width-lineHeight;
        }
    }

    /**
     * Function which can be used to insert text in textarea.
     *
     * @param insert Text to insert.
     * @return nothing
     */
    function insertText(insert) {
        var selection = textArea.selectedText;
        var selectionStart = textArea.selectionStart;
        var selectionEnd = textArea.selectionEnd;
        if (selection == "") {
            var cursor = textArea.cursorPosition;
            var start = textArea.text.substring(0,cursor);
            var end = textArea.text.substring(cursor,textArea.text.length);
            var resultText = ""+start+insert+end;
            textArea.text = resultText;
            textArea.cursorPosition = cursor+1;
        } else {
            var start = textArea.text.substring(0,selectionStart);
            var end = textArea.text.substring(selectionEnd,textArea.text.length);
            var resultText = ""+start+insert+end;
            textArea.text = resultText;
            textArea.cursorPosition = selectionEnd;
        }
    }

    /**
     * Function which is used to remove text in text textarea.
     */
    function removeText() {
        var selection = textArea.selectedText;
        var selectionStart = textArea.selectionStart;
        var selectionEnd = textArea.selectionEnd;
        if (selection == "") {
            var cursor = textArea.cursorPosition;
            if (cursor > 0) {
                var cursor = textArea.cursorPosition;
                var start = textArea.text.substring(0,cursor-1);
                var end = textArea.text.substring(cursor,textArea.text.length);
                var resultText = ""+start+end;
                textArea.text = resultText;
                textArea.cursorPosition = cursor-1;
            } else {
                textArea.cursorPosition = 0;
            }

        } else {
            var start = textArea.text.substring(0,selectionStart);
            var end = textArea.text.substring(selectionEnd,textArea.text.length);
            var resultText = ""+start+end;
            textArea.text = resultText;
            textArea.cursorPosition = selectionStart;
        }
    }

    /**
     * Moves cursor to selected direction.
     *
     * @param direction Direction (in string) where cursor is moving.
     * Possible directions are "up","down","left" and "right"
     */
    function moveCursor (direction) {
        var text = textArea.text;
        var textClip = text.substring(0, textArea.cursorPosition);
        var clipArray = textClip.split('\n');
        var allLinesArray = text.split('\n');
        if (direction == "up" && clipArray.length > 1) var nextLineIndex = clipArray.length-2;
        else if (direction == "down" && clipArray.length < allLinesArray.length) var nextLineIndex = clipArray.length;
        else return;
        var lastNewLineIndex = 0;
        lastNewLineIndex = textClip.lastIndexOf('\n')+1;
        textClip = textClip.substring((lastNewLineIndex), textArea.cursorPosition);
        var currentPosition = textClip.length;
        var nextLineLength = allLinesArray[nextLineIndex].length+1;
        if (nextLineIndex < 1) var currentLineLength = allLinesArray[nextLineIndex].length+1;
        else var currentLineLength = allLinesArray[nextLineIndex-1].length+1;
        var here = 0;
        if (direction == "up") {
            if (currentPosition < nextLineLength && textArea.cursorPosition < nextLineLength) {
                here = textArea.cursorPosition-nextLineLength;
            } else if (currentPosition < nextLineLength && 0 < clipArray.length) {
                here =textArea.cursorPosition-nextLineLength;
            } else {
                here = lastNewLineIndex-1;
            }
        } else if (direction == "down") {
           if (currentPosition < nextLineLength) {
               here = textArea.cursorPosition+currentLineLength;
           } else {
              here = lastNewLineIndex+currentLineLength + nextLineLength-1;
           }
        } else return;
        textArea.cursorPosition = here;
    }

    Component.onCompleted: {
        contentHeight = textArea.height;
        heightDifference =  contentHeight - textAreaMargin.height;
        contentWidth = content.length*2;

        scrollBarHeight = lineHeight;
        if (maxLength != -1 && textArea.text.length >= maxLength) {
            textArea.text = textArea.text.slice(0,maxLength);
            textArea.cursorPosition = maxLength;
        }

        if (heightDifference <= 0) {
            scrollBarVertical.visible = false;
        } else {
            linesNonVisible = (horizontalScale)?Math.round(heightDifference/lineHeight)+1:Math.round(heightDifference/lineHeight);
            scrollBarVertical.visible = true;
            scrollBarVertical.maximum = (linesNonVisible <= 0)?1:linesNonVisible;
            contentHeight = textArea.height;
        }
        if(horizontalScale){
            contentWidth = (scrollBarVertical.visible)?(textArea.width + lineHeight):textArea.width;
            widthDifference =  contentWidth - textAreaMargin.width;
            if (widthDifference <= 0) {
                scrollBarHorizontal.visible = false;
            } else {
                columnsNonVisible = widthDifference/lineWidth;
                scrollBarHorizontal.visible = true;
                scrollBarHorizontal.maximum = (columnsNonVisible <= 1)?widthDifference:columnsNonVisible;
            }
        }
    }

    onWidthChanged: {updateInfo()}

    onHeightChanged: {updateInfo()}

    width: 200
    height: 100
    color: colorWhenDefault
    border{width:borderWidth;color:borderColor}
    radius: Functions.countRadius(roundness,width,height,0,1)

    TextEdit{
        id: whatismyLineHeight

        font.pointSize: fontSize
        font.family: fontFamily
        text: "W"
        visible: false
    }

    TextEdit{
        id: myWidth

        font.pointSize: fontSize
        font.family: fontFamily
        text: "W"
        visible: false
    }


    Rectangle{
        id: textAreaContainer

        width: container.width - container.radius
        height: container.height - container.radius
        anchors.centerIn: container
        color: container.bgColor
        clip: true

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            onClicked: textArea.focus = true
            hoverEnabled: true
        }

        Rectangle{
            id: textAreaMargin

            anchors{leftMargin: 4; topMargin: 4; centerIn: textAreaContainer; fill: parent}
            color: container.bgColor
            clip: true

            TextEdit {
                id: textArea

                onTextChanged: {
                    updateInfo();
                    container.textChange();
                }
                onCursorPositionChanged: {
                    cursorPos();
                    container.cursorPositionChange();
                }
                Component.onCompleted:{
                    if (text == "" || text == " ") textArea.cursorPosition = 0;
                    else textArea.cursorPosition = text.length;
                    if (!horizontalScale) {
                        textArea.width = textAreaMargin.width;
                        if (scrollBarVertical.visible) textArea.width = textAreaMargin.width-lineHeight;
                    }
                    freeForScale = true;
                    scrollBarHorizontal.value = 0;
                    scrollBarVertical.value = 0;
                    textArea.x = 0;
                    textArea.y = 0;
                }
                font.pointSize: fontSize
                color: textColor
                persistentSelection: false
                selectedTextColor: textColorWhenSelected
                selectionColor: textAreaColorWhenSelected
                text: (content == "")?" ":content
                width: if (!horizontalScale) textAreaMargin.width
                font.family: fontFamily
                wrapMode: (horizontalScale)? TextEdit.WordWrap : TextEdit.WrapAnywhere
                readOnly: container.readOnly
                selectByMouse:true
            }
        }

        CLScrollBarVertical{
            id:scrollBarVertical

            onValueChanged: {
                textArea.y = -value*lineHeight;
            }
            anchors.right: textAreaContainer.right
            anchors.top: textAreaContainer.top
            anchors.bottom: ( scrollBarHorizontal.visible )? scrollBarHorizontal.top : textAreaContainer.bottom;
            width: container.scrollBarHeight
            visible: false
            minimum: 0
            maximum: 100
            step: 1
            clip: true
            opacity: 1
            buttonRoundness: container.buttonRoundness
            sledRoundness: container.sledRoundness
            textColor:  container.textColor
            bgColor:  container.scrollBarBgColor
            colorWhenDefault:  container.colorWhenDefault
            colorWhenPressed:  container.colorWhenPressed
            colorWhenHovered:  container.colorWhenHovered
            borderColor:  container.borderColor
            borderColorWhenHovered:  container.borderColorWhenHovered
            borderColorWhenPressed:  container.borderColorWhenPressed
            borderColorInner:  container.borderColorInner
            borderColorInnerWhenHovered:  container.borderColorInnerWhenHovered
            borderColorInnerWhenPressed:  container.borderColorInnerWhenPressed
            gradientBg:  container.gradientBg
            gradientWhenDefault:  container.gradientWhenDefault
            gradientWhenHovered:  container.gradientWhenHovered
            gradientWhenPressed:  container.gradientWhenPressed
            gradientDefaultOn:  container.gradientDefaultOn
            gradientHoveredOn:  container.gradientHoveredOn
            gradientPressedOn:  container.gradientPressedOn
            gradientBgOn:  container.gradientBgOn
            hoveredStateOn:  container.hoveredStateOn
            pressedStateOn:  container.pressedStateOn
            nextBackgroundImage: container.downBackgroundImage
            previousBackgroundImage: container.upBackgroundImage
            sledImage:  container.sledImage
            sledImageWhenHovered:  container.sledImageWhenHovered
            sledImageWhenPressed:  container.sledImageWhenPressed
        }

        CLScrollBar{
            id:scrollBarHorizontal

            onValueChanged: {
                if (columnsNonVisible <= 1) textArea.x = -value*columnsNonVisible;
                else textArea.x = -value*lineWidth;
            }
            anchors.bottom: textAreaContainer.bottom
            anchors.right: ( scrollBarVertical.visible )? scrollBarVertical.left : textAreaContainer.right;
            anchors.left: textAreaContainer.left
            height: container.scrollBarHeight
            visible: false
            minimum: 0
            maximum: 100
            opacity: 1
            clip: true
            buttonRoundness: container.buttonRoundness
            sledRoundness: container.sledRoundness
            textColor:  container.textColor
            bgColor:  container.scrollBarBgColor
            colorWhenDefault:  container.colorWhenDefault
            colorWhenPressed:  container.colorWhenPressed
            colorWhenHovered:  container.colorWhenHovered
            borderColor:  container.borderColor
            borderColorWhenHovered:  container.borderColorWhenHovered
            borderColorWhenPressed:  container.borderColorWhenPressed
            borderColorInner:  container.borderColorInner
            borderColorInnerWhenHovered:  container.borderColorInnerWhenHovered
            borderColorInnerWhenPressed:  container.borderColorInnerWhenPressed
            gradientBg:  container.gradientBg
            gradientWhenDefault:  container.gradientWhenDefault
            gradientWhenHovered:  container.gradientWhenHovered
            gradientWhenPressed:  container.gradientWhenPressed
            gradientDefaultOn:  container.gradientDefaultOn
            gradientHoveredOn:  container.gradientHoveredOn
            gradientPressedOn:  container.gradientPressedOn
            gradientBgOn:  container.gradientBgOn
            hoveredStateOn:  container.hoveredStateOn
            pressedStateOn:  container.pressedStateOn
            nextBackgroundImage: container.rightBackgroundImage
            previousBackgroundImage: container.leftBackgroundImage
            sledImage:  container.sledImage
            sledImageWhenHovered:  container.sledImageWhenHovered
            sledImageWhenPressed:  container.sledImageWhenPressed
        }
        //next rectangle covers the empty space between scrollbars
        Rectangle{
            color: container.colorWhenDefault
            gradient: (gradientBgOn)?container.gradientBg:container.nullGradient
            anchors{ right: textAreaContainer.right; left: scrollBarHorizontal.right; top: scrollBarVertical.bottom; bottom: textAreaContainer.bottom }
            visible: (scrollBarHorizontal.visible && scrollBarVertical.visible)?true:false
        }
    }
}



