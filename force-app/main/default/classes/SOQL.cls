/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Kharaam Sharifpour
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	public static List<Lead> getAllLeads() {
		List<Lead> allLeads = new List<Lead>([SELECT Id, LastName, Company, Phone, Email FROM Lead]);
		return allLeads;
	}

	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Contact> getContactsByFirstName() {
		List<Contact> contactsNamedJohn = new List<Contact>([SELECT Id, FirstName, LastName, Name 
															 FROM Contact 
															 WHERE FirstName = 'John']);
		return contactsNamedJohn;
	}

	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Id> getContactIdsByLastName() {
		List<Contact> contactWithLastNameSmithOrJones = new List<Contact>([SELECT Id 
																		   FROM Contact 
																		   WHERE LastName IN ('Smith', 'Jones')]);
		List<Id> conWithLastNameIds = new List<Id>();
		for (Contact con : contactWithLastNameSmithOrJones) {
				conWithLastNameIds.add(con.Id);
		}
		if (conWithLastNameIds.size() == 0) {
			return null;
		}

		return conWithLastNameIds;
	}



	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static List<Opportunity> accountWonOppo (Id accountId){
		if (accountId == null) {
			return null;
		}
		List<Opportunity> accWonOppo = new List<Opportunity>([SELECT Id, Name, StageName, Account.Name, Account.Id, CloseDate, Amount
															  FROM Opportunity 
															  WHERE Account.Id = :accountId AND StageName = 'Closed Won']);
	return accWonOppo;
	}

	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}

	public static Integer countOfAccounts (){
		List<Account> allAccounts = new List<Account>([SELECT Id FROM Account]);
		if (allAccounts.size() == 0) {
			return null;
		}
		return allAccounts.size();
	}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}
	public static Map<Id, Task> taskIdRecord(){
		List<Task> tasksDueNext7Days = new List<Task>([SELECT Id, WhoId, ActivityDate 
													   FROM Task 
													   WHERE ActivityDate <= NEXT_N_DAYS:7]);
		Map<Id, Task> taskIdRecPairMap = new Map<Id,Task>(tasksDueNext7Days);
		return taskIdRecPairMap;
	}
	

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}

	public static List<Contact> contactExampleEmail(){
		String exampleEmail = 'example.com';
		List<Contact> conExampleEmail = new List<Contact>([SELECT Id, Name, Email 
		                                                   FROM Contact 
														   WHERE Email LIKE '%example.com']);
		return conExampleEmail;
	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		String oppoKeyword = '%'+ keyword + '%';
		List<Opportunity> oppoWithKeyword = new List<Opportunity>([SELECT Id, Name 
		                                                           FROM Opportunity 
																   WHERE Name LIKE :oppoKeyword]);
		return oppoWithKeyword; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		List<Case> casesWithOtherOrigin = new List<Case>([SELECT Id, Origin, CaseNumber 
		                                                  FROM Case 
														  WHERE Origin NOT IN ('Email', 'Web', '')]);
		return casesWithOtherOrigin; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	//[public | private ] [static] data_type method_name (input parameters) {
	//  The body of the method
	//}

	public static List<Lead> filterLeadbySourceOrTitle (String leadSource, String keyword){
		//String q = 'SELECT Id, LeadSource, Title FROM Lead WHERE LeadSource = :leadSource OR Title LIKE '
		String titleIncludesKeyword = '%'+ keyword + '%';
		List<Lead> filteredLeads = new List<Lead>([SELECT Id, LeadSource, Title, LastName, Company, Phone, Email
												   FROM Lead 
												   WHERE LeadSource = :leadSource OR Title LIKE :titleIncludesKeyword]);
	return filteredLeads;
	}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		// Create a list to hold the Contact LastNames
		List<String> conLastNames = new List<String>();
		// Query the Contacts
		List<Contact> conFromAcc = new List<Contact> ([SELECT Id, LastName, AccountId
													   FROM Contact
													   WHERE AccountId = :accountId]);
		// Loop through each Contact and add the LastName to the list
		for (Contact con : conFromAcc) {
			//if (!conFromAcc.isEmpty()) {
				//continue;
			//}
			conLastNames.add(con.LastName);
		}
		if (conLastNames.size() == 0) {
			return null;
		}
		// Return the list of Contact LastNames
		return conLastNames; // Replace null with the variable you used to store the result
	}
	
	

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		// Use AggregateQuery to get the total revenue
		List<AggregateResult>  totalRevenueList = new List<AggregateResult>([SELECT SUM(Amount)
																			 FROM Opportunity 
																			 WHERE StageName = :stage OR Amount > 10000]);
		// Return the total revenue
		if (!totalRevenueList.isEmpty()) {
			Decimal totalRevenue = (Decimal) totalRevenueList[0].get('expr0');
		    return totalRevenue; // Replace null with the variable you used to store the result
		}
		return 0;
		
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		List<Account> tenAccount = new List<Account>([SELECT Id, Name 
													  FROM Account 
													  ORDER BY Name ASC 
													  LIMIT 10]);
		return tenAccount; // Replace null with the variable you used to store the result
	}



	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		List<Opportunity> oppoMoreThan100 = new List<Opportunity>([SELECT Amount, CloseDate, Id 
																   FROM Opportunity 
																   WHERE Amount > 100000 
																   ORDER BY CloseDate 
																   LIMIT 5]);
		return oppoMoreThan100; // Replace null with the variable you used to store the result
	}



	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		List<Contact> mostRecentBD = new List<Contact>([SELECT Birthdate 
														FROM Contact 
														ORDER BY Birthdate DESC 
														LIMIT 3]);
		return mostRecentBD; // Replace null with the variable you used to store the result
	}



	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		List<Case> caseWithStatus = new List<Case>([SELECT Status, CreatedDate, Id 
													FROM Case 
													WHERE Status != 'Closed'
													ORDER BY CreatedDate ASC 
													LIMIT 10 
													OFFSET 5]);
		return caseWithStatus; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		// Create a set to hold the Case Ids
		SET<Id> caseIds = new SET<Id>();
		// Query the Cases
		List<Case> casesByAccount = new List<Case>([SELECT Id FROM Case WHERE AccountId = :accountId]);
		// Loop through each Case and add the Id to the set
		for (Case c : casesByAccount) {
			if (!casesByAccount.isEmpty()) {
				caseIds.add(c.Id);
			}
		}

		return caseIds; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();
		// String to modify the parameter to be used in LIKE operator
		// String addressIncludesCountry = '%'+ country + '%';
		// Query the Accounts
		List<Account> accNotInCountry = new List<Account>([SELECT Id, Name, BillingCountry
														   FROM Account 
														   WHERE BillingCountry != :country]);
		// Loop through each Account and add the Id and Name to the map
		for (Account acc : accNotInCountry) {
			accountIdsToNames.put(acc.Id, acc.Name);
		}
		return accountIdsToNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		String accName;
		List<Account> conAccount = new List<Account>(
			[SELECT Id, Name 
			 FROM Account 
			 WHERE Id IN (SELECT AccountId FROM Contact WHERE Id = :ContactId)]);
		accName = (String) conAccount.get(0).Name;
		return accName; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		Account acc;
		List<Opportunity> oppsRelatedToAccount = new List<Opportunity>([SELECT Id FROM Opportunity WHERE AccountId = :accountId]);
		List<Account> accWithRelatedOpps = new List<Account>(
													[SELECT Name, Id, 
														(SELECT Id, AccountId, StageName, Name FROM Opportunities WHERE AccountId = :accountId) 
													FROM Account 
													WHERE Id = :accountId]);
		
		if (accWithRelatedOpps.isEmpty() || oppsRelatedToAccount.isEmpty()) {
			return null;
		}
		acc = accWithRelatedOpps[0];
		return acc; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		// Query the Account
		Account acc = [SELECT Id, BillingState FROM Account WHERE Id = :accountId LIMIT 1];
		// Store the Account's BillingState
		String accBillingState;
		if (acc != null) {
			accBillingState = acc.BillingState;
		}
		// Query the Contacts
		List<Contact> contactInBillingState = new List<Contact>(
														[SELECT Id 
														FROM Contact 
														WHERE MailingState =: accBillingState]);
		if (contactInBillingState.isEmpty()) {
			return null;
		}
		return contactInBillingState; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 22
	 * Extracts email domains from them leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		// Query the Leads

		Set<Lead> leadsWithEmail = new Set<Lead>([SELECT Id, Email FROM Lead WHERE Id IN :leadIds]);
		// Create a set of email domains from the Leads

		Set<String> emailDomains = new Set<String>();
		// Loop through each Lead

		for (Lead l : leadsWithEmail) {
			// Check if the email is not null

			if (!leadsWithEmail.isEmpty() && l.Email != null && l.Email.contains('@')) {
			// Get the email from the Lead
				
				String domain = l.Email.substring(l.Email.indexOf('@') + 1);	
				// Add the email domain to the set
				
				emailDomains.add(domain);
			}
		}
		
		List<Account> allAccountsWithWebsite = new List<Account>(
			[SELECT Id, Website
			 FROM Account WHERE Website != null]);

		List<Account> accountWithMatchingDomain = new List<Account>();
		
	
		for (Account acc: allAccountsWithWebsite) {
			//I figured I cannot compare the complete webiste string with just a substring of the email
			//I am trying to get a substring of the website for each account to compare with the email domain set
			//creating a substring to contain the domain part of the website.
			
			String websiteDomain;
			if (acc.Website.startsWith('www.')) { //what other possible starting strings can a website have
				websiteDomain = acc.Website.substring(4);
			} 
			if (emailDomains.contains(websiteDomain)) {
				accountWithMatchingDomain.add(acc);
			}
		}
		
		// Query the Accounts
		return accountWithMatchingDomain; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {

		// Query the original Opportunity Line Items
		List<OpportunityLineItem> originalLineItems = new List<OpportunityLineItem>(
			[SELECT Id, Quantity, UnitPrice, Product2Id, OpportunityId, Opportunity.Pricebook2Id, PricebookEntryId
			 FROM OpportunityLineItem 
			 WHERE OpportunityId = :origOppId]);

		// Create a list to hold the new line items
		List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();

		// Generate a random number between 1 and 3
		// I moved this line to inside the loop so that each line item has its own random number.
		// I think I should create a OpportunityLineItem sobject variable to be used in the loop.


		// Loop through each cloned Opportunity Id
		for (Id clonedId : cloneOppIds) {
			if (!cloneOppIds.isEmpty()) {
				
				// Loop through each original line item
				for (OpportunityLineItem lineI : originalLineItems) {
					if (!originalLineItems.isEmpty()) {
						
						// Clone the original line item and add the random number to the quantity
						// OpportunityLineItem clonedLI = clonedLineItem.clone(false,true); I realized I cannot use this because it
						// automatically assigns the oppo ID which is unwritable.
						// declared an sobject

						OpportunityLineItem newLI = new OpportunityLineItem();

						// the newLI record fields to be set using the original opp and cloned LI fields
						Integer ranNumber = (Integer) Math.floor(Math.random() * 3) + 1;
						newLI.quantity = lineI.Quantity +ranNumber;
						newLI.UnitPrice = lineI.UnitPrice;
						newLI.Product2Id = lineI.Product2Id;
						newLI.OpportunityId = clonedId;
						newLI.PricebookEntryId = lineI.PricebookEntryId;
						newLineItems.add(newLI);
					}
				}
			}
		}
		// Insert the new line items

		insert newLineItems;
	}

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		List<Opportunity> oppoWithAccOwnerDetails = new List<Opportunity>([SELECT Id, Name, Account.Name, AccountId, Owner.Name 
																		   FROM Opportunity
																		   WHERE StageName = 'Closed Won']);
		return oppoWithAccOwnerDetails; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {
		
		//Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
		List<Opportunity> oppoToUpdate = getOpportunityDetailsForClosedWon();

		// Created a string to store the contact first name
		String conFirstName;

		// Create a set of Account Ids from the Opportunities
		Set<Id> accIds = new Set<Id>();
		for (Opportunity opp : oppoToUpdate) {
			if (!oppoToUpdate.isEmpty()) {
				accIds.add(opp.AccountId);
			}
		}

		// Query the Contacts
		List<Contact> primaryContact = new List<Contact>(
			[SELECT Id, FirstName, AccountId 
			 FROM Contact 
			 WHERE AccountId IN : accIds 
			 ORDER BY FirstName ASC LIMIT 1]);

		// Loop through each Contact and add the Account Id and Contact to the map
		Map<Id,Id> accIdConFirstName = new Map<Id,Id>();
		for (Contact con : primaryContact) {
			if (!primaryContact.isEmpty()) {
				accIdConFirstName.put(con.AccountId, con.Id);
			}
		}

		// Loop through each Opportunity
		for (Opportunity opp : oppoToUpdate) {
			if (!oppoToUpdate.isEmpty()) {

				// Update the Opportunity primary contact from accountToContactMap
			    opp.Primary_Contact__c = accIdConFirstName.get(opp.AccountId);
			}
		}

		// Update the Opportunities
		update oppoToUpdate;

	}
}