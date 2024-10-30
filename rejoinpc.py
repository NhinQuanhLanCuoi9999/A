import requests
import time
import os
import platform
from art import text2art

# Mã ANSI cho màu xanh và màu đỏ
BLUE = '\033[94m'
RED = '\033[91m'
RESET = '\033[0m'

def load_user_id():
    try:
        with open("config.txt", "r") as file:
            return file.read().strip()
    except FileNotFoundError:
        return None

def save_user_id(user_id):
    with open("config.txt", "w") as file:
        file.write(user_id)

def check_user_status(user_id):
    api_url = f'https://api.roblox.com/users/{user_id}'
    try:
        response = requests.get(api_url, timeout=10)
        data = response.json()
        return data.get('isOnline', False)
    except requests.ConnectionError:
        print("Lỗi kết nối: Không thể kết nối đến API.")
        return False
    except Exception as e:
        print(f"Lỗi khi lấy dữ liệu: {e}")
        return False

def is_roblox_open():
    if platform.system() == "Linux":
        result = os.system("ps | grep -i roblox")
    else:
        result = os.system("tasklist | findstr Roblox")
    return result == 0

def is_termux_running():
    return os.getenv('TERMUX_VERSION') is not None

def open_roblox(place_id):
    if is_termux_running():
        os.system(f'am start -a android.intent.action.VIEW -d "roblox://placeID={place_id}"')
    else:
        os.system(f'start roblox://placeID={place_id}')  # Dành cho Windows

def auto_rejoin(user_id, place_id, sleep_time):
    while True:
        if not is_roblox_open():
            print("Roblox không được mở! Mở Roblox...")
            open_roblox(place_id)
            while not is_roblox_open():
                time.sleep(5)
            print("Đã mở Roblox.")

        print("Kiểm tra trạng thái trò chơi...")
        if not check_user_status(user_id):
            print("Đã thoát game! Đang thực hiện rejoin...")
            open_roblox(place_id)
            while not is_roblox_open():
                time.sleep(5)
            print("Đã mở Roblox trở lại.")

        print(f"Chờ {sleep_time // 60} phút trước khi kiểm tra lại...")
        time.sleep(sleep_time)

def select_game():
    print("Chọn game:")
    print("1 - Blox Fruit (2753915549)")
    print("2 - King Legacy (4520749081)")
    print("3 - Meme Sea (10260193230)")
    print("4 - The Strongest Battleground (10449761463)")
    print("5 - PLS DONATE (8737602449)")
    print("6 - Pet Simulator (6284583030)")
    print("7 - Anime Defender (17017769292)")
    print("8 - Private Server Link")

    choice = input("Nhập số game bạn muốn rejoin: ")
    if choice == '1':
        return "2753915549"
    elif choice == '2':
        return "4520749081"
    elif choice == '3':
        return "10260193230"
    elif choice == '4':
        return "10449761463"
    elif choice == '5':
        return "8737602449"
    elif choice == '6':
        return "6284583030"
    elif choice == '7':
        return "17017769292"
    elif choice == '8':
        return input("Nhập link Private Server: ")
    else:
        print("Lựa chọn không hợp lệ, vui lòng thử lại.")
        return select_game()

def get_sleep_time():
    while True:
        try:
            sleep_time = int(input("Nhập thời gian ngủ (tính bằng phút, tối đa 89 phút): "))
            if 1 <= sleep_time < 90:
                return sleep_time * 60  # Chuyển đổi sang giây
            else:
                print("Vui lòng nhập thời gian dưới 90 phút.")
        except ValueError:
            print("Vui lòng nhập một số hợp lệ.")

if __name__ == "__main__":
    print(BLUE + text2art("Linear Rejoin") + RESET)
    print(RED + "Bản quyền thuộc về Dawn và Linear" + RESET)

    user_id = load_user_id()
    if not user_id:
        user_id = input("Nhập user_id Roblox của bạn: ")
        save_user_id(user_id)
        print("Đã lưu user_id vào config.txt")

    place_id = select_game()
    sleep_time = get_sleep_time()
    auto_rejoin(user_id, place_id, sleep_time)
