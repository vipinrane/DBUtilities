EXECUTE msdb.dbo.sysmail_add_account_sp
@account_name = 'MailTest',
@description = 'Sent Mail using MSDB',
@email_address = 'csa@e-zest.in',
@display_name = 'csa',
@username='csa@e-zest.in',
@password='Cs@$2014',
@mailserver_name = 'MAILSERVER.ezest.local'

EXECUTE msdb.dbo.sysmail_add_profile_sp
@profile_name = 'MailTest',
@description = 'Profile used to send mail'

EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
@profile_name = 'MailTest',
@account_name = 'MailTest',
@sequence_number = 1

EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
@profile_name = 'MailTest',
@principal_name = 'public',
@is_default = 1 ;

SELECT *FROM msdb.dbo.sysmail_account
SELECT *FROM msdb.dbo.sysmail_configuration
SELECT *FROM msdb.dbo.sysmail_principalprofile
SELECT *FROM msdb.dbo.sysmail_profile
SELECT *FROM msdb.dbo.sysmail_profileaccount
SELECT *FROM msdb.dbo.sysmail_profileaccount



 exec msdb.dbo.sp_send_dbmail @profile_name = 'MailTest', @recipients = 'sachin.lad@e-zest.in', @subject = 'Mail Test', @body = 'Mail Sent Successfully', @body_format = 'text'