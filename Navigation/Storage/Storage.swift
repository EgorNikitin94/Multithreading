//
//  Storage.swift
//  Navigation
//
//  Created by Егор Никитин on 12.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

struct Storage {
    static let news: [Post] = [
        
        Post(author: "Apple News", description: "Apple представила новые Mac на собственном процессоре M1", image: "Macbook", likes: 9999, views: 99999),
        Post(author: "Rozetked", description: "Во «ВКонтакте» случился сбой.Сайт работает с перебоями, не грузятся сообщения и комментарии.", image: "VK", likes: 100, views: 1000),
        Post(author: "Programm Memes", description: "Я сначала не понял, но потом как понял) И действительно, это в своем роде день рождения для Unix", image: "mem", likes: 333, views: 4578),
        Post(author: "Reddit", description: "В японском городе Такикава на острове Хоккайдо для отпугивания медведей от человеческих поселений впервые установили робота «Монстр-Волк»", image: "Robot", likes: 99, views: 1099),
        Post(author: "Reddit Life", description: "Анонсирован новый MacBook Pro Apple обещает 5-кратный прирост производительности по сравнению с предыдущем поколением 13-дюймовых MacBook Pro на процессорах Intel. Работа на одном заряде составит до 20 часов. Ценник составит $1299.", image: "M1", likes: 876, views: 1935),
        Post(author: "Television", description: "Второй сезон «Ведьмака» пал жертвой коронавируса. По данным Deadline, производство было свёрнуто после того, как несколько членов съёмочной команды сдали положительный тест. Теперь все отправятся на двухнедельный карантин.", image: "Witcher", likes: 10, views: 2900)
    ]
}
