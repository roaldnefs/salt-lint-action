# Salt Lint for GitHub Action
This action allows you to run `salt-lint` with no additional options.

The project is heavily based on [ansible-lint-action](https://github.com/ansible/ansible-lint-action), which was created by [Stefan Stölzle](/stoe) and is now maintained as part of the [Ansible](https://ansible.com/) by [Red Hat](https://redhat.com/) project.

## Usage
To use the action simply add the following lines to your `.github/main.workflow`.

```hcl
action "Lint SaltStack State" {
  uses = "roaldnefs/salt-lint-action@master"
}
```

N.B. Use `v0.0.1` or any other valid tag, or branch, or commit SHA instead of `master` to pin the action to use a specific version.

### Environment Variables
- **ACTION_STATE_NAME**: (optional) defaults to `init.sls`

## License
The Dockerfile and associated scripts and documentation in this project are released under the [MIT](license).

## Credits
The GitHub action is heavily based on [ansible-lint-action](https://github.com/ansible/ansible-lint-action). The initial [ansible-lint-action](https://github.com/ansible/ansible-lint-action) has been created by [Stefan Stölzle](/stoe) at [stoe/actions](https://github.com/stoe/actions).