-- Leadboard query

-- Gets the top 10 players with the highest score
SELECT 
    username as "Player",
    score as "Score"
FROM 
    player
ORDER BY 
    score desc
LIMIT 10;