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
        <ul class="nav nav-tabs" role="tablist">
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
    $('a[data-toggle="tab"]').on( 'shown.bs.tab', function (e) {
        $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
    } );
     
    $('table.table').DataTable( {
        scrollY: 200,
        scrollCollapse: true,
        paging:         false,
        "searching": false,
        responsive: true,
        "info" : false,
        "bSort" : false
    } );
    // Apply a search to the second table for the demo
    //$('#myTable2').DataTable().search( 'New York' ).draw();
</script>


# Overview
<table id="reportoverview" class="display" width="100%" cellspacing="0">
  {% for row in site.data.reports.[page.title].finals.overview %}
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

<script>
$('#reportoverview').DataTable({
        paging: false,
        "searching": false,
        responsive: true,
        "info" : false,
	"bSort" : false,
        "columnDefs": [
            {
                "targets": [ 3,4,5 ],
                "visible": false,
                "searchable": false
            }
	]
})
</script>

## AV Damage <img src="/images/av.png" height="32" alt=" ">
<table id="avdps" class="scrollbar-deep-purple bordered-deep-purple thin">
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

<script>
$('#avdps').DataTable({
        paging: false,
        "order": [[ 3, "desc" ]],
        scrollY: 400,
        "searching": false,
        responsive: true,
        "info" : false,
        "columnDefs": [
	    {
                "targets": [ 3,4,5,6 ],
                "visible": false,
                "searchable": false
            },
            {
                "targets": [ 0 ],
                "searchable": true,
                "data": "Job",
                "render": function ( data, type, full, meta ) {
                        return '<img src="/images/jobs/'+data+'.png" alt=" " title=""> '+data+'';
               }
	    },
            {
                "targets": [ 2 ],
                "searchable": true,
		data: 'DPS',
    		render: $.fn.dataTable.render.number( ',', '.', 0, '' )
            },
            {
                "targets": [ 1 ],
                "searchable": true,
                "data": "Name",
		defaultContent: '+data+',
                "render": function ( data, type, full, meta ) {
                        return '<img src="/images/people/'+data+'.png" width="32" height="32" alt=" " style="border-radius: 50%"> '+data+'';
                }
            }
        ]
})
</script>

# Ozma Damage
<table id="ozmadps" class="scrollbar-deep-purple bordered-deep-purple thin">
  {% for row in site.data.reports.[page.title].finals.ozmadamage %}
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


<script>
$('#ozmadps').DataTable({
        paging: false,
        "searching": true,
        responsive: true,
        "info" : false,
        "columnDefs": [
            {
                "targets": [ 3,4,5,6 ],
                "visible": false,
                "searchable": false
            },
            {
                "targets": [ 0 ],
                "searchable": true,
                "data": "Job",
                "render": function ( data, type, full, meta ) {
                        return '<img src="/images/jobs/'+data+'.png" alt=" " width="32" height="32"> '+data+'';
               }
            },
            {
                "targets": [ 1 ],
                "searchable": true,
                "data": "Name",
                defaultContent: '+data+',
                "render": function ( data, type, full, meta ) {
                        return '<img src="/images/people/'+data+'.png" width="32" height="32" alt=" " style="border-radius: 50%"> '+data+'';
                }
            }
        ]
})
</script>
