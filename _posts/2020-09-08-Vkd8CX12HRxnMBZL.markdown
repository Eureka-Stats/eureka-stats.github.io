---
layout: post 
title:  Vkd8CX12HRxnMBZL
date:   2020-09-08 15:01:35 +0300
image: '/assets/img/hydatosbg.png'
categories: reports
dataTable: true
tags:   [reports]
---
# Overview
<table id="reportoverview" class="table align-items-center table-dark" wi>
  {% for row in site.data.reports.[page.title].finals.overview %}
    {% if forloop.first %}
    <thead class="thead-dark">
    <tr>
      {% for pair in row %}
        <th scope="col" class="sort">{{ pair[0] }}</th>
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
<table id="avdps" class="table align-items-center table-dark">
  {% for row in site.data.reports.[page.title].finals.avdamage %}
    {% if forloop.first %}
    <thead class="thead-dark">
    <tr>
      {% for pair in row %}
        <th scope="col" class="sort">{{ pair[0] }}</th>
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
jQuery.noConflict()(function ($) {
$(document).ready(function() {
$('#avdps').DataTable({
        paging: false,
        "order": [[ 3, "desc" ]],
        scrollY: 400,
        "searching": false,
        responsive: true,
        "info" : false,
        "columnDefs": [
	    {
                "targets": [ 3,4,5,6,7 ],
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
                        return '<object data="/images/people/'+data+'.png"  width="32" height="32" alt=" " style="border-radius: 50%;vertical-align:middle"> <img src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="> </object> '+data+'';
                }
            }
        ]
})
});
});
</script>

# Ozma Damage
<table id="ozmadps" class="table align-items-center table-dark">
  {% for row in site.data.reports.[page.title].finals.ozmadamage %}
    {% if forloop.first %}
    <thead class="thead-dark">
    <tr>
      {% for pair in row %}
        <th scope="col" class="sort">{{ pair[0] }}</th>
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
jQuery.noConflict()(function ($) {
$(document).ready(function() {
$('#ozmadps').DataTable({
        paging: false,
        "order": [[ 3, "desc" ]],
        scrollY: 400,
        "searching": false,
        responsive: true,
        "info" : false,
        "columnDefs": [
            {
                "targets": [ 3,4,5,6,7 ],
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
});
});
</script>
