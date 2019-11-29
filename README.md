# Run OPA tests using Conftest 

This action uses [Conftest](https://github.com/instrumenta/conftest) to run [OPA policy](https://www.openpolicyagent.org/) as well as pull policy bundles from public or private OCI registry.

## Inputs

| Property | Default | Description |
| --- | --- | --- |
| path | | **Required** Path to resource file or helm chart |
| policy | policy | Path to policy folder |
| namespace | main | Rego namespace (package) to use for testing |
| output | stdout | Conftest output format |
| pull_image | | Registry to pull policies from. E.g. `myregistry.azurecr.io/myopapolicies:0.0.1` |
| type | | Supported: `helm` Will run additional tool(s), like helm conftest plugin |


## Environment Variables (required for private registries)

- `REGISTRY_USER` - Registry username
- `REGISTRY_PWD` - Registry password


## Example usage

### Pull policy from registry and test a helm chart

```
name: Test
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Run OPA tests
      uses: ibiqlik/conftest-action-docker@master
      with:
        path: "mychart"
        pull_image: "myregistry.azurecr.io/myopapolicies:0.0.1"
        type: "helm"
      env:
        REGISTRY_USER: ${{ secrets.REGISTRY_USER }}
        REGISTRY_PWD: ${{ secrets.REGISTRY_PWD }}
```

### Run test with local policy against Kubernetes resource files

```
name: Test
on: [push]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: Run OPA tests
      uses: ibiqlik/conftest-action-docker@master
      with:
        path: "my/k8s/resources/*" # Use wildcard to test all files inside a folder
        namespace: "kubernetes.labels"
        policy: "policy"
```
