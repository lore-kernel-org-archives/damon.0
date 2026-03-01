Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F2337BB6;
	Sun,  1 Mar 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387012; cv=none; b=OXymLCL62PAd6NAMszqBf3eCl4sSMtANsvOKTxlTS+74gUq/Dw2dW8QgWAAd2yqny53kDyW4DtFS11wb1tMM2XfJY0UgB4mAcwEUz0eDomYENK+w/Ktg4T6GrtSUXmaBz1oOX/aJ8zvcpvruTGiNaWG3QxuZ1M02XRJ8OtFJA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387012; c=relaxed/simple;
	bh=nkxfWGkCfA0dtqbKfL4Ap5CeLN1/sVBbqbCyhGOAcDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IALWcGDTxPTDNRvAvZM/0frzQAxLrMLPgdtSUQeor7VB2rXI4eELeM5ghiY00iLZ7i4PepBNSqqbvRvN2qk96+/a85ofv6miinkvrwkWIuLFt2S1Ebp5TO12TFP033Q4PGs9YDCoT9Xz9Q0zV/zUejF81YhciNuoxj2ExJCoxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa/1Hh26; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa/1Hh26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B92C2BCAF;
	Sun,  1 Mar 2026 17:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387012;
	bh=nkxfWGkCfA0dtqbKfL4Ap5CeLN1/sVBbqbCyhGOAcDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pa/1Hh267VDif0fGECk4ZBsQQZXzXfS8+im3ufGhSbXqQAUw5hsIrfOzfy1h442s/
	 leZWhqr9a1qEaoiqvnQ+flJSjdWw3+l2hcccGnCWBNysvlfgxgesGRG0eztr2m27Z5
	 WFbIAE6/2kpFTBY+s9f0zz7IHcv67IRQ5eSBBJW+hAdlcNtb92GOzS1cyCPk0FzBbx
	 1TUeRYgSDmgNq8F7wegrNC4MyLjIRII4Bx2xUSOylKEm99RqJ8jyEtUx4zLNhjvq2r
	 vD749FkEGato7zuc9wkEF98Wvaxk35fOtkn+VyN1KBJth4VY00iiizRnFXsNI5bvQu
	 bppMvpKICqtyg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 05/10] mm/damon/core: add damon_merge_two_regions() debug_sanity check
Date: Sun,  1 Mar 2026 09:43:20 -0800
Message-ID: <20260301174327.76849-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260301174327.76849-1-sj@kernel.org>
References: <20260301174327.76849-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A data corruption could cause damon_merge_two_regions() creating zero
length DAMON regions.  Add a sanity check for that under
CONFIG_DAMON_DEBUG_SANITY.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2b5aed89d449d..8a3738a17cdd9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2473,6 +2473,21 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	mutex_unlock(&c->walk_control_lock);
 }
 
+#ifdef CONFIG_DAMON_DEBUG_SANITY
+static void damon_verify_merge_two_regions(
+		struct damon_region *l, struct damon_region *r)
+{
+	/* damon_merge_two_regions() may created incorrect left region */
+	WARN_ONCE(l->ar.start >= l->ar.end, "l: %lu-%lu, r: %lu-%lu\n",
+			l->ar.start, l->ar.end, r->ar.start, r->ar.end);
+}
+#else
+static void damon_verify_merge_two_regions(
+		struct damon_region *l, struct damon_region *r)
+{
+}
+#endif
+
 /*
  * Merge two adjacent regions into one region
  */
@@ -2486,6 +2501,7 @@ static void damon_merge_two_regions(struct damon_target *t,
 	l->nr_accesses_bp = l->nr_accesses * 10000;
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
+	damon_verify_merge_two_regions(l, r);
 	damon_destroy_region(r, t);
 }
 
-- 
2.47.3
