//
//  MyCoreDataManager.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 06.12.2022.
//

import UIKit
import CoreData

struct MyCoreDataManager {
    static let shared: MyCoreDataManager = .init()

    private init() {}

    func saveGameToPicked(gameAPIModel: GameResponse, context: NSManagedObjectContext, completion: @escaping(() -> Void)) {
        let game = gameAPIModel
        let cdGame = CDGame(context: context)
        cdGame.guestTotalScore = game.scores?.awayScores?.total?.description
        cdGame.homeTotalScore = game.scores?.homeScores?.total?.description
        cdGame.homeTeamName = game.teams?.home?.name
        cdGame.homeTeamImageURL = game.teams?.home?.logo
        cdGame.guestTeamName = game.teams?.away?.name
        cdGame.guestTeamImageURL = game.teams?.away?.logo
        cdGame.countryCode = game.country?.code
        cdGame.status = game.status?.long
        cdGame.date = game.date
        cdGame.leagueImageURL = game.league?.logo
        self.cdSave(context)
        completion()
    }

    // MARK: Save Objects to Core Data
    func cdSave(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error while Core Data try to save Object")
        }
    }

    // MARK: Clear Database from Core Data objects
    func cdTryDeleteAllObjects(context: NSManagedObjectContext, completion: @escaping(() -> Void)) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDGame")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            completion()
        } catch let error as NSError {
            print("Error while Core Data try delete all objects: \(error)")
        }
    }

    // MARK: Delete exact Core Data Object
    func deleteCoreDataObjct(object: NSManagedObject, context: NSManagedObjectContext, completion: @escaping(() -> Void)) {
        // Remove the present
        context.delete(object)

        // Save the data
        do {
            try context.save()
        } catch {
            print("Error while delete one of the Core Data objects")
        }
        completion()
    }
}
