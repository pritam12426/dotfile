#!/usr/bin/env python3

from os import environ
from datetime import datetime
from requests import get
import argparse
from urllib.parse import urlparse

BASE_API_URL = "https://api.github.com/repos/"
# Safely get GitHub token (optional, for higher rate limits)
AUTHKEY = environ.get("GITHUB_AUTH_TOKEN")

# Prepare headers if token exists (GitHub uses "token", not "Bearer" for PATs)
headers = {"Authorization": f"token {AUTHKEY}"} if AUTHKEY else {}
ARGS: argparse.Namespace = argparse.Namespace()

class GetAndParseRepoInfo:
	"""Class to fetch and display GitHub repository information."""

	def __init__(self, owner: str, repo: str):
		url = f"{BASE_API_URL}{owner}/{repo}"
		response = get(url, headers=headers)

		if response.status_code != 200:
			raise ValueError(
				f"Error fetching repo: {response.status_code} - {response.json().get('message', 'Unknown error')}"
			)

		api_data = response.json()

		# Populate attributes
		self.name = api_data.get("name", "N/A")
		self.owner = api_data.get("owner", {}).get("login", "N/A")
		self.description = api_data.get("description", "N/A")
		self.created_at = api_data.get("created_at", "N/A")
		self.updated_at = api_data.get("updated_at", "N/A")
		self.pushed_at = api_data.get("pushed_at", "N/A")
		self.ssh_url = api_data.get("ssh_url", "N/A")
		self.clone_url = api_data.get("clone_url", "N/A")
		self.html_url = api_data.get("html_url", "N/A")
		self.language = api_data.get("language", "N/A")
		self.default_branch = api_data.get("default_branch", "N/A")
		self.open_issues = api_data.get("open_issues_count", 0)
		self.forks_count = api_data.get("forks_count", 0)
		self.stargazers_count = api_data.get("stargazers_count", 0)

	def format_dates(self):
		"""Convert ISO dates to '22 Dec 2025' format."""
		for attr in ["created_at", "updated_at", "pushed_at"]:
			date_str = getattr(self, attr)
			if date_str and date_str != "N/A":
				try:
					dt = datetime.strptime(date_str, "%Y-%m-%dT%H:%M:%SZ")
					# New format: 22 Dec 2025
					formatted = dt.strftime("%d %b %Y")
					setattr(self, attr, formatted)
				except ValueError:
					pass  # Keep original if parsing fails

	def convert_numbers_to_words(self):
		"""Convert large numbers (stars, forks, issues) to words."""
		try:
			from num2words import num2words
		except ImportError:
			print("Warning: 'num2words' not installed. Run: pip install num2words")
			return

		# Save original numbers in case needed later
		self.stars_in_words = num2words(self.stargazers_count, lang='en').capitalize()
		self.forks_in_words = num2words(self.forks_count, lang='en').capitalize()
		self.issues_in_words = num2words(self.open_issues, lang='en').capitalize() if self.open_issues > 0 else "Zero"

	def print_info(self):
		"""Print all repository information in a nice format."""
		self.format_dates()
		self.convert_numbers_to_words()  # Now we call it!

		print("=== GitHub Repository Information ===")
		print(f"Repository Name    : {self.name}")
		print(f"Owner              : {self.owner}")
		print(f"Description        : {self.description or 'No description'}")
		print(f"Language           : {self.language or 'Not specified'}")
		print(f"Default Branch     : {self.default_branch}")
		print(f"Created At         : {self.created_at}")
		print(f"Updated At         : {self.updated_at}")
		print(f"Last Push          : {self.pushed_at}")
		print(f"Stars              : {self.stargazers_count} ({getattr(self, 'stars_in_words', self.stargazers_count)})")
		print(f"Forks              : {self.forks_count} ({getattr(self, 'forks_in_words', self.forks_count)})")
		print(f"Open Issues        : {self.open_issues} ({getattr(self, 'issues_in_words', self.open_issues)})")
		print(f"HTML URL           : {self.html_url}")
		print(f"Clone URL (HTTPS)  : {self.clone_url}")
		print(f"Clone URL (SSH)    : {self.ssh_url}")
		print("=====================================\n")

	def __str__(self):
		stars_words = getattr(self, 'stars_in_words', self.stargazers_count)
		return f"{self.owner}/{self.name} ({self.language or 'Unknown'}) - ★ {stars_words}"



def argparseInit() -> argparse.Namespace:
	parser = argparse.ArgumentParser(
		description="A CLI tool to fetch and display information about a GitHub repository.",
		formatter_class=argparse.ArgumentDefaultsHelpFormatter,
	)

	# Version
	parser.add_argument(
		"--version",
		"-v",
		action="version",
		version="0.1.0",
		help="Show program version and exit",
	)

	# Positional argument: the repo (URL or owner/repo)
	parser.add_argument(
		"repo",
		type=str,
		help="GitHub repository as 'owner/repo' or full URL (e.g., 'torvalds/linux' or 'https://github.com/torvalds/linux')",
	)

	args = parser.parse_args()

	# Parse the input to extract owner and repo
	repo_input = args.repo.strip()

	# Case 1: Full URL like https://github.com/owner/repo
	if repo_input.startswith("http"):
		parsed_url = urlparse(repo_input)
		if parsed_url.netloc not in ["github.com", "www.github.com"]:
			parser.error("Only GitHub URLs are supported.")
		path = parsed_url.path.strip("/")
		if path.count("/") < 1:
			parser.error("Invalid GitHub URL: missing owner/repo")
		owner, repo_name = path.split("/", 1)
		if repo_name.endswith(".git"):
			repo_name = repo_name[:-4]  # Remove .git if present
	else:
		# Case 2: Just owner/repo
		if "/" not in repo_input:
			parser.error(
				"Please provide repository as 'owner/repo' or a full GitHub URL."
			)
		owner, repo_name = repo_input.split("/", 1)
		if not owner or not repo_name:
			parser.error("Invalid format: 'owner/repo' required.")

	# Attach parsed values to args
	args.owner = owner
	args.repo = repo_name

	return args

# === Example Usage ===
if __name__ == "__main__":
	args = argparseInit()

	try:
		repo_info = GetAndParseRepoInfo(args.owner, args.repo)
		repo_info.print_info()
	except ValueError as e:
		print(f"Error: {e}")
	except Exception as e:
		print(f"Unexpected error: {e}")

# sed -i 's/	/\t/g'
