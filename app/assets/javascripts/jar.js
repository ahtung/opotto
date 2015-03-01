$(".d3").each(function(){
  //The data for our line
  var lineData = $(this).data('points');

  //This is the accessor function we talked about above
  var lineFunction = d3.svg.line()
                     .x(function(d) { return d.x; })
                     .y(function(d) { return d.y; })
                      .interpolate("basis-closed");
  //The SVG Container
  var svgContainer = d3.select(this)
                     .attr("width", 200)
                     .attr("height", 200);

  //The line SV.pushath we draw
  var lineGraph = svgContainer.append("path")
                     .attr("d", lineFunction(lineData))
                     .attr("stroke", "blue")
                     .attr("stroke-width", 2)
                     .attr("fill", "lime");

  var height = 200;
  var width = 200;
  var fullness = parseFloat($(this).data('fullness'));

  svgContainer
  .append('defs')
    .append('mask')
      .attr('id', 'mask')
      .attr('x', 0)
      .attr('y', 0)
      .attr('width', width)
      .attr('height', height)
    .append("path")
      .attr("d", lineFunction(lineData))
      .attr("stroke", "red")
      .attr("stroke-width", 2)
      .attr("fill", "lime");

  svgContainer
  .append("rect")
    .attr('x', 0)
    .attr('y', 0)
    .attr('width', width)
    .attr('height', height)
    .attr('fill', 'blue');

  svgContainer
  .append("rect")
    .attr('x', 0)
    .attr('y', height - (fullness * height))
    .attr('width', width)
    .attr('height', (fullness * height))
    .attr('fill', 'red')
    .attr('mask', 'url(#mask)');
});