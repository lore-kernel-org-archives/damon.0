Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D1136672
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215813; cv=pass; b=mJZcRfe6C5/XH6b+OVqdVf/cASrqdBkftHGttwPgILpoXdHH5sEHN2vGnVRGaapUoxf5yId9o42TTaC4IzRHKPtcQpIlLvBiGpAq3UbyYuVEBdSe3ak8ojnDzCCjIlAc2c04SR3dVV1YdusmvVeg+HtyPEXk+tOq9Up0UT0eclo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215813; c=relaxed/simple;
	bh=rOWYCe+k/BIIe+5LC7XeKm2ALFJSY7gLrVxnt8ztEgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnW71yJ7Yx9+oCCWhdCwinzq51ULGhMvFzI6WOJCnRrJjfGGuUIazFDwjQd/BimYyvlI4ZaUdb6zRxdQiHfrc+m7O67t2Gj6j4Zm5jPUABPNXQ+/P9Hj4icoQWVE8tbPdzRqBYpJMVw6yS+jpATr7Fr32bEo9x2ISUpPPi2GujY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=UEoD6V83; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="UEoD6V83"
ARC-Seal: i=1; a=rsa-sha256; t=1774215808; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=g3djrmfnwM1wF8ILuforzESC0t4OfSCDibNFkxXY2tfjFH++eO7eHvDlHZ37y5FKogGTpwrhCxXy1rGayGGuXr/hx9PC/BsOaCr4Ed7Jwx6HUWwKQ49i1btEuRq0QA0dckLEyfZDmNC+6CoPwiWFK7HRrnz6246w4334Dj20CdA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774215808; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RHfw9ceLzpOOGcaWO7lr+z8Bam/Q09h2DMbLR9bZIdo=; 
	b=XeWScmsA3lkdXBw/5yIV1tK/7QjSkvmrKnb7He+G7gcY2vZDAPa/5E4kuQewtBUXueJp+YKL5/KtL9H8OvgGp00Zva1vwP+MpwZDR8lUSwXYtJumHU+30wNLACSsNDGaf2HH/DR1ejCd3UHkDix+TTOnt++vz2J1qZ000Vqexi0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774215808;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=RHfw9ceLzpOOGcaWO7lr+z8Bam/Q09h2DMbLR9bZIdo=;
	b=UEoD6V83DTDz4mAiQ55yDxvgqpYmJC/+dqaSeZ9toRmtIGmBrJOc7Mu+RuB4Yrlh
	O1cDI8exUSlsCY5TVwaoPh4SHzkuq/2bnCPjyHdt02aPnSWeWa5RQ2DNtngwwgbrLhW
	f8CMBhoJxrNkcnrgPxMuTJr+tGvLpmbgPgXREwjs=
Received: by mx.zoho.eu with SMTPS id 1774215806856109.11691678942373;
	Sun, 22 Mar 2026 22:43:26 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 2/2] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Sun, 22 Mar 2026 21:43:25 +0000
Message-Id: <20260322214325.260007-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260322214325.260007-1-objecting@objecting.org>
References: <20260322214325.260007-1-objecting@objecting.org>
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

