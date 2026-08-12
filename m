Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F953398910
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517968; cv=none; b=bAZC/s25vyPG9XgTNLLLFgppwBM1BSm8512+7xMMxykeVOrA4wpZjQ55c/yu/XJQOEEfYezPD3W/8AxUhqaxEC2FbRDJdv3/EW8dAvpXHDyUVjK+tdhGKhyt7amMg9E6c0t+3uBOpkQ9t0y0aEaOn5tVBfj4ChDYMnTdMh7dhT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517968; c=relaxed/simple;
	bh=WIAuDm5KWKeCXbUA7qblf7Ti3VLEdPQOqG/N3pB7uF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AfuJ9K1ssAfoOqfDxmBWO4Ch8QNSB02liKphU0oyB4bpnnXPmbNbCyTTs5A6X+CbBJZlwuye4qXVHd25cykKEeGzS8z9HFIihjPiNMP6UUkqTxzuYRJLXNjSwRbhqL9+makShVZs3nTkHnj+AasyDheuH6F3DQ2WVAkP5F5DjPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLMB778+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLMB778+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4955c545a94so127795e9.3
        for <damon@lists.linux.dev>; Tue, 11 Aug 2026 23:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786517963; x=1787122763; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jYLC+//as5WkDB9Cfqs3UoupJV7njGedAREDeXd0kB8=;
        b=eLMB778+ogJ7K4TPyl4in8azC2Yy6RnhjzPQDmWqTgPyewvahcX9Hzhdl5nOZzsMP8
         R7DkNZEw7cKUir9e+l8tpAK4gYKW1M/2YoLufgBPvIXcq4/R2nJSKBGMQrpdqvM3UOk7
         e+DbtOQVPMdVWAxfZj9QXoJjh3/BBwCvktJn92778zfMTbC7AzYC7hBYC0DaZMtJJlJp
         TKRJJaJw0SB8ojN/apKLFuurXycSjQHaoXN4B5W19UiQCOUhm/+vbJje0vU20ScU+JO7
         h0PUMhYhHJuyPc7u3/SLspPVXii+3QbgqkE8xT8Wzg3Yn2mEWkJkdyh5MbbfXNyJoUNK
         sotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517963; x=1787122763;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jYLC+//as5WkDB9Cfqs3UoupJV7njGedAREDeXd0kB8=;
        b=Ptxv6rCJ8K9v9fV/DKIQQ1fK/60ATUle45iWxAlVau00D4wFg2bjYFtzNsiSZICY9J
         u1THRLlqZdUmyVom3pSEW3wFY/KD2MV24gNuTcaFWFTCkv37hUrVlc8+/leqFdIYZJF4
         PhMocsafujUvLtMCH+0Ko6CSJ4c2TM2V7lzQzUl5IlT+/qRKlJR+cV6xukxQ4S2WgGzG
         lmIleTROkO23dmj8XheZ2aZfW9+Og0PFH4ZBKECKuIMGy8q6zat4zpWl0uzIfGcHdPRq
         +9A/kFGah8ZydEXoC2Sw753Cfh0FKErNHCJUai5QpIYKScGU7G5gOrqbR+7dobXvPI1F
         k45A==
X-Forwarded-Encrypted: i=1; AHgh+RrMDz0ZyNaBszquRNvTZt0S/UZBpOMZpnWXcPeL0Q34oK6i9a9Ly/AjSr2JSy6w0b9GA0EVSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHeNCH2AsAyM5OLISkgT7WIZQNleL6UcudZQ+CWiLjz7Yt4ONt
	qJZJQVR8Ts1RhmCr4iC7hf7zdD8Y6/yUfoZpnk8Jk4c1P6uFrGimSGx8
