#import "template.typ": internship_report

// Set up your report details here
#show: internship_report.with(
  title: "Optimisation des Algorithmes de Maintenance Prédictive",
  author: "Jane Doe",

  // University info
  university_name: "Université d'Occitanie",
  // university_logo: "uni-logo.png",

  // Company info
  company_name: "AeroTech Industries",
  // company_logo: "company-logo.png",

  // Internship details
  dates: "Janvier 2026 - Juillet 2026",
  supervisors: (
    "Dr. Alan Turing (Tuteur Universitaire)",
    "Sarah Connor (Maître de stage)",
  ),

  // Frontmatter sections
  acknowledgements: [
    Je tiens à remercier chaleureusement mes tuteurs pour leurs conseils avisés, ainsi que toute l'équipe d'ingénierie d'AeroTech pour m'avoir intégré de manière si bienveillante durant ces six mois.
  ],

  abstract: [
    Ce rapport détaille un stage de six mois chez AeroTech Industries, axé sur l'optimisation des algorithmes de maintenance prédictive pour les avions commerciaux. En implémentant de nouvelles techniques d'apprentissage automatique (Machine Learning), les fausses alertes ont été réduites de 14%. Ce document couvre le contexte théorique, la méthodologie employée, ainsi que les résultats de la phase de test A/B.
  ],
)

// ==========================================
// YOUR REPORT STARTS HERE
// ==========================================

= Introduction
L'industrie aérospatiale génère des téraoctets de données de télémétrie par vol. L'enjeu principal de ce stage était d'exploiter ces données pour prédire les pannes matérielles avant qu'elles ne surviennent, réduisant ainsi les temps d'immobilisation au sol.

= Contexte Technique
== Modèle de Détection d'Anomalies
Pour traiter les séries temporelles provenant des capteurs des moteurs, nous avons opté pour une architecture basée sur des forêts aléatoires (Random Forest) combinée à un réseau de neurones récurrent (LSTM).

Voici un extrait du script de prétraitement utilisé pour nettoyer le signal des capteurs de température :

```python
import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler

def preprocess_sensor_data(df, window_size=50):
    # Suppression des valeurs aberrantes extrêmes
    df = df[(np.abs(df.temperature - df.temperature.mean()) <= (3 * df.temperature.std()))]

    # Normalisation des données
    scaler = StandardScaler()
    df['temp_scaled'] = scaler.fit_transform(df[['temperature']])

    # Création des fenêtres glissantes pour le LSTM
    return df.rolling(window=window_size).mean()
```

= Résultats et Évaluation
== Comparaison des Performances
Après l'entraînement des modèles sur le cluster de l'entreprise, nous avons comparé notre nouvelle approche (Modèle Hybride LSTM) avec l'ancien système de règles statiques.

#figure(
  table(
    columns: (2fr, 1fr, 1fr, 1fr),
    align: (left, center, center, center),
    [Modèle Utilisé], [Précision], [Rappel (Recall)], [F1-Score],
    [Système Héritage (Règles)], [78.2%], [81.5%], [79.8%],
    [Régression Logistique], [82.4%], [84.1%], [83.2%],
    [Forêt Aléatoire (Baseline)], [89.1%], [87.3%], [88.2%],
    [Modèle Hybride LSTM (Nouveau)], [94.5%], [92.8%], [93.6%],
  ),
  caption: [Comparaison des métriques de performance sur l'ensemble de test (Juin 2026)],
)

Comme le montre le tableau ci-dessus, le modèle hybride surpasse largement le système héritage, justifiant ainsi son déploiement en production.

= Conclusion
Ce stage m'a permis d'appliquer des concepts théoriques de Machine Learning à des problématiques industrielles critiques. Les résultats obtenus ouvrent la voie à une généralisation de cette approche à d'autres sous-systèmes de l'appareil.
