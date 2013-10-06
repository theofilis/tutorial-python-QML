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
 *  USE THIS FILE INSTEAD OF histogram.js
 *  UNTIL THE BUG DESCRIBED IN histogram.js
 *  IS FIXED!
 */

/**
 * Populates row with columns
 *
 * @param allValues A 2D table of columns values [0] and labels [1]
 * @return Nothing
 */
function populate(allValues) {
    var tableLength = allValues.length;
    for (var i = 0; i < tableLength; ++i) addColumn(allValues[i][0], allValues[i][1]);
}

/**
 * Deletes all existing columns
 *
 * @return Nothing
 */
function deleteAll() {
    var curVisible = countVisible();
    for (var i = 0; i < curVisible; ++i) {
        rowArea.children[i].visible = false;
    }
}

/**
 * Re-Draws the whole chart. If necessary, adds/deletes extra columns.
 * @param newValues A 2D table of columns values [0] and labels [1]
 * @return Nothing
 *
function reDrawColumns(newValues) {
    var newValuesLength = newValues.length;
    var childrenLength = rowArea.children.length;
    // Delete unnecessary columns
    if (newValuesLength < childrenLength) {
        deleteFromEnd( (childrenLength-newValuesLength), childrenLength );
        childrenLength = childrenLength - ( childrenLength - newValuesLength );
    }
    // Add values to existing columns
    for (var i = 0; i < childrenLength; ++i) {
        rowArea.children[i].value = newValues[i][0];
        rowArea.children[i].label = newValues[i][1];
    }
    // Add new columns, if newValues exceeds rowAreas children count
    for (var ii = childrenLength; ii < newValuesLength; ++ii) addColumn( newValues[ii][0], newValues[ii][1] );
}*/

/**
 * Re-Draws the whole chart. If necessary, adds/deletes extra columns.
 *
 * @param newValues A 2D table of columns values [0] and labels [1]
 * @return Nothing
 */
function reDrawColumns(newValues) {
    var newValuesLength = newValues.length;
    var childrenLength = rowArea.children.length;
    var visibleLength = countVisible();
    // Delete unnecessary columns
    if (newValuesLength < visibleLength) {
        deleteFromEnd( (visibleLength-newValuesLength), visibleLength );
        visibleLength = visibleLength - ( visibleLength - newValuesLength );
    }
    var tempvar = (newValuesLength<childrenLength)?newValuesLength:childrenLength;
    // Add values to existing columns
    for (var i = 0; i < tempvar; ++i) {
        rowArea.children[i].value = newValues[i][0];
        rowArea.children[i].label = newValues[i][1];
        rowArea.children[i].visible = true;
    }
    // Add new columns, if newValues exceeds rowAreas children count
    for (var ii = childrenLength; ii < newValuesLength; ++ii) addColumn(newValues[ii][0], newValues[ii][1]);
    structure.setID = structure.setID + 1;
}

/**
 * Deletes specific amount of columns from the end of the chart
 *
 * @param amount The amount of columns to be deleted
 * @param childs The amount of columns existing
 * @return Nothing
 */
function deleteFromEnd( amount, childs ) {
    var lastIndex = childs - 1;
    for (var i = lastIndex; i > ( -1 && (lastIndex - amount)); --i ) {
        rowArea.children[i].visible = false;
    }
}

/**
 * Adds a column
 *
 * @param value Column value
 * @param label Column name
 * @return Nothing
 */
function addColumn( value, label ) {
    createQmlObject('import Qt 4.7;import "../";HistogramColumn{ value:'+value+'; label:"'+label+'"; }',
    rowArea, "dynamicSnippet1");
    return;
}

/**
 * Gets info from visible columns
 *
 * @return array
 */
function getValues() {
    var valueTable = new Array();
    for (var i = 0; i < countVisible(); ++i) {
        valueTable[i] = new Array();
        valueTable[i][0] = rowArea.children[i].value
        valueTable[i][1] = rowArea.children[i].label
    }
    return valueTable;
}

