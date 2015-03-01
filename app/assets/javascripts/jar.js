//The data for our line
var lineData = [ { "x": 1,   "y": 5},  { "x": 20,  "y": 20},
                 { "x": 40,  "y": 10}, { "x": 60,  "y": 40},
                 { "x": 80,  "y": 5},  { "x": 100, "y": 60}];

//This is the accessor function we talked about above
var lineFunction = d3.svg.line()
                         .x(function(d) { return d.x; })
                         .y(function(d) { return d.y; })
                         .interpolate("basis-closed");

//The SVG Container
var svgContainer = d3.select("#d3")
                     .attr("width", 200)
                     .attr("height", 200);

var height = 200;
var width = 200;
var fullness = 0.85;

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
    .attr("stroke", "blue")
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