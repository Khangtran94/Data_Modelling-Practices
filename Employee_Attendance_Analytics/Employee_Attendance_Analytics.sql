CREATE TABLE "Dim_Date" (
	"date" INTEGER NOT NULL UNIQUE,
	"day" INTEGER NOT NULL,
	"day_name" VARCHAR(255) NOT NULL,
	"month" INTEGER,
	"month_name" VARCHAR(255) NOT NULL,
	"quarter" INTEGER NOT NULL,
	"year" INTEGER NOT NULL,
	"is_weekend" BOOLEAN NOT NULL,
	"is_holiday" BOOLEAN NOT NULL,
	"date_key" VARCHAR(255),
	PRIMARY KEY("date")
);

CREATE TABLE "Dim_Employee" (
	"employee_id" INTEGER NOT NULL UNIQUE,
	"employee_name" VARCHAR(255) NOT NULL,
	"department_id" INTEGER NOT NULL,
	"role_level" VARCHAR(255) NOT NULL,
	"hire_date" DATE NOT NULL,
	"contract_type" TEXT NOT NULL,
	"effect_from" DATE NOT NULL,
	"effect_to" DATE NOT NULL,
	PRIMARY KEY("employee_id")
);

CREATE TABLE "Dim_Department" (
	"department_id" INTEGER NOT NULL UNIQUE,
	"department_name" VARCHAR(255) NOT NULL,
	"manager_id" INTEGER NOT NULL,
	"location" VARCHAR(255) NOT NULL,
	PRIMARY KEY("department_id")
);

CREATE TABLE "Fct_Attendance" (
	"id" INTEGER NOT NULL UNIQUE,
	"date" INTEGER NOT NULL,
	"department_id" INTEGER NOT NULL,
	"employee_id" INTEGER NOT NULL,
	"hour_worked" DECIMAL NOT NULL,
	"is_present" BOOLEAN NOT NULL,
	"is_absent" BOOLEAN NOT NULL,
	"is_sick" BOOLEAN NOT NULL,
	"is_pto" BOOLEAN NOT NULL,
	"is_late" BOOLEAN NOT NULL,
	"minutes_lated" INTEGER NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "Fct_PTO_Balance" (
	"employee_id" INTEGER NOT NULL UNIQUE,
	"year" INTEGER UNIQUE,
	"pto_days_available" DECIMAL,
	"pto_days_used" DECIMAL,
	PRIMARY KEY("employee_id", "year")
);

ALTER TABLE "Dim_Employee"
ADD FOREIGN KEY("department_id") REFERENCES "Dim_Department"("department_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "Fct_Attendance"
ADD FOREIGN KEY("date") REFERENCES "Dim_Date"("date")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "Fct_Attendance"
ADD FOREIGN KEY("department_id") REFERENCES "Dim_Department"("department_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "Fct_Attendance"
ADD FOREIGN KEY("employee_id") REFERENCES "Dim_Employee"("employee_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "Fct_PTO_Balance"
ADD FOREIGN KEY("employee_id") REFERENCES "Dim_Employee"("employee_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

-- Indexes on foreign key columns
CREATE INDEX "idx_dim_employee_department_id" ON "Dim_Employee"("department_id");
CREATE INDEX "idx_fct_attendance_date" ON "Fct_Attendance"("date");
CREATE INDEX "idx_fct_attendance_department_id" ON "Fct_Attendance"("department_id");
CREATE INDEX "idx_fct_attendance_employee_id" ON "Fct_Attendance"("employee_id");