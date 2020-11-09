---
layout: post
title:  Table Test
date:   2020-11-08 15:01:35 +0300
image:  ''
tags:   [Business, Work]
---
<table>
  {% for row in site.data.avdamage %}
    {% if forloop.first %}
    <tr>
      {% for pair in row %}
        <th>{{ pair[0] }}</th>
      {% endfor %}
    </tr>
    {% endif %}

    {% tablerow pair in row %}
      {{ pair[1] }}
    {% endtablerow %}
  {% endfor %}
</table>
