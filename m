Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36822374737;
	Wed, 20 May 2026 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258549; cv=none; b=RHfZogGT1YPu995mCfk0h6nKJ8UZUO8ft8um1wxW06f9x/Y7oyq8vDwON9wass1Kq7pdf6dHP7kWHrkqvSEeNlp/rTF2Y5okNk66xnUQFhvSiqw8MOZ7bIm2kIJ8zCk0xoY6lx8HspLzxjsMJ9VX657a82Tg4nfHyFlthtm4F30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258549; c=relaxed/simple;
	bh=8B9IiCSCXwYFGO3g7QwEtxLcmC3JtXQgAOF4um9StEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5prRGnFehU4OkgfKD4/jVutX5NRzQABpV2zlU/OxAh3e7Lfa6drNi+0h9UekBwPC4BQDeXKGdIjE0bkBC4bfhHl7Q1b3u2CQu4dgV2ObA75PZ7SV3tviBjG6f6eqHlUne2TtZcuuN8NKxb3o7kLe4N8N8ZZqhfhvDTziAIvoEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyIpHYnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyIpHYnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA59B1F000E9;
	Wed, 20 May 2026 06:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258548;
	bh=5i2WVbg2PjBsmn2NfpjKEh0VGjqNajgL/l9BFto2EhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SyIpHYnjvm5BvCUeqEVymybuuMIUQkaBuEJ8pOnKiKstfFIQQasKUJ8E3+IQRi8EL
	 ++ItVK7QeRL/cDh/3UzevM1WxJc2l/rBxLrfxz+EqaI+WdxrdfF547J7zqN+fM3NM1
	 BOdn2Zo52cOP1D3oobAwUUoe9TpEuPeo0qxzI21COSS/ShGGs56TR7XW1llorDFMqY
	 x+fZedTsTZf763mlRhzkDXMB+DOdOBM6oVxAs4nLW8Mh1ak81EQOHaserdRzql0HWu
	 UhvQpB6DPCM7YfqU/P9R1Q7MsUifJTW7tfFC/wKO5UVinpsoOqYjLg6d7SkP257R0b
	 y02wySKMDj7gw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 01/14] mm/damon/core: safely handle no region case in damon_set_regions()
Date: Tue, 19 May 2026 23:28:33 -0700
Message-ID: <20260520062858.167011-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520062858.167011-1-sj@kernel.org>
References: <20260520062858.167011-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_regions() calls damon_first_region() regardless of the number
of DAMON regions in a given DAMON target.  damon_first_region()
internally uses list_first_entry(), which clearly documents the list is
expected to be not empty.  Due to the internal implementation of the
macro, damon_set_regions() is safe for now.  But the internal
implementation of the macro can be changed in future.  Refactor the
function to explicitly and safely handle the empty region list case
without depending on the internal implementation.

No behavioral change is intended.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0267faf216b95..40946a7f6f549 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -356,6 +356,19 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			damon_destroy_region(r, t);
 	}
 
+	if (!damon_nr_regions(t)) {
+		for (i = 0; i < nr_ranges; i++) {
+			r = damon_new_region(
+					ALIGN_DOWN(ranges[i].start,
+						min_region_sz),
+					ALIGN(ranges[i].end, min_region_sz));
+			if (!r)
+				return -ENOMEM;
+			damon_add_region(r, t);
+		}
+		return 0;
+	}
+
 	r = damon_first_region(t);
 	/* Add new regions or resize existing regions to fit in the ranges */
 	for (i = 0; i < nr_ranges; i++) {
-- 
2.47.3
