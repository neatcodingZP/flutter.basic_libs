## Publish manually

1. Increment version: Update the version in your pubspec.yaml (e.g., from 1.0.0 to 1.0.1 for a patch, 1.1.0 for a minor release, 2.0.0 for a major release).

2. Update CHANGELOG.md: Document the new changes.

3. Run `flutter pub publish --dry-run`.

4. Run `flutter pub publish`.

## Publish automated
1. Publish branch to `origin`.
2. Run `git tag packages/ui_kit/v1.0.0`
3. Run `git push origin packages/ui_kit/v1.0.0`
4. Monitor GitHub Actions:
Go to your GitHub repository's "Actions" tab. You should see your "Publish Monorepo Package to pub.dev" workflow running. Monitor its progress. If there are any errors (e.g., version mismatch, pubspec.yaml not found), the workflow will fail, and you'll get detailed logs.
5. Merge `branch` to `master`.

### Use if need
- create new branch `git checkout -b new_branch`
- publish new branch `git publish origin new_branch`
- delete local tag `git tag -d tag_name`
- delete remote tag `git push --delete origin tag_name`
