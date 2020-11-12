---
layout: post 
title:  Vkd8CX12HRxnMBZL
date:   2020-09-08 15:01:35 +0300
image: '/images/hydatosbg.png'
categories: reports
dataTable: true
tags:   [reports]
---

# AV Damage - <img src="/images/whitewulf.jpg">
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
                "targets": [ 1 ],
                "searchable": false,
                "data": "Job",
                "render": function ( data, type, full, meta ) {
                        return '<img src="/images/'+data+'.png">';
                }
            }
        ]
})
</script>

# Ozma Damage
<table class="ozmadps">
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
$('table.ozmadps').DataTable({
        paging: false,
        "order": [[ 3, "desc" ]],
        scrollY: 400,
        responsive: true,
        "columnDefs": [
            {
                "targets": [ 3 ],
                "visible": false,
		"decimal": ",",
                "searchable": false
            }
        ]
} )
</script>
