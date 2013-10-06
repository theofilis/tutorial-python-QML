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

Rectangle{
    id:scrollBar

    property CLStyle style: CLStyle {}
    property real minimum: 0
    property real maximum: 100
    property int value: 0
    property real step: 0
    property real takeAwayValue: 0
    property real buttonRoundness: style.itemRoundness
    property real sledRoundness: style.roundness
    property int fontSize: style.fontSize
    property color textColor: style.textColor
    property string fontFamily: style.fontFamily
    property variant fontWeight: style.fontWeight
    property color bgColor: style.bgColor
    property color colorWhenDefault: style.colorWhenDefault
    property color colorWhenPressed: style.colorWhenPressed
    property color colorWhenHovered: style.colorWhenHovered
    property int borderWidth: style.borderWidth
    property color borderColor: style.borderColor
    property color borderColorWhenHovered: style.borderColorWhenHovered
    property color borderColorWhenPressed: style.borderColorWhenPressed
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
    property Image nextBackgroundImage: next
    property Image nextWhenDefault: nextBackgroundImage
    property Image nextWhenHovered: nextBackgroundImage
    property Image nextWhenPressed: nextBackgroundImage
    property Image previousBackgroundImage: previous
    property Image previousWhenDefault: previousBackgroundImage
    property Image previousWhenHovered: previousBackgroundImage
    property Image previousWhenPressed: previousBackgroundImage
    property Image sledImage: nullImage
    property Image sledImageWhenHovered: nullImage
    property Image sledImageWhenPressed: nullImage
    //next properties are private ones
    property Image nullImage: Image { //this property is "private" don't write it to documentation
        id: "null"
        source: ""
    }
    property Gradient nullGradient: Gradient{}
    property string textPrevious: ""
    property string textNext: ""
    property Image previous: Image { //this property is "private" don't write it to documentation
        id: picPrevious

        source: "images/arrow_up_50x50.png"
        smooth: true
        height: scrollBar.height*0.15*0.6
        width: scrollBar.width*0.8
    }
    property Image next: Image { //this property is "private" don't write it to documentation
        id: picNext

        source: "images/arrow_down_50x50.png"
        smooth: true
        height: scrollBar.height*0.15*0.6
        width: scrollBar.width*0.8
    }

    onRadiusChanged: {
        radius = 0;
    }

    Component.onCompleted: {
        scrollBar.value = minimum;
        bar.minimum = minimum;
        bar.maximum = scrollBar.maximum;
        if (step == 0) step = Math.round(maximum/(maximum-minimum));
        else step = step;
        scrollBar.takeAwayValue = bar.value;

        if (minimum >= maximum) console.log("Error occured: minimum >= maximum");
        if (step > (maximum-minimum)) console.log("Error occured: step > (maximum-minimum)");

    }

    onMaximumChanged:{
        bar.maximum = maximum;
        if (step == 0) step = Math.round(maximum/(maximum-minimum));
        else step = step;
    }

    onMinimumChanged: {
        bar.minimum = minimum;
        if (step == 0)step = Math.round(maximum/(maximum-minimum));
        else step = step;
    }

    onValueChanged: {
        bar.setValue(value);
    }

    width: 20
    height: 200
    visible: true
    color: scrollBar.bgColor
    border{color:borderColor;width:borderWidth}
    gradient: (gradientBgOn)?gradientBg:nullGradient

    Column{
        CLButton{
            onClicked: {
                if (bar.value >= bar.minimum) {
                    bar.setValue(bar.value - step);
                    takeAwayValue = bar.value - step;
                }
            }
            width: scrollBar.width
            height :scrollBar.height*0.15
            text: (textPrevious != "")?textPrevious:""
            roundness: scrollBar.buttonRoundness
            colorWhenDefault: scrollBar.colorWhenDefault
            colorWhenPressed: scrollBar.colorWhenPressed
            colorWhenHovered: scrollBar.colorWhenHovered
            textColor: scrollBar.textColor
            borderColor: scrollBar.borderColor
            borderWidth: scrollBar.borderWidth
            fontSize: scrollBar.fontSize
            fontFamily: scrollBar.fontFamily
            fontWeight: scrollBar.fontWeight
            borderColorWhenHovered: scrollBar.borderColorWhenHovered
            borderColorWhenPressed: scrollBar.borderColorWhenPressed
            backgroundImage: scrollBar.previousBackgroundImage
            backgroundImageWhenDefault: scrollBar.previousWhenDefault
            backgroundImageWhenHovered: scrollBar.previousWhenHovered
            backgroundImageWhenPressed: scrollBar.previousWhenPressed
            gradientDefaultOn: scrollBar.gradientDefaultOn
            gradientHoveredOn: scrollBar.gradientHoveredOn
            gradientPressedOn: scrollBar.gradientPressedOn
            hoveredStateOn: scrollBar.hoveredStateOn
            pressedStateOn: scrollBar.pressedStateOn
            gradientWhenDefault: scrollBar.gradientWhenDefault
            gradientWhenHovered: scrollBar.gradientWhenHovered
            gradientWhenPressed: scrollBar.gradientWhenPressed
        }

        CLSliderVertical{
            id: bar

            onValueChanged: {
                scrollBar.value = bar.value;
            }

            width: scrollBar.width
            height: scrollBar.height*0.70
            //0.0001 value is for disabling 'strange' gradient effect when roundness <= 0
            roundness: (scrollBar.sledRoundness <= 0)?0.0001:scrollBar.sledRoundness
            sledImage: scrollBar.sledImage
            sledImageWhenHovered: scrollBar.sledImageWhenHovered
            sledImageWhenPressed: scrollBar.sledImageWhenPressed
            bgColor: "transparent"
            colorWhenDefault: scrollBar.colorWhenDefault
            colorWhenPressed: scrollBar.colorWhenPressed
            colorWhenHovered: scrollBar.colorWhenHovered
            borderWidth: 0
            borderColor: "transparent"
            borderColorWhenHovered: "transparent"
            borderColorWhenPressed: "transparent"
            borderWidthInner: scrollBar.borderWidthInner
            borderColorInner: scrollBar.borderColorInner
            borderColorInnerWhenHovered: scrollBar.borderColorInnerWhenHovered
            borderColorInnerWhenPressed: scrollBar.borderColorInnerWhenPressed
            gradientWhenDefault: scrollBar.gradientWhenDefault
            gradientWhenHovered: scrollBar.gradientWhenHovered
            gradientWhenPressed: scrollBar.gradientWhenPressed
            gradientDefaultOn: scrollBar.gradientDefaultOn
            gradientHoveredOn: scrollBar.gradientHoveredOn
            gradientPressedOn: scrollBar.gradientPressedOn
            gradientBgOn: false
            hoveredStateOn: scrollBar.hoveredStateOn
            pressedStateOn: scrollBar.pressedStateOn
        }

        CLButton{
            onClicked: {
                if (bar.value <= bar.maximum) {
                    bar.setValue(bar.value + step);
                    takeAwayValue = bar.value + step;
                }
            }
            width: scrollBar.width
            height: scrollBar.height*0.15
            text: (textNext != "")?textNext:""
            roundness: scrollBar.buttonRoundness
            colorWhenDefault: scrollBar.colorWhenDefault
            colorWhenPressed: scrollBar.colorWhenPressed
            colorWhenHovered: scrollBar.colorWhenHovered
            textColor: scrollBar.textColor
            borderColor: scrollBar.borderColor
            borderWidth: scrollBar.borderWidth
            fontSize: scrollBar.fontSize
            fontFamily: scrollBar.fontFamily
            fontWeight: scrollBar.fontWeight
            borderColorWhenHovered: scrollBar.borderColorWhenHovered
            borderColorWhenPressed: scrollBar.borderColorWhenPressed
            backgroundImage: scrollBar.nextBackgroundImage
            backgroundImageWhenDefault: scrollBar.nextWhenDefault
            backgroundImageWhenHovered: scrollBar.nextWhenHovered
            backgroundImageWhenPressed: scrollBar.nextWhenPressed
            gradientDefaultOn: scrollBar.gradientDefaultOn
            gradientHoveredOn: scrollBar.gradientHoveredOn
            gradientPressedOn: scrollBar.gradientPressedOn
            hoveredStateOn: scrollBar.hoveredStateOn
            pressedStateOn: scrollBar.pressedStateOn
            gradientWhenDefault: scrollBar.gradientWhenDefault
            gradientWhenHovered: scrollBar.gradientWhenHovered
            gradientWhenPressed: scrollBar.gradientWhenPressed
        }
    }
}
