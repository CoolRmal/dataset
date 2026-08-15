# Reference PDFs

This directory holds the source textbooks behind the problems in `Dataset/`, one PDF per `Dataset/<Book>/` directory, and nothing else: no generated reports, and no book that does not back a `Dataset/` directory. Several of them are scans: four have no text layer at all, and five more carry only a noisy OCR layer, so grepping for a theorem is unreliable and pages usually have to be looked at. The table below gives the offset between the printed (book) page number and the PDF page number, so a citation like "Theorem 5.1, p. 281" can be turned into a PDF page directly instead of hunted for. For a scanned book, render the page you want with

```
pdftoppm -r 130 -gray -png -f <pdfpage> -l <pdfpage> <file> <outprefix>
```

and open the resulting `<outprefix>-<pdfpage>.png`.

## Offsets

| File | Book | Dataset directory | Text layer? | PDF page = printed page + |
| --- | --- | --- | --- | --- |
| `Bogachev.pdf` | Bogachev, *Measure Theory* (vols. 1–2) | `Dataset/Bogachev/` | yes (digital) | **+16** (vol. 1) / **+526** (vol. 2) [^bog] |
| `BogachevGaussian.pdf` | Bogachev, *Gaussian Measures* | `Dataset/BogachevGaussian/` | OCR | **+13** [^bg] |
| `EngelkingGeneralTopology.pdf` | Engelking, *General Topology* | `Dataset/EngelkingGeneralTopology/` | no | **+6** |
| `FollandHarmonic.pdf` | Folland, *A Course in Abstract Harmonic Analysis* | `Dataset/FollandHarmonic/` | yes (digital) | **+13** |
| `GrafakosFourier.pdf` | Grafakos, *Classical Fourier Analysis* | `Dataset/GrafakosFourier/` | yes (digital) | **+17** [^graf] |
| `HaymanMeromorphic.pdf` | Hayman, *Meromorphic Functions* | `Dataset/HaymanMeromorphic/` | no | **+12** |
| `KongODE.pdf` | Kong, *A Short Course in Ordinary Differential Equations* | `Dataset/KongODE/` | yes (digital) | **+12** [^kong] |
| `KrylovSobolev.pdf` | Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces* | `Dataset/KrylovSobolev/` | no | **+19** |
| `LeeSmoothManifolds.pdf` | Lee, *Introduction to Smooth Manifolds* | `Dataset/LeeSmoothManifolds/` | OCR | **+16** [^lee] |
| `NivenIrrational.pdf` | Niven, *Numbers: Rational and Irrational* | `Dataset/NivenIrrational/` | OCR | **+9** |
| `NivenZuckermanNumberTheory.pdf` | Niven and Zuckerman, *An Introduction to the Theory of Numbers* | `Dataset/NivenZuckermanNumberTheory/` | no | **+11** [^nz] |

[^bog]: Two volumes in one file, each numbered from 1. Vol. 1: +16 through printed p. 441 (PDF 456), then +15 for the references/index. Vol. 2 begins at PDF p. 527 = printed p. 1 and is a constant +526 to the end.
[^bg]: Printed p. 347 is missing from the scan, so PDF 360–421 run at +12 (printed pp. 348–409); a duplicated scan of p. 409 at PDF 421/422 restores +13 from PDF 423 on.
[^graf]: Drops by 1 at several chapter/appendix openers: +18 for pp. 1–84, +17 for pp. 85–313, +16 for pp. 314–419, +15 for pp. 420–563, then +14 → +9 across the appendices and index.
[^kong]: +13 for ch. 1 (pp. 1–29), +12 for pp. 31–203, +11 for pp. 204–261, then +10/+9 for the bibliography and index.
[^lee]: Constant +16 for the whole body and references; +15 in the index (from printed p. 602).
[^nz]: +12 for printed pp. 1–118 (PDF 13–130); printed p. 119 is missing from the scan, so +11 from printed p. 120 (PDF 131) to the end.

## Books in `Dataset/` with no source PDF here

- `ConwayFunctionalAnalysis`
- `KallenbergProbability`
- `KrylovHolder`
- `MattilaGeometry`
- `NikolskiOperators`
