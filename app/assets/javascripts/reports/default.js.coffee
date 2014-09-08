draw_frequency_table = () ->
  table = d3.select("#freq-table").append("table")
  .attr("class", "table table-bordered")

  @columns = ["label", "frequency"]
  thead = table.append("thead")
  tbody = table.append("tbody")

  #thead.selectAll("th").data(columns).enter().append("th").text((d) -> d)


  update_frequency_table()

update_frequency_table = () ->
  tbody = d3.select("#freq-table table tbody")
  question_id = $("#question-select").val()
  answer_session_id = $("#question-select").data("answer-session-id")
  qf_path = $("#question-select").data("json-path")

  d3.json(qf_path+'/'+question_id+'/'+answer_session_id+'.json', (error, json_data) ->
    user_answer = json_data.user_answer
    data = json_data.frequencies.map((f) -> { label: f.label, frequency: (Math.round(f.frequency * 100) + "%") })

    rows = tbody.selectAll("tr").data(data)

    rows.exit().remove()

    rows.enter()
    .append("tr")

    rows.attr('class', (d) ->
      if user_answer == d.label
        "active"
      else
        ""
    )

    cells = rows.selectAll("td")
    .data((row) -> columns.map((column) ->
      {column: column, value: row[column]}
    ))

    cells.exit().remove()

    cells.enter()
    .append("td")

    cells.html((d) -> d.value )


  )


draw_frequency_graph = () ->
  width = 300
  height = 300
  @radius = 150
  @color = d3.scale.category20c();
  @arc = d3.svg.arc().outerRadius(radius)
  @pie = d3.layout.pie().value((d) -> d.frequency)

  svg = d3.select("#freq-graph").append('svg')
  .attr("height", height)
  .attr("width", width)
  .append("g")
  .attr("transform", "translate("+radius+","+radius+")")



  update_frequency_graph()



update_frequency_graph = () ->
  question_id = $("#question-select").val()
  answer_session_id = $("#question-select").data("answer-session-id")
  qf_path = $("#question-select").data("json-path")

  d3.json(qf_path+'/'+question_id+'/'+answer_session_id+'.json', (error, json_data) ->
    d3.select("#freq-graph svg g").selectAll("g.slice").remove()

    arcs = d3.select("#freq-graph svg g").selectAll("g.slice")
    .data(pie(json_data.frequencies))

    g = arcs.enter()
    .append("g")
    .attr("class", "slice")

    g.append("path")
    .attr("fill", (d,i) -> color(i))
    .attr("d", arc)

    g.append("text")
    .attr("transform", (d) ->
      d.innerRadius = 0
      d.outerRadius = radius
      "translate(" + arc.centroid(d) + ")"
    )
    .attr("dy", ".35em")
    .style("text-anchor", "middle")
    .text((d) ->
      if d.data.frequency > 0.1
        d.data.label
      else
        ""
    );


  )

draw_frequency_table()
draw_frequency_graph()

$(document).on 'change', '#question-select', () ->
  update_frequency_table()
  update_frequency_graph()