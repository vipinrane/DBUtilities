declare @startproc datetime
declare @endproc datetime
declare @time integer
declare @timeSeconds integer

select @startproc = getdate()

--Start - Add your SP with parameters to capture the time
exec 
rptCustomersAndDealsAddedHP '01/01/2014','06/04/2014' 
--rptContactAndReferenceParticipationAddedHP '01/01/2014','06/04/2014' 
--rptAutoFulfillContactsHP
--rptAssetProductionPipelineHP
--rptContentAssetListHP
--rptProspectAndInvitationDetailHP
--rptRequestActivityByStatusHP
--rptRequestActivityByType
--rptRequestActivityDetailHP
--rptRequestActivityHPCompletedBy
--rptRequestConfirmationStatusHP
--rptSpotlightInterviewViewersHP
--rptUnmanagedAssetUseHP
--rptUserAdoptionHP
--End - Add your SP with parameters to capture the time

select @endproc = getdate()

select @time = DATEDIFF(MILLISECOND, @startproc, @endproc)
select @timeSeconds = DATEDIFF(SECOND, @startproc, @endproc)
select str(@time) [In milliseconds]
select str(@timeSeconds) [In seconds]