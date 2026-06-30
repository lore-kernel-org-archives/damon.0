Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF63E1D07;
	Tue, 30 Jun 2026 04:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792513; cv=none; b=RL+DjOFcYdqV3JdgbcCMLK83MVudA09oUan7Z3X9nLzBtnf/CmbJBY4fdEAe21ZsFN2kFfNNq2SXSIeCPHACSVApQP+ij4lPcJpzov2UDLgyFwm4DYdTB/vM8Darhd12SH3L7EarT0m0dv8sr0/upzdpjGMwoocpXvwXJ83AUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792513; c=relaxed/simple;
	bh=NMuRMG7W2yArBvXJuBrSy9xQpe5FzjrufpnSySNdkXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUbIJeI3aXqUK2Bgn24AKa+g3j8B9Yj4b8wRfUrZhATRQ2gNliC4vwpBFleVwH+/BBasgsNlB9NfqBl9ttE5uU5ktSOzQ3Xbe2eV7USXr5EQ4EA8ks6T7rT/GKvCzbaFeA9r+ftgvgtIh3hD1r7FSW+KUQpf9CeRYs9Z83TZVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU3TDn8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU3TDn8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27971F00A3E;
	Tue, 30 Jun 2026 04:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792511;
	bh=pKyd33wwPt+YfMdA3ISpRxLndBZ3QlqVZ2syg7ZfqQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cU3TDn8d6HhHxZPKkBRZkU0tc+DnWjph7oFfRfkN8xCLp+nzZMDjr54xh/A/JsbK4
	 9k36F0oD/ABX6Uxk/uBMWiD/QpmkyF5NaBeatqumHp7+8ebg8o0td7TAYGYGAEaxCP
	 PiF/CE19xi2EYfrRn+OOKNXYqJNkv9DwlR67Rko+S5C3jsNhBr6sbDTFexKqiAvlwO
	 Lr6WjF/iDRTqYDE7bUW8u1Akz1eKcUcIq72Cf2dP+MX1iMk6FdMmBeEAWKqjE/6qzY
	 EAqt5CWcxWBFrf+DX9a8ElXNHPeFscMsGgzqtFC6BrEgMTGPWSNzbcFjw103npe4Qf
	 rLnRZ6np3m6Yw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 18/18] mm/damon/core: remove damon_region->nr_accesses_bp
Date: Mon, 29 Jun 2026 21:08:11 -0700
Message-ID: <20260630040812.149729-19-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No code touches damon_region->nr_accesses_bp field.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 10 ----------
 mm/damon/core.c       |  3 +--
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 02ed47c558cc2..805e089ff4f2f 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -45,8 +45,6 @@ struct damon_size_range {
  * @ar:			The address range of the region.
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
- * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
- *			each sampling interval.
  * @probe_hits:		Number of probe-positive region samples.
  * @list:		List head for siblings.
  * @age:		Age of this region.
@@ -59,13 +57,6 @@ struct damon_size_range {
  * not be done with direct access but with the helper function,
  * damon_update_region_access_rate().
  *
- * @nr_accesses_bp is another representation of @nr_accesses in basis point
- * (1 in 10,000) that updated for every &damon_attrs->sample_interval in a
- * manner similar to moving sum.  By the algorithm, this value becomes
- * @nr_accesses * 10000 for every &struct damon_attrs->aggr_interval.  This can
- * be used when the aggregation interval is too huge and therefore cannot wait
- * for it before getting the access monitoring results.
- *
  * @age is initially zero, increased for each aggregation interval, and reset
  * to zero again if the access frequency is significantly changed.  If two
  * regions are merged into a new region, both @nr_accesses and @age of the new
@@ -75,7 +66,6 @@ struct damon_region {
 	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
-	unsigned int nr_accesses_bp;
 	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 83753a53e7b98..59a91a0ab6d45 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3630,8 +3630,7 @@ static int kdamond_fn(void *data)
 				 * aggregation, and make aggregation
 				 * information reset for all regions.  Then,
 				 * following kdamond_reset_aggregated() call
-				 * will make the region information invalid,
-				 * particularly for ->nr_accesses_bp.
+				 * will make the region information invalid.
 				 *
 				 * Reset ->next_aggregation_sis to avoid that.
 				 * It will anyway correctly updated after this
-- 
2.47.3
