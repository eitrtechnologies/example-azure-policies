# Example Azure Policy Assignments for Idem

## TABLE OF CONTENTS

- [INSTALLATION](#installation)
- [CREDENTIALS](#credentials)
- [RESOURCE DEFINITION](#resource-definition)
- [TESTING AND BUILDING RESOURCES](#testing-and-building-resources)
- [INCLUDED POLICY ASSIGNMENTS](#included-policy-assignments)
  * [Audit Diagnostic Log Enablement](#diagnosticssls)
  * [Restrict Allowed Resource Locations](#locationssls)
  * [Audit VM Disk Encryption](#vmencryptionsls)
  * [Restrict Allowed VM Sizes](#vmsizessls)

Azure is a cloud service offered by Microsoft that provides virtual machines, SQL services, media services, and more.
Azure Resource Manager is the next generation of the Azure portal and API.

These examples show how to assign built-in Policy definitions using [Idem](https://gitlab.com/saltstack/pop/idem), a new
configuration management, Infrastructure as Code (IaC), and API management platform written to the
[POP](https://gitlab.com/saltstack/pop/pop) programming paradigm.

Further information on the Azure plugins used in these examples can be found on the `idem-azurerm`
[GitHub page](https://github.com/eitrtechnologies/idem-azurerm) or the
[Read the Docs page](https://idem-azurerm.readthedocs.io/en/latest/).

## INSTALLATION
The azurerm idem provider can be installed via pip:
```
pip install idem-azurerm
```

## CREDENTIALS
This provider requires that a dictionary populated with valid Azure credentials be passed via
[acct](https://gitlab.com/saltstack/pop/acct).

The credentials can be stored in an arbitrarily named file, such as `myawesomecreds.yml`
```
#!yaml

azurerm:
  default:
    client_id: "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
    secret: "X2KRwdcdsQn9mwjdt0EbxsQR3w5TuBOR"
    subscription_id: "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb"
    tenant: "cccccccc-cccc-cccc-cccc-cccccccccccc"
```

In order to prepare the credentials file for use, the acct command can be run to encrypt the file with the Fernet
algorithm.
```
(env) $ acct myawesomecreds.yml
New encrypted file at: myawesomecreds.yml.fernet
The file was encrypted with this key:
71Gbz2oDSv40Er9YUFBJPzOjtCi6Z2-5niBHPekkvqs=
```

Now we have an encrypted file containing the credentials and a symmetric key for decryption. Since you have encrypted
the file with the key, you can now remove the original plaintext file.
```
(env) $ rm myawesomecreds.yml
```

All we have to do now is to tell idem where to get the file and key for acct. This information can be passed to acct on
the command line as parameters, but we will set up environment variables for the purposes of this tutorial.
```
(env) $ export ACCT_FILE="/path/to/myawesomecreds.yml.fernet"
(env) $ export ACCT_KEY="1Gbz2oDSv40Er9YUFBJPzOjtCi6Z2-5niBHPekkvqs="
```

## RESOURCE DEFINITION
After installation, the Azure Resource Manager Idem Provider execution and state modules will be accessible to the hub.

The following example uses an azurerm state module to ensure the existence of a resource group.

Let's call this file "mytest.sls"
```
Resource group exists:
  azurerm.resource.group.present:
    - name: idem
    - location: eastus
    - tags:
        organization: EITR Technologies
```

## TESTING AND BUILDING RESOURCES
Before you build the resources defined in the ".sls" file you may want to test what will happen when the state file is
run. To do this, run idem with the `--test` option.
```
(env) $ idem state mytest.sls --test
```
Once you determine that your state file with perform the intended operations, then you can build the defined resources
by running idem like so:
```
(env) $ idem state mytest.sls
```

## INCLUDED POLICY ASSIGNMENTS

### `diagnostics.sls`
Audit diagnostic settings for selected resource types.

### `locations.sls`
This policy enables you to restrict locations your organization can specify when deploying resources.

### `vmencryption.sls`
VMs without disk encryption enabled will be monitored by Azure Security Center as recommendations.

### `vmsizes.sls`
This policy enables you to specify a set of virtual machine size SKUs that your organization can deploy.
