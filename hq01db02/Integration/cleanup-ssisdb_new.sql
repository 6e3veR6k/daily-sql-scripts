DECLARE @DateFrom AS DATETIME = GETDATE() - 7
DECLARE @Records AS INT = 1
DECLARE @MaxOperationId AS INT

SELECT @MaxOperationId = MAX(O.operation_id)
FROM internal.operations AS O
WHERE O.end_time <= @DateFrom


WHILE @Records > 0
BEGIN

  ;WITH MSG_CTE AS (
    SELECT TOP 100000 msg.*
    FROM internal.event_messages AS msg
    WHERE msg.operation_id <= @MaxOperationId
  )

  DELETE FROM MSG_CTE

  SET @Records = @@ROWCOUNT
END


SET @Records = 1


WHILE @Records > 0
BEGIN

  ;WITH MSG_CTE AS (
    SELECT TOP 100000 msg.*
    FROM internal.execution_component_phases AS msg
    WHERE msg.execution_id <= @MaxOperationId

  )

  DELETE FROM MSG_CTE

  SET @Records = @@ROWCOUNT
END

SET @Records = 1

WHILE @Records > 0
BEGIN

  ;WITH MSG_CTE AS (
    SELECT TOP 100000 msg.*
    FROM internal.operation_messages AS msg
    WHERE msg.operation_id <= @MaxOperationId
  )

  DELETE FROM MSG_CTE

  SET @Records = @@ROWCOUNT
END
