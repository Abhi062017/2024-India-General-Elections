/*
16th Nov 2024 - 9:37pm IST
2024 India General Elections
Source : Amazing Real Time SQL Project | Start to End Analysis | SQL Tutorial for Beginners | SQL 2024 #sql
*/

show tables;
use sql_portfolio_projects;

/* Tables : 
constituencywise_details
constituencywise_results
partywise_results
states
statewise_results
*/

-- Querying the tables
select * from constituencywise_details;
select * from constituencywise_results;
select * from partywise_results;
select * from states;
select * from statewise_results;

select count(distinct constituency_ID) from constituencywise_details;  -- 543
select count(distinct parliament_constituency) from constituencywise_results;  -- 543 (candidate for a PK)
select count(distinct constituency_name) from constituencywise_results;  -- 540
select count(distinct party) from partywise_results;  -- 42 parties participated in the elections
select sum(won) from partywise_results; -- 543 : total seats won by all parties

-- Q1. What are the total number of seats in the election?
select count(constituency_id) from constituencywise_results;  -- 543

-- Q2. What are the total number of seats available for elections in each state?
select s.state as States, count(sr.Constituency) as total_seats
from statewise_results sr
join states s on sr.State_ID=s.StateID
group by s.state;

-- Q3. Total Seats Won by NDA Alliance
select sum(won) as NDA_seats_won
from partywise_results
where party in ('Bharatiya Janata Party - BJP', 'Telugu Desam - TDP', 'Janata Dal  (United) - JD(U)', 'Shiv Sena - SHS', 'AJSU Party - AJSUP','Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP', 'Hindustani Awam Morcha (Secular) - HAMS', 'Janasena Party - JnP', 'Janata Dal  (Secular) - JD(S)', 'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP', 'Rashtriya Lok Dal - RLD', 'Sikkim Krantikari Morcha - SKM');

-- Q4. Seats Won by NDA Alliance Parties
select cr.Parliament_Constituency, cr.Winning_Candidate
from partywise_results pr
join constituencywise_results cr on pr.Party_ID=cr.Party_ID
where party in ('Bharatiya Janata Party - BJP', 'Telugu Desam - TDP', 'Janata Dal  (United) - JD(U)', 'Shiv Sena - SHS', 'AJSU Party - AJSUP','Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP', 'Hindustani Awam Morcha (Secular) - HAMS', 'Janasena Party - JnP', 'Janata Dal  (Secular) - JD(S)', 'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP', 'Rashtriya Lok Dal - RLD', 'Sikkim Krantikari Morcha - SKM');
                
-- Q5. Total Seats Won by I.N.D.I.A. Alliance
select sum(won) as INDIA_seats_won
from partywise_results
where party in ('Indian National Congress - INC', 'Aam Aadmi Party - AAAP', 'All India Trinamool Congress - AITC', 'Bharat Adivasi Party - BHRTADVSIP', 'Communist Party of India  (Marxist) - CPI(M)',
				'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)', 'Communist Party of India - CPI', 'Dravida Munnetra Kazhagam - DMK', 'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN', 'Jharkhand Mukti Morcha - JMM', 'Jammu & Kashmir National Conference - JKN', 'Kerala Congress - KEC', 'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP', 'Rashtriya Janata Dal - RJD', 'Rashtriya Loktantrik Party - RLTP', 'Revolutionary Socialist Party - RSP', 'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT', 'Viduthalai Chiruthaigal Katchi - VCK');

-- Q6. Seats Won by I.N.D.I.A. Alliance Parties
select cr.Constituency_Name, cr.Winning_Candidate
from partywise_results pr
join constituencywise_results cr on pr.Party_ID=cr.Party_ID
where party in ('Indian National Congress - INC', 'Aam Aadmi Party - AAAP', 'All India Trinamool Congress - AITC', 'Bharat Adivasi Party - BHRTADVSIP', 'Communist Party of India  (Marxist) - CPI(M)',
				'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)', 'Communist Party of India - CPI', 'Dravida Munnetra Kazhagam - DMK', 'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN', 'Jharkhand Mukti Morcha - JMM', 'Jammu & Kashmir National Conference - JKN', 'Kerala Congress - KEC', 'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP', 'Rashtriya Janata Dal - RJD', 'Rashtriya Loktantrik Party - RLTP', 'Revolutionary Socialist Party - RSP', 'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT', 'Viduthalai Chiruthaigal Katchi - VCK');
                
