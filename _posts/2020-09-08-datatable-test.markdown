---
layout: post
title:  DataTable Test
date:   2020-09-08 15:01:35 +0300
image:  ''
dataTable: true
tags:   [Business, Work]
---
<table class="display">
  {% for row in site.data.csvfile %}
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
$('table.display').DataTable()
</script>

<!--
<script>
$(document).ready(function () {
$("#my-table > table").DataTable();
});
</script>
-->
