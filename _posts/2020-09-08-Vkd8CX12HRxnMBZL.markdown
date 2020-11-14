---
layout: post 
title:  Vkd8CX12HRxnMBZL
date:   2020-09-08 15:01:35 +0300
image: '/images/hydatosbg.png'
categories: reports
dataTable: true
tags:   [reports]
---
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
    <tfoot>
        <tr>
            <th colspan="4" style="text-align:right">Total:</th>
            <th></th>
        </tr>
    </tfoot>
    {% endif %}
    {% tablerow pair in row %}
      {{ pair[1] }}
    {% endtablerow %}
  {% endfor %}
  <tfoot></tfoot>
</table>

<script>
$("#reportoverview").append('<tfoot><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tfoot>');
var table = $('#reportoverview').DataTable({
        paging: true;,
        "searching": false,
        responsive: true,
        "info" : false,
	buttons: [{ extend: 'print',
            footer: true }],
	"columnDefs": [
        	{
                "targets": [ 2 ],
                "data": "FFlogs",
                "render": function ( data, type, full, meta ) {
                        return '<a href="https://www.fflogs.com/reports/'+data+'">Link</a>';
                }
            }

	],
        "footerCallback": function ( tfoot, data, start, end, display ) {
            var api = this.api(), data;
 
            // Remove the formatting to get integer data for summation
            var intVal = function ( i ) {
                return typeof i === 'string' ?
                    i.replace(/[\$,]/g, '')*1 :
                    typeof i === 'number' ?
                        i : 0;
            };
 
            // Total over all pages
            total = api
                .column( 3 )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
 
            pageTotal = api
                .column( 3, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
 
            // Update footer
            $( api.column( 3 ).footer() ).html(
                '$'+pageTotal +' ( $'+ total +' total)'
            );
        }
    } );
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
