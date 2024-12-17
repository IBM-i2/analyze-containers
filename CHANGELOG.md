# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [semantic versioning](https://i2group.github.io/analyze-deployment-tooling/guidetoc/index.html#support-policy):

* `Added` for new features.
* `Changed` for changes in existing functionality.
* `Deprecated` for soon-to-be removed features.
* `Removed` for now removed features.
* `Fixed` for any bug fixes.
* `Security` in case of vulnerabilities.

## 3.0.3 - 17/12/2024

### Fixed

* Missing changelog entry for 3.0.2.
* Additional trust certificates types support in SQL Server.
* Error when running bootstrap script in an already installed environment.

[3.0.3]\: <!-- markdown-link-check-disable --><https://github.com/i2group/analyze-deployment-tooling/tree/v3.0.3><!-- markdown-link-check-enable -->

## 3.0.2 - 12/12/2024

### Changed

* Improved support for external CA certificates.

### Fixed

* Broken duplicate configuration task for shared configurations.
* Wrapper script installation issues.

[3.0.2]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v3.0.2>

## 3.0.1 - 15/08/2024

### Added

* Documentation for deploying external connectors with SSL enabled.

### Fixed

* Bootstrap script errors in environments with non-default permissions.
* Renew secrets in a deployment pattern without database.
* ProvisioningCompatibilityMode and UserIdentityCompatibilityMode not set to true after upgrading.

[3.0.1]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v3.0.1>

## 3.0.0 - 08/08/2024

### Added

