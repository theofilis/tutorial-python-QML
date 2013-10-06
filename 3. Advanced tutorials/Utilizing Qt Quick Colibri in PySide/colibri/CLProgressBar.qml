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

Rectangle {
    id: structure

    // Operational properties
    property real minValue: 0
    property real maxValue: 100
    property real value: 60
    property int percentage: Math.round((value-minValue)/(maxValue-minValue) * 100) //read-only
    // CLStyle properties
    property CLStyle style: CLStyle {}
    property int spacing: 1
    property color bgColor: style.bgColor
    property color colorWhenDefault: style.colorWhenDefault
    property real roundness: style.roundness
    property int borderWidth: style.borderWidth
    property color borderColor: style.borderColor
    property Gradient gradientBg: style.gradientBg
    property Gradient gradientWhenDefault: style.gradientWhenDefault
    property bool gradientDefaultOn: style.gradientDefaultOn
    property bool gradientBgOn: style.gradientBgOn
    property Gradient nullGradient: Gradient{}

    onValueChanged: {
        if (value < minValue) value = minValue;
        if (value > maxValue) value = maxValue;
    }

    width: 300
    height: 20
    color: bgColor
    border.color: borderColor
    border.width: borderWidth
    smooth: true
    clip: true
    radius: (height/2) * roundness
    gradient: (gradientBgOn)?gradientBg:nullGradient

    Rectangle {
        id: bar

        width: Math.round( ((value-minValue)/(maxValue-minValue))*(structure.width - 2*spacing - 2*structure.borderWidth) )
        height: Math.round( structure.height - 2*spacing - 2*structure.borderWidth )
        x: spacing + structure.borderWidth
        y: spacing + structure.borderWidth
        smooth: true
        color: colorWhenDefault
        gradient: (gradientDefaultOn)?gradientWhenDefault:nullGradient
        radius: (height/2) * roundness

        Behavior on width { SmoothedAnimation { target: bar; property: "width"; velocity: 300; } }
    }
}
