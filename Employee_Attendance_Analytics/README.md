# Problem

You work at a company with 10,000+ employees across multiple offices. The HR team needs a dashboard to track attendance patterns and time-off usage.

Your job: design a simple star schema that lets HR see who's showing up, who's absent, and how PTO is being used.

---

# Business Context

HR managers want to answer questions like:

- What's the attendance rate by department and month?
- How many PTO days are being used vs. available?
- Which employees have frequent absences or are consistently late?
- Do attendance patterns differ by office location or role level?
- How do attendance trends change over the year (holiday seasons, summer)?

---

# Requirements

## Fact Table Grain

- One row per employee per day in the attendance fact table (transactional grain)

## Dimensional Modeling Requirements

- Create a Date dimension for `attendance_date` with useful calendar attributes
- Design:
  - Employee Dimension
  - Department Dimension
- Store attendance status in a way that supports numerical attendance-rate calculations
- Track `hours_worked` as a measure
  - Consider whether the measure is additive
- Support:
  - Daily detailed reporting
  - Monthly aggregate reporting

---

# Constraints

- 10,000+ employees
- 50+ departments
- Multiple office locations
- Attendance tracked daily:
  - One record per employee per working day
- Global workforce with different holiday calendars
- Some employees work:
  - Part-time schedules
  - Shift-based schedules
- Maintain 3+ years of historical data
