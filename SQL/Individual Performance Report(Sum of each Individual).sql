select Name,SEC_TO_TIME( SUM( TIME_TO_SEC( `Time Taken` ) ) ) from IPR1 
group by Name