X-Gm-Gg: AR+sD10MukRIPyeLm4mS9kiJeNG2OW+LjDn9zUWDIw708K/ggmldknAvN3jSdspDc1Q
	mRjhv+Z11ECas+ACNdBsVRmDdHpHZChNgQ/E9wsOOFMEjLNOWNlItdxklw+3hYsgt0Eva49sEh2
	8kT+pc/lSep69eYHaEHVVqnGvFr0Q35QZsadnG/Kjd5YWCg2iPQA45tvOz7rTX4xk0Zx9T5C8RW
	Wy7kvpg5MBv5N8BHErF70Vb/CDeoOXXRgzIBrUM8rsH+ClkEo2X4D7dMdpdPRn/rj1Tbr20OD8a
	JnpZlGPa063DKGZD95LmB10b6ope+PuiEvedJz/BlEbwWgajJTKXgQyJS/J8S6YLS8G8lWGhfrM
	QDXSUGq5pnsG+55BFexb0MZrbuglJ0ibN6vsRhHDtkO9NOL+lmh4lZe7Ccn4UfJAlx4j4VEG/bT
	bdlGtMClr3uvmTHM6joWv7IwTmbLQ/jggFtfvDKT+MxWWehV13v48YH2TRPHNkpw51nQ24oBse4
	6SFv4TqA/ZL5VRAxzAfLfxkKd58Jxp5TfamvQBEV/dC3bMoyNXJgqfMXRlqYCXGpUh00YSIsrGt
	JmM+tmk9Q6K5pz9M5+9OJYz/Pm8Umh0Yu43Xbna1uq2MUA==
X-Received: by 2002:a05:600c:1f82:b0:496:bbce:ef with SMTP id 5b1f17b1804b1-4997c15bc31mr16199015e9.3.1786517963083;
        Tue, 11 Aug 2026 23:59:23 -0700 (PDT)
Received: from doehyun-dev.pradel.rg.cispa.de (x06.xlate.fw.cispa.de. [195.37.157.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b15b807sm73628005e9.7.2026.08.11.23.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:59:22 -0700 (PDT)
From: Doehyun Baek <doehyunbaek@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Cc: Doehyun Baek <doehyunbaek@gmail.com>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/7] docs/zh_CN: update DAMON documentation translation
Date: Wed, 12 Aug 2026 06:59:04 +0000
Message-ID: <20260812065914.3071433-1-doehyunbaek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bring the Chinese DAMON documentation translations up to date.  Update the
DAMON design and administration-guide translations, and add the DAMON_STAT
usage translation.

Changes from v6:
- Clarify the DAMOS quota goal descriptions for the optional ``nid`` and
  ``path`` parameters.
- Improve the translation of "offload" and fix the duplicated character in
  the non-access-pattern filter description.
- Consistently translate "tracepoint" as "跟踪点" throughout the series.
- Consistently use "监测上下文" and "聚集间隔" for DAMON terms.

The changes were suggested and clarified by Dongliang Mu.

Doehyun Baek (7):
  docs/zh_CN: update DAMON design translation
  docs/zh_CN: add DAMON_STAT usage translation
  docs/zh_CN: update DAMON index translation
  docs/zh_CN: update DAMON start translation
  docs/zh_CN: update DAMON usage translation
  docs/zh_CN: update DAMON reclaim translation
  docs/zh_CN: update DAMON LRU sort translation

 .../zh_CN/admin-guide/mm/damon/index.rst      |  15 +-
 .../zh_CN/admin-guide/mm/damon/lru_sort.rst   |  68 +-
 .../zh_CN/admin-guide/mm/damon/reclaim.rst    |  82 ++-
 .../zh_CN/admin-guide/mm/damon/start.rst      |  63 +-
 .../zh_CN/admin-guide/mm/damon/stat.rst       |  94 +++
 .../zh_CN/admin-guide/mm/damon/usage.rst      | 523 +++++++++++---
 .../translations/zh_CN/mm/damon/design.rst    | 667 +++++++++++++++++-
 7 files changed, 1346 insertions(+), 166 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/damon/stat.rst


base-commit: db6ed2a3d31068ca5577466591b2521dee0508ca
-- 
2.43.0

