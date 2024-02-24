Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D264EB33
	for <damon@lists.linux.dev>; Sat, 24 Feb 2024 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708814891; cv=none; b=c314Pt8NmIX+ccTuLNGhdCSVgEkpYCrcv8lzXbtfsji6VFPO+jtUBMaUMy4C8kTQlPjB9J+a1RnHawCMn0BaRqeTi9w75BqlrRayGgk8Et/FLieWSnviNFMJ855DXPOkTnsF0cywEWQnphKvKLQkaTj2Dfo+7oNhgzAl2mJAkU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708814891; c=relaxed/simple;
	bh=Ta6daWl0ZVd61hh3oEvw2iF0kiGee521SeK6zSYDs70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y/v3T8GmvYFNQ9jF5TnJU3vFmqpZ6M4Hhzdm7tixbMBXd/xiKJntjX+ZJz8CFbeAcRiUsOSA9mp9yil9uZaDoYvubU719+50CNJZLA3VJjNpqETWHIBz8Qfx592UIzUdag9n0sBFZtubDVe8eRGoVQNebtcoKOUMom9mSrZSFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0XbTDPT; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0XbTDPT"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21eea6aab5eso1224703fac.0
        for <damon@lists.linux.dev>; Sat, 24 Feb 2024 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708814887; x=1709419687; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BvzO7ZUsymLO2jBd+mJ7CM2X1lBqtVuXEd4hC3J8wSU=;
        b=f0XbTDPTYOVj+UN6mYiS/nTEe806mUmnlxTi5+pWFXZ9R5ir+S9PpybK7fU+DBrhP4
         wTykC1IQ6RE5Xah6Eco3tCPfchn8tDWBnP0SRVoxU0uBgHKb0SZBvH31xiHSlCQJUxfb
         yQIraE6MYpvBtSKIzT/emN09n0+L9Qi3B09kEItDPOxayvzd7vI2Z90692Qkr3fSAN22
         D+AG9H8qlT8viFfV6Es7SZiVFsAXz9yWHLv8OufQeSbWam3jnMb/hs6pSs6Wv+C+l53i
         yLg8GxBx0gEz9/vv86basq1lGR0XZHFTrGhXSW+P8dUBFioIzQyYFA4180FkVXa1VJFg
         DjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708814887; x=1709419687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvzO7ZUsymLO2jBd+mJ7CM2X1lBqtVuXEd4hC3J8wSU=;
        b=X4Hr04h5TSv4YRwB+DIVZQwrFtxvGpl4f6/m5q4x66i91//ToPHcjH6bs0yr+3VvEy
         ply9oAIOTO14W4ajGab1HD7nTx1lSZYjDO9gy/FdGaoz0w5Qp0Kg+3fPyqup/0OVyu8W
         anGjorgoXbwQsAAUEpYJCHt/2HaCzYyxOX+WDlWAAqqjOQPL11kBGc5jXe6s8DNg8Gzb
         nwfC/8IUUg1qWEeGh+oXApJebo/qw4cLxL1JwT0yNAGrddTuEqkSEGKHnxdeiqPGlfnf
         EXjmrbGn8wzfkutBkH0yMcPlnHw7pI9VyDY4RQ6W+iv+q6Yj0L/Y3dQSY5zUKbuag4sl
         UfKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFo8xuXuvsVLHT3DPsjd6INsY1BDTFjQSOJA1cb+RBcWys6K+Buc53E3GI1hYZy0UqbHIblr4cCluikMLW1N549hyIf9A=
X-Gm-Message-State: AOJu0Yy8RFiLDbOefcHtyGXVBjpFqLlS3qsmsAkAHAbV1LrMkTNOxhIL
	oTo1jbIP5zN3/ATa81NdNMgG1Pyk+CMjW+30nWq7Y7QIbtTG9g9V
X-Google-Smtp-Source: AGHT+IGtgVmOgAMzHE/9QbMi+O3Hk+d0Dl2iKByTn0sco5cLzPXoOU8adxaZX9wsTwzocuE6fNNw6g==
X-Received: by 2002:a05:6870:364c:b0:21f:dc71:c3f4 with SMTP id v12-20020a056870364c00b0021fdc71c3f4mr2515594oak.43.1708814887599;
        Sat, 24 Feb 2024 14:48:07 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:fae4:3bff:fecb:410])
        by smtp.gmail.com with ESMTPSA id fy16-20020a17090b021000b0029aac9c523fsm595754pjb.47.2024.02.24.14.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 14:48:07 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: corbet@lwn.net,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	SeongJae Park <sj@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH v2] Docs/mm/damon/design: remove the details for pageout as paddr doesn't use MADV_PAGEOUT
Date: Sun, 25 Feb 2024 11:47:51 +1300
Message-Id: <20240224224751.4673-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The doc needs fix. As only in the case of virtual address, we
are calling madvise() with MADV_PAGEOUT. But in the case of
physical address, we are calling reclaim_pages() directly.
MADV_PAGEOUT on virtual address is much more aggresive to
reclaim memory compared to reclaim_pages() on paddr region.
This patch removes the details so that the description can
apply to both cases. And we don't need to couple with the
implementation details.

Cc: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v2: decouple with the details according to SeongJae
 -v1: https://lore.kernel.org/linux-mm/20240224215023.5271-1-21cnbao@gmail.com/

 Documentation/mm/damon/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8c89d26f0baa..5620aab9b385 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -315,7 +315,7 @@ that supports each action are as below.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
  - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
- - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
+ - ``pageout``: Reclaim the region.
    Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
-- 
2.34.1

