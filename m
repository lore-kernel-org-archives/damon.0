Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22B400978
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529084; cv=none; b=DBiZNwzJ0RBQ01esoBIAFwgE8Jm3x5a7LgWvSc+dwnmjNpdJx4uZsG36K1rhc791jpR3qhp/nVdwcB/Oi4eAbdO6Y26wcehoiouPldiBw/QIbblw2szAi9lEqpXXdXpuNCungUq1ZbOfWyZWwQkoBWgLZH5/i9mbAa+GdT57sT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529084; c=relaxed/simple;
	bh=qDTWo32iEis5B5EikwCAmCw2XSqTDoKs39jdS5gj1yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/HS8K+NzQ9vbR5Ea4QMaEeoCFkWdBnCVB92R1U+PeXfxUnee7nX/5nxo26IJ++f16zVuH0LnKUIa/LfvTNsfMfYNCTrpDj1NUO0C4QK6YMg4xJqDrjSynMnBimC6xZyZZLwQMe6d7Ma9wI34NVgTluDK01PA7ye/4c19/qBCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLuUGe4I; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLuUGe4I"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e7391839cso677195a12.0
        for <damon@lists.linux.dev>; Wed, 12 Aug 2026 03:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786529082; x=1787133882; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w1Amz75UuSYEUv3v4aAO3alBAyuVKiTqpSzrEm2VkvA=;
        b=mLuUGe4Il0eFT/46AAER4hwjsrk+zSSH4l+fvqDF0oEWdDNKgCgrLLhg+vt+uHe8y+
         G5Eh9ydNqm/heWYyif5jbyem8EsRI/6IzTofXoiSK5f9GXHavRrq5O1UOVaabYUDwYNJ
         hxX765aVRnoSnms++hQaC9BJ2ZE1XS2o/txbUu61jl/WzVLqvk1LPvhe1kL9eGVRaodb
         hkwe0G3FhkUb3ecshQ3yLB72Dj8Q9GMbhkFpFDKEiexycgZRqMWXJKIDzcY8LaNVzdqD
         yT8r/UNFNTKW7u9xeJDAyla4SuWABuMtjisg3dTJnrKXug64gi2VO5G9esp3ROrdj3M5
         Bb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786529082; x=1787133882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1Amz75UuSYEUv3v4aAO3alBAyuVKiTqpSzrEm2VkvA=;
        b=EFOpEyKjkdSnmxsh8tHAwAxiRVzP8fmLr7wM1iipKPB7qBxEuglyODHVpOSKqcURXN
         xOLVpFEWEj/p4C3JFrU2YvAjRXJkGl/DE0xSRqYItxqpIdjDqmrvm95KMIMmLf+56MZ7
         E27ryYVxOAKfNhnXv0f4iq+lmCLDmuv66Yek/kjzgMRSEOcUX5AI9Ol/4/8GX/UI5/mi
         HtA/ubxjep9SGMGEz0RgApQ07CQYCDX14p96yGa5tewj/2FRoMAyp/aRz8m6GGmuU2Vf
         xUBO/uPJY/VxhMNw8eYNDsw7xZBatE786kKwbmj4BiWc69tm0xgW1WXT0NDgRE67+1f7
         LnGA==
X-Forwarded-Encrypted: i=1; AHgh+Rrr0tYI/9A7lgrBYDBtVwFNTvmm2cKD4VBrFSOigGDlktjsGE844cUJ+EFCHKjf7h2s8Pp7ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkvOFNSsnsTwMvgJ7mpMi9Zv0NW/Ly449KuW/GBUySa15sgAUu
	a9X9GqOX945ZDIB2NAK7xyvY48SNjkNJ7JiYP9X8ijSLymSVSyt6KXp3
X-Gm-Gg: AR+sD11L7GWh+YwKRiBcvcj2sHff0x4org4G1mUg/j6Wt9PCadlMnHVpwhc3tJzCfY9
	zDBhwbWMBHHY9LH1XNkGsdcKuGoeiaB7ujdX9bvlRwYnIQDpWvGKt0+KqREa9JDoux6PgUjyT18
	txMokpe8LahLuPddcjNxk+6RxnhTWRxMI5x4rkIv07R88ngVUtdMKS97NRoF4q2qZb2WrrFewLr
	PianZtsNGTudN7nw4WthXjcYdoqzPA+5/KYkp4cGamwtFZfThTSVX20GNhpveSubbGuDrvbMKsZ
	llFhfNnqbVjUMJTUVYX+62glaZZz8bJSdMGIo/cjeKTj3B7cYXwKA2CvRo0dcL4TuA7q1vYLjnA
	YO/ex/7A0nm12SsGx5+u0IFbCbieutgeRbQxqawLazFM4t2KE2d1JxjZ76tDVGGyspZfq+c3uhv
	88BaLYLQcmVVAN17d9qV0XeuPJTf+4X788ndxe8eGbuNWeMRVH22hLMh2x3oXckvnMdKKXzCuOm
	EkGB/qJh9gPpgZJlrR4TwjfWQ==
X-Received: by 2002:a05:6a21:9104:b0:3c3:859b:9178 with SMTP id adf61e73a8af0-3cc3f7fecf9mr4939767637.34.1786529082230;
        Wed, 12 Aug 2026 03:04:42 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:85a:5c46:85a5:ec7:8aa8:72be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124454d3csm8821247c88.2.2026.08.12.03.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:04:41 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH 0/3] docs/mm/damon/design: add explanation of nr_snapshots
Date: Wed, 12 Aug 2026 18:04:30 +0800
Message-ID: <20260812100433.6288-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an explanation of nr_snapshots to avoid misunderstandings.

Changes from v1:
- v1: https://lore.kernel.org/damon/20260811101841.804596-1-aethernet65535@gmail.com
- Patch 1 word order adjustment: Repositioned "completely" ("tried to be
  completely applied" -> "completely tried to be applied").
- Patch 2: Use two spaces between sentences.
- Patch 3: Add the "Reviewed-by:" of SJ, because he added this in v1.

Liew Rui Yan (3):
  docs/mm/damon/design: accurate semantics of nr_snapshots
  docs/mm/damon/design: difference between watermarks and nr_snapshots
  docs/mm/damon/design: fix typo of max_nr_snapshots

 Documentation/mm/damon/design.rst | 7 ++++---
 include/linux/damon.h             | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.55.0

