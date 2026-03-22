Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E39255F57
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215400; cv=pass; b=sKCRhkpLzxUipEQg0ZpyizuOikzaVXSgiim9OcqNh3ANUHgt9HGN3dOb8Fz70dSim9kSrZx42qRrNJcgEADf9Xmn2EyVwsS3zfXrCr11mSz0ntzkXOPY2KqkXH/5Lei9YFsr5RuhEeGSxyWQxfv0wUVKKsL3x6YOOARpj6uTEyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215400; c=relaxed/simple;
	bh=rOWYCe+k/BIIe+5LC7XeKm2ALFJSY7gLrVxnt8ztEgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eb+jFyMRfTjF7acnWyEdj6+rjq9jAcKem0/duVOOfzewCm79fsdd72JrHRtH5qZoSPTIsFFZXROrd5SlT0u4mmlsVTN9T0tQdxUFS+qwMiAh1jM6U1LM/q+Ekd4DVbToP9TdRUsXYuGYi3cVY8ulTT5ttZy1jFTl5PSaqIdNAUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=aGrn6C2E; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="aGrn6C2E"
ARC-Seal: i=1; a=rsa-sha256; t=1774215395; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=a8buJwdv0fnyjXPnjSzU0NixJSLF/TzSGGov6xPpZtRpwhYiknP3yA14oCX/xca04ZfzcZcIipC1n6SOe/m/Ta2/4L5q/HfwbprilyrRCEJsPBkYcuSwiIZKmFZWl5rLDXLPJOto/VdyBuoqPo7OI6F1pxu+JQDs32fOwvaBdqw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774215395; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RHfw9ceLzpOOGcaWO7lr+z8Bam/Q09h2DMbLR9bZIdo=; 
	b=FnaVTlTVD3lyrS8yuBTC76nkhF4UlOuuz5qnWSwf2JpRr9LQl8TDcWvr++N+wqKF/42cbmTo2SECFqMztrS8GhZs1ad402f18jDBv6KmcTlDwdDkYqIPZS2GlMfxkpm+9p5OoJy0sxT7xZ82TszQqyvXRoSzw33atqHt+tUxMF0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774215395;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RHfw9ceLzpOOGcaWO7lr+z8Bam/Q09h2DMbLR9bZIdo=;
	b=aGrn6C2EndXpNqu+CHTyPqGyHeNPRVVl8I/6TRMcZa8VFCFSNcoA/GL5nTKnrjyv
	ZadhJO57jhLeaZNqN7BCi8s0U2qbECC1M8FxakENBmVcRFrjCqJ25rFG9Lc18wcVs7j
	ups7ojkWYNO0m304NQ8X86fnzi6EdhEoLhjfrbTs=
Received: by mx.zoho.eu with SMTPS id 1774215393375234.02038613876493;
	Sun, 22 Mar 2026 22:36:33 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v2 2/2] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Sun, 22 Mar 2026 21:36:31 +0000
Message-Id: <20260322213631.259212-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260322213631.259212-1-objecting@objecting.org>
References: <20260322213631.259212-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hardware integer division is slow. The function damon_max_nr_accesses(),
which is called very frequently (e.g., once per region per sample
interval inside damon_update_region_access_rate), performs an integer
division: attrs->aggr_interval / attrs->sample_interval.

However, the struct damon_attrs already caches this exact ratio in the
internal field aggr_samples (since earlier commits). We can eliminate
the hardware division in the hot path by simply returning aggr_samples.

This significantly reduces the CPU cycle overhead of updating the access
rates for thousands of regions.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 include/linux/damon.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6bd71546f7b2..438fe6f3eab4 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -960,8 +960,7 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
 	/* {aggr,sample}_interval are unsigned long, hence could overflow */
-	return min(attrs->aggr_interval / attrs->sample_interval,
-			(unsigned long)UINT_MAX);
+	return min_t(unsigned long, attrs->aggr_samples, UINT_MAX);
 }
 
 
-- 
2.34.1

