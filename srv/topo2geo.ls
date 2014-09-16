require! topojson
require! fs

topo = fs.readFileSync "#__dirname/../data/pha_2010_obvody/pha10obv.topo.json" |> JSON.parse
features = topojson.feature topo, topo.objects."data" .features
fs.writeFileSync "#__dirname/../data/pha_2010_obvody/pha10obv.geo.json", JSON.stringify features
