CREATE TRIGGER refresh_sumamry
AFTER INSERT ON detailed
FOR EACH STATEMENT
EXECUTE PROCEDURE refresh_sumamry_function();
