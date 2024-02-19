# Studienarbeit II

Dieses Repository enthält die Codebeispiele aus der Studienarbeit: **"Vergleich der Parallelen Verarbeitung in den Laufzeitumgebungen Node.js, Deno und Bun"**

## Basics

Der Ordner "Basics" enthält Beispiele für jeweils Node.js, Deno und Bun um einen einfachen Worker Thread zu erstellen.

## Benchmark

Der Ordner "Benchmark" enthält die jeweiligen Implementierung für Node.js, Deno und Bun des Benchmarks aus der Studienarbeit.

### Ausführung des Benchmarks

#### Vorraussetzung

Für den Benchmark wird ein **Linux Betriebssystem** vorrausgesetzt.

Um den Benchmark auszuführen müssen die Laufzeitumgebungen installiert werden:

-   Node.js [https://nodejs.org/en/download](https://nodejs.org/en/download)
-   Deno [https://docs.deno.com/runtime/manual/getting_started/installation](https://docs.deno.com/runtime/manual/getting_started/installation)
-   Bun [https://bun.sh/docs/installation](https://bun.sh/docs/installation)

Außerdem wird für den Benchmark ein **separates** time Programm verwendet:

-   `$ sudo apt install time`

#### Ausführung

Zum Ausführen des Benchmarks kann das `benchmark.sh` Skript im Benchmark Ordner ausgeführt werden.

-   `$ cd Benchmark`
-   `$ chmod +x benchmark.sh`
-   `$ ./benchmark.sh`

#### Ergebnisse

-   Die Ergebnisse vom Benchmark werden im **"Benchmark/results"** Ordner abgelegt.
-   Für jede Laufzeitumgebung wird jeweils eine **$runtime.csv** und **$runtime_average.csv** erstellt.
-   Die **$runtime.csv** Datei enthält **alle 10 Testdurchläufe** für jede Threadkonfiguration.
-   Die **$runtime_average.csv** enthält dabei für jede Threadkonfiguration die **Durchschnitte der 10 Testdurchläufe**.
