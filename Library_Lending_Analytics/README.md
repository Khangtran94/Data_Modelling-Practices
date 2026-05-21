# Problem

You work at a public library system with 50+ branches. Management wants dashboards to track book circulation, patron activity, and collection utilization.

Your job: design a simple star schema for lending analytics.

---

# Business Context

Library managers want to answer questions like:

- How many books are checked out per day, week, and month?
- Which genres and authors are most popular?
- What's the average loan duration by category?
- Which patrons check out the most books?
- How does lending volume vary by branch and time of year?

---

# Requirements

## Fact Table Grain

- One row per loan (checkout event)

## Dimensional Modeling Requirements

- Use role-playing date dimensions for:
  - `checkout_date`
  - `due_date`
  - `return_date`
- Design the following dimensions:
  - Book Dimension
  - Patron Dimension
  - Branch Dimension
  - Date Dimension
- Handle overdue books:
  - `return_date > due_date` must be identifiable
- Track loan duration:
  - `return_date - checkout_date` as a measurable metric
- Books can have multiple authors:
  - Decide how to model multi-author relationships

---

# Constraints

- 50+ library branches
- 5M+ loans per year
- Books can have up to 5 co-authors
- Patron membership type rarely changes
- Overdue tracking is important for library operations
- `return_date` is `NULL` for currently checked-out books
