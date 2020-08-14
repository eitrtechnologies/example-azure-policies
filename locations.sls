{#- EITR Technologies
    https://eitr.tech/ #}

{%- set subscription = hub.acct.PROFILES["azurerm"].get("default", {}).get("subscription_id") %}

Restrict Allowed Locations:
  azurerm.resource.policy.assignment_present:
    - name: "AllowedLocations"
    - scope: "/subscriptions/{{ subscription }}"
    - definition_name: "e56962a6-4747-49cd-b67b-bf8b01975c4c"
    - display_name: "Allowed Locations"
    - description: "This policy enables you to restrict locations your organization can specify when deploying resources"
    - parameters:
        listOfAllowedLocations:
          value:
            - "centralus"
            - "eastus"
            - "eastus2"
            - "northcentralus"
            - "southcentralus"
            - "westcentralus"
            - "westus"
            - "westus2"
