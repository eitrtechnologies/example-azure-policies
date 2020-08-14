{#- EITR Technologies
    https://eitr.tech/ #}

{%- set subscription = hub.acct.PROFILES["azurerm"].get("default", {}).get("subscription_id") %}

Require Disk Encryption:
  azurerm.resource.policy.assignment_present:
    - name: "DiskEncryption"
    - scope: "/subscriptions/{{ subscription }}"
    - definition_name: "0961003e-5a0a-4549-abde-af6a37f2724d"
    - display_name: "Disk Encryption"
    - description: "VMs without disk encryption enabled will be monitored by Azure Security Center as recommendations"
