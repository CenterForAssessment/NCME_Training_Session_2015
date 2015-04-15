/*!
* plot created in R using the rChart package
* 
* require(rCharts)
* hair_eye = as.data.frame(HairEyeColor)
* p2 <- nPlot(Freq ~ Hair, group = 'Eye', data = subset(hair_eye, Sex == "Female"), type = 'multiBarChart')
* p2$chart(color = c('brown', 'blue', '#594c26', 'green'))
* p2
*/

$(document).ready(function(){
  drawchart()
});
function drawchart(){  
  var opts = {
      "dom": "chart",
      "width":    700,
      "height":    350,
      "x": "Hair",
      "y": "Freq",
      "group": "Eye",
      "type": "multiBarChart",
      "id": "chart" 
  },
    data = [{
        "Hair": "Black",
        "Eye": "Brown",
        "Sex": "Female",
        "Freq": 36 
    },{
        "Hair": "Brown",
        "Eye": "Brown",
        "Sex": "Female",
        "Freq": 66 
    },{
        "Hair": "Red",
        "Eye": "Brown",
        "Sex": "Female",
        "Freq":     16 
    },{
        "Hair": "Blond",
        "Eye": "Brown",
        "Sex": "Female",
        "Freq":      4 
    },{
        "Hair": "Black",
        "Eye": "Blue",
        "Sex": "Female",
        "Freq":      9 
    },{
        "Hair": "Brown",
        "Eye": "Blue",
        "Sex": "Female",
        "Freq":     34 
    },{
        "Hair": "Red",
        "Eye": "Blue",
        "Sex": "Female",
        "Freq":      7 
    },{
        "Hair": "Blond",
        "Eye": "Blue",
        "Sex": "Female",
        "Freq":     64 
    },{
        "Hair": "Black",
        "Eye": "Hazel",
        "Sex": "Female",
        "Freq":      5 
    },{
        "Hair": "Brown",
        "Eye": "Hazel",
        "Sex": "Female",
        "Freq":     29 
    },{
        "Hair": "Red",
        "Eye": "Hazel",
        "Sex": "Female",
        "Freq":      7 
    },{
        "Hair": "Blond",
        "Eye": "Hazel",
        "Sex": "Female",
        "Freq":      5 
    },{
        "Hair": "Black",
        "Eye": "Green",
        "Sex": "Female",
        "Freq":      2 
    },{
        "Hair": "Brown",
        "Eye": "Green",
        "Sex": "Female",
        "Freq":     14 
    },{
        "Hair": "Red",
        "Eye": "Green",
        "Sex": "Female",
        "Freq":      7 
    },{
        "Hair": "Blond",
        "Eye": "Green",
        "Sex": "Female",
        "Freq":      8 
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

        chart.color([ "brown", "blue", "#594c26", "green" ])

        d3.select("#" + opts.id)
        .append('svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

        nv.utils.windowResize(chart.update);
        return chart;
    });
};
