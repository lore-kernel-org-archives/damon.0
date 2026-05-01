Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035619D065
	for <damon@lists.linux.dev>; Fri,  1 May 2026 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777599460; cv=none; b=UTe2TPOnGZnwyIqvJ7LCKCVaxzSWfuheBDAy6MMAhDXWHco0lu5RIcuUXk9BFinCwnU8O7RvQjW9LlPC5+rAVfhNq4b7JIyz7IItcZ9UhWDD7hEK/Xvpcq4LP6X/EI+We+DdGhw7hMCbj9+i9/Aw4g8e71ZZzp92Do+mMT76GzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777599460; c=relaxed/simple;
	bh=dVMyT+yVYg9vYveEPWd9b7boztQgUjSLX77P0wmm1Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2tAa2veNtLsCdUsqdQ33I2YeonTu2p72A4otarItnvzwg7uSkRh/kJ8W2XObUnuyzuSiCgAQJxFcRuNGeZt1cIYWGrjahqXYho8bkakTRtxgNGiYWvRCcySWyYAg6xMSlF8oRKbyUZbmbUEK6PhxD1x9paE1v+sKxUo6LLJSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7nit2BR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7nit2BR"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c648bc907ebso975089a12.3
        for <damon@lists.linux.dev>; Thu, 30 Apr 2026 18:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777599459; x=1778204259; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6ydozng44U75UGI9RXA2frlbGtS6jtczWtr/PXLzzE=;
        b=L7nit2BR0ooOSD3nn2qZ+WuZggpJNZE/0udLeaP1uOnk9g5uQm5u61NWTBNAbtE7wU
         0HqEArx1d4cbzQcoU4G+hkYg1ZUdUz/Pl316Ncj2iuuzLzRA4eY/iIZImPj0ZB9i0ggK
         qQFok3Y1Zosi5S71QL0KLAqlpwkKPcVRgelXVkncEKHdNLvf97U0Vw4du6F65ZZyNvpZ
         WBXtdi8350mpqYlp+rA1vNz6VLqDG97Js7pjNrNmB/7Uz3y3q9ROUxkW3X8UlIfFUYPX
         G1le9aKIg/ptpRoFXOUf3yDJB06P98oo/1FHkjnLP7QU26+VlLt5vjRd0XIs5//LBPzg
         Vt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777599459; x=1778204259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6ydozng44U75UGI9RXA2frlbGtS6jtczWtr/PXLzzE=;
        b=l9J7ALz1bQSOc2TbHqbK9rNlkt9FXqeAnBD2NNth8vZB8X7EKspSRDZwN83Oq3OXm+
         96rDYZ8Kf6gs61/4LD7LbQCu5qGAaOvoJZVtb7xyRVODRVQ87wsd1GfZEU/3jSZ8ApSb
         I4Y/J7TBGq8JDJSmOtHU8UecmHjs+SxvPVjjXEi+dowymI+N1ThidoVpIr7Vnsp463nh
         NFyWTjyxP1hetUVMFgncq86Di1uZO5g9i8UlKAFIGpR/RQza0m2BcMKmGvy+BHnr8zDV
         YcpJwk6YsP+cIVWNoT3/PWtkBjICpaLCTjGUs3y2VkgmRQBFmuQ2RDkcP7zC9QoTKuBP
         Q+7w==
X-Gm-Message-State: AOJu0Yyx28a/5zS2+avTaiI344ZalsSEASbEhQCsDjBRmmQSDGrqoJQp
	Ua+YIYb+vPdDvNjwkXFcqpNCsfSwGh5GLVj3c9kjaxwT9PHcCDtvjZ5Z
X-Gm-Gg: AeBDietNOvQGVB/X6VSWMuFavSoKj75f9wvzOECbzgaRZk2AiJfpkJrOC6MlwEA424W
	zwpUdaUsHaWjPvWAVgYIoYcAVaRA9g4Yv129WsPHSp85Alyh8xARYP4LGVuGf/ZGEDfqOoUjsFt
	PYLhl5ctujs/2EZmGn2tTUeOIXqEC5mVMaKgXDwKladQJMJQWBVr02iQ6o1pBLSyGXrci3S1rMi
	NaN3gjpD95EbwYPN5g1k8Zbc9epAbWFVVQAk6c6YjfAqjh1n+p2i8MfnF42YjMN90goFkrxF4Vz
	Sc/EVUaT9GmMgRzMOmS47j1XpNQjIDpBMlKJwufcoupfcbj+sghdzl3uusKYXGCM86lh1lt3jNM
	cUh190TfGsYQmHEZSRKvo7978YGhlSIAM7CKob8sqZocqqBRLv9ddjsZc/Jle4V2kyV2G5SMm9A
	LR7/sADAvbqKUZbIgQo6SOweQMJHDkklABdyhY1HS4JRr4EVh/z+1pcKQ8SKnC
X-Received: by 2002:a05:6a00:1797:b0:827:3946:a23c with SMTP id d2e1a72fcca58-8351a0a5bf8mr1029293b3a.10.1777599458715;
        Thu, 30 Apr 2026 18:37:38 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:8f3:e8d0:1478:fdf:dfb3:daec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b02935sm956318b3a.41.2026.04.30.18.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:37:38 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [PATCH v5 0/2] mm/damon: validate min_region_size to be power of 2
Date: Fri,  1 May 2026 09:37:48 +0800
Message-ID: <20260501013750.71704-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
When a user sets an invalid 'addr_unit' (e.g., 3) via DAMON_LRU_SORT or
DAMON_RECLAIM, 'min_region_sz' becomes a non-power-of-2 value. While
damon_commit_ctx() correctly detects this and returns -EINVAL, it sets
the 'maybe_corrupted' flag during this process.

This flag causes the running kdamond to terminate. While the termination
is a safety measure, it is suboptimal in this case because the error is
just a simple invalid input from the user, which shouldn't neccessitate
stopping the kdamond.

Solution
========
Add an early validation in damon_lru_sort_apply_parameters() and
damon_reclaim_apply_parameters() to check 'min_region_sz' before any
state change occurs. If it is non-power-of-2, return -EINVAL immediately,
preventing 'maybe_corrupted' from being set.

Patch 1 fixes the issue for DAMON_LRU_SORT.
Patch 2 fixes the issue for DAMON_RECLAIM.

Changes from v4
(https://lore.kernel.org/20260410044259.95877-1-aethernet65535@gmail.com)
- Clarify this is only a minor user experience improvement.
- Remove Fixes: and Cc: stable tags.
Changes from v3
(https://lore.kernel.org/20260403052837.58063-1-aethernet65535@gmail.com)
- Improve commit message: clarify "unexpected termination".
- Add detailed User Impact with reason why kdamond cannot be restarted.
Changes from v2
(https://lore.kernel.org/20260402053756.26606-1-aethernet65535@gmail.com)
- Split the patch into two per-module patches.
- Add Fixes: and Cc: stable tags.
- Elaborate user impact and reproduction steps.
Changes from v1
(https://lore.kernel.org/20260331073231.30060-1-aethernet65535@gmail.com)
- Fix memory leak issue.
Changes from first attempt
(https://lore.kernel.org/20260327062627.66426-1-aethernet65535@gmail.com)
- Renamed the subject.
- Validate min_region_sz rather than addr_unit.

Liew Rui Yan (2):
  mm/damon/lru_sort: validate min_region_size to be power of 2
  mm/damon/reclaim: validate min_region_size to be power of 2

 mm/damon/lru_sort.c | 5 +++++
 mm/damon/reclaim.c  | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.53.0