-- Q7. Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER
select *,
		case when party in ('Bharatiya Janata Party - BJP', 'Telugu Desam - TDP', 'Janata Dal  (United) - JD(U)', 'Shiv Sena - SHS', 'AJSU Party - AJSUP','Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP', 'Hindustani Awam Morcha (Secular) - HAMS', 'Janasena Party - JnP', 'Janata Dal  (Secular) - JD(S)', 'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP', 'Rashtriya Lok Dal - RLD', 'Sikkim Krantikari Morcha - SKM') then 'NDA'
			when party in ('Indian National Congress - INC', 'Aam Aadmi Party - AAAP', 'All India Trinamool Congress - AITC', 'Bharat Adivasi Party - BHRTADVSIP', 'Communist Party of India  (Marxist) - CPI(M)',
				'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)', 'Communist Party of India - CPI', 'Dravida Munnetra Kazhagam - DMK', 'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN', 'Jharkhand Mukti Morcha - JMM', 'Jammu & Kashmir National Conference - JKN', 'Kerala Congress - KEC', 'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP', 'Rashtriya Janata Dal - RJD', 'Rashtriya Loktantrik Party - RLTP', 'Revolutionary Socialist Party - RSP', 'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT', 'Viduthalai Chiruthaigal Katchi - VCK') then 'INDIA'
                else 'Other' end as 'Party_Alliance'
from partywise_results;

-- Q8. Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
with cte_elections as
(select *,
		case when party in ('Bharatiya Janata Party - BJP', 'Telugu Desam - TDP', 'Janata Dal  (United) - JD(U)', 'Shiv Sena - SHS', 'AJSU Party - AJSUP','Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP', 'Hindustani Awam Morcha (Secular) - HAMS', 'Janasena Party - JnP', 'Janata Dal  (Secular) - JD(S)', 'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP', 'Rashtriya Lok Dal - RLD', 'Sikkim Krantikari Morcha - SKM') then 'NDA'
			when party in ('Indian National Congress - INC', 'Aam Aadmi Party - AAAP', 'All India Trinamool Congress - AITC', 'Bharat Adivasi Party - BHRTADVSIP', 'Communist Party of India  (Marxist) - CPI(M)',
				'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)', 'Communist Party of India - CPI', 'Dravida Munnetra Kazhagam - DMK', 'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN', 'Jharkhand Mukti Morcha - JMM', 'Jammu & Kashmir National Conference - JKN', 'Kerala Congress - KEC', 'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP', 'Rashtriya Janata Dal - RJD', 'Rashtriya Loktantrik Party - RLTP', 'Revolutionary Socialist Party - RSP', 'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT', 'Viduthalai Chiruthaigal Katchi - VCK') then 'INDIA'
                else 'Other' end as 'Party_Alliance'
from partywise_results)

select ce.party_alliance, sr.state, sum(ce.won) as seats_won
from cte_elections ce
join constituencywise_results cr on ce.Party_ID=cr.Party_ID
join statewise_results sr on cr.Parliament_Constituency=sr.Parliament_Constituency
group by sr.State, ce.party_alliance
order by seats_won desc;

-- Q9. Winning candidate's name, their party name, total votes, and the margin of victory for across states and constituency?
select cr.Winning_Candidate, pr.Party, cr.Total_Votes,cr.Margin,s.State,cr.Parliament_Constituency
from constituencywise_results cr
join partywise_results pr on cr.Party_ID=pr.Party_ID
join statewise_results sr on cr.Parliament_Constituency=sr.Parliament_Constituency
join states s on sr.State_ID=s.StateID;

