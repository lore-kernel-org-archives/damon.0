Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F538A726;
	Fri, 19 Jun 2026 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897689; cv=none; b=U7VaLGQhG0+yJ7LeBT6+pNanUWTlorHSP/gq/asG18C9xInCGkxitXOUENht7cv2fVguLJ9Fpk3PT1O/2yEqrBd0cqZ3TQzPkwwfsSKqCIY8MutGcKbeb6y7khXBFRDG8kPM2sfqXykkbB0/gfmTdcVDavy5RBLnHCnoMHWPmS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897689; c=relaxed/simple;
	bh=yCgALqM9ASqF2M/Jl8ZtRhSynrCgD4Lsd6n1/rH5BqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jf5dyK4cf3xlQPzazbAKksHsf9FODU82xzkudL6JciKq7yIwwJ0Cja8knDL61veAUhZxXgVXOut6t/phf2ZXDWWv7O6X38oQO0zmzjWiJvC2iBHnrHQ/p5izkSJLkSv/aEVOfUlKt7maf5IW1Pjkp7zHfSt7p5IvqlbYflJabD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfbyDuns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfbyDuns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB351F00A3E;
	Fri, 19 Jun 2026 19:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897688;
	bh=cGEwdWm1i2XGPdtfoqBvAk2HJiq3M8DXniB/T4RFsYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YfbyDunsJZH2Wt8zzLZmJmrjtSndBIdr0N5RdX4YVDTfxX8QSKEOIAvdW3Bp6rZxW
	 0nx+ze4sL0CfTsd+H+AZMpskxmcm4cHvEhz/zVhuGw1gS9GpdBeTCobzKGzWaQ/Zuf
	 QRqIfR2DV0R4qsPt1iKfeo5llmSstkjqxO/bG4Q0iZ7y4WzWWYww2MNnddW8Qp6dNQ
	 tSGzdU8yqUD0o9N7kW0uVfzFMwG8CiDudVOAfsaSToli8PnSQChhwOIMd2aCUA9mHK
	 VwaoZt4kU+NzN0sYjcqRjlOTPyP+AAzhwdWzlZjoMyYZtfyBJsUAFKCjcm0AOPzEaN
	 GF3AIZTsxd6vw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 13/13] mm/damon: remove damon_region->nr_accesses_bp
Date: Fri, 19 Jun 2026 12:33:58 -0700
Message-ID: <20260619193415.73833-14-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619193415.73833-1-sj@kernel.org>
References: <20260619193415.73833-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No code touches damon_region->nr_accesses_bp field.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 16e3e0910526b..cfd653c3e88cd 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -47,8 +47,6 @@ struct damon_size_range {
  * @ar:			The address range of the region.
  * @sampling_addr:	Address of the sample for the next access check.
  * @nr_accesses:	Access frequency of this region.
- * @nr_accesses_bp:	@nr_accesses in basis point (0.01%) that updated for
- *			each sampling interval.
  * @probe_hits:		Number of probe-positive region samples.
  * @list:		List head for siblings.
  * @age:		Age of this region.
@@ -61,13 +59,6 @@ struct damon_size_range {
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
@@ -77,7 +68,6 @@ struct damon_region {
 	struct damon_addr_range ar;
 	unsigned long sampling_addr;
 	unsigned int nr_accesses;
-	unsigned int nr_accesses_bp;
 	unsigned char probe_hits[DAMON_MAX_PROBES];
 	struct list_head list;
 
-- 
2.47.3
