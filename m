Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAB375F80;
	Sun, 13 Sep 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319503; cv=none; b=m8olcH31fS1U+CzYQZ+1fu3AANNFZUDs95EDl0/S9589Cqm3hrMk9PHCClaGVLX2XC+FGNpvlIlQq41DSZs29tEHGur1SUF6JvAMoPWNXLxEK4kyPHY9dxikjEtC3sDP1cFNAeru2nXtVI7nH5EfcrQ7yj+Ba9+lOmR2Lql6BcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319503; c=relaxed/simple;
	bh=rKplGYxWCKFMa7GYxEp6v+ntDcuuIqtHQHXYrF7Fkeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abEA+HkYnGKTNI+EiAr7rGTI8bP0LajsW+6t0tGPDodGb1kgKtb8cn5fP4eA5E3McZp4uhI/oCsPEme7LqnZXtj8nNizFRYQ38QiyVCPyw34INp0HBMrO9Wnc3kyDL+AP7p2VSnEsOapz7zOM5q7Mnv79Q5wft+9g2EUD8/+CLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp4KZOl3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp4KZOl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D24F1F0089C;
	Sun, 13 Sep 2026 17:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319502;
	bh=WKHC2ohfBCTfxJBQb1w+ZA1oqxl4Tap4PnGbWDCoJ/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vp4KZOl31dlS71Xlig/awbyEcGBsaOfBoJ+8S6UPztXW16Vw4bjbpuqrkKntVm8ss
	 T8nGpBDS3+/5j9dkRdcMqgMO6s7KBndqZWWDcpWg/ZwDY3aq3TCBYUI+hF5X+BWxxM
	 b9mnYwiDxLRZ0NrfxrZXw3Vf07NoBazywfbkNtH/dYOKuMlkTZm5aThKBvGIrM1r+K
	 J0saQ5JhTpBXPyExoHEdo/nccOYpzLdWCYva1ntd5sVhiWhlDA/2NiilpDqzk8onrh
	 X/S71liwj/HGPJJuaGxwMWGSgzVtOGrL/ZqQI8mmRzU+IhpoXqrylo08U4IYOQhsN0
	 CgyF/vHt3r4Tw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/8] mm/damon/api: introduce DAMON_FILTER_TYPE_HUGEPAGE_SIZE
Date: Sun, 13 Sep 2026 10:11:23 -0700
Message-ID: <20260913171133.102366-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171133.102366-1-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new data attribute probe filter type, hugepage_size.  It
will work for memory that is backed by a hugepage of a given size range.
Add a new damon_filter_type enum DAMON_FILTER_TYPE_HUGEPAGE_SIZE to
identify the type.  Add two new fields in the damon_filter struct for
saving the size range.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 4be7d1df8e71f..bbb190b474015 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -783,12 +783,14 @@ struct damon_prep {
  * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
  * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
  * @DAMON_FILTER_TYPE_PGIDLE_SET:	Pgidle is set.
+ * @DAMON_FILTER_TYPE_HUGEPAGE_SIZE:	Page is part of a hugepage.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
 	DAMON_FILTER_TYPE_MEMCG,
 	DAMON_FILTER_TYPE_PGIDLE_UNSET,
 	DAMON_FILTER_TYPE_PGIDLE_SET,
+	DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
 };
 
 /**
@@ -798,6 +800,8 @@ enum damon_filter_type {
  * @matching:	Whether this filter is for the type-matching ones.
  * @allow:	Whether the @type-@matching ones should pass this filter.
  * @memcg_id:	Memcg id of the question if @type is DAMON_FILTER_MEMCG.
+ * @range_min:	Minimum value of range arguments.
+ * @range_max:	Maximum value of range arguments.
  */
 struct damon_filter {
 	enum damon_filter_type type;
@@ -805,6 +809,10 @@ struct damon_filter {
 	bool allow;
 	union {
 		u64 memcg_id;
+		struct {
+			unsigned long range_min;
+			unsigned long range_max;
+		};
 	};
 /* private: */
 	/* Siblings list. */
-- 
2.47.3
