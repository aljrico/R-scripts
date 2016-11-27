# Els paquets que necessitem

require("quantmod")
require("nortest")

# Carreguem les dades del S%P des del 1950 (que son les dades més antigues de les que disposem) fins al 2016, fent servir la base de dades de 'Yahoo Finance'.

sp500 <- new.env()
getSymbols("^GSPC", env = sp500, src = "yahoo", from = as.Date("1950-01-01"), to = as.Date("2016-12-31"))

# Agafem la dada corresponent al preu tancat ajustat a dividends i splits

GSPC <- sp500$GSPC

# Visualitzem aquestes dades

plot(GSPC$GSPC.Adjusted, type ="h", main="S&P 500", ylim = c(0, max(GSPC$GSPC.Adjusted)))

# Calculem la diferència diària entre el logaritme natural dels preus i la visualitzem

lr <- diff(log(GSPC$GSPC.Adjusted))
plot(lr, main = "S&P daily logreturn", ylab="logreturn")

# Visualitzem un histograma de la freqüència d'aquests 'logreturns' normalitzat, obtenint una distribució de probabilitat.

hlr <- hist(lr, main = "Histogram for S&P daily logreturn", xlab="logreturn", ylab="normalized frequency", border="blue", col="green", xlim=c(-0.1,0.1), las=1, breaks=500, prob=TRUE)

# Això que veiem és una distribució normal? Si assumim la normalitat de la distribució de 'logreturns' com a null hypothesis, passem el test de normalitat de Anderson-Darling:

ad.test(lr)

# Si el p-value està per sota de 0.05, donem per rebutjada l'hipòtesi nula. i.e. la normalitat de la distribució.

# Podem comprovar que les dades tenen forats (NA values o missing values), per realitzar segons quines tasques això és un problema.
# Per emplenar aquests forats es poden realitzar diferents procediments, en particular a mi mi'agrada substituir el valor d'aquests forats per la mitja dels valors que sí existeixen, d'aquesta manera:

mean <- mean(lr, na.rm = TRUE) 
lr[is.na(lr)] <- mean

## Ara començarem a estudiar aquestes dades com una sèrie temporal.
# Primer hem de comprovar que les dades que tenim segueixen una sèrie temporal estacionària.

adf.test(lr)

# Per un p.value inferior a 0.05 rebutgem l'hipòtesi nul·la i done per acceptada l'hipòtesi alternativa, que en aquest cas és la estacionalitat de les dades. Dit d'una altra manera: Si el p-value és inferior a 0.05, la sèrie temporal és estacionaria.
# Volem ajustar aquesta sèrie temporal a un model ARMA(p,q), així que el primer que hem de fer és passar-li filtres de models ACF i PACF per valorar quina st tenim.

# Amb això veiem la funció de autocorrelació.
corr <- acf(lr, na.action = na.pass)
plot(corr)

# I ara veiem la funció d'autocorrelació parcial. 

pcorr <- pacf(lr, na.action = na.pass)
plot(pcorr)

# Amb això podem deduir que tenim un model ARIMA(4,1,0)

fit <- arima(lr, c(4,1,0))
dataf <- predict(fit,n.ahead=5000)
plot(dataf$pred, col=c(6,2), xlim = c(16820,16850))
ts.plot(lrs,dataf$pred, col=c(1,6))

