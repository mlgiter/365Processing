// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Creature {

  ArrayList nodes;

  float diameter;

  // We initialize a Cluster with a number of nodes, a diameter, and centerpoint
  Creature(int n, float d, Vec2D center) {

    // Initialize the ArrayList
    nodes = new ArrayList();
    // Set the diameter
    diameter = d;

    // Create the nodes
    for (int i = 0; i < n; i++) {
      // We can't put them right on top of each other
      nodes.add(new Node(center.add(Vec2D.randomVector()), random(3,15), random(100)));
    }


    // Connect all the nodes with a Spring
    for (int i = 1; i < nodes.size(); i++) {
      VerletParticle2D pi = (VerletParticle2D) nodes.get(i);
      for (int j = 0; j < i; j++) {
        VerletParticle2D pj = (VerletParticle2D) nodes.get(j);
        // A Spring needs two particles, a resting length, and a strength
        physics.addSpring(new VerletSpring2D(pi,pj,diameter,0.0005));
      }
    }
  }

  void display() {
    // Show all the nodes
    for (int i = 0; i < nodes.size(); i++) {
      Node n = (Node) nodes.get(i);
      n.display();
    
    }
    
  }

  // This functons connects one cluster to another
  // Each point of one cluster connects to each point of the other cluster
  // The connection is a "VerletMinDistanceSpring"
  // A VerletMinDistanceSpring is a string which only enforces its rest length if the 
  // current distance is less than its rest length. This is handy if you just want to
  // ensure objects are at least a certain distance from each other, but don't
  // care if it's bigger than the enforced minimum.
  void connect(Creature other) {
    ArrayList otherNodes = other.getNodes();
    for (int i = 0; i < nodes.size(); i++) {
      VerletParticle2D pi = (VerletParticle2D) nodes.get(i);
      for (int j = 0; j < otherNodes.size(); j++) {
        VerletParticle2D pj = (VerletParticle2D) otherNodes.get(j);
        // Create the spring
        physics.addSpring(new VerletMinDistanceSpring2D(pi,pj,(diameter+other.diameter)*0.5,0.05));
      }
    }
  }


  // Draw all the internal connections
  void showConnections() {
    stroke(0,70);
    for (int i = 0; i < nodes.size(); i++) {
      VerletParticle2D pi = (VerletParticle2D) nodes.get(i);
      for (int j = i+1; j < nodes.size(); j++) {
        VerletParticle2D pj = (VerletParticle2D) nodes.get(j);
        line(pi.x,pi.y,pj.x,pj.y);
      }
    }
  }

  // Draw all the connections between this Cluster and another Cluster
  void showConnections(Creature other) {
    stroke(255);
    ArrayList otherNodes = other.getNodes();
    for (int i = 0; i < nodes.size(); i++) {
      VerletParticle2D pi = (VerletParticle2D) nodes.get(i);
      for (int j = 0; j < otherNodes.size(); j++) {
        VerletParticle2D pj = (VerletParticle2D) otherNodes.get(j);
        line(pi.x,pi.y,pj.x,pj.y);
      }
    }
  }

  ArrayList getNodes() {
    return nodes;
  }
}
