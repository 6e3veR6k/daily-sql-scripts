SELECT
 *
FROM Stage.AgentActsCommissions AS src
LEFT JOIN Hub.AgentActsCommissions AS fh ON fh.HubAgentActsCommissionId = src.id
LEFT JOIN Hub.RealPayments AS sh on sh.RealPaymentGid = src.RealPaymentGid

WHERE sh.HubRealPaymentId is null or fh.HubAgentActsCommissionId is null