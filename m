Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496FA29C33F
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898601; cv=none; b=I/b10tqDjKRbtWo2ciol5KqKN4BXriZ4lmc/b9O/1hJimkJkwhDiC4ZfBhKSudrcC98lrBaGYCGaBEU3y9IG+wyLsrqeIJ1zqM4vV62yLUt7SLtySje1YeoHbn7jlPQcgblGWFl/KUgWbjT5J0Um7hc6D4Fi6vJT0vW4/6AyMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898601; c=relaxed/simple;
	bh=qfKaMWmF0sxnjH+gu9kp51f1jwGLmJYv7TRXGRVBt0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJyBWv5YYBwJ62LDYvO18HakKcwy/7U6TI18Quavj4xcbS6WrTiee8fmcevTfsWJPMkk/fn8adKIo+IvvUmeccNBhyRU8ZfcsKeSOph74+NIKsXGkNAPOhmGuMJLsw8XmEwfhNQ9c/besGhJuQH76lMfMQaKeFcSwmWBIWTzTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWMaeJsr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWMaeJsr"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490ae0812c9so3431795e9.2
        for <damon@lists.linux.dev>; Sun, 07 Jun 2026 23:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780898599; x=1781503399; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ZSzr00MGkKxaluJZ1HWpON2lHxunjWudF+1j2Ezry4=;
        b=GWMaeJsruNdDzFwgxmKhvSS2hU0fPJkpEzhw0mVOV2euQ4dHcNzPsAxRSC6eQVkCGY
         8MSL/HgcrgH206yLKskw8c09sDsYyr15uXRdVWxmk3SB2fssK80dA7gwDxi9w+Moopjx
         tCfO7eFk6HWxYfzXXPagpl6IEItQ/acDIuNQXH2EgcoczCznH0caheJskmb91E59Wzax
         E5iBaZ5GYr5aAQNih3IDsKlPXGNCFqkVpxViSG7YhZqKFgyruaElsRaTVBhhSTz0PNmV
         nARz4RrvEo2xzH/NnRJxop/dF6PCjdz9VaMnLn1vRGH4Mv25UIrVG8HkrKb9I81z4yLD
         IW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780898599; x=1781503399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ZSzr00MGkKxaluJZ1HWpON2lHxunjWudF+1j2Ezry4=;
        b=dQ4M/DqZrNcg8Xa3p7JJHCaJyT6vo6NU3JiVjsMjuPdEGM/D3DKwnNCST1rbK/zU3V
         tAJgIoePr1/Znz9EU811AAoqZKafgV3K3e2efx+stOe5HZHGyxAq8Y9Hq56b7pCw+UJY
         B+YcT0RbgunxuD4wqXvJCTymHf8/SifEuj+vRTwrXvMG1MmQsrqu7l51/IbZJq14L3IV
         Na+XhYDdVV54YLCa8Lvcnh93y0QdXmkPMFmT40O6bfDsmP06iypz68kxtb9u++wFCJs5
         Evt/sWbBw+RqvIXWgN5yIdXtRmqrLeUs5003Ye32tM8Ekfu18F8n2vcWqc//CLYqptLv
         qzSw==
X-Forwarded-Encrypted: i=1; AFNElJ9Yvw+ckoHhWGmQ7Wpr7HtmxUu5xpiGD/kPTbUmoQvgMoO9sSAX9Vs3VlsyEvPyMLBTQ4HR+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYsGOW6Ul6mTODtx+qPYWeBjECw5Cuao3J24RnHdqq6XDs/Qbh
	c8CYvuxDQIuRxoYqIoRHepRhaj3MwRjludEU0py2HIlFbgceOIm7Ab8w
X-Gm-Gg: Acq92OGcmwFUTolBH7LYW9J218OV9vaPftLP/PLMIH/4jmWkDFAELRLnEw8hPXp49LS
	yCMoBAa7H4S4YE7V2hN8CDpKQg3FkwfizEK6sC4+X1N/1TphQe8tUWiufzumKPG6/MuyduOkbIJ
	DYQkzOsGsCPyO3i+xmzP9mXjGPAEingfdSiPQtZDWg9WGstUMf4xrD+42ivqGRB75FzAkpE0f23
	09QY1C4x+CSG64I978fRxL/mk5OvpQdMuhMkgEauNEMMZuD57JH2QMcEyl15g+McWzRYWBcIuAY
	7REa2Esb1mxjvpp/yC9BMqAXSLWeZcg7irZxWC35/x/57wdH4VCjns306bmAJkJOSUZq2t5Ghjr
	HcXVWqHqMnEauDHAzvXdh4UkkhXLkpl50XnXUDowytVL7QFYqj03GyD/6NFUZGd7elKlpIfhW4d
	A7oI3VtQ23luGvL3wSRg0reHQ/Pe2LilNsuwJalQawCFLMLCx4mOFwUis8ku1Djd7bXTXXtiZDz
	kkkeKAnVpX0SFrJNSR9VNRb25JlsN7dISPPAA==
X-Received: by 2002:a05:600c:3551:b0:490:b71f:2eb with SMTP id 5b1f17b1804b1-490c26220b7mr97147595e9.7.1780898598517;
        Sun, 07 Jun 2026 23:03:18 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm392992805e9.8.2026.06.07.23.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:03:18 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	SeongJae Park <sj@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	Doehyun Baek <doehyunbaek@gmail.com>
Subject: [PATCH v2 0/2] docs/zh: update DAMON usage sysfs documentation
Date: Mon,  8 Jun 2026 06:03:00 +0000
Message-ID: <20260608060302.1564003-1-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523094420.741003-1-doehyunbaek@gmail.com>
References: <20260523094420.741003-1-doehyunbaek@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
- Revise both commit messages to follow the translation update format
  documented in Documentation/translations/zh_CN/how-to.rst.

Doehyun Baek (2):
  docs/zh_CN: update DAMON usage Chinese translation
  docs/zh_TW: update DAMON usage Traditional Chinese translation

 .../zh_CN/admin-guide/mm/damon/usage.rst      | 56 +++++++++++++------
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 56 +++++++++++++------
 2 files changed, 80 insertions(+), 32 deletions(-)


base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.43.0

