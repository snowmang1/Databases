MARKDOWN
The .md files are Markdown Files and can be viewed in any plain text editor 
or in Typora found here: https://typora.io/
Ignore the ``` head and end tags if you're viewing in plain text 

DUMP
The dump files should import properly if your mysql client is version 8.0.23
or similar. Otherwise, make sure that foreign key checks are disabled for the
the import with these tags:
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

Also, the triggers and procedures might not import if you are on a lower version.
To solve it's best to manually copy from the corresponding .md files (procedures.md
or triggers.md)