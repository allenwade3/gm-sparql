DELETE { GRAPH <%s>
 { ?s <%s/newBR> ?o } 
} WHERE 
{ GRAPH <%s> {?s <%s/newBR> ?o } };

INSERT { GRAPH <%s> 
{ ?s <%s/newBR> ?Contribution . }}
WHERE {
SELECT ?s ((sum(?val2/?val1)*%s)+%s as ?Contribution)
WHERE {
    {
        {?x <%s> ?s.}
        { graph  <%s>
         {
            ?x  <%s/Deg> ?val1 . 
            ?x  <%s/prevBR> ?val2 
         }
        }
    }
}
GROUP BY ?s};


INSERT { GRAPH <%s> 
{ ?s <%s/newBR> ?Contribution.}} 
WHERE
{
    SELECT ?s (?val2 * (1 - %s) + %s as ?Contribution)
    WHERE {
        {
            {?s <%s> ?o.}
            { graph  <%s>
             {
                ?s  <%s/prevBR> ?val2 
             }
            }
            filter not exists {?x <%s> ?s.}
        }
    }

};
