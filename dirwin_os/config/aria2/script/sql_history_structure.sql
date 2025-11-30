-- Basic table structure for aria2 download history
-- Do not modify this file directly. Use appropriate migration scripts instead.
-- Database: aria2_downloads.db

CREATE TABLE IF NOT EXISTS "DOWNLOAD_HISTORY" (
	"gid"           TEXT,
	"date"          datetime DEFAULT (strftime('%Y-%m-%d %H:%M:%S', 'now')),
	"total_files"   INTEGER,
	"size_bytes"    INTEGER,
	"size_human"    TEXT,
	"base_name"     TEXT,
	"path"          TEXT
);
