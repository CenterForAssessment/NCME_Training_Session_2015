/*!
* plot created in R using the rChart package
* 
* require(rCharts)
* ## {title: Stacked Area Chart}
* dat <- data.frame(t=rep(0:23,each=4),var=rep(LETTERS[1:4],4),val=round(runif(4*24,0,50)))
* p8 <- nPlot(val ~ t, group =  'var', data = dat, type = 'stackedAreaChart', id = 'chart')
* p8
*/

$(document).ready(function(){
	drawchart64af4f227d3()
});
function drawchart64af4f227d3(){  
	var opts = {
		"dom": "chart64af4f227d3",
		"width":    700,
		"height":    350,
		"x": "t",
		"y": "val",
		"group": "var",
		"type": "stackedAreaChart",
		"id": "chart64af4f227d3" 
	},
	data = [{
		"t": 0, "var": "A", "val":     32 
		},{
		"t": 0, "var": "B", "val":     27 
		},{
		"t": 0, "var": "C", "val":      3 
		},{
		"t": 0, "var": "D", "val":     30 
		},{
		"t": 1, "var": "A", "val":     26 
		},{
		"t": 1, "var": "B", "val":     29 
		},{
		"t": 1, "var": "C", "val":     49 
		},{
		"t": 1, "var": "D", "val":     41 
		},{
		"t": 2, "var": "A", "val":     41 
		},{
		"t": 2, "var": "B", "val":     14 
		},{
		"t": 2, "var": "C", "val":     24 
		},{
		"t": 2, "var": "D", "val":     31 
		},{
		"t": 3, "var": "A", "val":     26 
		},{
		"t": 3, "var": "B", "val":      5 
		},{
		"t": 3, "var": "C", "val":     47 
		},{
		"t": 3, "var": "D", "val":      1 
		},{
		"t": 4, "var": "A", "val":     28 
		},{
		"t": 4, "var": "B", "val":     10 
		},{
		"t": 4, "var": "C", "val":     26 
		},{
		"t": 4, "var": "D", "val":     44 
		},{
		"t": 5, "var": "A", "val":     25 
		},{
		"t": 5, "var": "B", "val":     40 
		},{
		"t": 5, "var": "C", "val":      7 
		},{
		"t": 5, "var": "D", "val":     45 
		},{
		"t": 6, "var": "A", "val":      9 
		},{
		"t": 6, "var": "B", "val":     36 
		},{
		"t": 6, "var": "C", "val":      3 
		},{
		"t": 6, "var": "D", "val":      2 
		},{
		"t": 7, "var": "A", "val":     47 
		},{
		"t": 7, "var": "B", "val":     14 
		},{
		"t": 7, "var": "C", "val":     24 
		},{
		"t": 7, "var": "D", "val":     28 
		},{
		"t": 8, "var": "A", "val":      3 
		},{
		"t": 8, "var": "B", "val":     15 
		},{
		"t": 8, "var": "C", "val":      5 
		},{
		"t": 8, "var": "D", "val":     23 
		},{
		"t": 9, "var": "A", "val":     15 
		},{
		"t": 9, "var": "B", "val":     30 
		},{
		"t": 9, "var": "C", "val":     49 
		},{
		"t": 9, "var": "D", "val":     20 
		},{
		"t": 10, "var": "A", "val":     41 
		},{
		"t": 10, "var": "B", "val":     34 
		},{
		"t": 10, "var": "C", "val":     24 
		},{
		"t": 10, "var": "D", "val":     24 
		},{
		"t": 11, "var": "A", "val":      3 
		},{
		"t": 11, "var": "B", "val":      5 
		},{
		"t": 11, "var": "C", "val":     26 
		},{
		"t": 11, "var": "D", "val":     29 
		},{
		"t": 12, "var": "A", "val":      8 
		},{
		"t": 12, "var": "B", "val":     37 
		},{
		"t": 12, "var": "C", "val":     27 
		},{
		"t": 12, "var": "D", "val":     21 
		},{
		"t": 13, "var": "A", "val":     18 
		},{
		"t": 13, "var": "B", "val":     34 
		},{
		"t": 13, "var": "C", "val":     31 
		},{
		"t": 13, "var": "D", "val":     24 
		},{
		"t": 14, "var": "A", "val":     21 
		},{
		"t": 14, "var": "B", "val":     44 
		},{
		"t": 14, "var": "C", "val":     32 
		},{
		"t": 14, "var": "D", "val":     43 
		},{
		"t": 15, "var": "A", "val":     20 
		},{
		"t": 15, "var": "B", "val":      6 
		},{
		"t": 15, "var": "C", "val":     25 
		},{
		"t": 15, "var": "D", "val":     30 
		},{
		"t": 16, "var": "A", "val":     43 
		},{
		"t": 16, "var": "B", "val":     21 
		},{
		"t": 16, "var": "C", "val":     27 
		},{
		"t": 16, "var": "D", "val":     45 
		},{
		"t": 17, "var": "A", "val":      7 
		},{
		"t": 17, "var": "B", "val":     41 
		},{
		"t": 17, "var": "C", "val":     30 
		},{
		"t": 17, "var": "D", "val":     14 
		},{
		"t": 18, "var": "A", "val":      3 
		},{
		"t": 18, "var": "B", "val":     42 
		},{
		"t": 18, "var": "C", "val":     44 
		},{
		"t": 18, "var": "D", "val":     32 
		},{
		"t": 19, "var": "A", "val":     47 
		},{
		"t": 19, "var": "B", "val":      2 
		},{
		"t": 19, "var": "C", "val":     24 
		},{
		"t": 19, "var": "D", "val":     10 
		},{
		"t": 20, "var": "A", "val":     48 
		},{
		"t": 20, "var": "B", "val":     18 
		},{
		"t": 20, "var": "C", "val":     19 
		},{
		"t": 20, "var": "D", "val":     13 
		},{
		"t": 21, "var": "A", "val":     13 
		},{
		"t": 21, "var": "B", "val":     47 
		},{
		"t": 21, "var": "C", "val":     11 
		},{
		"t": 21, "var": "D", "val":     30 
		},{
		"t": 22, "var": "A", "val":     30 
		},{
		"t": 22, "var": "B", "val":     44 
		},{
		"t": 22, "var": "C", "val":     31 
		},{
		"t": 22, "var": "D", "val":     35 
		},{
		"t": 23, "var": "A", "val":     22 
		},{
		"t": 23, "var": "B", "val":      1 
		},{
		"t": 23, "var": "C", "val":     49 
		},{
		"t": 23, "var": "D", "val":     29 
	}]

	var data = d3.nest()
	.key(function(d){
	  return opts.group === undefined ? 'main' : d[opts.group]
	})
	.entries(data)

	nv.addGraph(function() {
		var chart = nv.models[opts.type]()
		  .x(function(d) { return d[opts.x] })
		  .y(function(d) { return d[opts.y] })
		  .width(opts.width)
		  .height(opts.height)

		d3.select("#" + opts.id)
		.append('svg')
		.datum(data)
		.transition().duration(500)
		.call(chart);

		nv.utils.windowResize(chart.update);
		return chart;
	});
};
