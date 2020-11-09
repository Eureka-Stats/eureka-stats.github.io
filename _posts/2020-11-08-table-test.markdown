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



    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/jquery.csv.min.js"></script>
    <script type="text/javascript" src="/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/js/dataTables.bootstrap.js"></script>
    <script type="text/javascript" src="/js/csv_to_html_table.js"></script>


    <script type="text/javascript">
      function format_link(link){
        if (link)
          return "<a href='" + link + "' target='_blank'>" + link + "</a>";
        else
          return "";
      }

      CsvToHtmlTable.init({
        csv_path: '_data/Health Clinics in Chicago.csv',
        element: 'table-container', 
        allow_download: true,
        csv_options: {separator: ',', delimiter: '"'},
        datatables_options: {"paging": false},
        custom_formatting: [[4, format_link]]
      });
