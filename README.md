## SAAD Algorithm
Self Adapting Adversarial Decision Tree. Aims to simulate threat actors in a controlled environment for video game companies and indie devs to secure their anti cheat mechanics and refine them.

This is designed to detect misuse of software rather than technically going in and breaking things. This minimal version is an isolated design to show the direction Im going as a prove of concept.

## Concept
Using a modified naive bayes and decision tree thats removed marshall unloading:

Ration boosts in starting metrics for each metric

From each metric run a specialized decision tree that branches between player, pet, and enemy.
  * Players tree branches between 14 dimensions
  * Pets tree branches between 14 dimensions
  * Enemies tree branches between 14 dimensions

Do economic exchange between player, pet, and enemy that either:
  * Simulates coordinated action ( against a greater foe )
  * Simulates competitive dynamics

Use naive bayes to measure final outcome of each metric.
