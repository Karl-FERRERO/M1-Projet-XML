xquery version "3.0";

import module namespace httpclient = "http://exist-db.org/xquery/httpclient";

declare function local:getMonumentDetail($query as xs:anyURI)  {
    let $uri := xs:anyURI(concat("https://query.wikidata.org/bigdata/namespace/wdq/sparql?query=" ,$query))
    return httpclient:get($uri,false(),())
};

declare function local:buildQuery($ref as xs:string)  {
    let $query := concat("SELECT ?image ?longlat WHERE { ?subject wdt:P380 '"
            ,$ref, "'. ?subject wdt:P18 ?image . ?subject wdt:P625 ?longlat}")

    return $query

};


declare function local:getRes($res as xs:string){
    let $string1 := substring-before($res, ' ')
    let $string2 := substring-after($res, ' ')
    let $string2 := substring-after($string2, '(')
    let $string2 := substring-before($string2, ')')
    let $string2 := (substring-after($string2, ' '), substring-before($string2, ' '))
    return ($string1, $string2)
};
let $res := local:getMonumentDetail(xs:anyURI(encode-for-uri(local:buildQuery("PA00078014"))))

let $normalized :=normalize-space(data($res))


for $x in local:getRes($normalized)
return <div class="test">{$x}</div>