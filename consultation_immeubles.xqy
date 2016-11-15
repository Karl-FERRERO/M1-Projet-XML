xquery version "3.0";

element {QName("http://www.w3.org/1999/xhtml", "html")} {
    <body>
    
    <h1>Test</h1>
    
    <ul>
    {
    for $x in doc("merimee-MH.xml")/csv_data/row
    where $x/REF="PA00078014"
    order by $x/REF
    return <li style="color:blue;" class="{data($x/REG)}">{data($x/TICO)}</li>
    }
    </ul>
    
    </body>
}