def img_pre(img_path, model_path):
    model = YOLO(model_path)
    results = model(img_path)

    # 只返回概率最高的类别名称
    return results[0].names[np.argmax(results[0].probs.data.tolist())]