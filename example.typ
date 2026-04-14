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

= Méthodologie et Architecture
== Schéma du Réseau de Neurones
Pour relever le défi des prédictions en temps réel, nous avons implémenté une architecture spécifique. Le diagramme ci-dessous illustre le flux de données entrant dans le modèle LSTM hybride.

#figure(
  // If you have a real image file, use:
  // image("data-flow-diagram.png", width: 80%)

  // Here is a stylistic placeholder so this code compiles immediately.
  // When you insert a real image(), it will get the identical look.
  block(
    width: 100%,
    height: 6cm,
    fill: rgb("#e2e8f0"),
    radius: 2pt,
    align(center + horizon)[
      #set text(fill: rgb("#555"), font: "Noto Sans")
      *DIAGRAMME PLACEHOLDER* \
      Remplacez ce bloc rect(dy: ...) par : \
      #raw("image(\"chemin/vers/image.png\")", lang: "typ")
    ],
  ),
  caption: [Diagramme d'architecture du réseau LSTM hybride développé pour l'analyse des séries temporelles.],
)

= Analyse des Résultats
== Métriques de Performance

#figure(
  table(
    columns: (2fr, 1fr, 1fr),
    align: (left, center, center),
    [Approche], [Précision], [Gains vs. Baseline],
    [Règles Statiques], [78.2%], [0%],
    [Forêt Aléatoire], [89.1%], [+10.9 pts],
    [Notre Modèle], [94.5%], [+16.3 pts],
  ),
  caption: [Synthèse des métriques de performance sur l'ensemble de test.],
  kind: table, // This is important to tell Typst this is a table figure
)

Comme illustré par les résultats tabulaires, l'optimisation a dépassé nos objectifs initiaux.

= Conclusion
Ce stage m'a permis d'appliquer des concepts théoriques de Machine Learning à des problématiques industrielles critiques. Les résultats obtenus ouvrent la voie à une généralisation de cette approche à d'autres sous-systèmes de l'appareil.
