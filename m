Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4E145A03;
	Tue, 13 May 2025 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096044; cv=none; b=imUWRoQvMGMXiRmAf7AV2/P1MMYO0saeWD3wfIRyr+O4i+XpUQbqJtWs9F2jQE3J/PxRF69ntHVfLnOqzl8w9KeEjAexNfokb+C3Y/NFOig3ubkQN2/xdFIl91F/7Py48N39KqdtAbxJb+OUat7XgEOcjMcPshybpvCfjvuBcDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096044; c=relaxed/simple;
	bh=Iasq73PJLgx1anHaIVswYQx4Nq1K0KmoGxN00BPcit8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ruE5+uOVUnrTnyw/7lCUXGWm0orDdc0g2tAMi9jy44/B7cLyC9VSpfxuiRV43QVKSULKWIDbzCHfVBVvNED5qvezRoYjgSm0gmvEK/fT6FBYbuninZs06emor9cr42pGzwikz95dE+yKCuOwpnPBGwPn+FhS7dcamb6eLYZExvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvYMViSA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvYMViSA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1F2C4CEEE;
	Tue, 13 May 2025 00:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747096044;
	bh=Iasq73PJLgx1anHaIVswYQx4Nq1K0KmoGxN00BPcit8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvYMViSAXi08PUHWi4jcDJf/7X0MBPFQGW/A4Ig4/HR6YMPJr07N9lWgtAh6s7Gg9
	 nvgicrumVe8Nrb4bnTykQ192t/+P1gO8v/0FH9+hRplERoKO3ZP9OrW0pE2y0OBo+i
	 FR902Odp0Q60NBqEwSutLMpMBXOXJsf+ClpFQ4CuVGtAOF4oHki8pEfvQatu5yTIqF
	 T7rqx9UPESuPEIX0UOtZpUvP8aVgmR1DmvM+Ge2W+lxLme29+5kvpKlXrUMQOy0cDd
	 5h6T97Kofa5Fx2gnRgmIjgB9ZzIKU+Vc6xRrDj9+HzMlOFyOJK8S19csAMV4zYSsBf
	 sSYE1LERyy/9w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/6] mm/damon/paddr: remove unused variable, folio_list, in damon_pa_stat()
Date: Mon, 12 May 2025 17:27:12 -0700
Message-Id: <20250513002715.40126-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250513002715.40126-1-sj@kernel.org>
References: <20250513002715.40126-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c0cb9d91bf297 ("mm/damon/paddr: report filter-passed bytes back
for DAMOS_STAT action") added unused variable in damon_pa_stat(), due to
a copy-and-paste error.  Remove it.

Fixes: c0cb9d91bf297 ("mm/damon/paddr: report filter-passed bytes back for DAMOS_STAT action")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 1b70d3f36046..e8464f7e0014 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -548,7 +548,6 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
 	unsigned long addr;
-	LIST_HEAD(folio_list);
 	struct folio *folio;
 
 	if (!damon_pa_scheme_has_filter(s))
-- 
2.39.5

