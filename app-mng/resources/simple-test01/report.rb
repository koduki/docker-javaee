require 'erb'
require 'json'
require 'time'

lines = open('app.log').read.split(/\n/)
items = lines.map do |l|
    xs=l.split(/\s+/)
    data=JSON.parse(xs[2..-1].join(' '))
    data['type']=xs[1]
    data['timestamp']=Time.parse(xs[0])
    data
end

data = items.group_by do |item|
    item['timestamp']
end.map do |xs| 
    xs[1].map{|item| item['Turnaround(ms)'] }
end.map do |xs|
    sum = xs.reduce(0){|r, x| r + x.to_f }
    [xs.size, sum / xs.size]
end

count = data.map{|xs| xs.first}
time  = data.map{|xs| xs.last }


puts ERB.new(DATA.read, nil, '-').result(binding)
__END__

<html>
    <head>
        <!-- Load c3.css -->
        <link href="http://cdnjs.cloudflare.com/ajax/libs/c3/0.4.7/c3.min.css" rel="stylesheet" type="text/css">

        <!-- Load d3.js and c3.js -->
        <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="http://d3js.org/d3.v3.min.js"></script>
        <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/c3/0.4.7/c3.min.js"></script>
        <script type="text/javascript">
        $(function(){
            var chart_jaxrs = c3.generate({
                bindto: '#chart_jaxrs',
                data: {
                    columns: [
                        ['request', <%= count.join(',') %>],
                        ['response', <%= time.join(',') %>]
                    ],
                    types: {
                        request: 'bar',
                        response: 'line'
                    },
                    axes: {
                        response: 'y2'
                    }
                },
                axis: {
                    y: {
                        label: {
                            text: 'request(count)',
                            position: 'outer-middle'
                        }
                    },
                    y2: {
                        show: true,
                        label: {
                            text: 'response(ms)',
                            position: 'outer-middle'
                        }
                    }
                }
    
            });
            
        });
        </script>
        <title>JavaEE Perfomance Report</title>
    </head>
    <body>
        <h1>JavaEE Perfomance Report</h1>
        <h2>JAX-RS with EJB + JPA(READ)</h2>
        <div id="chart_jaxrs"></div>
    </body>
</html>
