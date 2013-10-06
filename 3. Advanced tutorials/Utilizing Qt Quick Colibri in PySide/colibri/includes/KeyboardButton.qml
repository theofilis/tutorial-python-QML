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
import "../"

CLButton {
    id: structure

    property CLStyle style : CLStyle{}
    property string value:  ""
    property string shiftValue: value.toUpperCase()
    property string shiftTextFontFamily : style.fontFamily
    property string shiftTextFontWeight : style.fontWeight
    property real shiftTextFontSize: structure.height*0.2
    property color shiftTextColor: "red"
    property string shiftText: shiftValue
    property Image nullImage : Image { //this property is "private" don't write it to documentation
        id: "null"
        source: ""
        width: buttonWidth
        height: buttonHeight
        fillMode: Image.PreserveAspectCrop
        smooth: false
        scale: 1
    }
    property Image specialImage : nullImage
    property CLButton buttonCLStyle : CLButton{}

    /**
     * Returns HTML auml tag to uppercase
     * "<html>&auml;</html>" -> "<html>&Auml;</html>"
     */
    function htmlToUpperCase(htmlString) {
        return (htmlString.replace(htmlString.substring(7,8),htmlString.substring(7,8).toUpperCase()));
    }

    /**
     * Checks if word has html-tag in start.
     * "<html>&auml;</html>" -> true
     *  "<html>" -> true
     *  "<htm" -> false
     *  "dog" -> false
     */
    function isHtml(string) {
        return (string.substring(0,6) == "<html>")
    }

    colorWhenDefault: buttonCLStyle.colorWhenDefault;
    colorWhenPressed: buttonCLStyle.colorWhenPressed;
    colorWhenHovered: buttonCLStyle.colorWhenHovered;
    textColor: buttonCLStyle.textColor;
    roundness: buttonCLStyle.roundness;
    borderColor: buttonCLStyle.borderColor;
    borderWidth: buttonCLStyle.borderWidth;
    fontSize: buttonCLStyle.fontSize;
    fontFamily: buttonCLStyle.fontFamily;
    fontWeight: buttonCLStyle.fontWeight;
    borderColorWhenHovered: buttonCLStyle.borderColorWhenHovered;
    borderColorWhenPressed: buttonCLStyle.borderColorWhenPressed;
    backgroundImage: buttonCLStyle.backgroundImage;
    backgroundImageWhenHovered: buttonCLStyle.backgroundImageWhenHovered;
    backgroundImageWhenPressed: buttonCLStyle.backgroundImageWhenPressed;
    gradientDefaultOn: buttonCLStyle.gradientDefaultOn;
    gradientHoveredOn: buttonCLStyle.gradientHoveredOn;
    gradientPressedOn: buttonCLStyle.gradientPressedOn;
    hoveredStateOn: buttonCLStyle.hoveredStateOn;
    pressedStateOn: buttonCLStyle.pressedStateOn;
    gradientWhenDefault: buttonCLStyle.gradientWhenDefault;
    gradientWhenHovered: buttonCLStyle.gradientWhenHovered;
    gradientWhenPressed: buttonCLStyle.gradientWhenPressed;
    textAlign: buttonCLStyle.textAlign;
    leftMargin: buttonCLStyle.leftMargin;
    rightMargin: buttonCLStyle.rightMargin
    smooth: buttonCLStyle.smooth
    gradientSelectedOn: buttonCLStyle.gradientSelectedOn;
    gradientWhenSelected: buttonCLStyle.gradientWhenSelected;
    colorWhenSelected: buttonCLStyle.colorWhenSelected;

    Image {
        source: specialImage.source
        width: if(source != "") specialImage.width
        height: if(source != "") specialImage.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        smooth: specialImage.smooth
        scale: specialImage.scale
    }

    /** Shows shift mark in upleft corner**/
    Text {
        anchors.left: parent.left;
        anchors.leftMargin: structure.width*0.1;
        anchors.top: parent.top;
        anchors.topMargin: structure.height*0.1;
        text: shiftText;
        color: shiftTextColor
        font.pointSize: 0.001+shiftTextFontSize
    }
}
