## SAAD Algorithm
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
