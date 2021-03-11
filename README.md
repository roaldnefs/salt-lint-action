# Salt Lint for GitHub Action
This action allows you to run `salt-lint`.

The project is heavily based on [ansible-lint-action](https://github.com/ansible/ansible-lint-action), which was created by [Stefan Stölzle](/stoe) and is now maintained as part of the [Ansible](https://ansible.com/) by [Red Hat](https://redhat.com/) project.

## Usage
To use the action simply add the following lines to your `.github/workflows/main.yml`.

```yaml
on: [push]

jobs:
  test:
    runs-on: ubuntu-latest
    name: Salt Lint Action Demo
    steps:
    - uses: actions/checkout@v1
    - name: Run salt-lint
      uses: roaldnefs/salt-lint-action@master
      env:
        ACTION_STATE_NAME: init.sls
```

If you want to analyse all `*.sls` files in the repository and increase logs verbosity use folowing env values istead:
```yaml
      env:
        ACTION_STATE_FIND_PATTERN: '.'
        SALT_LINT_EXTRA_PARAMS: '-v'
```

N.B. Use `v0.0.1` or any other valid tag, or branch, or commit SHA instead of `master` to pin the action to use a specific version.

### Environment Variables
- **ACTION_STATE_NAME**: (optional) defaults to `init.sls`
- **ACTION_STATE_FIND_PATH**: (optional) when defined, `find` command is used for searching salt files matching a pattern defined by the ACTION_STATE_FIND_PATTERN. Both absolute and relative paths are supported.
- **ACTION_STATE_FIND_PATTERN**: (optional) defaults to `*.sls`
- **SALT_LINT_EXTRA_PARAMS**: (optional) extra parameters passed to the salt-lint command, e.g. `-v` for increased verbosity. Check `salt-lint` help for more information.

## License
The Dockerfile and associated scripts and documentation in this project are released under the [MIT](license).

## Credits
The GitHub action is heavily based on [ansible-lint-action](https://github.com/ansible/ansible-lint-action). The initial [ansible-lint-action](https://github.com/ansible/ansible-lint-action) has been created by [Stefan Stölzle](/stoe) at [stoe/actions](https://github.com/stoe/actions).
