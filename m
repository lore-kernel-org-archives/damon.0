Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7818396B6F
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267434; cv=none; b=immToqJCjFIElit2VBrUf0s/sFSOz3QTHfsCle/gXkkCASOR4R0hk5/d5cuGjh/Xl9l0EI3hPXajXaTv2aFBbGcTssh2yZWzyPHhM3c8cicz8+1hB9qAJQjIo6gTiJHifNoH2/JImRcUccK1WrSDyGlGtaTwvh2m+6HQdSO7Feo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267434; c=relaxed/simple;
	bh=FHrnFnUSAWmZNX0SWBNQDgoJTqUbfpq0tVyXroLnvKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9RxTGgDEgGLZaEgyR7J0MJj7r+z9exJPcFQYPmc3D0NWO45nSxdhNbimrpTbzYfI2lXF7SE+rGj86khRO3/CwUTVjjXCI6MRW7bhVbSxOnP2Hx/za4EdEpcoi2rgCfXe9uPtGlk3EgbIv3tXdwR2nAZm6aAb7jpXweFgAkrPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFSNoR9S; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFSNoR9S"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3a7d9d9b67bso242363a91.2
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791267430; x=1791872230; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OoJmGRoqngODEsvXRKt/ZMhZp/J8z+h3M6E+QYGZLJw=;
        b=KFSNoR9S1e2yr09vYwgpZQmDvYzYDVuN7XFPGi6F31zuivwOxOwSx/8RTXlB6X1ucK
         0uVZuUqrnatOXWLdq4r+AzFIHibVYxMdEG0F//1Sx7vAupplJNirWsaqoPQbQRzHwYpa
         rFniO3GlO+dEfja0l23jCTTgarNyOXwKXeyjTTPXgvvrwG1LGsSQbEVSpGgeAN2fqr/l
         yu4gQ/cp3lAIVq/pRkYN/G/S4OuDSBxac1PqqyU/OoBU9fZSGRvJsL00Pq7aCS1dqsFx
         7EUcqgNRBrSxIuvZkb03gYqyQA9EaOydmdDTgNBW8RKbSRat/J6RYymuG/CaezP+6PDX
         UsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791267430; x=1791872230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OoJmGRoqngODEsvXRKt/ZMhZp/J8z+h3M6E+QYGZLJw=;
        b=GK/PYIG/8juivP6mJL4hNbdKXX+ZO3Sja6YoJpshxdlYxuabAHVci6An4GsqLH3g/9
         0t2x7XPom26chaJqyeBXTIq37pC1Rwbz1OgZ1aQsXbgTD6prD8jrNlZNroMV2t6q5+SZ
         AhI4QuYmuZpxRlhtGJpM8VRaMHmYUHIAK2cm/Xu4a79OlovRAbi816kPGOWrdE0ATgdS
         M48M+PeT5r+bn0z/wjcY2Erfx0ZYZlG31I+JI0Y8Qia/t4MFfrvaSggABu5OZkerYopZ
         uhdb0u2LeqZm9WwsjPe4mj9JKYz7m9Q5u+6GFzgMN2owUdTQ+Gl+CScGiPwhtQgHI3MP
         5tnw==
X-Gm-Message-State: AFq9FYJKfNGP5cyX5BbZfsJjidQUA8pXsmzsdcdDIMmFPhwbg/RypIK9
	MO21DJGKVnGZ1W42BboSe2pJY/h7kmvheZGzCfwp72iLlGpJJ3Q/S5eN
X-Gm-Gg: AYBFou1oAKPjUiB94dB5h9VIXdsJHFdAVPF0IalKcvv3mEzWngQd/T4Cqm0HRkDpXn6
	3lJPkhqrqDgTgoVIdVrD2dYZ3bC8QCexv+EmgPEyDPtmp5E3eZVSwbAX3PXpifikGSb7vw7imax
	+YIOusJYgTIlfQYj6MC1mWDYgKMnI6gCSIPfLtMhzdF+SbMd2YlKX8rlmRquwgHuDrFVWWDqBvW
	zsgNLdmcHLYTFDX9Jpmtmj+ylQAIMzHjSstxWgjaAcQ4kven3YeGyE6JUpm/z/TTKQoJTVyDFrw
	RGUzgnJ790AA+vyFgvCdB/S4Jzzp2SKyJUzPCNTR4YLRqWITVkv8O2Rgmy/ke9ReyXo1sH+tXxI
	92izMqSJk2EuJ3eBRfQSdL4ZAppaA+SDLf86WOVUVX9hy0LT+tig/BrmwUD7oBn/tU15r5mxsyp
	j7RwNIvWL7twhWQohtDvGmj2cDDP7Gr5K3Laq/3xzvKehBfUIf6yhMn0ji7lIJPx/f60dr3j+xY
	V+v7/knkPPZHgrpizm2C7CpD7J24nSFdXPdhtINoUB8xyIR4vplF171jJ2+1/qW0HOyoP/Xgxfc
	aQXy0epNXIR055hj0nJi8hN4kDI=
X-Received: by 2002:a17:90b:2f88:b0:3a8:6b84:235b with SMTP id 98e67ed59e1d1-3a8726c1d9fmr135343a91.7.1791267430371;
        Mon, 05 Oct 2026 23:17:10 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (61-221-208-111.hinet-ip.hinet.net. [61.221.208.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8533aba95sm3662789a91.2.2026.10.05.23.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 23:17:09 -0700 (PDT)
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
Subject: [PATCH 2/3] Docs/admin-guide/mm/damon/lru_sort: Fix copy-paste mistakes
Date: Tue,  6 Oct 2026 14:15:48 +0800
Message-Id: <20261006061549.627-3-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261006061549.627-1-adrianhuang0701@gmail.com>
References: <20261006061549.627-1-adrianhuang0701@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DAMON_LRU_SORT documentation mistakenly refers to DAMON_RECLAIM
in a few places.

Fix these copy-paste mistakes to correctly refer to DAMON_LRU_SORT.

Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 Documentation/admin-guide/mm/damon/lru_sort.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index c3b688385681..0c04d238edc4 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -264,7 +264,7 @@ addr_unit
 A scale factor for memory addresses and bytes.
 
 This parameter is for setting and getting the :ref:`address unit
-<damon_design_addr_unit>` parameter of the DAMON instance for DAMON_RECLAIM.
+<damon_design_addr_unit>` parameter of the DAMON instance for DAMON_LRU_SORT.
 
 ``monitor_region_start`` and ``monitor_region_end`` should be provided in this
 unit.  For example, let's suppose ``addr_unit``, ``monitor_region_start`` and
@@ -347,7 +347,7 @@ memory regions that not accessed for 120 seconds.  The prioritization and
 deprioritization is limited to be done using only up to 1% CPU time to avoid
 DAMON_LRU_SORT consuming too much CPU time for the (de)prioritization.  It also
 asks DAMON_LRU_SORT to do nothing if the system's free memory rate is more than
-50%, but start the real works if it becomes lower than 40%.  If DAMON_RECLAIM
+50%, but start the real works if it becomes lower than 40%.  If DAMON_LRU_SORT
 doesn't make progress and therefore the free memory rate becomes lower than
 20%, it asks DAMON_LRU_SORT to do nothing again, so that we can fall back to
 the LRU-list based page granularity reclamation. ::
-- 
2.43.0

