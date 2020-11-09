---
layout: post
title:  Table Test
date:   2020-11-08 15:01:35 +0300
image:  ''
tags:   [Business, Work]
---
### AV Damage
<div class="table-container">
<table>
  {% for row in site.data.avdamage %}
    {% if forloop.first %}
   <thead>
   <tr>
        <th class="text">Job</th>
        <th class="text">Name</th>
        <th class="text">DPS</th>
        <th class="text">Total Damage</th>
   </tr>
   </thead>
    {% endif %}

    {% tablerow pair in row %}
      {{ pair[1] }}
    {% endtablerow %}
  {% endfor %}
</table>
</div>


### Ozma Damage
<div class="table-container">
<table>
  {% for row in site.data.ozmadamage %}
    {% if forloop.first %}
   <thead>
    <tr>
      {% for pair in row %}
        <th class="text">{{ pair[0] }}</th>
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
