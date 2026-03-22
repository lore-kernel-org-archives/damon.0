Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557C4207A
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205216; cv=pass; b=cAtur/yF2edpGqifRBriaxfZEeSgGpwWmJfV21DhbA7SmI2oB5uhVbkqjo6TNy/zoumkdwCZC/EB5GhANgDsZbUUixiVb7i9JTalJAPZ2yMJ7t5YBB3lo6ClXVUukqhDBy6FGjwX/ak1odd14C65XycfZXldI8EiMHPNfyhFE1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205216; c=relaxed/simple;
	bh=W8dBMfzxr8V0OtT7VOhajRCtCl4Kjb5Y7IinemsCa/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QDgw8bNk5VHNhIELaD4PFjAn24O/FMTYn6YScRNsMXsYMrVwC90g7eKdEiWgZTA/BN8mnZTrqq6pfef70qIT+G1gLVlq+ycsYU1EEmNuMOKLQyqGwI3zJcZwNboINaGA5cPcPpkkddPgYJtWS0mY0e6lSj2+ogphM/mVPOOs/wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=l8pYAPpZ; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="l8pYAPpZ"
ARC-Seal: i=1; a=rsa-sha256; t=1774205206; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Zzg2qELQVF3tfbkI0jcLJC3JWMCMtcernSKxBrdjto4K7Yg4WRfokio6Ac69aoKIlRxZOBeEGHVTs8CUZz/XOlLCHBGKk71+G4LOqgWgSi86LS8VGEg+puyCjO2kAIVledLxM97n4kUiIw9ByYpB3XJKdPGPjOt6QLQI5Edl3nw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774205206; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=05a6CfwNgkeRFd6GC3+9/VEwzrQUx3NsZy711o2AxTU=; 
	b=FmwsXgy/tGA1atYBBow9L+u7K+btTqA6f6EOL0MovVJTnoXuTAy1727/useKcsWtDbSFQArKfmt6IaBS1Zu8pypOTnMjAssJeMho8vSJ+w7YDvJmnqmEzvQZe1K67yT0Y+iMtS3FZweCZLCJlxKr1kfKQAIdvB7jDPywNamm6u8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774205206;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=05a6CfwNgkeRFd6GC3+9/VEwzrQUx3NsZy711o2AxTU=;
	b=l8pYAPpZo2Kcy+acCpggJdzpcEbMTQCfAJKyF+uCcZ7XdONfJUSGyNon2hJpk7zi
	bpw+ckxFeu4fIHtH1mXn/7ip6ZeJKjHODk/n/LN9FRP9p4xL6TVDWrdgJnr1kkEW0j5
	PzPQBQUUAP7e25C0MvLAU74AV9552/N9XCzjGUu4=
Received: by mx.zoho.eu with SMTPS id 1774205204010549.1240841832505;
	Sun, 22 Mar 2026 19:46:44 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/damon/core: eliminate hot-path integer division in damon_max_nr_accesses()
Date: Sun, 22 Mar 2026 18:46:41 +0000
Message-Id: <20260322184641.251966-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260322184641.251966-1-objecting@objecting.org>
References: <20260322184641.251966-1-objecting@objecting.org>
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
index 6bd71546f7b2..fffdb08326a2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -960,8 +960,7 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
 static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs)
 {
 	/* {aggr,sample}_interval are unsigned long, hence could overflow */
-	return min(attrs->aggr_interval / attrs->sample_interval,
-			(unsigned long)UINT_MAX);
+	return min(attrs->aggr_samples, (unsigned long)UINT_MAX);
 }
 
 
-- 
2.34.1

