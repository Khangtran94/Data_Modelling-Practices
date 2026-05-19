CREATE TABLE "Dim_Book" (
	"book_id" INTEGER NOT NULL UNIQUE,
	"title" VARCHAR(255) NOT NULL,
	"genre" VARCHAR(255) NOT NULL,
	"isbn" VARCHAR(255),
	"publication_year" INTEGER NOT NULL,
	"main_author_id" INTEGER,
	PRIMARY KEY("book_id")
);

CREATE TABLE "Dim_Patron" (
	"patron_id" INTEGER NOT NULL UNIQUE,
	"patron_name" VARCHAR(255) NOT NULL,
	"membership_type" TEXT NOT NULL,
	"join_date" DATE NOT NULL,
	"branch_preference" VARCHAR(255),
	"valid_from" DATE NOT NULL UNIQUE,
	"valid_to" DATE,
	"active_status" BOOLEAN,
	PRIMARY KEY("patron_id", "valid_from")
);

CREATE TABLE "Dim_Branch" (
	"branch_id" INTEGER NOT NULL UNIQUE,
	"branch_name" VARCHAR(255) NOT NULL,
	"address" VARCHAR(255) NOT NULL,
	"manager_name" VARCHAR(255) NOT NULL,
	PRIMARY KEY("branch_id")
);

CREATE TABLE "Fct_Loan" (
	"loan_id" INTEGER NOT NULL UNIQUE,
	"patron_id" INTEGER NOT NULL,
	"book_id" INTEGER NOT NULL,
	"checkout_date" DATE NOT NULL,
	"due_date" DATE NOT NULL,
	"return_date" DATE,
	"branch_id" INTEGER NOT NULL,
	"loan_days" INTEGER NOT NULL,
	"is_overdued" BOOLEAN NOT NULL,
	"days_overdued" INTEGER,
	PRIMARY KEY("loan_id")
);

CREATE TABLE "Dim_Date" (
	"date" DATE NOT NULL UNIQUE,
	"year" INTEGER NOT NULL,
	"quarter" INTEGER NOT NULL,
	"month" INTEGER NOT NULL,
	"month_name" VARCHAR(255) NOT NULL,
	"day_name" VARCHAR(255) NOT NULL,
	"day_of_week" VARCHAR(255) NOT NULL,
	"is_holiday" BOOLEAN NOT NULL,
	"is_weekend" BOOLEAN NOT NULL,
	PRIMARY KEY("date")
);

CREATE TABLE "Dim_Author" (
	"author_id" INTEGER NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	"date_of_birth" DATE,
	"country" VARCHAR(255) NOT NULL,
	"status" TEXT NOT NULL,
	PRIMARY KEY("author_id")
);

CREATE TABLE "Bridge_Book_Author" (
	"book_id" INTEGER NOT NULL UNIQUE,
	"author_id" INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("book_id", "author_id")
);

ALTER TABLE "Fct_Loan"
ADD FOREIGN KEY("patron_id") REFERENCES "Dim_Patron"("patron_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "Fct_Loan"
ADD FOREIGN KEY("book_id") REFERENCES "Dim_Book"("book_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "Fct_Loan"
ADD FOREIGN KEY("checkout_date") REFERENCES "Dim_Date"("date")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "Fct_Loan"
ADD FOREIGN KEY("due_date") REFERENCES "Dim_Date"("date")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "Fct_Loan"
ADD FOREIGN KEY("return_date") REFERENCES "Dim_Date"("date")
ON UPDATE NO ACTION ON DELETE SET NULL;

ALTER TABLE "Fct_Loan"
ADD FOREIGN KEY("branch_id") REFERENCES "Dim_Branch"("branch_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "Bridge_Book_Author"
ADD FOREIGN KEY("book_id") REFERENCES "Dim_Book"("book_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "Bridge_Book_Author"
ADD FOREIGN KEY("author_id") REFERENCES "Dim_Author"("author_id")
ON UPDATE NO ACTION ON DELETE CASCADE;

-- Indexes on foreign key columns
CREATE INDEX "idx_fct_loan_patron_id" ON "Fct_Loan"("patron_id");
CREATE INDEX "idx_fct_loan_book_id" ON "Fct_Loan"("book_id");
CREATE INDEX "idx_fct_loan_checkout_date" ON "Fct_Loan"("checkout_date");
CREATE INDEX "idx_fct_loan_due_date" ON "Fct_Loan"("due_date");
CREATE INDEX "idx_fct_loan_return_date" ON "Fct_Loan"("return_date");
CREATE INDEX "idx_fct_loan_branch_id" ON "Fct_Loan"("branch_id");