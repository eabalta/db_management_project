# DBM Midterm Project: Extending a Conceptual Design

## PART-I ANALYSIS and DESIGN 

In this project, you will reverse engineer a database design given below.

- Draw an EER diagram for AIRLINE relational database.
The AIRLINE relational database schema shown in the above figure describes a database for airline
flight information. Each FLIGHT is identified by a Flight_number, and consists of one or more
FLIGHT_LEGs with Leg_numbers 1, 2, 3, and so on. Each FLIGHT_LEG has scheduled arrival and
departure times, airports, and one or more LEG_INSTANCEs—one for each Date on which the flight
travels. FAREs are kept for each FLIGHT. For each FLIGHT_LEG instance, SEAT_RESERVATIONs are kept,
as are the AIRPLANE used on the leg and the actual arrival and departure times and airports. An
AIRPLANE is identified by an Airplane_id and is of a particular AIRPLANE_TYPE. CAN_LAND relates
AIRPLANE_TYPEs to the AIRPORTs at which they can land. An AIRPORT is identified by an Airport_code.

- Extend your design to satisfy the following requirements:
1. Separate the CUSTOMER entity from the SEAT_RESERVATION and extend it with the following
attributes; e-mail, adress, country, passport number.
2. Create a COMPANY entity for both AIRPLANE and AIRLINE. Use generalization/specialization
hierarchy.
3. Create an entity for frequent flyer customer tracking called FFC to keep track of the customers’
flight information. If a customer has checked-in physically a flight create a transaction record
with the mileage information assigned to that flight leg.


Identify all the important concepts represented in EER diagram. In particular, identify the
abstractions of classification (entity types and relationship types), aggregation, identification, and
specialization/generalization. Specify (min, max) cardinality constraints whenever possible. List
details that will affect the eventual design but that have no bearing on the conceptual design. List
the semantic constraints separately. Please do not hesitate to state your own assumptions
regarding the conceptual design.
