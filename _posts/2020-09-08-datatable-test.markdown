---
layout: post
title:  Vkd8CX12HRxnMBZL
date:   2020-09-08 15:01:35 +0300
image:  ''
categories: reports
dataTable: true
tags:   [reports]
---
# AV Damage
<table id="avdps" class="scrollbar-deep-purple bordered-deep-purple thin">
  {% for row in site.data.[page.title].avdamage %}
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

# Ozma Damage
<table class="ozmadps">
  {% for row in site.data.[page.title].avdamage %}
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
                "targets": [ 3 ],
                "visible": false,
                "searchable": false
            }
        ]
} )
</script>

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
                "searchable": false
            }
        ]
} )
</script>