-- Q10.  What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
select cr.Parliament_Constituency, round(avg(cd.EVM_Votes/cd.Total_Votes)*100,2) as 'EVM_Votes%', round(avg(cd.Postal_Votes/cd.Total_Votes)*100,2) as 'Postal_Votes%'
from constituencywise_details cd
join constituencywise_results cr on cd.Constituency_ID=cr.Constituency_ID
group by cr.Parliament_Constituency;

-- Q11. Which parties won the most seats in a state, and how many seats did each party win?
select pr.party, pr.won, s.state
from partywise_results pr
join constituencywise_results cr on pr.party_id=cr.party_id
join statewise_results sr on sr.parliament_constituency = cr.parliament_constituency
join states s on s.stateid=sr.state_id
group by pr.party, pr.won, s.state
order by pr.won desc;

-- Q12. What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024?
with cte_elections as
(select *,
		case when party in ('Bharatiya Janata Party - BJP', 'Telugu Desam - TDP', 'Janata Dal  (United) - JD(U)', 'Shiv Sena - SHS', 'AJSU Party - AJSUP','Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP', 'Hindustani Awam Morcha (Secular) - HAMS', 'Janasena Party - JnP', 'Janata Dal  (Secular) - JD(S)', 'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP', 'Rashtriya Lok Dal - RLD', 'Sikkim Krantikari Morcha - SKM') then 'NDA'
			when party in ('Indian National Congress - INC', 'Aam Aadmi Party - AAAP', 'All India Trinamool Congress - AITC', 'Bharat Adivasi Party - BHRTADVSIP', 'Communist Party of India  (Marxist) - CPI(M)',
				'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)', 'Communist Party of India - CPI', 'Dravida Munnetra Kazhagam - DMK', 'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN', 'Jharkhand Mukti Morcha - JMM', 'Jammu & Kashmir National Conference - JKN', 'Kerala Congress - KEC', 'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP', 'Rashtriya Janata Dal - RJD', 'Rashtriya Loktantrik Party - RLTP', 'Revolutionary Socialist Party - RSP', 'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT', 'Viduthalai Chiruthaigal Katchi - VCK') then 'INDIA'
                else 'Other' end as 'Party_Alliance'
from partywise_results)

select ce.party,ce.won,s.state
from cte_elections ce
join constituencywise_results cr on ce.party_id=cr.party_id
join statewise_results sr on cr.parliament_constituency=sr.parliament_constituency
join states s on s.stateID=sr.state_ID
group by ce.party,ce.won,s.state
order by ce.won desc;


-- Q13. Which candidate received the highest number of EVM votes in each constituency (Top 10)?
with cte_q13 as 
(select cd.candidate, sum(cd.evm_votes) highest_Votes, cr.Constituency_Name
from constituencywise_details cd
join constituencywise_results cr on cd.Constituency_ID=cr.Constituency_ID
group by cr.Constituency_Name, cd.candidate),

cte_q13_2 as
(select *,
dense_rank() over(partition by constituency_name order by highest_Votes desc) dr
from cte_q13)

select candidate, highest_Votes, Constituency_Name
from cte_q13_2
where dr=1
order by highest_Votes desc
limit 10;

-- Q14. Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?
select Leading_Candidate, Trailing_Candidate, Parliament_Constituency, state
from statewise_results;

-- Q.15 : For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?
select s.state, count(distinct sr.constituency) total_no_of_seats, count(distinct cd.candidate) total_candidates, 
count(distinct cr.party_id) total_parties, sum(cd.total_votes) total_votes,
sum(cd.evm_votes) total_evm_votes, sum(cd.postal_votes) total_postal_votes
from states s
join statewise_results sr on s.stateid=sr.state_id
join constituencywise_results cr on sr.Parliament_Constituency=cr.Parliament_Constituency
join constituencywise_details cd on cr.Constituency_ID=cd.Constituency_ID
where s.state='Maharashtra';

