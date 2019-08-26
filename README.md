# chef-load

Deploys chef-load as a service.

## Maintainers

sbrown@chef.io

## Type of Package
Service

## Usage
Set user toml file with the required settings and load the service into a habitat supervisor

## Bindings

This service can load test both a `chef automate server` and a `chef server`.
Binds for chef server and automate have been included, but you have the option to configure
through config as well.

## Topologies

### Standalone

## Update Strategies

At once

### Configuration Updates

see default.toml for all configuration options
