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

/**
 *  THIS FILE IS NOT TO BE USED UNTIL BUG WITH
 *  rowArea.children[i].destroy(); IS FIXED
 *  FROM QT/QML LANGUAGE
 *
 *  USE histogram2.js INSTEAD !
 */

/**
 * Populates row with columns
 *
 * @param allValues A 2D table of columns values [0] and labels [1]
 * @return Nothing
 */
function populate(allValues) {
    if (rowArea.children.length > 0) deleteAll();
    var tableLength = allValues.length;
    for (var i = 0; i < tableLength; ++i) addColumn( allValues[i][0], allValues[i][1] );
    return;
}

/**
 * Deletes all existing columns
 *
 * @return Nothing
 */
function deleteAll() {
    for (var i = 0; i < rowArea.children.length; ++i) {
        rowArea.children[i].destroy();
        console.log("delete all: i:" + i + " children length " + rowArea.children.length);
    }
}

/**
 * Re-Draws the whole chart. If necessary, adds/deletes extra columns.
 *
 * @param newValues A 2D table of columns values [0] and labels [1]
 * @return Nothing
 */
function reDrawColumns(newValues) {
    var newValuesLength = newValues.length;
    var childrenLength = rowArea.children.length;
    console.log(" ");
    console.log("Suoritetaan...");
    console.log("Uuden taulukon pituus: "+newValues.length);
    console.log("Child taulukon pituus: "+childrenLength);
    // Delete unnecessary columns
    if (newValuesLength < childrenLength) {
        console.log("Poistetaan "+(childrenLength-newValuesLength)+" elementtia");
        deleteFromEnd( (childrenLength-newValuesLength), childrenLength );
        childrenLength = childrenLength - ( childrenLength - newValuesLength );
        console.log("Child taulukon pituus nyt: "+childrenLength);
    }
    // Add values to existing columns
    for (var i = 0; i < childrenLength; ++i) {
        rowArea.children[i].value = newValues[i][0];
        rowArea.children[i].label = newValues[i][1];
        console.log("Vaihetaan arvo indeksiin "+i+", value: "+newValues[i][0]+", label: "+newValues[i][1]);
    }
    // Add new columns, if newValues exceeds rowAreas children count
    for (var ii = childrenLength; ii < newValuesLength; ++ii) addColumn(newValues[ii][0], newValues[ii][1]);
}

/**
 * Deletes specific amount of columns from the end of the chart
 *
 * @param amount The amount of columns to be deleted
 * @param childs The amount of existing columns
 * @return Nothing
 */
function deleteFromEnd(amount, childs) {
    var lastIndex = childs - 1;
    for (var i = lastIndex; i > ( -1 && (lastIndex - amount) ); --i) {
        console.log("Poistetaan pylvas indeksista: "+i+", arvo on: "+rowArea.children[i].value);
        rowArea.children[i].destroy();
        console.log("delete from end: i:" + i + " children length " + rowArea.children.length);
    }
}

/**
 * Add a column
 *
 * @param value Column value
 * @param label Column name
 * @return Nothing
 */
function addColumn(value, label) {
    createQmlObject('import Qt 4.7;import "../";HistogramColumn{ value:'+value+'; label:"'+label+'"; }',
    rowArea, "dynamicSnippet1");
    console.log("Lisattiin pylvas arvolla: "+value+", labelilla: "+label);
    console.log("rowArean child luku on nyt: "+rowArea.children.length);
    return;
}

/**
 * THIS FUNCTION IS FOR TEST PURPOSES
 */

/**
 * Sets random values to histogram
 *
 * @return Nothing
 */
function testIt() {
    var testTable = new Array();
    for (var i = 0; i < (4+Math.round(3*Math.random())); ++i) {
        testTable[i] = new Array();
        testTable[i][0] = Math.round(Math.random()*100);
        testTable[i][1] = "Tuote-"+i;
    }
    console.log("testIt: " + testTable.length +  " " + testTable[0].length)
    reDrawColumns( testTable );
    console.log("testIt-oppu");
}



// testTable
var testTable = new Array();
testTable[0] = new Array();
testTable[0][0] = 40;
testTable[0][1] = "Tuote1";
testTable[1] = new Array();
testTable[1][0] = 60;
testTable[1][1] = "Tuote2";
testTable[2] = new Array();
testTable[2][0] = 100;
testTable[2][1] = "Tuote3";
testTable[3] = new Array();
testTable[3][0] = 85;
testTable[3][1] = "Tuote4";

