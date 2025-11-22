#!/usr/bin/env python3

from datetime import date, timedelta
from argparse import ArgumentParser


def calculate_age(birth_date):
	today = date.today()
	years = today.year - birth_date.year
	months = today.month - birth_date.month
	days = today.day - birth_date.day

	if days < 0:
		months -= 1
		days += (date(today.year, today.month, 1) - timedelta(days=1)).day

	if months < 0:
		years -= 1
		months += 12

	age_years = years + months / 12 + days / 365.25
	return round(age_years, 2), years, months, days


def check_eligibility(age_decimal):
	exam_eligibility = {
		"Vayu": (17.5, 21),
		"NDA": (16.5, 19.5),
		"CDS": (20, 24),
		"AFCAT": (20, 24),
		"TGC": (20, 27),
	}

	results = []
	for exam, (min_age, max_age) in exam_eligibility.items():
		if min_age <= age_decimal <= max_age:
			results.append(f"✅ Eligible for {exam}")
		elif age_decimal < min_age:
			days_left = int((min_age - age_decimal) * 365.25)
			results.append(f"⏳ Not eligible for {exam} (Eligible in {days_left} days)")
		else:
			results.append(f"❌ Too old for {exam}")
	return results


parser = ArgumentParser(description="Check exam eligibility based on age")
parser.add_argument(
	"-d", "--data", action="store_true", help="Print info about age ranges"
)
args = parser.parse_args()

if args.data:
	print("""
       ME                     Normal
12th   :- 19 AGE          12th   :- 18 AGE
BCA    :- 22 AGE          BCA    :- 12 AGE
b-tech :- 23 AGE          b-tech :- 22 AGE

NDA:   16.5 - 19.5
CDS:   20   - 24
TGC :   20  - 27 with 8+ GPA (09 - 12 POST)
Vayu:  17.5 - 21
    """)
else:
	birth_date = date(2007, 4, 12)  # change as needed
	age_decimal, y, m, d = calculate_age(birth_date)
	print(f"You are {y} years, {m} months, and {d} days old.\n")
	for result in check_eligibility(age_decimal):
		print(result)
