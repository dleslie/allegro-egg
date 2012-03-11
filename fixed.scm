(cond-expand
 (windows 
  (define fix-to-rad (foreign-value "al_fixtorad_r" integer32))
  (define rad-to-fix (foreign-value "al_fixtorad_r" integer32)))
 (else '()
))
