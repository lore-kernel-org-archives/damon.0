Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD944303C9C;
	Tue,  7 Jul 2026 04:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783399141; cv=none; b=pwPnj5qY1VzE1OIakDTeRDZuTuYzDc/1653vdLjANv6h1h4aMzaG66gZssR9VhKymlpDpT8NJU8F/A+w/gVMP4PmGieSt8pUVKdH6yvatsUY21vTl2HXUnKo2n3RQ+lKvDrNa0yk/8Y9bNkILUK3yXvOb9Aq7pMx9QuSyJZ1nlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783399141; c=relaxed/simple;
	bh=WpJ9GxyCGHspKVvlRme6iGjT3y6LDKikIaWk1XiIHp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGePNdZ9xRCalhfSGNl1Dw/fjTh+Y2X0gvrPC2AXi96pVXUFIZyAGSB+tYY6ssdE9sTWlcQRaYY5qekqL9CXoy1Mnmz0VH6uKrPAM1cfpkSpOvveJ/eVCiTpb3zE8o+8T92qsIA7MKBZwaGpnxwlnXAFtYRQ08OGOk8aXT1h0gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oD1rUo1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oD1rUo1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9C41F00A3D;
	Tue,  7 Jul 2026 04:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783399140;
	bh=BcikUZMCVNS0h///WuvRclAdjwoWFw897c+LuoOpqhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oD1rUo1EwOOqrsoZo5RHyvCv82l6uKkLDQjTWeZKHV0qeEjfSAz4HSiDXuRpVj5Wi
	 dDZpxXNMYK1m/X++YMIdva4UIXgU50n12AhjdpoqwmMxIKx0wkT9c3Nu8OhAcDbzXu
	 7fGYpRjohzkJO4yHM/ODCD/iFAHi9140IxBkneBiCOTViEYv/YWX1hZHCw9TPBzsg7
	 zoYjbo0esYlGiWTDqdaMkeDq0fvV2aBluA+uSY9FwL+pMdNiLjsfPiUNDtYfHivAgd
	 cDTQ9TVFmfUC6ssiOijddJ6W8j33jwzH/GsIhsP6o3ka879a5n07XlVZCjJI/nKDDR
	 MxRBGpkEpatlQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/6] mm/damon/core: s/accesses_bp_to_nr_accesses/sample_bp_to_count/
Date: Mon,  6 Jul 2026 21:38:22 -0700
Message-ID: <20260707043828.97900-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707043828.97900-1-sj@kernel.org>
References: <20260707043828.97900-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

accesses_bp_to_nr_accesses() actually converts a positive samples ratio
to the count.  Rename it to better describe what it really does and not
confusing for more general uses.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e710e2789085e..ca530faaa4f83 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -876,11 +876,11 @@ static unsigned int damon_age_for_new_attrs(unsigned int age,
 	return age * old_attrs->aggr_interval / new_attrs->aggr_interval;
 }
 
-/* convert access ratio in bp (per 10,000) to nr_accesses */
-static unsigned int damon_accesses_bp_to_nr_accesses(
-		unsigned int accesses_bp, struct damon_attrs *attrs)
+/* convert sample ratio in bp (per 10,000) to count */
+static unsigned int damon_sample_bp_to_count(
+		unsigned int bp, struct damon_attrs *attrs)
 {
-	return accesses_bp * damon_nr_samples_per_aggr(attrs) / 10000;
+	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
 }
 
 /*
@@ -899,7 +899,7 @@ static unsigned int damon_nr_accesses_to_accesses_bp(
 static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
-	return damon_accesses_bp_to_nr_accesses(
+	return damon_sample_bp_to_count(
 			damon_nr_accesses_to_accesses_bp(
 				nr_accesses, old_attrs),
 			new_attrs);
-- 
2.47.3
