AddCSLuaFile()
ENT.Spawnable= true
ENT.AdminOnly= false

ENT.PrintName= "Tribal Figurine"
ENT.Category= "Tribal Stuff" 
 
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
if SERVER then
        local materials = {
                "models/humans/male/group01/joe_facemap",
                "models/humans/male/group01/van_facemap",
                "models/humans/male/group01/vance_facemap",
                "models/humans/male/group01/ted_facemap",
                "models/humans/male/group01/sandro_facemap",
                "models/humans/male/group01/mike_facemap",
                "models/humans/male/group01/eric_facemap",
                "models/humans/male/group01/erdim_facemap",
                "models/humans/male/group01/art_facemap",
                "models/police/barneyface",
                "models/monk/grigori_head",
                "models/breen/breen_face",
                "models/kleiner/walter_face",
                "models/gman/gman_face_map3",
                "models/eli/eli_tex4z",
                "models/humans/male/group01/art_facemap",
                "models/magnusson/magnusson_face",
                "models/odessa/odessa_face",
                "models/humans/female/group01/chau_facemap",
                "models/humans/female/group01/joey_facemap",
                --"models/humans/female/group01/kanisha_facemap",
                "models/humans/female/group01/kim_facemap",
                "models/humans/female/group01/lakeetra_facemap",
                --"models/humans/female/group01/naeomi_facemap",
                "models/alyx/alyx_faceandhair",
                --"models/mossman/mossman_facemodels/mossman/mossman_face"
        }
 
        local sounds = {
                "vo/npc/female01/hi01.wav",
                "vo/npc/female01/hi02.wav",
                "vo/npc/male01/hi01.wav",
                "vo/npc/male01/hi02.wav"
        }
 
        function ENT:Initialize()
                self:SetModel("models/dav0r/hoverball.mdl")
                self:SetMaterial(table.Random(materials))
                self:SetMoveType( MOVETYPE_VPHYSICS )
                self:SetSolid( SOLID_VPHYSICS )
                self:PhysicsInit(SOLID_VPHYSICS)
                self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)
                self:StartMotionController()
                local phys = self:GetPhysicsObject()
                if IsValid(phys) then
                        phys:SetMass(10)
                        phys:Wake()
                        phys:SetBuoyancyRatio( 1.5 )
                        phys:EnableGravity(false)
                end
        end
 
        function ENT:PhysicsSimulate(phys)
                if math.random() > 0.9 then self:EmitSound(table.Random(sounds), 70     , math.random(200,255)) end
                phys:Wake()
                local figurines = 0
                local velocity = Vector()
                for key, figurine in pairs(ents.FindByClass("tribal_figurine")) do
                        if self:GetPos():Distance(figurine:GetPos()) < 2000 then
                                velocity = velocity + (figurine:GetPos() - self:GetPos())
                                figurines = figurines + 1
                        end
                end
                if figurines > 1 then velocity = velocity / figurines end
                phys:AddVelocity(velocity+(VectorRand()*100)-(phys:GetVelocity()*0.05))
        end
 
end