Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2708425A2BC;
	Sat, 28 Jun 2025 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751129513; cv=none; b=m6+fkizi1xBAqvXkCZtB/frTXoLVbEvBD0clazAY6Ov3KcLVW5TgOsZ1HsOptVi5cWD0ZW7/8jKb+XxoGQZ0H651F04UJcW34XRIcdB1+psSyS5oTqLr/4BZkJNyLj6E/hrwbNXIT4H16Y2wAZPUTjngjD66pPEMS9m1GeH1NQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751129513; c=relaxed/simple;
	bh=L6arW2jwx/Rbwfx5uwGlsnD8HGyjJeRRb71lu8RP0Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBNU2rNpWrf/bjhoEdzXWSrt+50BgswYVXOkG4R6DhRUGAQi28TOi92zMWAaEKEl7UWmYW7X+3c/xEnA4wCNXUp39JGh9IlGZ6QNunK46l/oIFvRq+CBj0bZ30PF4JzqF22xZbNe3qOtNoSxA4Yj38lEDXfXEtuIfhtRCbt4mnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXUs26kP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXUs26kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9D7C4CEED;
	Sat, 28 Jun 2025 16:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751129513;
	bh=L6arW2jwx/Rbwfx5uwGlsnD8HGyjJeRRb71lu8RP0Uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXUs26kP0UoD7duEu7XVlCCG8xhCD0eEHfGltVLEgEZVFgEIDFdFanNFuwJ8iUfDF
	 JpVITsSKaWKJJ08wGCv7/lAxYizGdicuzw+wb3j+3w0Zz75hKR7Rtqc9LJ9rZWK7kw
	 LRDS+BjfpPWsnlMqWpP0nnu6/l0HPpZGLh+Us/cL/mRs0KM+q9NxR+PqkWUYQbB79K
	 tGSmQBy4A7wGu6adn7ZTFpSejfJPTOtZA88qXYojXlx4vpStbijaGu6iYhbwd8K6FA
	 rlUlYAMnWJ4aypn/N4DuS0OIIlD6cfbQnHJAcMi4xTgeoAbnfsKT32hnE3f/dAHq6Z
	 SxhbcF4v+zcuA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/11] mm/damon/lru_sort: consider age for quota prioritization
Date: Sat, 28 Jun 2025 09:51:38 -0700
Message-Id: <20250628165144.55528-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250628165144.55528-1-sj@kernel.org>
References: <20250628165144.55528-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_LRU_SORT is doing under-quota access pattern based regions
prioritization using only access frequency.  Age of regions is another
useful information for distinguishing hot and cold regions.  Use it for
the prioritization, too.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 4af8fd4a390b..7513ebc6aeef 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -71,7 +71,7 @@ static struct damos_quota damon_lru_sort_quota = {
 	/* Within the quota, mark hotter regions accessed first. */
 	.weight_sz = 0,
 	.weight_nr_accesses = 1,
-	.weight_age = 0,
+	.weight_age = 1,
 };
 DEFINE_DAMON_MODULES_DAMOS_TIME_QUOTA(damon_lru_sort_quota);
 
-- 
2.39.5
