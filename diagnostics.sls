{#- EITR Technologies
    https://eitr.tech/ #}

{%- set subscription = hub.acct.PROFILES["azurerm"].get("default", {}).get("subscription_id") %}

Audit Diagnostic Settings:
  azurerm.resource.policy.assignment_present:
    - name: "AuditDiagnosticSettings"
    - scope: "/subscriptions/{{ subscription }}"
    - definition_name: "7f89b1eb-583c-429a-8828-af049802c1d9"
    - display_name: "Audit Diagnostic Settings"
    - description: "Audit diagnostic settings for selected resource types"
    - parameters:
        listOfResourceTypes:
          value:
            - "microsoft.keyvault/vaults"
            - "microsoft.storage/storageaccounts"
