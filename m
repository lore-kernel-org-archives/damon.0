Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4049F117;
	Mon, 31 Aug 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186385; cv=none; b=J6ecVoSiS/xMpz9eNF/72yE0oNIRe26EbPFMF9VUK9su2lGbhR9D5cwHlztU4AVxveHQ+OPRElmoEN6l3WFnQ/mxpOAaKpOqAufItGnMTzo4KiS0U+IKrRSqHUpxpYs2RqPNmYBevWCxOiWZpWPoeo8mV6Jau+qc0H876oEswZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186385; c=relaxed/simple;
	bh=aVdWKKuRk8nkHDpzmEb77cT15+azH/FUhxdnKjZpuIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7HTWtxviOaVEMIQmYyTGY4ohtPceG8TQMzvFV9QKFX9XhCkVwG55u8x0PdfbYtAZWOuyegjuf7p3+5h3J48c1oVsH5fTkAjbvBDyH6rKm1L6+GXPUQAgbK+3oilLv5tu13hPJ9sZ+rhwW8GJM1+k8lxHNUji1zYK8H6zV7xl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOnu/tWm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOnu/tWm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38F11F00A3F;
	Mon, 31 Aug 2026 14:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186384;
	bh=j0ux2Ajr+KLUU8fQjRJzy/leuNsARMPnQOrajKg2u/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OOnu/tWm7FfN/WVmuah++vaeUv4DTc82sDlwfcr2fojF5ZyGY1ykULsmmlY5KU12p
	 tT56GE1m+DVb8VmGJzfdb7Awq9W4WmaX5D5fOuECuUGO+ZEKDO4r4RmWiOr2M821vI
	 2SeZlnWf5CULk4zQd2cQ2/0cy+hkpUiDq894szbRuHeGbG+gD2ecFNJ6wmFpA6wPXn
	 sFMeKH5ncp+HwYNPBy50vTiy4AGoUnWRrFr+q6p6o7Z9nZfBdZJsXs7O0MouB8kcuW
	 dnFZt459wBFA+cGkZqr27oXM1TsX5DLpIZU17wb/bf5sSL2jYUwIXqcUf8VixxYxN9
	 LQMbH3H8wLu6Q==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/7] mm/damon/core: remove declaration of __damon_commit_ctx()
Date: Mon, 31 Aug 2026 07:26:03 -0700
Message-ID: <20260831142611.77572-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831142611.77572-1-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>

It was added by commit b1471afe4d10 ("mm/damon/core: do parameter testing
commit on damon_start()") but is actually not needed.  Remove it.

Changes from v1
- v1: https://lore.kernel.org/20260806170701.79266-1-zenghui.yu@linux.dev
- Collect R-b: from SJ.
- Rebase to latest mm-new.

Cc: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b3f8bea774c2d..79515ef03fc2a 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1961,8 +1961,6 @@ static int __damon_start(struct damon_ctx *ctx)
 	return err;
 }
 
-static int __damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src);
-
 /**
  * damon_start() - Starts the monitorings for a given group of contexts.
  * @ctxs:	an array of the pointers for contexts to start monitoring
-- 
2.47.3
