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



    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/jquery.csv.min.js"></script>
    <script type="text/javascript" src="/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="/js/dataTables.bootstrap.js"></script>
    <script type="text/javascript" src="/js/csv_to_html_table.js"></script>
 
<div class="container-fluid">

      <h2>CSV to HTML Table</h2>

      <p>Display any CSV file as a searchable, filterable, pretty HTML table. Done in 100% JavaScript. <a href='https://github.com/derekeder/csv-to-html-table'>Code on GitHub</a>.</p>

      <p>Here's a table of Health Clinics from the <a href='https://data.cityofchicago.org/browse?q=health%20clinic&sortBy=relevance&utf8=%E2%9C%93'>City of Chicago Data Portal</a>.</p>
      
      <div id='table-container'></div>

    </div><!-- /.container -->

    <footer class='footer'>
      <div class='container-fluid'>
        <hr />
        <p class='pull-right'><a href='https://github.com/derekeder/csv-to-html-table'>CSV to HTML Table</a> by <a href='http://derekeder.com'>Derek Eder</a></p>
      </div>
    </footer>

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
    </script>
