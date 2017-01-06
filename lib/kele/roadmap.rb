require 'pry'
module Roadmap

  def get_roadmap(roadmap_id)
    response = self.class.get("/roadmaps/#{roadmap_id}",
    headers: { "authorization" => @auth_token })


    #binding.pry
    JSON.parse(response.body)["sections"][156]["checkpoints"][0]["id"]
    #JSON.parse(response.body)

  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get("/checkpoints/#{checkpoint_id}",
    headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  def create_submission(assignment, link, checkpoint_id, comment, enrollement_id)
    response = self.class.post('/checkpoint_submissions',
    headers: { "authorization" => @auth_token },
    body: {
            "assignment_branch"=> assignment,
            "assignment_commit_link"=> link,
            "checkpoint_id"=> checkpoint_id,
            "comment"=> comment,
            "enrollment_id"=> enrollement_id
            })
  end

end
