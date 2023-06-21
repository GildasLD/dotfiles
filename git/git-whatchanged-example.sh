#!/bin/bash

echo "=== Git Commands Examples ==="
echo "1. Basic Usage: Show all commits and raw changes (git whatchanged)"
echo "2. Limit the Number of Commits (git whatchanged -n)"
echo "3. View Changes for a Specific File (git whatchanged -- <file-path>)"
echo "4. Filter Commits by Author (git whatchanged --author)"
echo "5. Show Detailed Commit Information for a Specific Commit (git show)"
echo "6. View Blob Content by Hash (git show <blob-hash>)"
echo "7. Compare Blob to Another Blob (git diff <blob-hash1> <blob-hash2>)"
echo "8. Restore a Blob to a File (git cat-file -p <blob-hash> > <file>)"
echo "9. View File Change Statistics (git log --stat)"
echo "10. Exit"
echo "================================="

while true; do
	read -p "Choose an option (1-10): " option

	case $option in
	1)
		echo "=== Basic Usage ==="
		git whatchanged
		;;
	2)
		read -p "Enter the number of commits to display: " num
		echo "=== Limit to $num Commits ==="
		git whatchanged -n "$num"
		;;
	3)
		read -p "Enter the file path to filter by: " file_path
		echo "=== Changes for $file_path ==="
		git whatchanged -- "$file_path"
		;;
	4)
		read -p "Enter the author name or email to filter by: " author
		echo "=== Commits by $author ==="
		git whatchanged --author="$author"
		;;
	5)
		read -p "Enter the commit hash to show details for: " commit_hash
		echo "=== Details for Commit $commit_hash ==="
		git show "$commit_hash"
		;;
	6)
		read -p "Enter the blob hash to view: " blob_hash
		echo "=== Content of Blob $blob_hash ==="
		git show "$blob_hash"
		;;
	7)
		read -p "Enter the first blob hash: " blob_hash1
		read -p "Enter the second blob hash: " blob_hash2
		echo "=== Differences Between $blob_hash1 and $blob_hash2 ==="
		git diff "$blob_hash1" "$blob_hash2"
		;;
	8)
		read -p "Enter the blob hash to restore: " blob_hash
		read -p "Enter the file name to save the content to: " file_name
		echo "=== Restoring Blob $blob_hash to File $file_name ==="
		git cat-file -p "$blob_hash" > "$file_name"
		echo "Blob content restored to $file_name."
		;;
	9)
		echo "=== File Change Statistics ==="
		git log --stat
		;;
	10)
		echo "Exiting. Goodbye!"
		break
		;;
	*)
		echo "Invalid option. Please choose between 1 and 10."
		;;
	esac
done
