# Problem

You are a data engineer at a public library system. Design a relational schema to manage books, members, and borrowing records.

---

# Business Context

A library needs to track:

- Their collection of books
- Registered members
- Lending activities

The system must answer key business questions such as:

- How many books does each member currently have borrowed?
- Which books are overdue?
- What is the most popular book by borrowing count?
- How many active members do we have?
- Which books need to be reordered (low stock)?

---

# Requirements

## Functional Requirements

- Design tables to store books with author information
- Manage member profiles and membership status
- Track borrowing history with due dates and return dates
- Support querying overdue books
- Enable reporting on popular books and member borrowing patterns

---

# Constraints

- Small library scale:
  - ~10,000 books
  - ~5,000 members
  - ~50,000 borrowing records
- Single library location
- Standard SQL database:
  - PostgreSQL or MySQL
- Data retention:
  - 5 years of borrowing history
