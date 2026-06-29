`ERD.md` contains markdown-formatted entity-relationship diagram for the database.

`creating.sql` creates the tables in a database.

`inserting.sql` inserts test data into the tables.

`procedures.sql` contains 3 procedures: `create_flight`, `register_passenger_on_flight`, and `schedule_flight`. All the procedures have `WHERE` clauses to ensure data consistency.

`triggers.sql` contains a trigger for updating the amount of passengers on a flight.

`indexes.sql` contains a script for creating indexes to relevant columns, which are usually foreign key ones.

`test_scipt.sql` contains some test code.

`roles.sql` is used to create 3 main roles and grant access to execute the according procedures.

`views.sql` contains a view to display all the scheduled flights and a view to show top-10 passengers with the most flights taken.

`functions.sql` contains the `get_random_passenger_uuid` function, which is used for testing purposes.