# hiera_analyze

#### Table of Contents
1. [Overview] (#overview)
1. [Requirements] (#requirements)
1. [Installation] (#installation)
1. [Options] (#options)
1. [Log Format] (#log-format)

## Overview

A tool to aid in cleaning out stale data in Hiera.

## Requirements

- Puppet Master >= 3.x
- Hiera YAML or JSON backends

## Installation

Deploy into your hiera.yaml file with `yaml_analzye` or `json_analyze`
instead of `yaml` or `json` to track lookups for that backend.  The
`datadir` value can be left unadjusted because the analyze classes inherit
the original backend.

~~~
# hiera.yaml
---
:backends:
  - yaml_analyze

:hierarchy:
  - "nodes/%{::trusted.certname}"
  - common

:yaml:
  datadir: /etc/puppetlabs/code/environments/%{environment}/hieradata

:analyze_log: /root/hiera_analyze.log
~~~

## Options

**analyze_log**: Log file to which you want to record Hiera lookups. *Default:* `/var/log/hiera_analyze.log`

## Log Format

~~~
ANALYZE: 2016-05-23 12:39:24 +0000: [localhost.localdomain] 'test' from 'common'
                    ↑                         ↑               ↑           ↑
                timestamp                 clientcert         key      datasource
~~~

#### Notes

Using `puppet apply` on the Master or `puppet agent` from any Agent will append the `hiera_analyze.log`.
Lookups done from `hiera` CLI will not, so that debugging will not effect usage statistics.  This
backend is meant to implemented for a limited time to gather information on what keys are being actively
used.  The process of comparing used keys to all keys and cleaning them out is out of scope.

#### Limitation

This module currently only covers analyzing the YAML and JSON backends.
