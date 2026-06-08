Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B361037204E
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 06:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901876; cv=none; b=QA6AGJBTttrC+kp5eIIFK9cuIghJyNU8Moo/Hvn0MhX6ejtoo+SroMogWIBvN+uwP1t+2/S5APQgzVOOjNMEblrkRkSUrqdULpoa9KqS7BCvRHz44nUsJQuL68Izr6UsItW75oaVwJLfoA+7rMxE1SXpL84qlnPDmm70PdgGWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901876; c=relaxed/simple;
	bh=4qchsheXtUN9lVoh9GlKQ7z1L47obZCT1Z7CnuIlt0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onERG7QnNHvWuAztFCgxrEzR9e5zQ9Z1S+YziTHmTZbeUMm4V5JFp5dzPndtE1VK0Fp5RyUAacFh7P7XKP4tSuPAbCLrr9ATCpLb1u5Cm4wT01EWm++KuRHyfeX8ZtGiNeZBZwBGjKIL02KLPKYWSEaTcxdHU8GHOXCtXFfi46c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYT+dETA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYT+dETA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a762c8d5so4403175e9.0
        for <damon@lists.linux.dev>; Sun, 07 Jun 2026 23:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780901873; x=1781506673; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ubq42riN1El7PoCOC8HhM4UEVQCQTgOWtnuKwiB/z8=;
        b=VYT+dETAF0x4wYQM900SlUBW/kRdDGAwtawY8XaYEtXrSCulyWdrUClNQ9QFb8ea4b
         T5D2RPaKN/gNafMlPA0p45fon1DH+oDNpUEAKn3gyZ5uPadG8SZIbthJlA9S0qrmexCm
         mWmG8FpdGIFWLdWccoXYEx3u14MeSvWnkJVZuejttdUWyAbM1D7XKAz1Lv+GC7Ij9mSu
         955mTJerMwLpeiQDa1m2MmK4LxX4gUey86cA6Z9VzIuO7B6hkFQZNZ/NLGpwMUMW2Wq5
         rf8AJWngJZT+3Wx/V4HR5wkrfZ4Qxs/o63zqsTSL6xNmBSJAJ9FE7oQ8R/yoLEVqjDl8
         aNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901873; x=1781506673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ubq42riN1El7PoCOC8HhM4UEVQCQTgOWtnuKwiB/z8=;
        b=M5trX8rkyAPxDoZ5EUqoIOhfjNLLeqXcJb4diUxzytSH20wLyAG3DTgDkY0vXnukNS
         iylWZ+ySHeRuCEB7Mw4pkQK7xQ3dH64shIJfQg6SQMOptGVMQeZv+5vvHva0RA8VfGHB
         SXda7t7HjbAwGjsYl3gbT7UGhr1mWWyZojzno6uRGF1ychch6e5jw9XZRDOD94E3cpg/
         GcmOR8Q3jsfbUEoPz/aWl2v7YEXwSIVwe5PWEcnc6D/GiDS+hYst+7k+b23c0ISl3VZT
         Exv8St8QB9eHNcBQ4Oo6tVYoPsBYWwWL9W2qIKNu08JvjuKnqX1NvDqHY/gYDJ6zGXFL
         oV+w==
X-Forwarded-Encrypted: i=1; AFNElJ+rHi+I0369FOLxu3Am8o/QXKQ52Ea5uN80jCIeJr5rIACnSInTtp7M+B2Xq5uqi99ENnvnCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWmK1ObQ+SVrPE3YQU9NU+199Mu3O+OefHq3RaAdEVd0V88+WE
	Z107s3zV9jnxHPthTE44qa/dqUOD28WXcEGrbiCK1IjWNvHIbeMXzi7P
X-Gm-Gg: Acq92OESFwd7kFj3NrWdf4cGQDdTwO6hiZpQp8h95HSmWQWvS2nDAgMksIkH37ycBrc
	+encWvbOpt2dp2sW7bIXPsrkLkYdhDLAGWZlV1UwrA93IdvG8Zb/OCqydwVrvP6pyuqhqm6qhBT
	21NRhi/FCSLhbnzcm9n4kOVOv5M0h2sMYSrJbhhilBbTuE4fC5VdvkseDuSRLez4v+hOC4uls/F
	VOhygLheoV4zPc5BU9PmRQFvnWlzHAwZWsD98Olm4SZWY3diqgvyPiXbT03T2mL8+w1ZtSRAd66
	fU4SiqGsgy+ZrCbYnrAPvDmrC5l2B6fypUFvTmRc+s/2zhfQYwIxdjnKSyfV4aBnFOobsedsbPQ
	B7tQbUaQT135/BRoh+dMWre+Xq8Z6xkXNHLU/7kFiVR+gwrMLVQZ5SNCl6xn9uyvrVq3BKQnBxP
	kVPb3et/DeoMChY2tRLF5vJ4XmFbA8caZWtgLFP5G24inkdRbKM/ACj0PFJH7NgWjWAXTEVYB29
	eJ4z+NILV3+I1opdD+LSVhXGcdKFyt6Q6JcHQ==
X-Received: by 2002:a05:6000:1ac5:b0:448:8796:9c1e with SMTP id ffacd0b85a97d-4603019c601mr10555818f8f.0.1780901873053;
        Sun, 07 Jun 2026 23:57:53 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm89908194f8f.29.2026.06.07.23.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:57:52 -0700 (PDT)
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
Subject: [PATCH v3 0/2] docs/zh: update DAMON usage sysfs documentation
Date: Mon,  8 Jun 2026 06:57:43 +0000
Message-ID: <20260608065745.1587885-1-doehyunbaek@gmail.com>
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

Changes since v2:
- Fix missing DAMON sysfs hierarchy entries and related file lists/counts.

Changes since v1:
- Revise both commit messages to follow the translation update format
  documented in Documentation/translations/zh_CN/how-to.rst.

Doehyun Baek (2):
  docs/zh_CN: update DAMON usage Chinese translation
  docs/zh_TW: update DAMON usage Traditional Chinese translation

 .../zh_CN/admin-guide/mm/damon/usage.rst      | 92 +++++++++++++------
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 92 +++++++++++++------
 2 files changed, 130 insertions(+), 54 deletions(-)


base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.43.0

