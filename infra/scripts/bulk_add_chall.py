#!/usr/bin/env python3
# created by claude.ai
import os
import subprocess
import yaml
import argparse
import configparser


def load_config(config_path):
    """Load the CTF config file and return the challenges dict"""
    config = configparser.ConfigParser()
    if os.path.exists(config_path):
        config.read(config_path)
        return dict(config["challenges"]) if "challenges" in config else {}
    return {}


def is_challenge_dir(directory):
    """Check if directory contains challenge.yml"""
    return os.path.isfile(os.path.join(directory, "challenge.yml"))


def validate_challenge_yml(yml_path):
    """Validate that challenge.yml has required fields"""
    try:
        with open(yml_path, "r") as f:
            challenge_data = yaml.safe_load(f)
            required_fields = ["name", "description", "value", "category"]
            return all(field in challenge_data for field in required_fields)
    except:
        return False


def is_challenge_added(challenge_path, existing_challenges):
    """Check if challenge is already in config"""
    abs_path = os.path.abspath(challenge_path)
    return any(
        os.path.abspath(path) == abs_path
        for path in existing_challenges.values()
    )


def find_and_add_challenges(root_dir, config_path):
    """Recursively find and add all valid challenges"""
    added_challenges = []
    failed_challenges = []
    skipped_challenges = []

    # Load existing challenges from config
    existing_challenges = load_config(config_path)

    for root, dirs, files in os.walk(root_dir):
        if is_challenge_dir(root):
            yml_path = os.path.join(root, "challenge.yml")

            # Skip if challenge already exists in config
            if is_challenge_added(root, existing_challenges):
                print(f"Skipping already added challenge: {root}")
                skipped_challenges.append(root)
                continue

            if validate_challenge_yml(yml_path):
                try:
                    # Run ctf challenge add command
                    result = subprocess.run(
                        ["ctf", "challenge", "add", root],
                        capture_output=True,
                        text=True,
                        check=True,
                    )
                    added_challenges.append(root)
                    print(f"Successfully added challenge: {root}")
                except subprocess.CalledProcessError as e:
                    print(f"Failed to add challenge {root}: {e.stderr}")
                    failed_challenges.append(root)
            else:
                print(f"Invalid challenge.yml found in {root}")
                failed_challenges.append(root)

    return added_challenges, failed_challenges, skipped_challenges


def main():
    parser = argparse.ArgumentParser(
        description="Bulk import CTF challenges from a directory"
    )
    parser.add_argument(
        "directory", type=str, help="Directory containing CTF challenges"
    )
    parser.add_argument(
        "-C",
        "--config",
        type=str,
        default=os.path.expanduser("~/.ctf/config"),
        help="Path to CTF config file (default: ~/.ctf/config)",
    )
    args = parser.parse_args()

    # Convert to absolute path and verify directory exists
    target_dir = os.path.abspath(args.directory)
    if not os.path.isdir(target_dir):
        print(f"Error: Directory '{target_dir}' does not exist")
        return 1

    print(f"Starting bulk challenge import from: {target_dir}")
    print(f"Using config file: {args.config}")
    print("=" * 50)

    added, failed, skipped = find_and_add_challenges(target_dir, args.config)

    print("\nImport Summary")
    print("=" * 50)
    print(f"Successfully added {len(added)} challenges")
    print(f"Skipped {len(skipped)} existing challenges")
    print(f"Failed to add {len(failed)} challenges")

    if failed:
        print("\nFailed challenges:")
        for challenge in failed:
            print(f"- {challenge}")

    if skipped:
        print("\nSkipped challenges (already in config):")
        for challenge in skipped:
            print(f"- {challenge}")

    return 0 if not failed else 1


if __name__ == "__main__":
    exit(main())
