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
import "javascripts/keyboard.js" as KeyboardEngine
import "gradients/"
import "includes/"

/**
 * More simple keyboard. Loading time optimized.
 */
Rectangle {
    id: keyboard

    property CLStyle style : CLStyle { }

    property string text
    property real buttonWidth: ((keyboard.width-buttonSpacing*11)/11) - (keyboard.width*0.05)/11 ;
    property real buttonHeight: (keyboard.height-buttonSpacing*4)/4
    property int buttonSpacing: width*0.005

    property bool abcOn: true // read-only
    property bool numbersOn: false; // read-only
    property bool europeansOn: false // read-only

    property Gradient buttonGradientWhenSelected : style.gradientWhenSelected
    property color buttonColorWhenSelected : style.colorWhenSelected
    property bool buttonGradientSelectedOn : style.gradientSelectedOn

    property bool shiftOn: false // read-only
    property bool capsOn: false // read-only

    property bool showOkCLButton: true
    property bool showCancelCLButton: true

    property real shiftTextFontSize : buttonFontSize*0.7
    property string shiftTextFontFamily : style.fontFamily
    property variant shiftTextFontWeight : style.fontWeight
    property color shiftTextColor : style.textColor


    property real imageWidth : buttonWidth
    property real imageHeight : buttonHeight

    property Image shiftImage : Image { source: "images/shift_50x50.png"; scale: buttonHeight*0.01; smooth: true}
    property Image enterImage : Image { source: "images/enter_50x70.png"; scale: buttonWidth*0.01; smooth: true}
    property Image backspaceImage : Image { source: "images/backspace_50x70.png"; scale: buttonWidth*0.01; smooth: true}
    property Image leftArrowImage : Image { source: "images/arrow_left_50x50.png"; scale: buttonHeight*0.008; smooth: true}
    property Image rightArrowImage : Image { source: "images/arrow_right_50x50.png"; scale: buttonHeight*0.008; smooth: true}
    property Image upArrowImage : Image { source: "images/arrow_up_50x50.png"; scale: buttonHeight*0.008; smooth: true}
    property Image downArrowImage : Image { source: "images/arrow_down_50x50.png"; scale: buttonHeight*0.008; smooth: true}
    property Image okImage : Image { source: "images/ok_50x50.png"; scale: buttonHeight*0.01; smooth: true}
    property Image cancelImage : Image { source: "images/delete_50x50.png"; scale: buttonHeight*0.01; smooth: true}
    property Image capsImage : nullImage


    //properties straight from button
    property color buttonColorWhenDefault : style.colorWhenDefault
    property color buttonColorWhenPressed : style.colorWhenPressed
    property color buttonColorWhenHovered : style.colorWhenHovered
    property color buttonTextColor : style.textColor
    property real buttonRoundness : style.roundness
    property color buttonBorderColor : style.borderColor
    property int buttonBorderWidth : style.borderWidth
    property real buttonFontSize : height*0.05
    property string buttonFontFamily: style.fontFamily
    property variant buttonFontWeight : style.fontWeight
    property color buttonBorderColorWhenHovered : style.borderColorWhenHovered
    property color buttonBorderColorWhenPressed : style.borderColorWhenPressed


    /* Properties for background images
     * --------------------------------
     * This solution is temporary. Remember performance.
     */
    property Image nullImage : Image { //this property is "private" don't write it to documentation
        id: "null"
        source: ""
        width: buttonWidth
        height: buttonHeight
        fillMode: Image.PreserveAspectCrop
    }

    property Image buttonBackgroundImage : nullImage

    property Image buttonBackgroundImageWhenHovered : nullImage
    property Image buttonBackgroundImageWhenPressed : nullImage

    property Image buttonCurrentImage : buttonBackgroundImage //this property is "private" don't write it to documentation

    property bool buttonGradientDefaultOn : style.gradientDefaultOn
    property bool buttonGradientHoveredOn : style.gradientHoveredOn
    property bool buttonGradientPressedOn : style.gradientPressedOn

    property bool buttonHoveredStateOn : style.hoveredStateOn
    property bool buttonPressedStateOn : style.pressedStateOn

    property Gradient buttonGradientWhenDefault : style.gradientWhenDefault
    property Gradient buttonGradientWhenHovered : style.gradientWhenHovered
    property Gradient buttonGradientWhenPressed : style.gradientWhenPressed

    property string buttonTextAlign: "center"
    property real buttonLeftMargin: 0
    property real buttonRightMargin: 0


    signal leftArrowClicked()
    signal rightArrowClicked()
    signal upArrowClicked()
    signal downArrowClicked()
    signal okCLButtonClicked()
    signal cancelCLButtonClicked()
    signal clicked()
    signal backspaceClicked()


    /**
     * Function shows number buttons.
     */
    function showNumbers() {
        if (!numbersOn) {
           numbers.selected = true
            abc.selected = false
            europeans.selected = false

            changeCharacters(KeyboardEngine.numbers)
            numbersOn = true;
            abcOn = false
            europeansOn = false
        }
    }

    /**
     * Function shows abc buttons
     */
    function showAbc() {
        if (!abcOn) {
            abc.selected = true
            europeans.selected = false
            numbers.selected = false

            changeCharacters(KeyboardEngine.abc)

            abcOn = true
            numbersOn = false
            europeansOn = false
        }
    }

    /**
     * Function shows european(äöå) buttons
     */
    function showEuropeans() {
        if (!europeans.selected) {
            europeans.selected = true
            abc.selected = false
            numbers.selected = false

            changeCharacters(KeyboardEngine.europeans)

            europeansOn = true
            abcOn = false
            numbersOn = false
        }
    }

    /**
     * This function changes character text in buttons when "state" is changed.
     * Changes characters between abc characters, number characaters and european special characters (äöå)
     *
     * @param buttons in array
     * @return nothing
     */
    function changeCharacters(characters) {

        for (var i=0; i<row1.children.length; i++) {
           row1.children[i].value = characters[i][0];
           if(characters[i][1] != null) row1.children[i].shiftValue = characters[i][1];
           else row1.children[i].shiftValue = characters[i][0].toUpperCase()
           if ((shiftOn || capsOn) && row1.children[i].shiftValue != "") {
                row1.children[i].text = row1.children[i].shiftValue
                row1.children[i].shiftText = row1.children[i].value
           } else {
                row1.children[i].text = row1.children[i].value
                if (row1.children[i].shiftValue != "") row1.children[i].shiftText = row1.children[i].shiftValue
                else row1.children[i].shiftText = ""
           }
        }

        for (var i=0; i<row2.children.length; i++) {
           row2.children[i].value = characters[KeyboardEngine.row1Length + i][0];
           if (characters[KeyboardEngine.row1Length - 1 + i][1] != null) {
                row2.children[i].shiftValue = characters[KeyboardEngine.row1Length + i][1];
           } else  row2.children[i].shiftValue = characters[KeyboardEngine.row1Length + i][0].toUpperCase();

           //if shift or caps is on and character has a shift value
           if ((shiftOn || capsOn) && row2.children[i].shiftValue != "") {
                row2.children[i].text = row2.children[i].shiftValue
                row2.children[i].shiftText = row2.children[i].value
           } else {
                row2.children[i].text = row2.children[i].value
                if (row2.children[i].shiftValue != "") row2.children[i].shiftText = row2.children[i].shiftValue
                else row2.children[i].shiftText = ""
           }
        }

        for (var i=0; i<row3.children.length; i++) {
           row3.children[i].value = characters[KeyboardEngine.row1Length+KeyboardEngine.row2Length + i][0];
           if (characters[KeyboardEngine.row1Length+KeyboardEngine.row2Length + i][1] != null)row3.children[i].shiftValue = characters[KeyboardEngine.row1Length+KeyboardEngine.row2Length + i][1];
           else row3.children[i].shiftValue = characters[KeyboardEngine.row1Length+KeyboardEngine.row2Length + i][0].toUpperCase();

           if ((shiftOn || capsOn) && row3.children[i].shiftValue != "") {
                row3.children[i].text = row3.children[i].shiftValue
                row3.children[i].shiftText = row3.children[i].value

           } else {
                row3.children[i].text = row3.children[i].value
                if(row3.children[i].shiftValue != "") row3.children[i].shiftText = row3.children[i].shiftValue
                else row3.children[i].shiftText = ""
           }
        }
    }

    /**
     * Function which will be performed when button is clicked. In this moment
     * only used by buttons with shift value.
     *
     * @param active text(character) of button which is clicked
     * @return nothing
     */
    function keyboardCLButtonClicked(character) {
        keyboard.text += character;
        keyboard.clicked();
        if(shiftOn) shift();
    }

    /**
     * This function will be executed if shift- or caps-button is clicked on
     */
    function setShiftOn() {
        shiftOnSingleRow(row1);
        shiftOnSingleRow(row2);
        shiftOnSingleRow(row3);

        //if there is background image for up arrow button
        if (upArrowImage.source != "") {
            leftArrow.text = ""
            leftArrow.specialImage = upArrowImage
        } else {
            leftArrow.text = leftArrow.shiftValue
            leftArrow.specialImage = nullImage
        }

        leftArrow.shiftText = leftArrow.value

        //if there is background image for down arrow button
        if (downArrowImage.source != "") {
            rightArrow.text = ""
            rightArrow.specialImage = downArrowImage
        } else {
            rightArrow.text = rightArrow.shiftValue
            rightArrow.specialImage = nullImage
        }

        rightArrow.shiftText = rightArrow.value

        apostrophe.text = apostrophe.shiftValue
        apostrophe.shiftText = apostrophe.value
    }

    /**
     * Change button text to shift value in single row
     *
     * @param row Row of buttons.
     * @return nothing
     */
    function shiftOnSingleRow(row) {
        for (var i=0; i<row.children.length; i++) {
           if (row.children[i].shiftValue != "") {
             row.children[i].text = row.children[i].shiftValue;
             row.children[i].shiftText = row.children[i].value;
           }
        }
    }

    /**
     * This function will be executed if shift- or caps-button is clicked off
     */
    function setShiftOff() {
        shiftOffSingleRow(row1);
        shiftOffSingleRow(row2);
        shiftOffSingleRow(row3);

        if (leftArrowImage.source != "") {
            leftArrow.text = ""
            leftArrow.specialImage = leftArrowImage
        } else {
            leftArrow.text = leftArrow.value
            leftArrow.specialImage = nullImage
        }

        leftArrow.shiftText = leftArrow.shiftValue

        if (rightArrowImage.source != "") {
            leftArrow.text = ""
            rightArrow.specialImage = rightArrowImage
        } else {
            rightArrow.text = rightArrow.value
            rightArrow.specialImage = nullImage
        }

        rightArrow.shiftText = rightArrow.shiftValue

        apostrophe.text = apostrophe.value
        apostrophe.shiftText = apostrophe.shiftValue

    }

    /**
     * Sets shift off in single row of buttons.
     *
     * @param row of buttons
     * @return nothing
     */
    function shiftOffSingleRow(row) {
        for (var i=0; i<row.children.length; i++) {
           if (row.children[i].shiftValue != "") {
              row.children[i].text = row.children[i].value;
              row.children[i].shiftText = row.children[i].shiftValue;
           }
        }
    }

    /**
     * Function is called when shift-button is pressed...
     */
    function shift() {
        if (shiftOn) {
            //if shift is on, let's put it off
            setShiftOff();
            shiftOn = false;
            capsCLButton.disabled = false;
            shiftCLButton.selected = false
        } else {
            //if shift is off, let's put it on
            setShiftOn();
            shiftOn = true;
            capsCLButton.disabled = true;
            shiftCLButton.selected = true
        }
    }


    /**
     * Function is called when caps-button is pressed...
     */
    function caps() {
        if (capsOn) {
            //if caps is on, let's put if off
            setShiftOff();
            capsOn = false;
            capsCLButton.selected = false
            shiftCLButton.disabled = false;
        } else {
            //if caps is off, let's put it on
            setShiftOn();
            capsOn = true
            capsCLButton.selected = true
            shiftCLButton.disabled = true;
        }
    }

    Component.onCompleted: {
        abc.selected = true
        //if special buttons are using images in background texts has to removed
        if (backspaceImage.source != "") backspace.text = "";
        if (enterImage.source != "") enter.text = "";
        if (leftArrowImage.source != "") leftArrow.text = "";
        if (rightArrowImage.source != "") rightArrow.text = "";
        if (okImage.source != "") ok.text = "";
        if (cancelImage.source != "") cancel.text = "";
        if (capsImage.source != "") caps.text = "";
        if (shiftImage.source != "") shiftCLButton.text = "";

        if (!showOkCLButton) ok.visible = false
        if (!showCancelCLButton)  cancel.visible = false
    }

    clip: true;
    smooth: true
    width: 500
    height: 250
    color: "transparent"

    //this element is only used for forwarding properties to buttons
    CLButton { id: styleCLButton; visible: false; style: keyboard.style; colorWhenDefault: buttonColorWhenDefault; colorWhenPressed: buttonColorWhenPressed; colorWhenHovered: buttonColorWhenHovered; textColor: buttonTextColor; roundness: buttonRoundness; borderColor: buttonBorderColor; borderWidth: buttonBorderWidth; fontSize: buttonFontSize; fontFamily: buttonFontFamily; fontWeight: buttonFontWeight; borderColorWhenHovered: buttonBorderColorWhenHovered; borderColorWhenPressed: buttonBorderColorWhenPressed; backgroundImage: buttonBackgroundImage; backgroundImageWhenHovered: buttonBackgroundImageWhenHovered; backgroundImageWhenPressed: buttonBackgroundImageWhenPressed; gradientDefaultOn: buttonGradientDefaultOn; gradientHoveredOn: buttonGradientHoveredOn; gradientPressedOn: buttonGradientPressedOn; hoveredStateOn: buttonHoveredStateOn; pressedStateOn: buttonPressedStateOn; gradientWhenDefault: buttonGradientWhenDefault; gradientWhenHovered: buttonGradientWhenHovered; gradientWhenPressed: buttonGradientWhenPressed; textAlign: buttonTextAlign; leftMargin: buttonLeftMargin; rightMargin: buttonRightMargin; smooth: keyboard.smooth; gradientWhenSelected: buttonGradientWhenSelected; colorWhenSelected: buttonColorWhenSelected; gradientSelectedOn: buttonGradientSelectedOn}

    Column {
        id: qwerty

        spacing: buttonSpacing

        Column {
            id: abcCLButtons

            spacing: buttonSpacing

            Row {
                x: buttonWidth*0.5
                spacing: buttonSpacing

                Row {
                    id: row1

                    spacing: buttonSpacing

                    KeyboardButton { text: value; value: KeyboardEngine.abc[0][0]; shiftValue: KeyboardEngine.abc[0][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[1][0]; shiftValue: KeyboardEngine.abc[1][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[2][0]; shiftValue: KeyboardEngine.abc[2][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[3][0]; shiftValue: KeyboardEngine.abc[3][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[4][0]; shiftValue: KeyboardEngine.abc[4][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[5][0]; shiftValue: KeyboardEngine.abc[5][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[6][0]; shiftValue: KeyboardEngine.abc[6][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[7][0]; shiftValue: KeyboardEngine.abc[7][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[8][0]; shiftValue: KeyboardEngine.abc[8][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[9][0]; shiftValue: KeyboardEngine.abc[9][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                }

                KeyboardButton { id: backspace; shiftValue: ""; text:"<--"; style: keyboard.style; width: buttonWidth; height: buttonHeight; specialImage: backspaceImage; onClicked: {
                    keyboard.text = keyboard.text.substring(0,keyboard.text.length-1);
                    backspaceClicked()} buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor;
                }
            }

            Row {
                spacing: buttonSpacing
                KeyboardButton { id: capsCLButton; text:"caps"; shiftValue: ""; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: caps(); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor; specialImage: capsImage}
                Row {
                    id: row2

                    spacing: buttonSpacing

                    KeyboardButton { text: value; value: KeyboardEngine.abc[10][0]; shiftValue: KeyboardEngine.abc[10][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[11][0]; shiftValue: KeyboardEngine.abc[11][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[12][0]; shiftValue: KeyboardEngine.abc[12][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[13][0]; shiftValue: KeyboardEngine.abc[13][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[14][0]; shiftValue: KeyboardEngine.abc[14][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[15][0]; shiftValue: KeyboardEngine.abc[15][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[16][0]; shiftValue: KeyboardEngine.abc[16][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[17][0]; shiftValue: KeyboardEngine.abc[17][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }
                    KeyboardButton { text: value; value: KeyboardEngine.abc[18][0]; shiftValue: KeyboardEngine.abc[18][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor }

                }
                KeyboardButton { id: enter; text: value; value: "enter"; shiftValue: ""; style: keyboard.style; width: buttonWidth*1.5; height: buttonHeight; onClicked: keyboardCLButtonClicked("\n"); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor; specialImage: enterImage}
            }

            Row {
                id: row3
                x: buttonWidth*0.5
                spacing: buttonSpacing
                KeyboardButton { text: value; value: KeyboardEngine.abc[19][0]; shiftValue: KeyboardEngine.abc[19][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
                KeyboardButton { text: value; value: KeyboardEngine.abc[20][0]; shiftValue: KeyboardEngine.abc[20][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
                KeyboardButton { text: value; value: KeyboardEngine.abc[21][0]; shiftValue: KeyboardEngine.abc[21][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
                KeyboardButton { text: value; value: KeyboardEngine.abc[22][0]; shiftValue: KeyboardEngine.abc[22][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
                KeyboardButton { text: value; value: KeyboardEngine.abc[23][0]; shiftValue: KeyboardEngine.abc[23][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
                KeyboardButton { text: value; value: KeyboardEngine.abc[24][0]; shiftValue: KeyboardEngine.abc[24][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
                KeyboardButton { text: value; value: KeyboardEngine.abc[25][0]; shiftValue: KeyboardEngine.abc[25][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
                KeyboardButton { text: value; value: KeyboardEngine.abc[26][0]; shiftValue: KeyboardEngine.abc[26][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
                KeyboardButton { text: value; value: KeyboardEngine.abc[27][0]; shiftValue: KeyboardEngine.abc[27][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
                KeyboardButton { text: value; value: KeyboardEngine.abc[28][0]; shiftValue: KeyboardEngine.abc[28][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
                KeyboardButton { text: value; value: KeyboardEngine.abc[29][0]; shiftValue: KeyboardEngine.abc[29][1]; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
            }
        }

        Row {
            id: row4
            spacing: buttonSpacing
            KeyboardButton { id: shiftCLButton; text: "shift"; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: shift(); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor; specialImage: shiftImage}
            KeyboardButton { id: abc; text:"abc"; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: showAbc(); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
            KeyboardButton { id: numbers; text:"123@"; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: showNumbers(); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
            KeyboardButton { id: europeans; text:"<html>&auml;&ouml;&aring;</html>"; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: showEuropeans(); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
            KeyboardButton { id: space; text:""; shiftValue: ""; style: keyboard.style; width: buttonWidth*2; height: buttonHeight; onClicked: keyboardCLButtonClicked(" "); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
            KeyboardButton { id: leftArrow; text:value; value: "<html>&larr;</html>"; shiftValue: "<html>&uarr;</html>"; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: {
                if (shiftOn) {
                    keyboard.upArrowClicked();
                    shift();
                } else if (capsOn) {
                    keyboard.upArrowClicked();
                } else {
                    keyboard.leftArrowClicked();
                }
            } buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor; specialImage: leftArrowImage}
            KeyboardButton { id: rightArrow; text: value; value: "<html>&rarr;</html>"; shiftValue: "<html>&darr;</html>"; style: keyboard.style; width: buttonWidth;  height: buttonHeight; onClicked: {
                if (shiftOn) {
                    keyboard.downArrowClicked();
                    shift();
                } else if (capsOn) {
                    keyboard.downArrowClicked();
                } else {
                    keyboard.rightArrowClicked();
                }
            } buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor; specialImage: rightArrowImage}
            KeyboardButton { id: apostrophe; text: value; value: "'"; shiftValue: "\""; style: keyboard.style; width: buttonWidth; height: buttonHeight; onClicked: keyboardCLButtonClicked(text); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor}
            KeyboardButton { id: ok; text:"ok"; style: keyboard.style; width: buttonWidth;  height: buttonHeight; onClicked: keyboard.okCLButtonClicked(); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor; specialImage: okImage}
            KeyboardButton { id: cancel; text:"cancel"; style: keyboard.style; width: buttonWidth;  height: buttonHeight; onClicked: keyboard.cancelCLButtonClicked(); buttonCLStyle: styleCLButton; shiftTextFontSize: keyboard.shiftTextFontSize; shiftTextFontFamily: keyboard.shiftTextFontFamily; shiftTextFontWeight: keyboard.shiftTextFontWeight; shiftTextColor: keyboard.shiftTextColor; specialImage: cancelImage}
        }
    }
}
