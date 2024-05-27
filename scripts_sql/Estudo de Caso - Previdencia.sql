--Setor de Negócio: Previdência Cooperativa
--Gestor: Preciso de um relatório que me mostre a evolução de nosso total de participantes ativos, assistidos e Cancelados, mas observe que você não pode somar as quantidades de meses anteriores Ok?. Preciso desta informação pra ontem!!


WITH referencia AS (
SELECT 
last_day(dt_referencia) AS dt_referencia
FROM dw.ft_planoparticipante_agr
GROUP BY last_day(dt_referencia)
),qualificadora AS (
SELECT 
fp.dt_referencia,
fp.nk_plano,
fp.nk_central,
fp.nk_cooperativa,
fp.nk_agencia,
sum(CASE 
	WHEN fp.nk_statusplano IN (1,2,3,4) AND fp.dt_referencia = r.dt_referencia THEN qtd_participante ELSE 0 END) AS qtd_participantes_ativos,
SUM(CASE WHEN fp.nk_statusplano IN (11,12,13,14,15,16,19,20,21,25) AND fp.dt_referencia = r.dt_referencia THEN qtd_participante  ELSE 0 END) AS qtd_planosparticipantes_assisitidos,
sum(CASE WHEN fp.nk_statusplano IN (5,6,7,8,9,10,17,18,22,23,26,27) AND fp.dt_referencia = r.dt_referencia THEN qtd_participante ELSE 0 END) AS qtd_planoparticipantes_cancelados
FROM dw.ft_planoparticipante_agr fp
LEFT JOIN referencia AS r ON r.dt_referencia = fp.dt_referencia
GROUP BY 
fp.dt_referencia,
fp.nk_plano,
fp.nk_central,
fp.nk_cooperativa,
fp.nk_agencia
) SELECT
dt_referencia,
nk_plano,
nk_central,
nk_cooperativa,
nk_agencia,
sum(qtd_participantes_ativos) AS qtd_participantes_ativos,
sum(qtd_planosparticipantes_assisitidos) AS qtd_planosparticipantes_assisitidos,
sum(qtd_planoparticipantes_cancelados) AS qtd_planoparticipantes_cancelados
FROM qualificadora
GROUP BY 1,2,3,4,5
ORDER BY 1






























