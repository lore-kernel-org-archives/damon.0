Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308712E737E
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267426; cv=none; b=Er5UuIGPB5XltH+f/KmQSRejOtptrLS+jss1zXyYZJub9+L72K9Vp85lgqdT4DZNf+NSfMHlTpYa8HXTOAwxl8mp+RlPDEK/+XgDrRSET5wKVpM2tV/Hqc1M0EfjWfNI9vf0HIl9wlFLQB2B9KIh4JXEWl1A0Ytq10s8AbnoJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267426; c=relaxed/simple;
	bh=kxSqByyeQG8x8Q3nvxMnhN6h3epnkIv8HdewAakEGSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sMUicdYw+kXmcEncTLsPFA6YMDI+vl/Di+NfIk+Cw2EsxJhK6GiJnG9FT3pwVuUHH8qEHUr/dqenqBgVsWdmvz7r3AOKfDVaKZMOB4IEVDYSyBq2zVzp0rLWdvdCWTupQumO+SERA7fkBvLVVHUxQU7RIsqF7TUAXT59++6T5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pKh8FgAJ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKh8FgAJ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so92852a12.3
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 23:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791267424; x=1791872224; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3jlBcrEL7AxGWXF4qOYzXsJylUauI2sPDbkv+5OBUgw=;
        b=pKh8FgAJny4LcLHm0q4okGYea5RzRlgrJf/llRrxUdp7Eo6J+QxNdHEXIcEVEhhgAk
         tFE2UI8VXwKh3iCrxihnCH/aJGBM9O4sNaCGbESJwvydiFY+oh39po7XuzbdGRAHoVcQ
         m+GfOpW9dcbIZaFqlHJ97XLivE540BCyOSZVbXFp+0dZBYzg94MQb90nc4Z5fB5x8QWB
         kzh3CfRuJJQM2IoZIb8gE6jSiOEvqPLrCktUn5C8wMGQwWPi26iFlUrqduCCjT+qSM+Y
         vkXF/2kYqpD6+K4mGZfonNzdDV/Rg3V2qsoAYl2mi4gSKkOvvJRp2wEDwfFvyNILNJ3q
         T+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791267424; x=1791872224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3jlBcrEL7AxGWXF4qOYzXsJylUauI2sPDbkv+5OBUgw=;
        b=ift5+KI4NREopyPn+Z16Ldgg8Xryy5YF11O5PUWxvjX+L5tm7NrbPuiV1v4pgRuSMH
         tCDkX5ZuejCYjkLZbRcPpF3uw1ZMv2Zi8CspTIQZ6UyHrDw3NjRyFogTWsoBE2gmrZ4e
         vTrIZpfejAkoCHlquZfbd49fKalQJ2hw3ZKBRzz3NOarnlf0+7cX6nycOxR1o5LO5LHS
         Xz9fLMlULrR+rksEqxuf3lBQaQeRLO8kMM8enbPnH87q5WBk1oWIPS1DID/NaUVxJGwv
         Z6iBwNSJ3dRnXd34heyfdg9UsS8JdJAIhb2ThitYoWe2HAaUXFznlOh2EBA5o7rFUoNk
         tR/w==
X-Gm-Message-State: AFq9FYL8R/ASj3cScO4f0mRGpzwxX+SgytkAIS7qdihX+xPWjGeg0xPn
	gINkxuFXyvLHX1sV3uNNttKfLlArMVMeGevsbC2Ic+2yYyRPeKfqifLW
X-Gm-Gg: AYBFou31nLQzK+rsSkHJLeGXit0oDqXnrI1T1Fj9PTt5td9JehJlzRDJ7Wu2EanLGtF
	ExIh/9khCRBh+hfpmxtCiy3BxTk8XjU/aU1PmqgAUhsPBOiYSB5hZKIhMqkG30Wm6dGMTwoQwMS
	L7XpU/ERvgUIztXuh47bAlRDqnahONcds7Ep+D9Xy5pLLC7tB5GKPVLL9m8TtPuFpW5qH5oXdQ0
	jBqY2SzqjHEWvFkzdytf1WFtPNeOtfGQ+oLtFl4Dyq87r9taKwRFr3XJkLISchliQO+n3i6PumG
	zbFmpMj+IZjB5nsXzaxIswgmK/fH25T9obl1qQFTEPM9JYcdE7jn9l+7gEk3SRpbydbuS+SEx/c
	4wyKI5DvqPDsNA1MURbxo55I6hI/xvRB0XgYzW7xw8bEYfDfIIKCTN1Qv2SQRRhK9IyUKlK80Z7
	GncZAPxjrw/2qS0SkTQoG7GTJCwY54Arl9e4dV2g60JFX3AVlX9uS+qiUxqviZp12gEht7eEzcN
	4A5yZQ4C+YUyop1ph5AfsoAUNFSiX/oTxQVqsDyHLtQQroixZSRCT+S4Amkgu0T1z3lKSw1YMlM
	A6iy330v843aFjcJ
X-Received: by 2002:a17:90b:4a47:b0:3a0:9640:8043 with SMTP id 98e67ed59e1d1-3a873517b39mr304141a91.15.1791267424571;
        Mon, 05 Oct 2026 23:17:04 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (61-221-208-111.hinet-ip.hinet.net. [61.221.208.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533aba95sm3662789a91.2.2026.10.05.23.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:17:03 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 0/3] Docs/admin-guide/mm/damon: Minor fixes
Date: Tue,  6 Oct 2026 14:15:46 +0800
Message-Id: <20261006061549.627-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small patch series fixes various typos, copy-paste mistakes, and an
incorrect command syntax in the DAMON documentation files.

Adrian Huang (Lenovo) (3):
  Docs/admin-guide/mm/damon: Fix various typos
  Docs/admin-guide/mm/damon/lru_sort: Fix copy-paste mistakes
  Docs/admin-guide/mm/damon/usage: Fix incorrect option syntax in perf
    example

 Documentation/admin-guide/mm/damon/lru_sort.rst | 6 +++---
 Documentation/admin-guide/mm/damon/reclaim.rst  | 4 ++--
 Documentation/admin-guide/mm/damon/start.rst    | 6 +++---
 Documentation/admin-guide/mm/damon/stat.rst     | 2 +-
 Documentation/admin-guide/mm/damon/usage.rst    | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.43.0

