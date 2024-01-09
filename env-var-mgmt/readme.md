# Travis CI Environment Variable Management Script

This Bash script provides functionality to create or update environment variables in multiple Travis CI repositories.

## Prerequisites

- Bash shell
- `curl` command
- `jq` command (for JSON processing)

## Configuration

Before running the script, make sure to configure the following variables:

- `TRAVIS_TOKEN`: Your Travis CI API token.
- `TRAVIS_API`: Travis CI API endpoint (default: `https://travis-ci.com//api/repo`).
- `ORG`: Travis CI organization name (default: `pathshaala`).

Additionally, populate the `git-repo.list` file with the list of repositories and `travis-env-var.json` with the JSON payload for creating new environment variables.

## Usage

Run the script with the desired action as a command-line argument:
```bash
./travis_env_management.sh <create|update>
```
Replace `{create|update}` with the desired action.

### Actions:

- **create**: Creates new environment variables in Travis CI repositories.
- **update**: Updates existing environment variables in Travis CI repositories.


## License

This script is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.
