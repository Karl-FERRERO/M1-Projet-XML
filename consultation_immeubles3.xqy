xquery version "3.0";

element {QName("http://www.w3.org/1999/xhtml", "html")} {

    for $x in doc("merimee-MH.xml")/csv_data/row
    where $x/REF="PA00078014" or  $x/REF="PA00078015"
    return 
        <div class="fiche">
            <h1>
                <span>{data($x/REF)}</span> <br/>
                <span>{data($x/TICO)}</span>
                (<span>{data($x/COM)}</span>)
            </h1>
            <p>{data($x/PPRO)}</p>
        </div>
        
}
