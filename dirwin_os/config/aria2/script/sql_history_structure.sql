-- Basic table structure for aria2 download history
-- Do not modify this file directly. Use appropriate migration scripts instead.
-- Database: aria2_downloads.db

CREATE TABLE IF NOT EXISTS "DOWNLOAD_HISTORY" (
	"GID" TEXT,
	"DATE" datetime DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now')),
	"TOTAL_FILES" INTEGER,
	"BASE_NAME" TEXT,
	"PATH" TEXT
);
