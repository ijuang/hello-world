-- This Year MTD (Column 1) ---------------------------------------

-- VALIDATED
-- Unique Sessions
stat(sum, 0, select [Activity Date: Sum: # Sessions] from [all]
where [Fiscal Time.Fiscal Year] = getvariable('FCCurrentYear')
and [Fiscal Time.Fiscal Month] = getvariable('FCCurrentMonth')
and [Time.Date] < getVariable('CurrentDate'))

-- VALIDATED: Note this includes both inactive and active Contacts
-- Leads
stat(sum, 0, select [Created Date: # Distinct Contact Id] from [all]
where [Fiscal Time.Fiscal Year] = getvariable('FCCurrentYear')
and [Fiscal Time.Fiscal Month] = getvariable('FCCurrentMonth')
and [Time.Date] < getVariable('CurrentDate'))


-- All Assigned Opportunities
stat(sum, 0, select [Opportunity Assigned Date: # Distinct Opportunity Id] from [all]
where [Fiscal Time.Fiscal Year] = getvariable('FCCurrentYear')
and [Fiscal Time.Fiscal Month] = getvariable('FCCurrentMonth')
and [Time.Date] < getVariable('CurrentDate')
and ([CRM Opportunity.Opportunity Status] not in ('Duplicate', 'Training or Test Data') or [CRM Opportunity.Opportunity Status] is null)
and  [CRM Opportunity.Opportunity Designer Owner] <> 'To Be Assigned'
and [CRM Opportunity.Assigned Opportunities] = 1   -- WHAT DOES THIS MEAN
)
+
stat(sum, 0, select [Opportunity Created Date: # Distinct Opportunity Id] from [all]
where [Fiscal Time.Fiscal Year] = getvariable('FCCurrentYear')
and [Fiscal Time.Fiscal Month] = getvariable('FCCurrentMonth')
and [Time.Date] < getVariable('CurrentDate')
and ([CRM Opportunity.Opportunity Status] not in ('Duplicate', 'Training or Test Data') or [CRM Opportunity.Opportunity Status] is null)
and  [CRM Opportunity.Opportunity Designer Owner] <> 'To Be Assigned'
and [CRM Opportunity.Assigned Opportunities] = 1
and  [CRM Opportunity.Opportunity Creator Name] in (select [CRM Designer Creator.Designer Creator] from [CRM Designer Creator])
)


-- Designed Opportunities
stat(sum, 0, select [Opportunity Initial Packet Sent Date: # Distinct Opportunity Id] from [all]
where [Fiscal Time.Fiscal Year] = getvariable('FCCurrentYear')
and [Fiscal Time.Fiscal Month] = getvariable('FCCurrentMonth')
and [Time.Date] < getVariable('CurrentDate')
)


-- Sold Opportunities
/*
stat(sum, 0, select  [Sold Order Created Date: # Distinct Opportunity Id] from [all]
where [Fiscal Time.Fiscal Year] = getVariable('FCCurrentYear')
and [Fiscal Time.Fiscal Month] = getVariable('FCCurrentMonth')
and [Fiscal Time.Fiscal Business Day Of Month]  <= getVariable('FCCurrentBusinessDayOfMonth')
and [Sales Conversion.Checkout Amount] >= 1000
) */

stat(sum, 0, select  [JDE Order Created Date: # Distinct Opportunity Id] from [all]
where [Fiscal Time.Fiscal Year] = getVariable('FCCurrentYear')
and [Fiscal Time.Fiscal Month] = getVariable('FCCurrentMonth')
and [Fiscal Time.Fiscal Business Day Of Month]  <= getVariable('FCCurrentBusinessDayOfMonth')
and [Sales Conversion.Checkout Amount] >= 1000
)

-- CliqStudios JDE Orders

-- 6 Square JDE Orders

-- JDE Sales [Shipped]




-- Last Year MTD (Column 2) ---------------------------------------

-- Unique Sessions

-- Leads

-- All Assigned Opportunities

-- Designed Opportunities

-- Sold Opportunities


-- CliqStudios JDE Orders


-- 6 Square JDE Orders


-- JDE Sales [Shipped]
