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
import "javascripts/datepicker.js" as CalendarEngine
import "javascripts/functions.js" as Functions
import "javascripts"
import "gradients/"
import "includes"

Rectangle {
    id: structure;

    property CLStyle style : CLStyle{}
    property string selected : day + "." + month + "." + year

    //three properties below means selected day, year and month
    property int day : Date.today().getDate();
    property int year : Date.today().getFullYear()
    property int month : Date.today().getMonth()+1

    property int monthCounter : month
    property int yearCounter : year


    property real fontSize: style.fontSize
    property string fontFamily: style.fontFamily

    //properties related to selected date screen
    property bool showSelectedDate: true
    property real selectedDateScreenHeight: structure.height*0.125
    property real selectedDateFontSize: selectedDateScreenHeight*0.4
    property string selectedDateFontFamily: fontFamily
    property Gradient selectedDateGradient: style.gradientWhenDefault
    property bool selectedDateGradientOn: style.gradientDefaultOn
    property color selectedDateBgColor: style.colorWhenDefault

    //properties related to day of month -box
    property int boxWidth : boxHeight
    property int boxHeight: (structure.height-monthChangerHeight-selectedDateScreenHeight-column.spacing*3-dayBoxSpacing*5)/7
    property int dayBoxSpacing: height*0.01
    property real boxRoundness: style.roundness

    property color boxColorWhenDefault : style.colorWhenDefault
    property color boxColorWhenHovered : style.colorWhenHovered
    property color boxColorWhenSelected : "blue"
    property color boxColorWhenToday : "red"

    property real boxFontSize: structure.height*0.04
    property string boxFontFamily: fontFamily

    property Gradient gradientWhenDefault: style.gradientWhenDefault
    property Gradient gradientWhenHovered: style.gradientWhenHovered
    property Gradient gradientWhenToday: Blue{}
    property Gradient gradientWhenSelected: Red{}
    property bool gradientDefaultOn: style.gradientDefaultOn
    property bool gradientHoveredOn: style.gradientHoveredOn
    property bool gradientSelectedOn: true
    property bool gradientTodayOn: true

    property bool gradientPressedOn: style.gradientPressedOn
    property Gradient gradientWhenPressed: style.gradientWhenPressed
    property color colorWhenPressed: style.colorWhenPressed

    property bool hoveredStateOn: style.hoveredStateOn

    property color textColor: style.textColor

    //properties related to month changer
    property real monthChangerRoundness: style.roundness
    property real monthChangerHeight: structure.height * 0.15
    property real monthChangerWidth: structure.width
    property real monthChangerFontSize: monthChanger.height*0.3
    property string monthChangerFontFamily: fontFamily
    property Gradient monthChangerGradient: gradientWhenDefault
    property bool monthChangerGradientOn: gradientDefaultOn
    property color monthChangerBgColor: boxColorWhenDefault

    property color bgColor : "transparent"

    property real weekDaysFontSize: height*0.042
    property string weekDaysFontFamily: fontFamily

    property bool pastDaysDisabled: true

    property Image leftArrowImage : Image{ source: "images/arrow_left_50x50.png"; smooth: structure.smooth; scale: structure.height*0.002 }
    property Image rightArrowImage : Image{ source: "images/arrow_right_50x50.png"; smooth: structure.smooth; scale: structure.height*0.002 }

    property Gradient gradientDisabled : Grey{}

    signal clicked()


    /**
     * Change text in day Rectangles when changing month.
     */
    function changeDays() {
        //below: monday = 0, sunday = 6
        var dayWhereMonthStarts = CalendarEngine.dayWhereMonthStarts(yearCounter,monthCounter);
        for (var i=0; i < grid.children.length; i++) {
            if(i < dayWhereMonthStarts)  {
                grid.children[i].opacity = 0.0001
            } else {
                grid.children[i].opacity = 1
                if((i - dayWhereMonthStarts) < Date.getDaysInMonth(yearCounter,monthCounter-1)) {
                    grid.children[i].opacity = 1;
                    grid.children[i].day = i - CalendarEngine.dayWhereMonthStarts(yearCounter,monthCounter) + 1;
                } else {
                    grid.children[i].opacity = 0;
                }
            }
        }
    }


    /**
     * Next month.
     */
    function next(){
        if (monthCounter == 12) {
            monthCounter = 1
            yearCounter++;
        } else {
            monthCounter++;
        }
        changeDays();
    }


    /**
     * Previous month.
     */
    function previous() {
        if (monthCounter == 1) {
            monthCounter = 12
            yearCounter--;
        } else {
            monthCounter--;
        }
        changeDays();
    }

    Component.onCompleted: {
        buttonPrevious.fontSize = monthChanger.height*0.5;
        buttonNext.fontSize = monthChanger.height*0.5;
        selectedDate.fontSize = selectedDateFontSize
        if (!monthChangerGradientOn) monthChangerGradientContainer.destroy();
        if (!showSelectedDate) {
            selectedDate.visible = false;
            structure.boxHeight = (structure.height-monthChangerHeight-column.spacing*2-dayBoxSpacing*5)/7
        }
        changeDays()
    }

    onHeightChanged: {
       if (!showSelectedDate) structure.boxHeight = (structure.height-monthChangerHeight-column.spacing*2-dayBoxSpacing*5)/7
    }

    width: 220
    height: 300
    color: bgColor
    smooth: true

    Column {
        id: column
        spacing: 5;

        Screen {
            id: selectedDate;
            anchors.horizontalCenter: parent.horizontalCenter;
            height: selectedDateScreenHeight;
            value: day + "." + month + "." + year
            radius: Functions.countRadius(boxRoundness,width,height,0,1);
            fontFamily: selectedDateFontFamily
            color: selectedDateBgColor
            gradientOn: selectedDateGradientOn
            gradient: selectedDateGradient
            width: structure.width*0.7
            fontSize: selectedDateFontSize
            style: structure.style
        }

        Rectangle {
            id: monthChanger
            width: monthChangerWidth
            height: monthChangerHeight
            anchors.horizontalCenter: parent.horizontalCenter;
            radius: Functions.countRadius(monthChangerRoundness,width,height,0,1)
            color: monthChangerBgColor

            Rectangle {
                id: monthChangerGradientContainer
                anchors.fill: parent
                gradient: monthChangerGradient
                radius: parent.radius
            }


            CLButton {
                style: structure.style;
                id: buttonPrevious;
                text: "";
                onClicked: previous();
                height: parent.height-1;
                anchors.left: parent.left;
                leftMargin: parent.width*0.05;
                anchors.verticalCenter: parent.verticalCenter;
                width: parent.width/2; z:0;
                textAlign: "left"
                imageAlign: "left"
                borderColor: "transparent"
                borderColorWhenHovered: "transparent"
                borderColorWhenPressed: "transparent"
                smooth: structure.smooth
                backgroundImage: leftArrowImage

                gradientDefaultOn: structure.gradientDefaultOn
                gradientHoveredOn: structure.gradientHoveredOn
                gradientPressedOn: structure.gradientPressedOn
                gradientWhenDefault: structure.gradientWhenDefault
                gradientWhenHovered: structure.gradientWhenHovered
                gradientWhenPressed: structure.gradientWhenPressed
                colorWhenDefault: structure.boxColorWhenDefault
                colorWhenHovered: structure.boxColorWhenHovered
                colorWhenPressed: structure.colorWhenPressed
                hoveredStateOn: structure.hoveredStateOn
            }

            Text {
                id: monthName;
                text: CalendarEngine.getMonthName(monthCounter) + " " + yearCounter
                font.pointSize: 0.001+monthChangerFontSize;
                font.family: monthChangerFontFamily
                color: textColor
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                z:1
            }

            CLButton {
                id: buttonNext;
                style: structure.style;
                text: "";
                onClicked: next();
                height: buttonPrevious.height;
                width: buttonPrevious.width;
                anchors.right: parent.right;
                rightMargin: parent.width*0.05;
                borderColor: "transparent"
                borderColorWhenHovered: "transparent"
                borderColorWhenPressed: "transparent"
                smooth: structure.smooth
                anchors.verticalCenter: parent.verticalCenter; z:0;
                textAlign: "right";
                imageAlign: "right"
                backgroundImage: rightArrowImage
                gradientDefaultOn: structure.gradientDefaultOn
                gradientHoveredOn: structure.gradientHoveredOn
                gradientPressedOn: structure.gradientPressedOn
                gradientWhenDefault: structure.gradientWhenDefault
                gradientWhenHovered: structure.gradientWhenHovered
                gradientWhenPressed: structure.gradientWhenPressed
                colorWhenDefault: structure.boxColorWhenDefault
                colorWhenHovered: structure.boxColorWhenHovered
                colorWhenPressed: structure.colorWhenPressed
                hoveredStateOn: structure.hoveredStateOn
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter;
            spacing: dayBoxSpacing
            Repeater {
                model: 7
                delegate: Rectangle {
                    color: bgColor;
                    width: boxWidth;
                    height: boxHeight;
                    Text {
                        text: CalendarEngine.stringShorter(CalendarEngine.getDayName(index),2);
                        color: structure.textColor;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        anchors.verticalCenter: parent.verticalCenter;
                        font.pointSize: 0.001+weekDaysFontSize;
                        font.family: weekDaysFontFamily
                    }
                }
            }
        }

        Grid {
            id: grid
            anchors.horizontalCenter: parent.horizontalCenter;
            y: 40
            rows: 6;
            columns: 7;
            spacing: dayBoxSpacing

            Repeater {
                 model: 42

                 delegate: Rectangle {
                    id: dayBox

                    property alias day : dateField.text

                    width: boxWidth
                    height: boxHeight
                    border.color : "black"
                    color: boxColorWhenDefault
                    radius: Functions.countRadius(boxRoundness,width,height,0,1)
                    smooth: structure.smooth

                    Rectangle {
                        id: boxGradientContainer
                        anchors.fill: parent
                        gradient: gradientWhenDefault
                        radius: parent.radius
                        smooth: structure.smooth
                    }

                    Text {
                        id: dateField;
                        anchors.horizontalCenter: parent.horizontalCenter;
                        anchors.verticalCenter: parent.verticalCenter;
                        text: "0"
                        color: textColor
                        font.pointSize: 0.001 + boxFontSize
                        font.family: boxFontFamily
                        z:1
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true;
                        onClicked: {
                            structure.day  = dateField.text;
                            structure.month = monthCounter
                            structure.year = yearCounter
                            structure.clicked();
                        }
                    }

                    states: [
                    State {
                        name: "disabled"; when: pastDaysDisabled && CalendarEngine.dayBeforeToday(dayBox.day,structure.monthCounter,structure.yearCounter);
                        PropertyChanges {target: dayBox; enabled: false}
                        PropertyChanges {target: boxGradientContainer; gradient: gradientDisabled}
                        PropertyChanges {target: dateField; color: "black"}
                        PropertyChanges {target: dayBox; color: "grey"}

                    },
                    State {
                        name: "selected"; when: structure.day == dayBox.day && structure.month == monthCounter && structure.year == structure.yearCounter
                        PropertyChanges {target: dayBox; color: boxColorWhenSelected}
                        PropertyChanges {id: propertyChangesGradientSelected; target: boxGradientContainer; gradient: gradientWhenSelected; visible: {if(gradientSelectedOn) true; else false}}
                    },
                    State {
                        name: "today"; when: ( (dayBox.day == Date.today().getDate()) && (structure.monthCounter == Date.today().getMonth() + 1)  && (structure.yearCounter == Date.today().getFullYear()) );
                        PropertyChanges {target: dayBox; color: boxColorWhenToday}
                        PropertyChanges {id: propertyChangesGradientToday; target: boxGradientContainer; gradient: gradientWhenToday; visible: {if(gradientTodayOn) true; else false}}

                    },
                    State {
                        id: stateHovered
                        name: "hovered"; when: mouseArea.containsMouse
                        PropertyChanges {target: dayBox; color: boxColorWhenHovered}
                        PropertyChanges {id: propertyChangesGradientHovered; target: boxGradientContainer; gradient: gradientWhenHovered; visible: {if(gradientHoveredOn) true; else false}}
                    }
                    ]

                    Component.onCompleted: {
                        if (!hoveredStateOn) stateHovered.destroy();
                    }
                }
            }
        }
    }
}
