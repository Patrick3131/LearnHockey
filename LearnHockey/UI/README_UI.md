Überlegung UI Aufteilung

Components:
Simple UI Components, can have its own ViewModel but no injected Container, therefore highly reusable also in other projects.


Container:
More Complex UI Components, with their own ViewModel that has an injected DIContainer.
Usually consists of multiple simple Components.


Screen:
Compley component, has its own ViewModel thats has an injected DIContainer. One of the main screens.
