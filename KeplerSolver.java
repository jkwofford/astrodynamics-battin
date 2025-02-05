public class KeplerSolver {
    
    /**
     * Computes the expected number of iterations needed using the formula.
     * @param M Mean anomaly in radians.
     * @param e Orbital eccentricity.
     * @param tol Tolerance for convergence.
     * @return The expected number of iterations (rounded up).
     */
    public static int computeExpectedIterations(double M, double e, double tol) {
        return (int) Math.ceil((Math.log(tol * (1 - e)) - Math.log(M)) / Math.log(e));
    }

    /**
     * Solves Kepler's equation iteratively and prints each step.
     * @param M Mean anomaly in radians.
     * @param e Orbital eccentricity.
     * @param tol Tolerance for convergence.
     * @param maxIter Maximum number of iterations.
     * @return The estimated value of E (Eccentric anomaly).
     */
    public static double solveKepler(double M, double e, double tol, int maxIter) {
        int expectedIterations = computeExpectedIterations(M, e, tol);
        System.out.println("Expected iterations needed: " + expectedIterations);
        
        double E = M;  // Initial guess
        System.out.println("Iteration 0: E = " + E);
        
        for (int k = 1; k <= maxIter; k++) {
            double E_next = M + e * Math.sin(E);
            System.out.printf("Iteration %d: E = %.10f%n", k, E_next);
            
            if (Math.abs(E_next - E) < tol) {
                System.out.println("Converged in " + k + " iterations.\n");
                return E_next;
            }
            
            E = E_next; // Update E for next iteration
        }
        
        System.out.println("Did not converge within max iterations.\n");
        return E; // Return last computed value
    }
    
    /**
     * Unit test for quick convergence (low eccentricity).
     */
    public static void testQuickConvergence() {
        System.out.println("Running Quick Convergence Test (e = 0.1)...");
        double M = 1.0; // Mean anomaly in radians
        double e = 0.1; // Low eccentricity
        double tol = 1e-6; // Convergence tolerance
        int maxIter = 20; // Max iterations
        
        solveKepler(M, e, tol, maxIter);
    }

    /**
     * Unit test for slow convergence (high eccentricity).
     */
    public static void testSlowConvergence() {
        System.out.println("Running Slow Convergence Test (e = 0.9)...");
        double M = 1.0; // Mean anomaly in radians
        double e = 0.9; // High eccentricity
        double tol = 1e-6; // Convergence tolerance
        int maxIter = 100; // More iterations needed
        
        solveKepler(M, e, tol, maxIter);
    }

    public static void main(String[] args) {
        testQuickConvergence();
        testSlowConvergence();
    }
}