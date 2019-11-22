# Run OPA tests using Conftest 

This action uses [Conftest](https://github.com/instrumenta/conftest) to run OPA policies as well as pull policy bundles from public or private OCI registry.

## Inputs

### Required inputs

- `path` - Path to resource or helm chart name to be tested
- `bundle_name` - Bundle name (a.k.a. image/repository name). Example: `mypolicy`
- `tag` - Bundle (image) tag, can be a version, sha commit

### Optional inputs

- `policy` - Default `"policy"` Path to policy folder.
- `namespace` - Default `"main"` Rego namespace (package) to use for testing
- `output` - Default `stdout` Conftest output format
- `pull_image` - Registry to pull policies from. E.g. `myregistry.azurecr.io/myopapolicies:0.0.1`
- `helm` - Default `"false"` Bool `true|false` if testing helm charts

## Environment Variables (required for private registries)

- `REGISTRY_USER` - Registry username
- `REGISTRY_PWD` - Registry password


## Example usage

### Pull policy from registry and test

```
name: Run OPA Tests
on: [push]
jobs:
  conftest:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Run tests
      uses: ibiqlik/conftest-action-docker@master
      with:
        path: "mychart"
        pull_image: "myregistry.azurecr.io/myopapolicies:0.0.1"
        helm: "true"
      env:
        REGISTRY_USER: ${{ secrets.REGISTRY_USER }}
        REGISTRY_PWD: ${{ secrets.REGISTRY_PWD }}
```

### Run test with local policy against Kubernetes resource files

```
name: Run OPA Tests
on: [push]
jobs:
  conftest:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Run conftest tests
      uses: ibiqlik/conftest-action-docker@master
      with:
        path: "my/k8s/resources/*" # Use wildcard to test all files inside a folder
        namespace: "kubernetes.labels"
        policy: "policy"
```
