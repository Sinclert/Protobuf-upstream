# Protobuf upstream


## About
This repository serves as a skeleton for language neutral schemas of the data models
used on the different back-end services within a certain organization.

The repository uses Version 3 of the [Google Protobuf][google-protobuf-web] syntax
to defined schemas that later on will be translated to language-specific classes
by the use of CI triggers.


## Repository dependencies
The schema changes are propagated from this repository to language-specific ones
using CI jobs. For this reason, there is a hierarchical relationship across repositories:

                                   +--------------------+
                                   |     org-schemas    |
                                   +--------------------+
                                               |
                +------------------------------+-----------------------------+
                |                              |                             |
                v                              v                             v
    +-----------------------+      +-----------------------+     +-----------------------+
    |   org-schemas-python  |      |   org-schemas-golang  |     |          ...          |
    +-----------------------+      +-----------------------+     +-----------------------+


## Scripts adaptation
The repository offers an end-to-end set of scripts for _Python_ classes generation,
but it could be easily extended for supporting other programming languages.

Necessary changes:
1. Duplicate `update-python-schemas` CI job substituting Python references.
2. Duplicate `python.sh` scripts and substitute Python references by the new repo information:
    - `<ORGANIZATION_NAME>`: name of the target repo hosting organization.
    - `<DOWNSTREAM_REPOSITORY_NAME>`: name of the target repo.
    - `<DOWNSTREAM_REPOSITORY_FOLDER>`: name of the target repo, schema-containing folder.
3. Add the public key of the RSA pair as a _"Deploy key"_ to the language-specific repo.
4. **[Optional]** Add a custom plugin, by adding its installation to the `setup-plugings` Makefile rule.


## Final notes
The integration requires:

**A pair RSA keys to be used:**
- The private one as a _"Secret"_ (named `SSH_PRIVATE_KEY`) for this repository.
- The public one as a _"Deploy key"_ for the language-specific repository.

**A `VERSION` file at the language-specific repository**

This file should contain an integer number that will be bumped up when releasing
the next version of the schemas. [Semantic versioning][semantic-versioning] on schemas repos
is hard as there is no automatic way of identifying a _major_, _minor_ or _patch_ change.

**A `release` Makefile rule at the language-specific repository**

This rule is defined within the target repository and specifies how a release is carried out.

Tagging a particular commit? Uploading to PyPi? The end-repo decides!


[google-protobuf-web]: https://developers.google.com/protocol-buffers/
[semantic-versioning]: https://semver.org
