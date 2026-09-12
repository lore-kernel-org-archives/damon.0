Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE37C3C1979;
	Sat, 12 Sep 2026 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243705; cv=none; b=hLzf+5DjXC8cmKNwq7jcqUUoZ5p7ZfIjtFcAesApBY8RAY2sT390tfKMqxkNEcKzFigJ6g69holNgBWeYjWfRwPqA7Axb4CkevsMg9C3n/crcCvesKhvvbbm+6HTtlB+cFWhCasHEySpoLDNC72aDBpqHxMIv3fGzTS1qjH0zOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243705; c=relaxed/simple;
	bh=6rhYkjZ7AB+KNmnEE8VHBFxuc2YtsDhsMJQa8Ays6SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MnZ/NtFWTdWacECY9ugEtoMFMj9IH4GWFMKCwjtgFBFdwxpETNV/TAyarDatRokh2XOkUU5407PWOhjD+dorREir3NZnIFK3sBRFozw1sj09EOjHmxFblD0a/NlKB9SuZKfbW5jScFW/m0hK2GDZIPcm+NJt8pIpSopGpZZvp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP8NNACn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP8NNACn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7641F00899;
	Sat, 12 Sep 2026 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243703;
	bh=SPw7WofRL0yhNhsrvBljQ1VTNgjVbgROPe2T+epdfNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EP8NNACnxP8LGX0DzyAGrK4kC150AOFWaffrHPg6BDHffvFL2APmtx+fTXVg7xgmY
	 rIOBtRjTxhwkYweY1ksR8IJNS0EOUF3hFAwt9N3vg2YAWGUS/+O6x8Lbr3S+X6aOpz
	 gH8YdKJypaT9DVpoPfWwU8rZkUq62iME1elhD5MrQ0uFs7reGwuFCmX+sCGtxXhsj9
	 vzYqSQ6EaUn04l+QiGiWeu4lhZ6mhTIhO2yUG672NW6JaG+Rhn2JBYCKK3yGX06SRK
	 zKzmsqYTpKv+7BaLr1iO9X6If2mQBEAZEP9CJlJY7c2ogsEC1/s2dv70aGxK02puKl
	 J7SrG1DR3Aakw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/9] mm/damon/core: use damos_quota_is_set() in damos_adjust_quota()
Date: Sat, 12 Sep 2026 13:08:05 -0700
Message-ID: <20260912200814.145612-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912200814.145612-1-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_adjust_quota() is manually checking if the user set the DAMOS
quota.  There is a dedicated helper, damos_quota_is_set(), for the
purpose.  Use the helper.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index cf10f6d725c19..dd27068cb83e3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3344,7 +3344,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	unsigned long cumulated_sz, cached_esz;
 	unsigned int score, max_score = 0;
 
-	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
+	if (!damos_quota_is_set(quota))
 		return;
 
 	/* First charge window */
-- 
2.47.3
