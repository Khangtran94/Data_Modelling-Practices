CREATE TABLE "member" (
	"id" INTEGER NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	"phone" VARCHAR(255) NOT NULL UNIQUE,
	"email" VARCHAR(255) NOT NULL UNIQUE,
	"birthdate" DATE,
	"membership_status" VARCHAR(255) NOT NULL,
	"membership_joined" DATE NOT NULL,
	"street" VARCHAR(255),
	"state" VARCHAR(255),
	"city" VARCHAR(255),
	PRIMARY KEY("id")
);

CREATE TABLE "book" (
	"id" INTEGER NOT NULL UNIQUE,
	"title" VARCHAR(255) NOT NULL,
	"author_id" INTEGER NOT NULL,
	"genre" TEXT NOT NULL,
	"release_year" INTEGER NOT NULL,
	"number_on_stock" INTEGER NOT NULL,
	"total_copies_available" INTEGER NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "author" (
	"id" INTEGER NOT NULL UNIQUE,
	"name" VARCHAR(255) NOT NULL,
	"country" VARCHAR(255) NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "borrow_activity" (
	"id" INTEGER NOT NULL UNIQUE,
	"book_id" INTEGER NOT NULL,
	"member_id" INTEGER NOT NULL,
	"borrow_date" DATE NOT NULL,
	"due_date" DATE NOT NULL,
	"return_date" DATE,
	PRIMARY KEY("id")
);

ALTER TABLE "book"
ADD FOREIGN KEY("author_id") REFERENCES "author"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "borrow_activity"
ADD FOREIGN KEY("book_id") REFERENCES "book"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

ALTER TABLE "borrow_activity"
ADD FOREIGN KEY("member_id") REFERENCES "member"("id")
ON UPDATE NO ACTION ON DELETE CASCADE;

-- Indexes on foreign key columns
CREATE INDEX "idx_book_author_id" ON "book"("author_id");
CREATE INDEX "idx_borrow_activity_book_id" ON "borrow_activity"("book_id");
CREATE INDEX "idx_borrow_activity_member_id" ON "borrow_activity"("member_id");