---
layout: post 
title:  Vkd8CX12HRxnMBZL
date:   2020-09-08 15:01:35 +0300
image: '/images/hydatosbg.png'
categories: reports
dataTable: true
tags:   [reports]
---

# AV Damage <img src="/images/av.png" height="32" alt=" ">
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

<script>
document.addEventListener("DOMContentLoaded", function(event) {
   document.querySelectorAll('img').forEach(function(img){
  	img.onerror = function(){this.style.display='none';};
   })
});
</script>
