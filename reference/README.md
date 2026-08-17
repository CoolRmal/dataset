# Reference PDFs

This directory holds the source textbooks behind the problems in `Dataset/`, one PDF per `Dataset/<Book>/` directory, and nothing else: no generated reports, and no book that does not back a `Dataset/` directory. Several of them are scans: seven have no text layer at all, and four more carry only a noisy OCR layer, so grepping for a theorem is unreliable and pages usually have to be looked at. The table below gives the offset between the printed (book) page number and the PDF page number, so a citation like "Theorem 5.1, p. 281" can be turned into a PDF page directly instead of hunted for. For a scanned book, render the page you want with

```
pdftoppm -r 130 -gray -png -f <pdfpage> -l <pdfpage> <file> <outprefix>
```

and open the resulting `<outprefix>-<pdfpage>.png`.

## Offsets

| File | Book | Dataset directory | Text layer? | PDF page = printed page + |
| --- | --- | --- | --- | --- |
| `Bogachev.pdf` | Bogachev, *Measure Theory* (vols. 1–2) | `Dataset/Bogachev/` | yes (digital) | **+16** (vol. 1) / **+526** (vol. 2) [^bog] |
| `BogachevGaussian.pdf` | Bogachev, *Gaussian Measures* | `Dataset/BogachevGaussian/` | OCR | **+13** [^bg] |
| `ConwayFunctionalAnalysis.pdf` | Conway, *A Course in Functional Analysis* (2nd ed., 2007 reprint) | `Dataset/ConwayFunctionalAnalysis/` | OCR | **+15** [^conway] |
| `EngelkingGeneralTopology.pdf` | Engelking, *General Topology* | `Dataset/EngelkingGeneralTopology/` | no | **+6** |
| `FollandHarmonic.pdf` | Folland, *A Course in Abstract Harmonic Analysis* | `Dataset/FollandHarmonic/` | yes (digital) | **+13** |
| `GrafakosFourier.pdf` | Grafakos, *Classical Fourier Analysis* | `Dataset/GrafakosFourier/` | yes (digital) | **+17** [^graf] |
| `HaymanMeromorphic.pdf` | Hayman, *Meromorphic Functions* | `Dataset/HaymanMeromorphic/` | no | **+12** |
| `KallenbergProbability.pdf` | Kallenberg, *Foundations of Modern Probability* (3rd ed., 2021) | `Dataset/KallenbergProbability/` | yes (digital) | **+9 … −15**, piecewise [^kall] |
| `KongODE.pdf` | Kong, *A Short Course in Ordinary Differential Equations* | `Dataset/KongODE/` | yes (digital) | **+12** [^kong] |
| `KrylovHolder.pdf` | Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces* (1997 corrected printing) | `Dataset/KrylovHolder/` | no | **+10** [^kryh] |
| `KrylovSobolev.pdf` | Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces* | `Dataset/KrylovSobolev/` | no | **+19** |
| `LeeSmoothManifolds.pdf` | Lee, *Introduction to Smooth Manifolds* | `Dataset/LeeSmoothManifolds/` | OCR | **+16** [^lee] |
| `MattilaGeometry.pdf` | Mattila, *Geometry of Sets and Measures in Euclidean Spaces* (1995) | `Dataset/MattilaGeometry/` | no | **+10** [^matt] |
| `NikolskiOperators.pdf` | Nikolski, *Operators, Functions, and Systems: An Easy Reading*, vol. 1 (AMS, 2002) | `Dataset/NikolskiOperators/` | no | **+13** [^nik] |
| `NivenIrrational.pdf` | Niven, *Numbers: Rational and Irrational* | `Dataset/NivenIrrational/` | OCR | **+9** |
| `NivenZuckermanNumberTheory.pdf` | Niven and Zuckerman, *An Introduction to the Theory of Numbers* | `Dataset/NivenZuckermanNumberTheory/` | no | **+11** [^nz] |

[^bog]: Two volumes in one file, each numbered from 1. Vol. 1: +16 through printed p. 441 (PDF 456), then +15 for the references/index. Vol. 2 begins at PDF p. 527 = printed p. 1 and is a constant +526 to the end.
[^bg]: Printed p. 347 is missing from the scan, so PDF 360–421 run at +12 (printed pp. 348–409); a duplicated scan of p. 409 at PDF 421/422 restores +13 from PDF 423 on.
[^conway]: +15 for the whole numbered body, printed pp. 1–389 (PDF 16–404). The blank printed p. 390 is absent from the scan, so the List of Symbols and Index (printed pp. 391–399) run at +14 (PDF 405–413).
[^graf]: Drops by 1 at several chapter/appendix openers: +18 for pp. 1–84, +17 for pp. 85–313, +16 for pp. 314–419, +15 for pp. 420–563, then +14 → +9 across the appendices and index.
[^kall]: Every chapter opens on a recto page and the blank printed pages between chapters are absent from the PDF, so the offset steps down by 1–2 at chapter boundaries and is constant within each segment: +9 for printed 1–78 (Intro, Ch. 1–3), +7 for 81–99 (Ch. 4), +6 for 101–123 (Ch. 5), +5 for 125–161 (Ch. 6–7), +4 for 163–183 (Ch. 8), +3 for 185–230 (Ch. 9–10), +1 for 233–253 (Ch. 11), ±0 for 255–295 (Ch. 12–13), −1 for 297–319 (Ch. 14), −2 for 321–365 (Ch. 15–16), −3 for 367–392 (Ch. 17), −5 for 395–463 (Ch. 18–20), −6 for 465–487 (Ch. 21), −7 for 489–554 (Ch. 22–24), −9 for 557–585 (Ch. 25), −10 for 587–659 (Ch. 26–28), −11 for 661–733 (Ch. 29–31), −12 for 735–799 (Ch. 32–34), −13 for 801–851 (Ch. 35, appendices), −14 for 853–917 (notes, bibliography), −15 for 919–946 (indices). Front matter is PDF 1–9; printed p. 1 = PDF 10.
[^kong]: +13 for ch. 1 (pp. 1–29), +12 for pp. 31–203, +11 for pp. 204–261, then +10/+9 for the bibliography and index.
[^kryh]: Body starts at printed p. 1 = PDF 11. Two scan irregularities: printed p. 80 is duplicated (PDF 90 and 91 are identical), shifting printed 81–85 to +11, and printed p. 86 is missing from the scan, restoring +10 from printed p. 87 to the end (printed 164 = PDF 174).
[^lee]: Constant +16 for the whole body and references; +15 in the index (from printed p. 602).
[^matt]: Constant +10 for the whole Arabic-numbered body (printed 1–343, PDF 11–353). PDF 1 is the cover; the roman front matter runs at −1 (pp. iii–v) and −2 (pp. vii–xii).
[^nik]: Cover = PDF 1; roman front matter v–xiv = PDF 4–13; printed p. 1 = PDF 14, and +13 holds with no drift through the whole body (printed ~461 pages, 475 PDF pages).
[^nz]: +12 for printed pp. 1–118 (PDF 13–130); printed p. 119 is missing from the scan, so +11 from printed p. 120 (PDF 131) to the end.
