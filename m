Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02E4C630
	for <damon@lists.linux.dev>; Sat, 24 Feb 2024 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708811444; cv=none; b=dtcC0ZHMH9PS+TDa+qwlwzvL4CFrJqthgN9s3yjF653eJhI83i//psLzOBtzvzFxFiKX2JcCnA8wsYUE9MON7NIKo83+Xw8o1/rC+wjqtX88cdE1MM8CRVmU2D9VsU8XcNXqiof4jdVQ+2S+x1oZx7drgny/HIU13XZJuVcwEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708811444; c=relaxed/simple;
	bh=4BPgwLpKQTq/0vxcQXG57XBxOy8tRWhOr/7YSpHpNIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h4Y/Lkedegt0wOf1dLaikVZcB6zD5X3S5yDpBk/+n85K4NDjs+uogYQB3XYEYSbn/WxEuV/bMfJne1J8YFQ/zljm7AXgty/u++PJthd3IkVYMTMbuCXqvMfL7M1d3NsueCd8huomxNQ03W3KfwnZTZfnC/xGczh7WR3H4uBLyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr1AnM71; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr1AnM71"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e4957ff05cso141090a34.2
        for <damon@lists.linux.dev>; Sat, 24 Feb 2024 13:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708811441; x=1709416241; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ydh9YpZ5plBfJp+BJ1ZlCj0CTUl0s4YGZgmpPJqLx+E=;
        b=Wr1AnM71eCyX5EQIrj9jMpyVO5txZ22VP6F3czlv8DyFpTVcpWcqMqrej5+HKPWQjx
         cu851vROBoq2ct+Xmc+PQ80ZawmCROmR1VXLxHpUO9PDbEc8LNE9OvO7bwVOwwyibEjT
         6EjxIPn00vZHa/8jU335ipX50S/Vb6MaHnlnHU41Tf3avN5ipFrBemaZGGyGeSGu+qLg
         f3c0Qbt3Pq31qNeZBYyLJHomoeKRBtS6x9bcB+bk4MSYRYKKiAUnzaXRdtGZgY2jNkRL
         fUUNtNRIf2wkIqQz3zg2nrMItGwVL0k7fnsBU5zKWec/dPf2ssHmbiCzk+J81dbbIpAp
         o8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708811441; x=1709416241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ydh9YpZ5plBfJp+BJ1ZlCj0CTUl0s4YGZgmpPJqLx+E=;
        b=OXic/Qv0TIcOc2BtcE/wCqu8qprGALXFw3VwhpU8kFxAGAtItBEcp2jAIsCNH+LBth
         AHtI/bop6G+bF06Msq28RtQZ9O8a1QpT5mZz5M2r6DmP96nUr1rbdvdmXVin0+Dsbxl4
         FBZ4Upa4dqTgAKP/1xPQ3MLs9xNBCSYw8UgRNX63vjX3+GmJNnS0QewPRWLh2mXBIdrC
         7DRRWgTybzikDFKB+s633d0q8QfFk95mAkQaCOu/AShsty279BCdPQXDr/bKkFGE5+MJ
         sEiHdsKjdUvcfndu/Z6oGLAZO0Gvrc8a6x251lsvCeBSaEsoR26qQ8x3JTirLRBtiDTo
         mD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCR9Bh3PFcx9KAVyKCx1Amm9ddsiWRuOplgWO90T1S2c/tvljcHJ5ScbfgpJ47nRfT0/ZpBRhjyIHuikHlaOJQpldjbq8=
X-Gm-Message-State: AOJu0YwSGoYGN4e4pV13iR29Cq1+qUEGy2W+a5Vx12SCJguEpGHPWpn1
	bEqK5vFIdcwiDHhug6Km8n8fsApWpmAdvNNF0DYtKGCeiGVtL3H5
X-Google-Smtp-Source: AGHT+IFibMKAm7HJ/s6TRaLHq4riuHRV1LaOYrAXiM9s7Vh3AFlvSPBPKaMqLJjA0MKvOhsC6rc4jw==
X-Received: by 2002:a05:6830:4414:b0:6e4:82a4:742e with SMTP id q20-20020a056830441400b006e482a4742emr4515589otv.0.1708811440809;
        Sat, 24 Feb 2024 13:50:40 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:fae4:3bff:fecb:410])
        by smtp.gmail.com with ESMTPSA id du15-20020a056a002b4f00b006e4bcdcff43sm1509866pfb.78.2024.02.24.13.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 13:50:40 -0800 (PST)
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
Subject: [PATCH] Docs/mm/damon/design: describe the differences for pageout's virtual address and physcial address
Date: Sun, 25 Feb 2024 10:50:23 +1300
Message-Id: <20240224215023.5271-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The doc needs update. As only in the case of virtual address, we are
calling madvise() with MADV_PAGEOUT; but in the case of physical
address, we are actually calling reclaim_pages() directly. And
madvise() with MADV_PAGEOUT is much more aggresive on reclamation
compared to reclaim_pages() on paddr.

Cc: SeongJae Park <sj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/mm/damon/design.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8c89d26f0baa..6c50743552f5 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -315,7 +315,13 @@ that supports each action are as below.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
  - ``cold``: Call ``madvise()`` for the region with ``MADV_COLD``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
- - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT``.
+ - ``pageout``: Call ``madvise()`` for the region with ``MADV_PAGEOUT`` if
+   the region is using virtual address; otherwise, call ``reclaim_pages()``
+   for the region if physical address is used.
+   ``madvise()``  with ``MADV_PAGEOUT``  is aggressively reclaiming memory
+   when pages are not shared by multiple processes. Differently, paddr's
+   pageout  will do the best-effort reclamation by scanning PTEs to figure
+   out if pages are young, if not, pages are reclaimed.
    Supported by ``vaddr``, ``fvaddr`` and ``paddr`` operations set.
  - ``hugepage``: Call ``madvise()`` for the region with ``MADV_HUGEPAGE``.
    Supported by ``vaddr`` and ``fvaddr`` operations set.
-- 
2.34.1

