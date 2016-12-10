function getMonumentDetailByRefXml(ref) {

    var query = "SELECT ?image ?longlat WHERE { ?subject wdt:P380 '"
        + ref + "'. ?subject wdt:P18 ?image . ?subject wdt:P625 ?longlat}";

    var url = "https://query.wikidata.org/bigdata/namespace/wdq/sparql";

    var concat = url + "?query=" + query;

    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", concat, false );
    xmlHttp.send( null );
    return xmlHttp.responseXML;
}

/**
 * Retourne un oobjet qui contient l'url de l'image et un tableau qui contient la localisation de ref
 * objet retourné avec : image: url de l'image, longlat: [0:longitude,1:latitude]
 *
 * @param ref
 */
function getMonumentDetailByRef(ref){
    var test = getMonumentDetailByRefXml(ref);

    var imageUrl = test.getElementsByTagName("uri")[0].firstChild.data;
    var location = test.getElementsByTagName("literal")[0].firstChild.data.slice(6, -1).split(" ");

    return {'image': imageUrl, 'longlat': location};

}



//window.onload(getMonumentDetailByRef("PA00104806"));
