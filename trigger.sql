CREATE TRIGGER refresh_sumamry
AFTER INSERT ON detailed
FOR EACH STATEMENT
EXECUTE PROCEDURE refresh_summary_function();