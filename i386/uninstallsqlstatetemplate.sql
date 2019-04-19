USE master
GO

/*
   InstallSqlStateTemplate.sql and UninstallSqlStateTemplate.sql are
   templates files for installing the ASP.NET session state SQL objects
   on a database other than the default 'ASPState'.

   To create your own script files based on the template:
   1. Create your own script files by coping the two template files.
   2. Decide a name for your database (e.g. MyASPStateDB)
   3. In your own script files, replace all occurences of "DatabaseNamePlaceHolder"
      by your database name.
   4. Install and uninstall ASP.NET session state SQL objects using your own
      script files.
*/

/* Drop the database containing our sprocs */
IF DB_ID('DatabaseNamePlaceHolder') IS NOT NULL BEGIN
    DROP DATABASE DatabaseNamePlaceHolder
END
GO

/* Drop the obsolete startup enabler */
DECLARE @PROCID int
SET @PROCID = OBJECT_ID('EnableASPStateStartup') 
IF @PROCID IS NOT NULL AND OBJECTPROPERTY(@PROCID, 'IsProcedure') = 1 BEGIN
    DROP PROCEDURE EnableASPStateStartup
END
GO

/* Drop the obsolete startup disabler */
DECLARE @PROCID int
SET @PROCID = OBJECT_ID('DisableASPStateStartup') 
IF @PROCID IS NOT NULL AND OBJECTPROPERTY(@PROCID, 'IsProcedure') = 1 BEGIN
    DROP PROCEDURE DisableASPStateStartup
END
GO

/* Drop the DatabaseNamePlaceHolder_DeleteExpiredSessions_Job */
DECLARE @JobID BINARY(16)  
SELECT @JobID = job_id     
FROM   msdb.dbo.sysjobs    
WHERE (name = N'DatabaseNamePlaceHolder_Job_DeleteExpiredSessions')       
IF (@JobID IS NOT NULL)    
BEGIN  
    -- Check if the job is a multi-server job  
    IF (EXISTS (SELECT  * 
              FROM    msdb.dbo.sysjobservers 
              WHERE   (job_id = @JobID) AND (server_id <> 0))) 
    BEGIN 
        -- There is, so abort the script 
        RAISERROR (N'Unable to import job ''DatabaseNamePlaceHolder_Job_DeleteExpiredSessions'' since there is already a multi-server job with this name.', 16, 1) 
    END 
    ELSE 
        -- Delete the [local] job 
        EXECUTE msdb.dbo.sp_delete_job @job_name = N'DatabaseNamePlaceHolder_Job_DeleteExpiredSessions' 
END

