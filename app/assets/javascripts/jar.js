
var margin = 0;
var width = parseInt($('.vis').width()) - margin * 2;
var height = parseInt($('.vis').height()) - margin * 2;
var svgContainers = [];

console.log(width, height)

var xScale = d3.scale.linear()
    .range([0, width])
    .nice();

var yScale = d3.scale.linear()
    .range([0, height])
    .nice();

var line = d3.svg.line()
    .x(function(d) { return xScale(d.x); })
    .y(function(d) { return yScale(d.y); })
    .interpolate("basis-closed");

$(".d3").each(function(){
  //The data for our line
  var lineData = $(this).data('points');

  //The SVG Container
  var svgContainer = d3.select(this)
                     .attr("width", 200)
                     .attr("height", 200);

  var height = 200;
  var width = 200;
  var fullness = parseFloat($(this).data('fullness'));

  svgContainer
  .append('defs')
    .append('mask')
      .attr('id', 'mask')
      .attr('x', 0)
      .attr('y', 0)
      .attr('width', xScale(1.0))
      .attr('height', yScale(1.0))
    .append("path")
      .attr("d", line(lineData))
      .attr("fill", "#B7E8D8");
  //
  // svgContainer
  // .append("rect")
  //   .attr('x', 0)
  //   .attr('y', 0)
  //   .attr('width', width)
  //   .attr('height', height)
  //   .attr('fill', 'blue');

  svgContainer
  .append("rect")
    .attr('x', 0)
    .attr('y', yScale(1.0 - fullness))
    .attr('width', xScale(1.0))
    .attr('height', yScale(fullness))
    .attr('fill', '#B7E8D8')
    .attr('mask', 'url(#mask)');
});

// function init() {
//
//   $(".d3").each(function(index){
//
//     var lineData = $(this).data('points');
//     var fullness = parseFloat($(this).data('fullness'));
//
//     svg = d3.select(this)
//                .attr("width", xScale(1.0))
//                .attr("height", yScale(1.0));
//
//     svg.append('defs')
//           .append('mask')
//             .attr('class', 'mask')
//             .attr('x', 0)
//             .attr('y', 0)
//             .attr('width', xScale(1.0))
//             .attr('height', yScale(1.0))
//           .append("path")
//             .attr('class', 'line')
//             .attr("d", line(lineData))
//             .attr("fill", "#B7E8D8")
//           .append("rect")
//             .attr('class', 'rect')
//             .attr('x', 0)
//             .attr('y', yScale(1 - fullness))
//             .attr('width', xScale(1.0))
//             .attr('height', yScale(fullness))
//             .attr('fill', '#B7E8D8')
//             .attr('mask', 'url(#mask)');
//
//     svgContainers[index] = svg;
//   });
// }
//
// function draw() {
//   $(".d3").each(function(index){
//     var svg = d3.select(this).transition();
//     var fullness = parseFloat($(this).data('fullness'));
//
//     // svg.select(".mask").duration(200).attr("width", xScale(1.0));
//
//     // svg.select(".rect").attr('width', xScale(1.0))
//     //       .duration(200)
//     //       .attr('y', yScale(1 - fullness))
//     //       .attr('height', yScale(fullness))
//     // svg.select('.line')
//     //       .duration(200)
//     //         .attr('width', xScale(1.0))
//     //         .attr('height', yScale(1.0))
//   });
// }
//
// function resize() {
//   width = parseInt($('.vis').width()) - margin * 2;
//   height = parseInt($('.vis').height()) - margin * 2;
//
//   xScale.range([0, width]).nice();
//   yScale.range([0, height]).nice();
//
//   draw();
// }
//
// init();
// resize();
// d3.select(window).on('resize', resize);
//
