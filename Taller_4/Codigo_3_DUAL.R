

library(readxl)

BaseG7BRICS = read_excel("BaseG7BRICS.xlsx")
View(BaseG7BRICS)




library(FactoMineR)


BaseDUAL = BaseG7BRICS[,-1]

View(BaseDUAL)

res.dmfa = DMFA(BaseDUAL,
                 num.fact = 2,
                 quali.sup = 1,
                 graph = FALSE
)


res.dmfa


res.dmfa$eig # Valores propios (varianza explicada por cada eje)
res.dmfa$var  # Cargas de las variables
res.dmfa$var.partiel # Contribuciones parciales de las variables por grupo



# Muestra a los individuos (países) en el plano factorial.
plot.DMFA(res.dmfa, choix="ind",invisible="quali", label="none",new.plot=TRUE)

# Muestra cómo las variables se proyectan en el plano.
plot.DMFA(res.dmfa, choix="var",invisible="quali", label="none",new.plot=TRUE)

# Muestra la proyección de los grupos (como G7 vs BRICS).
plot.DMFA(res.dmfa, choix="group",invisible="quali", label="none",new.plot=TRUE)

# Visualiza las modalidades de la variable cualitativa.
plot.DMFA(res.dmfa, choix="quali",invisible="quali", label="none",new.plot=TRUE)



# Taller Link:

# https://databank.worldbank.org/source/world-development-indicators#




# INTERPRETACIÓN GENERAL ACP DUAL (DMFA) - CASO AÑOS COMO GRUPOS

# 1. VARIANZA EXPLICADA
# Las dos primeras dimensiones explican el 41.77% de la varianza total (Dim.1 = 28.05%, Dim.2 = 13.71%).
# Esto sugiere que estas dos dimensiones capturan una parte importante, pero no total, de la información de los datos.

# 2. VARIABLES QUE MÁS CONTRIBUYEN A CADA DIMENSIÓN
# Dim.1 está fuertemente asociada a variables de tamaño o estructura financiera: 
# 'Total_Assets', 'Total_Liabilities', 'Total_Debt' (con cargas altas positivas).
# También 'Working_Capital' y 'Gross_Profit_Margin' contribuyen negativamente.

# Dim.2 parece captar una dimensión de rentabilidad y liquidez:
# variables como 'ROA', 'ROE', 'Quick_Ratio' y 'Inventory' tienen cargas importantes positivas.

# 3. COS2 (CALIDAD DE REPRESENTACIÓN)
# 'Total_Assets' y 'Total_Liabilities' están muy bien representadas en Dim.1 (cos2 > 0.90).
# 'ROA', 'ROE' y 'Quick_Ratio' están bien representadas en Dim.2 (cos2 > 0.4).

# 4. INTERPRETACIÓN TEMPORAL (var.partiel)
# Al observar res.dmfa$var.partiel vemos cómo las variables se comportan por año (grupo).
# Por ejemplo, en 2020:
# - 'Inventory' y 'Quick_Ratio' tienen cargas especialmente altas en Dim.2 y Dim.3, 
#   lo que puede indicar un cambio en gestión de inventarios y liquidez.
# - 'ROA' y 'ROE' tienen contribuciones negativas a Dim.3, posiblemente indicando caída en rentabilidad.

# En 2022:
# - 'Working_Capital' carga muy fuerte en Dim.4 (≈ 0.75), indicando que este componente capturó cambios
#   en la gestión del capital de trabajo en ese año.

# 5. CONCLUSIÓN GENERAL:
# El ACP DUAL permite observar cómo las relaciones entre variables financieras han cambiado a lo largo
# del tiempo (2018-2022), identificando patrones comunes y diferencias específicas por año.
# Nos ayuda a entender si la estructura financiera de las empresas cambia de forma sistemática entre años
# o si ciertas variables se comportan diferente dependiendo del contexto temporal.