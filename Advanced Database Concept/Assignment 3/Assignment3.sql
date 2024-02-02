SELECT distinct mrrel.aui1, mrrel.aui2, mrconso2.str AS description2, mrrel.rela, mrconso1.str AS description1
FROM mrrel
JOIN mrconso AS mrconso1 ON mrrel.aui1 = mrconso1.aui
JOIN mrconso AS mrconso2 ON mrrel.aui2 = mrconso2.aui
WHERE mrrel.rela = 'entire_anatomy_structure_of'
LIMIT 50;
