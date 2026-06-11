/**
 * EGAP Learning Days — Abidjan 2026
 * Creates the comprehensive test as a Google Form (quiz mode).
 *
 * HOW TO USE:
 * 1. Go to https://script.google.com → New project
 * 2. Paste this file, save
 * 3. Run createLearningDaysTestForm (authorize when prompted)
 * 4. View → Logs for the published form URL
 */

function createLearningDaysTestForm() {
  var form = FormApp.create("EGAP Learning Days 2026 — Comprehensive Test");

  form.setDescription(
    "Answer all 20 multiple-choice questions (one choice each), then Question 21.\n\n" +
    "Répondez aux 20 questions à choix multiples (une réponse par question), puis à la question 21."
  );
  form.setIsQuiz(true);
  form.setCollectEmail(true);
  form.setAllowResponseEdits(false);

  var questions = [
    {
      title: "Q1. Fundamental problem of causal inference | Problème fondamental",
      choices: [
        ["a. We can never measure outcomes accurately | On ne peut jamais mesurer les résultats", false],
        ["b. We observe only one potential outcome per unit, not both Y(1) and Y(0) | Un seul résultat potentiel par unité", true],
        ["c. Treatment effects are always zero | Effets toujours nuls", false],
        ["d. Randomization always fails | La randomisation échoue toujours", false]
      ]
    },
    {
      title: "Q2. Average Treatment Effect (ATE) | Effet moyen du traitement",
      choices: [
        ["a. Effect on treated units only | Effet sur les traités seulement", false],
        ["b. Sample difference in means | Différence des moyennes", false],
        ["c. E[Y(1) - Y(0)] over the population | E[Y(1) - Y(0)] sur la population", true],
        ["d. Coefficient on a covariate | Coefficient d'une covariable", false]
      ]
    },
    {
      title: "Q3. Extension services study — main threat | Étude extension — menace principale",
      choices: [
        ["a. Measurement error | Erreur de mesure", false],
        ["b. Selection bias | Biais de sélection", true],
        ["c. Sample size too small | Échantillon trop petit", false],
        ["d. Yields in kilograms | Rendements en kg", false]
      ]
    },
    {
      title: "Q4. Exactly 50 treated, 50 control | Exactement 50 traités, 50 contrôles",
      choices: [
        ["a. simple_ra() with prob = 0.5", false],
        ["b. complete_ra() with m = 50", true],
        ["c. block_ra() with one block", false],
        ["d. Flip a coin 100 times | Lancer une pièce 100 fois", false]
      ]
    },
    {
      title: "Q5. All households in a village share assignment | Assignation au niveau village",
      choices: [
        ["a. Simple random assignment | Assignation simple", false],
        ["b. Complete random assignment | Assignation complète", false],
        ["c. Blocked random assignment | Randomisation par blocs", false],
        ["d. Cluster random assignment | Randomisation par grappes", true]
      ]
    },
    {
      title: "Q6. Blocking on predictive pre-treatment variable | Blocage sur variable prédictive",
      choices: [
        ["a. Biases the ATE | Biaise l'ATE", false],
        ["b. Reduces precision | Réduit la précision", false],
        ["c. Improves precision (with correct analysis) | Améliore la précision", true],
        ["d. Eliminates need for randomization | Élimine la randomisation", false]
      ]
    },
    {
      title: "Q7. Analyze as you randomize | Analyser comme on randomise",
      choices: [
        ["a. Same estimator regardless of assignment | Même estimateur", false],
        ["b. Match analysis to randomization | Adapter l'analyse à la randomisation", true],
        ["c. Always many covariates | Toujours beaucoup de covariables", false],
        ["d. Descriptives only | Descriptives seulement", false]
      ]
    },
    {
      title: "Q8. Why difference-in-means is unbiased | Pourquoi différence des moyennes non biaisée",
      choices: [
        ["a. Identical outcomes | Résultats identiques", false],
        ["b. Balance on every covariate | Équilibre sur toutes covariables", false],
        ["c. E[Y(0)|Z=1] = E[Y(0)|Z=0] (and similarly for Y(1)) | Égalité des espérances", true],
        ["d. Large sample | Grand échantillon", false]
      ]
    },
    {
      title: "Q9. Coefficient on X in Y ~ Z + X | Coefficient de X dans Y ~ Z + X",
      choices: [
        ["a. Causal effect of X | Effet causal de X", false],
        ["b. Association, not necessarily causal | Association, pas nécessairement causal", true],
        ["c. The ATE | L'ATE", false],
        ["d. SE of ATE | Erreur-type de l'ATE", false]
      ]
    },
    {
      title: "Q10. What a p-value represents | Ce que représente une p-value",
      choices: [
        ["a. P(null is true) | P(H0 vraie)", false],
        ["b. P(data this extreme | null true) | P(données extrêmes | H0)", true],
        ["c. Size of treatment effect | Taille de l'effet", false],
        ["d. Power | Puissance", false]
      ]
    },
    {
      title: "Q11. Fail to reject the null | Ne pas rejeter H0",
      choices: [
        ["a. The null is true | H0 est vraie", false],
        ["b. No treatment effect | Aucun effet", false],
        ["c. Insufficient evidence to reject | Preuves insuffisantes pour rejeter", true],
        ["d. Study underpowered | Étude sous-puissante", false]
      ]
    },
    {
      title: "Q12. Statistical power | Puissance statistique",
      choices: [
        ["a. P(correctly accept null) | P(accepter H0)", false],
        ["b. P(reject null when alternative true) | P(rejeter H0 si alternative vraie)", true],
        ["c. Same as alpha | Identique à alpha", false],
        ["d. Expected effect | Effet attendu", false]
      ]
    },
    {
      title: "Q13. What increases power? | Ce qui augmente la puissance ?",
      choices: [
        ["a. Smaller N | N plus petit", false],
        ["b. More variability | Plus de variabilité", false],
        ["c. Larger true effect | Effet vrai plus grand", true],
        ["d. Stricter alpha | Alpha plus strict", false]
      ]
    },
    {
      title: "Q14. MIDA diagnosis | Diagnostic MIDA",
      choices: [
        ["a. Replaces data collection | Remplace la collecte", false],
        ["b. Simulate bias, RMSE, power | Simuler biais, RMSE, puissance", true],
        ["c. Proves unbiasedness always | Prouve toujours l'absence de biais", false],
        ["d. Pick covariates after outcomes | Covariables après résultats", false]
      ]
    },
    {
      title: "Q15. SUTVA | SUTVA",
      choices: [
        ["a. Same dose for all | Même dose", false],
        ["b. No interference between units | Pas d'interférence", true],
        ["c. Constant effects | Effets constants", false],
        ["d. No attrition | Pas d'attrition", false]
      ]
    },
    {
      title: "Q16. Factorial interaction A × B | Interaction A × B",
      choices: [
        ["a. Main effect of A | Effet principal de A", false],
        ["b. Effect of A depends on B | Effet de A dépend de B", true],
        ["c. Sample mean | Moyenne", false],
        ["d. Randomization check | Vérifier randomisation", false]
      ]
    },
    {
      title: "Q17. Attrition | Attrition",
      choices: [
        ["a. Increases power | Augmente puissance", false],
        ["b. Can break balance if selective | Peut rompre l'équilibre", true],
        ["c. ATE undefined | ATE indéfini", false],
        ["d. Only observational | Seulement observationnel", false]
      ]
    },
    {
      title: "Q18. Cluster-randomized SEs | Erreurs-types (grappes)",
      choices: [
        ["a. Ignore clustering | Ignorer grappes", false],
        ["b. Account for within-cluster correlation | Corrélation intra-grappe", true],
        ["c. SE = 0 | ET = 0", false],
        ["d. Use K as N only | K comme N seulement", false]
      ]
    },
    {
      title: "Q19. Encouragement design | Conception par incitation",
      choices: [
        ["a. Perfect compliance | Conformité parfaite", false],
        ["b. Imperfect compliance; assignment affects uptake | Non-conformité", true],
        ["c. No control group | Pas de contrôle", false],
        ["d. Pre-treatment outcomes | Résultats pré-traitement", false]
      ]
    },
    {
      title: "Q20. Randomization & identification | Randomisation et identification",
      choices: [
        ["a. Every individual effect | Chaque effet individuel", false],
        ["b. Comparable groups in expectation | Groupes comparables en espérance", true],
        ["c. Only for small N | Seulement petit N", false],
        ["d. Replaces potential outcomes | Remplace résultats potentiels", false]
      ]
    }
  ];

  questions.forEach(function(q) {
    var item = form.addMultipleChoiceItem();
    item.setTitle(q.title)
        .setPoints(1)
        .setRequired(true)
        .setChoices(
          q.choices.map(function(c) {
            return item.createChoice(c[0], c[1]);
          })
        );
  });

  form.addParagraphTextItem()
      .setTitle("Q21. Core concept (open-ended) | Concept clé (question ouverte)")
      .setHelpText(
        "In 3–6 sentences: (1) Fundamental problem of causal inference. " +
        "(2) Why doesn't treated vs. untreated comparison = causal effect? " +
        "(3) One way randomization helps.\n\n" +
        "En 3–6 phrases : (1) Problème fondamental. (2) Pourquoi comparaison simple ≠ causal ? " +
        "(3) Comment la randomisation aide."
      )
      .setRequired(true);

  form.setPublishingSummary(true);
  form.setAcceptingResponses(true);

  Logger.log("Published URL: " + form.getPublishedUrl());
  Logger.log("Edit URL: " + form.getEditUrl());
}
