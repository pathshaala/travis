# Travis CI Environment Variable Management Script

This Bash script provides functionality to create or update environment variables in multiple Travis CI repositories.

## Prerequisites

- Bash shell
- `curl` command
- `jq` command (for JSON processing)

## Configuration

Before running the script, make sure to configure the following variables:

- `TRAVIS_TOKEN`: Your Travis CI API token.
- `ENV_NEW_VALUE`: Token for the new environment variable (used in the `env_update` function).
- `TRAVIS_API`: Travis CI API endpoint (default: `https://travis-ci.com//api/repo`).
- `ORG`: Travis CI organization name (default: `pathshaala`).

Additionally, populate the `git-repo.list` file with the list of repositories and `travis-env-var.json` with the JSON payload for creating new environment variables.

## Usage

Run the script with the desired action as a command-line argument:

```bash
./travis-env-mgmt.sh create
```

or

```bash
./travis-env-mgmt.sh update
```

Replace `travis-env-mgmt.sh` with the actual name of your script.

### Actions:

- **create**: Creates new environment variables in Travis CI repositories.
- **update**: Updates existing environment variables in Travis CI repositories.


## License

This script is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.
