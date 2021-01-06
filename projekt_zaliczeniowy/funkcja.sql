IF( SELECT COUNT(*) FROM produkty WHERE id_produktu = @p0 AND cena<30)>0 THEN RETURN "spoko" ; else RETURN "nie dobrze";
END IF