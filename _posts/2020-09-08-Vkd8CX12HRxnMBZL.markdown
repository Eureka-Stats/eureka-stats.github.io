---
layout: post 
title:  Vkd8CX12HRxnMBZL
date:   2020-09-08 15:01:35 +0300
image: '/images/hydatosbg.png'
categories: reports
dataTable: true
tags:   [reports]
---
#### Tab Test
<div>
        <ul class="nav nav-tabs" role="tablist" style="border-bottom: none;">
            <li class="active">
                <a href="#tab-table1" data-toggle="tab"><img src="/images/jobs/Samurai.png" alt=" " title="" data-action="zoom"></a>
            </li>
            <li>
                <a href="#tab-table2" data-toggle="tab">HPS</a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="tab-table1">
                <table id="myTable1" class="table" width="100%" cellspacing="0">
					{% for row in site.data.reports.[page.title].finals.avdamage %}
						{% if forloop.first %}
						<thead>
						<tr>
						{% for pair in row %}
							<th>{{ pair[0] }}</th>
						{% endfor %}
						</tr>
						</thead>
						{% endif %}
						{% tablerow pair in row %}
						{{ pair[1] }}
						{% endtablerow %}
					{% endfor %}
                </table>
            </div>
            <div class="tab-pane" id="tab-table2">
                <table id="myTable2" class="table" width="100%" cellspacing="0">
					{% for row in site.data.reports.[page.title].finals.avhealing %}
						{% if forloop.first %}
						<thead>
						<tr>
						{% for pair in row %}
							<th>{{ pair[0] }}</th>
						{% endfor %}
						</tr>
						</thead>
						{% endif %}
						{% tablerow pair in row %}
						{{ pair[1] }}
						{% endtablerow %}
					{% endfor %}
                </table>
            </div>
        </div>
    </div>
<script>
$(document).ready(function() {
     
    $('table.table').DataTable( {
        scrollY: 200,
        scrollCollapse: true,
        paging:         false,
        "searching": false,
        "info" : false,
        "bSort" : false
    } );

    $('a[data-toggle="tab"]').on( 'shown.bs.tab', function (e) {
        $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
    } );
    // Apply a search to the second table for the demo
    //$('#myTable2').DataTable().search( 'New York' ).draw();
} );
</script>

