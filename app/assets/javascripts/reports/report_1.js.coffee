calculate_predicted_ahi_change = () ->
  height = parseFloat($("#height").data("height"))
  old_w = parseFloat($("#current-weight").data("weight"))
  new_w = parseFloat($("#desired-weight").val())

  $("#predicted-change").html(weight_vs_ahi(old_w,new_w)+" %")
  $("#predicted-bmi").html(get_bmi(height, new_w))

weight_vs_ahi = (old_weight, new_weight) ->
  weight_change = ((new_weight-old_weight)/old_weight) * 100
  Math.round((2.938 * weight_change))

get_bmi = (height, weight) ->
  Math.round((weight / (height * height)) * 703)




draw_bmi_graph = () ->
  data = [
    { label: "Underweight", color: "underweight", from: 0, to: 18.5 },
    { label: "Normal", color: "normal", from: 18.5, to: 25 },
    { label: "Overweight", color: "overweight", from: 25, to: 30 },
    { label: "Obese", color: "obese", from: 30, to: 45 },
  ]

  bmi = parseFloat($("#bmi").data("bmi"))


  m = {top: 15, right: 5, bottom: 20, left: 5}
  w = 457 - m.left - m.right
  h = 90 - m.top - m.bottom
  x = d3.scale.linear().range([0, w])

  svg = d3.select("#bmi-graph svg.chart")
  .attr("class", "chart")
  .attr("height", h + m.top + m.bottom)
  .attr("width", w + m.right + m.left)
  .append("g")
  .attr("transform", "translate("+m.left+","+m.top+")")

  x.domain([0,45])

  xAxis = d3.svg.axis().scale(x).orient("bottom").tickValues([0, 18.5, 25, 30, 45, bmi])

  svg.append("g")
  .attr("class", "x axis")
  .attr("transform", "translate(0,"+h+")")
  .call(xAxis)

  graph = svg.selectAll(".bar").data(data).enter()

  graph.append("rect")
  .attr("class", (d) -> d.color)
  .attr("x", (d) -> x(d.from))
  .attr("width", (d) -> x(d.to - d.from))
  .attr("height", h)
  .attr("y", 0)

  graph.append("text")
  .style("text-anchor", "middle")
  .style("font-size", '10px')
  .style("font-weight", 'bold')
  .text((d) -> d.label)
  .attr("x", (d) -> x(((d.to - d.from)/2)+ d.from) )
  .attr("y", -7)

  svg.append('svg:line')
  .attr('class', 'my_bmi')
  .attr("x1", x(bmi))
  .attr("x2", x(bmi))
  .attr("y1", -1)
  .attr("y2", h+1)
  .attr("stroke-width", 2)
  .attr("stroke", "black")



draw_ahi_graph = () ->
  data = [
    {weight_change: -20, ahi_change: -48},
    {weight_change: -10, ahi_change: -26},
    {weight_change: -5, ahi_change: -14},
    {weight_change: 5, ahi_change: 15},
    {weight_change: 10, ahi_change: 32},
    {weight_change: 20, ahi_change: 70}
  ]


  m = {top: 10, right: 10, bottom: 30, left: 40}
  w = 750 - m.left - m.right
  h = 350 - m.top - m.bottom
  xa = d3.scale.ordinal().rangeRoundBands([0, w], .1)
  ya = d3.scale.linear().range([h, 0])



  # Create Graph Area
  svg = d3.select("#ahi-graph svg.chart")
  .attr("width", w + m.left + m.right)
  .attr("height", h + m.top + m.bottom)
  .append("g")
  .attr("transform", "translate(" + m.left + "," + m.top + ")")

  xa.domain([-20, -10, -5, 5, 10, 20])
  ya.domain([100, -100])

  xAxis = d3.svg.axis().scale(xa).orient("bottom")
  yAxis = d3.svg.axis().scale(ya).orient("left").ticks(20)


  # Create X Axis
  svg.append("g")
  .attr("class", "x axis")
  .attr("transform", "translate(0," + h + ")")
  .call(xAxis)
  .append('text')
  .attr("x", w/2)
  .attr("y", 27)
  .attr("dx", ".71em")
  .style("text-anchor", "middle")
  .text('Change in Weight (%)')

  # Create Y Axis
  svg.append("g")
  .attr("class", "y axis")
  .call(yAxis)
  .append("text")
  .attr("transform", "rotate(-90)")
  .attr("y", 0 - m.left)
  .attr("x", 0 - (h/2))
  .attr("dy", "1em")
  .style("text-anchor", "middle")
  .text("Change in AHI (%)")


  graph = svg.selectAll(".bar").data(data)

  graph.enter().append("rect")
  .attr("class", "bar")
  .attr("x", (d) -> xa(d.weight_change))
  .attr("width", w/6 - 10)
  .attr("y", (d) -> d3.min([h - ya(d.ahi_change), ya(0)]))
  .attr("height", (d) -> Math.abs(ya(d.ahi_change) - ya(0)))

  window.xa = xa
  window.ya = ya

draw_ahi_graph()
draw_bmi_graph()
$(document).on 'change', '#desired-weight', () ->
  calculate_predicted_ahi_change()