* Updated for compatibility with i2 Analyze 4.4.4.
* Connector Designer support for Config Dev Environment.
* Support for Connector Designer installation with separate deployment. See: [Adding Connector Designer to your deployment](https://docs.i2group.com/analyze/4.4.4/deploy_connector_designer.html).
* Load balancer support for Config Dev Environment.
* Documentation for different authentication mechanisms.
* Documentation for secret and certificate management.
* Support to start and stop specific components in the environment using the `manage-environment` script.
* Support for running connectors based on an image from a registry.
* Documentation for external database user configuration.

### Changed

* Rename repository to `analyze-deployment-tooling`.
* Update documentation for Solr replication and high availability after autoscaling policy rules deprecation.
* Database user creation to use the `dba` instead of master user (`postgres` or `sa`).
* Certificates for metric system.

### Fixed

* Container rebuilds on every deploy when changing runtime memory settings.
* Improved error handling when adding additional certificates to clients.
* Errors with TTY when running in a non-interactive shell.

[3.0.0]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v3.0.0>

## 2.9.4 - 30/07/2024

### Changed

* Postgres backup user (postgres) permissions. Reverted to before 2.9.1 given pg_dump error backing up charts.

### Fixed

* Postgres backup command in arm64 architecture.

[2.9.4]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v2.9.4>

## 2.9.3 - 08/05/2024

### Added

* Documentation about how to deploy analyze-deployment-tooling in an offline environment.
* Troubleshooting information if Docker runs out of memory.
* Ability to rotate secrets in the environment without data loss.

### Fixed

* Checking wrong files for placeholder text.
* If the `connector-references.json` file is missing, the deploy succeeds with errors.
* Unclear documentation about how to run an external connector running in WSL.
* Incorrect documentation about how to deploy the pre-prod example environment.

[2.9.3]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v2.9.3>

## 2.9.2 - 28/03/2024

### Fixed

* Broken copy mechanism for files in the `configuration/liberty` directory.

[2.9.2]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v2.9.2>

## 2.9.1 - 26/03/2024

### Added

* OIDC and SAML configuration documentation.
* Deployment reference architecture for Postgres.

### Fixed

* Postgres backup user (dbb) permissions.
* Additional trust certificates types support.

[2.9.1]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v2.9.1>

## 2.9.0 - 27/02/2024

### Added

* Ability to run with an external user managed database server.
* Ability to deploy with configurable container runtime variables.
* FAQ documentation page.
* Support for PostgreSQL SSL.

### Fixed

* Missing CHANGELOG file.
* Broken client utilities documentation link.
* Highlight query XSD file not always generated.
* Not removing symlinks when using manage-environment.
* Liberty container setting incorrect deployment state.
* Extension configuration files not being updated.
* Minor documentation issues.
* `EACCES` error when starting npm connectors. To resolve this issue if you are still experiencing it after upgrading, see [Troubleshooting](https://i2group.github.io/analyze-deployment-tooling/content/troubleshooting.html).
* "Changes to schema" message blocking deployment.

[2.9.0]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v2.9.0>

## 2.8.0 - 21/12/2023

### Added

* Updated for compatibility with i2 Analyze 4.4.3.
* Use of a client image to execute analyze-deployment-tooling.
* New installation mechanism (see bootstrap script).

### Changed

* Updated minimum support to Node v18 for Node connectors.

### Fixed

* Issue with generated run-database-script on change sets.
* Compatibility with pre-installed Mac bash version.
* Multiple issues with file permissions.
* Issue with opening the VS Code dev container.
  * If you see an error message when you open analyze-deployment-tooling in a VS Code dev container, see this [GitHub Issue](https://github.com/i2group/analyze-deployment-tooling/issues/13).

### Deprecated

* Toolkit example connector. Switched to example SDK connector.
* Removal of old top-level `.sh` scripts. Deprecated since version 2.4.0.
* Removal of old client functions. Deprecated since version 2.4.0.

[2.8.0]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v2.8.0>

## 2.7.1 - 27/09/2023

### Fixed

* Multiple issues with schema update.

[2.7.1]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v2.7.1>

## 2.7.0 - 01/09/2023

### Added

* Ability to backup and restore the database to S3 and shared file systems.

### Changed

* The default authentication mechanism is Form-Based Auth.
* The SQL Server Docker image is no longer built locally. The image is pulled from [docker hub - i2group](https://hub.docker.com/u/i2group).

### Fixed

* `renew-certificates` task updates connector secrets.
* Secret expiry no longer causes data loss since last backup.

[2.7.0]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v2.7.0>

## 2.6.0 - 24/07/2023

### Added

* Updated for compatibility with i2 Analyze 4.4.2.
* Ability to add additional web content to the Liberty server.
* Support for upgrading all previous backups during the upgrade process.

### Changed

* Update SQL Server version to 2022. *Important: This requires JDBC driver version 12.2.0 (minimum)*
* Improved database configuration UX for change sets.

### Fixed

* Incorrect warnings for i2 Connect server version validation are no longer displayed.
* A config that includes `overrideHttpAuthMethod="CLIENT_CERT"` in the `server.extensions.xml` can be deployed successfully.
* Fixed JDBC driver version validation for `create-environment` script.

[2.6.0]\: <https://github.com/i2group/analyze-deployment-tooling/tree/v2.6.0>

## 2.5.3 [Deprecated] - 07/06/2023

### Added

* Ability to update the Solr configuration without cleaning the deployment first.

### Changed

* Increased the certificate expiry time for the development environment certificates from 90 days to 365 days.

### Fixed

* Security schema changes now included in change sets.
* The pre-prod example deployment now backs up the match_index2.
* Versions are correctly resolved in documentation.

## 2.5.2 [Deprecated] - 31/03/2023

### Added

* Documentation to describe how to create your own repositories to deploy in an air-gapped system.

### Changed

* Improved documentation for creating and using the config development environment.

### Fixed

* Stopped filling Grafana logs with unnecessary messages.
* Database creation scripts no longer contain empty placeholders.
* Can now create ingestion sources in an upgraded system.
* The Liberty user registry is updated during a deploy.
* Stopped repeating Liberty properties on start up.
* Password generation issues on Mac OS.

## 2.5.1 [Deprecated] - 14/02/2023

### Changed

* Improved validation on scripts.

### Fixed

* Fixed documentation Docker bind examples.
* Fixed pre-prod upgrade from v2.3.0.

### Workaround

* Upgrading from v2.2.0 after a you complete a back up results in connectors that cannot be recovered. Before you upgrade, run `deploy -c <config_name> -t connectors`.

## 2.5.0 [Deprecated] - 20/12/2022

### Added

* Updated for compatibility with i2 Analyze 4.4.1.
* Support for PostgreSQL.
* General documentation improvements and bug fixes.

### Changed

* The Liberty Docker image now based on the Open Liberty Docker image.
* Node based connectors are built with the dependencies that are defined in a npm-shrinkwrap.json file if the file exist in the connector.
* Improved shared configuration UX by changing `configure-paths` script parameters. Use the `-h` flag for more information on how to run the command.
* `manage-environment -t upgrade` and `manage-toolkit-configuration -t {create | prepare | import | export}` commands now use the path specified in the `path-configuration.json` file instead of the `-p` flag. Use the `-h` flag in each script for more information on how to run the commands.

## 2.4.0 [Deprecated] - 23/09/2022

### Added

* Support for sharing configurations between users and environments.
* Support for deploying i2 Notebook plugins.
* Support for stopping all running containers.

### Changed

* Scripts have been converted to commands.
  * For example, `deploy.sh` is now called using `deploy`.
* The client functions in `client_functions.sh` are renamed.

### Deprecated

* The top-level `.sh` scripts. Start using the commands instead.
* The client functions with the previous names. Start using the renamed functions.

## 2.3.0 [Deprecated]- 22/07/2022

### Added

* Updated for compatibility with i2 Analyze 4.4.0.
* Support for Prometheus and Grafana.

### Changed

* The environment must be run inside a VS Code development container.
* The base Docker images are no longer built locally. The images are pulled from [docker hub - i2group](https://hub.docker.com/u/i2group).

## 2.2.0 [Deprecated] - 06/05/2022

### Added

* Updated for compatibility with i2 Analyze 4.3.5.
* Provided i2 Analyze Fix Pack support.
* Script to create database backups for all configs.

### Removed

* i2Connect SDK connector base image.

## 2.1.3 [Deprecated] - 13/05/2022

### Added

* Functionality to support upgrading to future releases of i2 Analyze.

## 2.1.2 [Deprecated] - 31/03/2022

### Security

* Updated the Liberty and Solr images to use Log4j2 version 2.17.2 to remediate <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228>
  * To remediate the CVE, you must rebuild the Docker images in your environment. To rebuild the Docker images, complete the instructions [Updating to the latest version of the analyze-deployment-tooling repository](https://i2group.github.io/analyze-deployment-tooling/content/managing_update_env.html).

## 2.1.1 [Deprecated] - 12/01/2022

### Security

* Updated the Liberty and Solr images to use Log4j2 version 2.17.1 to remediate <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228>
  * To remediate the CVE, you must rebuild the Docker images in your environment. To rebuild the Docker images, complete the instructions [Updating to the latest version of the analyze-deployment-tooling repository](https://i2group.github.io/analyze-deployment-tooling/content/managing_update_env.html).

## 2.1.0 [Deprecated] - 06/10/2021

### Added

* Support for i2 Connect server connectors developed using the i2 Connect SDK.
* Enabled connections to i2 Connect connectors hosted outside of the config development environment.
* Synchronize configuration between the config development environment and the i2 Analyze deployment toolkit.
* Deploy extensions to the config development environment from i2 Analyze Developer Essentials.

### Changed

* Additional command line tools required.
  * See [Updating to the latest version of the analyze-deployment-tooling repository](https://i2group.github.io/analyze-deployment-tooling/content/managing_update_env.html).

## 2.0.0 [Deprecated] - 23/07/2021

### Added

* Configuration development environment.
* Documentation hosted at <https://i2group.github.io/analyze-deployment-tooling/>
* Updated for compatibility with i2 Analyze 4.3.4

### Changed

* Moved `environments/pre-prod` to `examples/pre-prod`.

## 1.1.0 [Deprecated] - 18/02/2021

### Added

* Walkthroughs to demonstrate backup and restore procedure.
* Updated for compatibility with i2 Analyze 4.3.3.1.

## 1.0.1 [Deprecated] - 29/01/2021

### Added

* Walkthroughs to demonstrate high availability and disaster recovery scenarios.
* New client functions added - getSolrStatus & runi2AnalyzeToolAsExternalUser.
* Documentation for the environments/pre-prod/resetRepository.sh script.

### Fixed

* environments/pre-prod/walkthroughs/change-management/ingestDataWalkthrough.sh fixed to ingest all of the data in the example data set.
* Broken links in markdown documentation.

## 1.0.0 [Deprecated] - 17/12/2020

### Added

* Initial public release.
* Docker image creation scripts.
* Scripts to deploy all EIA components in Docker containers.
* Scripts to demonstrate secrets management and full end to end encryption.
* Scripts to demonstrate configuration change management across the deployment.

<!-- markdownlint-configure-file { "MD024": false } -->
