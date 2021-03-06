/*
 * The MIT License
 *
 * Copyright 2013 RBC1B.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
$(document).ready(function() {
   
    // list view
    roms.common.datatables(
        $('#department-list'),
        {
            "iDisplayLength": 10,
            "aoColumnDefs": [
            {
                'bSortable': false,
                'aTargets': [ 3 ]
            }
            ]
        }
    );
    
    // details view
    roms.common.datatables(
	    $('#department-skills-list'),
	    {
		"iDisplayLength": 10
	    }
    );
   
    var assignmentListActionTemplate = $("#read-only-list-action").html();
    roms.common.datatables(
	    $('#department-assignment-list'),
	    {
		"iDisplayLength": 10,
		"bProcessing": true,
		"bServerSide": true,
		"sAjaxSource": roms.common.relativePath + '/departments/' + $('#department-assignment-list').data("departmentId") + "/assignments",
		"aoColumns": [
		              {   "sName": "person.forename", "mData": "person.forename" },
		              {   "sName": "person.surname", "mData": "person.surname" },
		              {   "sName": "person.congregation.name", "mData": "person.congregation.name", "sDefaultContent": "" },
		              {   "sName": "team.name", "mData": "team.name" },
		              {   "sName": "role", "mData": "role" },
		              {   "sName": "tradeNumber", "mData": "tradeNumber" },
		              {   "sName": "assignedDate", "mData": "assignedDate" },
		              {   "sName": "action", "bSortable": false,
		                  "mData":
		                      function ( data, type, val ) {
		                          data.person.uriBase = roms.common.relativePath;
		                          return Mustache.to_html(assignmentListActionTemplate, data.person);
		                      }
		              }
	            ]
	        }
	    );
});
