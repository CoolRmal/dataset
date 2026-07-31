# L. Grafakos, *Classical Fourier Analysis*, Theorem 2.2.14 (Fourier inversion, Parseval's relation and Plancherel's identity on the Schwartz class)

- **Source:** L. Grafakos, *Classical Fourier Analysis*
- **Domain:** Fourier analysis
- **Lean declaration:** `Dataset.GrafakosFourier.grafakos_2_2_14_fourier_identities_on_schwartz` ([grafakos_2_2_14_fourier_identities_on_schwartz.lean](grafakos_2_2_14_fourier_identities_on_schwartz.lean))
- **Criteria:** [grafakos_2_2_14_fourier_identities_on_schwartz.criteria.md](grafakos_2_2_14_fourier_identities_on_schwartz.criteria.md)

## Statement

**Theorem 2.2.14.** Given $f$, $g$, and $h$ in $\mathcal{S}(\mathbb{R}^n)$, we have

1. $\displaystyle \int_{\mathbb{R}^n} f(x)\,\widehat{g}(x)\,dx = \int_{\mathbb{R}^n} \widehat{f}(x)\,g(x)\,dx$;
2. (Fourier Inversion) $\left(\widehat{f}\,\right)^{\vee} = f = \widehat{\left(f^{\vee}\right)}$;
3. (Parseval's relation) $\displaystyle \int_{\mathbb{R}^n} f(x)\,\overline{h(x)}\,dx = \int_{\mathbb{R}^n} \widehat{f}(\xi)\,\overline{\widehat{h}(\xi)}\,d\xi$;
4. (Plancherel's identity) $\|f\|_{L^2} = \|\widehat{f}\|_{L^2} = \|f^{\vee}\|_{L^2}$;
5. $\displaystyle \int_{\mathbb{R}^n} f(x)\,h(x)\,dx = \int_{\mathbb{R}^n} \widehat{f}(x)\,h^{\vee}(x)\,dx$.
