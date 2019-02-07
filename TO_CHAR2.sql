
create or replace function TO_CHAR2( I_STRING in varchar2 
                                   , I_REMOVE in T_STRING_LIST /* stopwords for example T_STRING_LIST( 'the', 'a', 'an' ) */
                                   ) return varchar2 deterministic is

/* **************************************************************************************************

    The TO_CHAR2 is a String to String converter function.
    It keeps alpha numeric characters only
    removes the Stop Words
    converts to upper case
    So, this is a normalizing function what makes the comparison of strings easier

    sample:
    -------
    select TO_CHAR2 ( '@@@@The quick brown fox jumps over the lazy dog! >666<' , T_STRING_LIST( 'the', 'a', 'an' ) ) from dual;

    result:
    -------
    QUICKBROWNFOXJUMPSOVERLAZYDOG666

    History of changes
    yyyy.mm.dd | Version | Author         | Changes
    -----------+---------+----------------+-------------------------
    2019.02.04 |  1.0    | Ferenc Toth    | Created 

**************************************************************************************************** */
    V_STRING    varchar2( 32000 ) := ' '||regexp_replace( upper( I_STRING ), '[^0-9^A-Z]', ' ' )||' ';
    V_NUMBER    number;
begin
    for L_I in 1..I_REMOVE.count
    loop
        V_STRING := replace( V_STRING, ' '||upper( I_REMOVE( L_I ) )||' ', null );  -- remove the stop words
    end loop;

    V_STRING := replace( V_STRING, ' ', null );  -- remove the spaces

    return V_STRING;

end;
/
