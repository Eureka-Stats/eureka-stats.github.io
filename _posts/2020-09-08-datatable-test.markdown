---
layout: post
title:  DataTable Test
date:   2020-09-08 15:01:35 +0300
image:  ''
dataTable: true
tags:   [Business, Work]
---
# AV Damage
<table id="avdps" class="table table-hover table-striped table-dark ">
  {% for row in site.data.Vkd8CX12HRxnMBZL.avdamage %}
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
<table class="ozmadps table">
  {% for row in site.data.ozmadamage %}
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
        buttons:[
            'searchPanes'
        ],
        dom: 'Bfrtip',
	"searching": false,
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
