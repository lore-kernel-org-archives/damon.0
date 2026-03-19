Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85303E9F65
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936990; cv=pass; b=k4rYPhUn2boNbiS+mTaL1oas12FaXOOl5/uqix7BM6w2NbufPVkAinOZ6EffnjzolN4jElUSl4St5TstIxO/T8fQoA8LwR/4WSRSq4SJqjgs2VNzGhLQyaEHAq9T8MHgI3RkegIT5b8eiuRpQi+siqQJzlCgmuC1z3vcX7AlvK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936990; c=relaxed/simple;
	bh=iwymhH/m9Py0cGUVWLndn+DBf0fQjyXOlUYWwZOaY80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6A6PxA7G54SehOgpSX0ibkwBtxJ+hwnRF8Xiq3c0sT70S2pR60+iC7Cv3HLT/XnRw/Uz8ZLGQLtZHhBTevikRalP+aKGUfFeV/m+AXW37lNq94FR1EROvxji7j5/3VBIfEfVl+sHWJEtRTmbji4GfUqJOoUO8xT9CxaOO1RPpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=PZ1EAUfN; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="PZ1EAUfN"
ARC-Seal: i=1; a=rsa-sha256; t=1773936984; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YtQ+n5adLWRhRlwMN/ButLVqI0ZbmvaM4gIG/cxPAIns1uVOQeOzWKZXRGp8VlENj/JNDx2sseAgMMmdXvRH58iiFRtgcnNImUH+HWs9OYrkYw2/ocDaCLbtnD5siUZ0uTztyznh65ajAGVffP2ib7MQfb77yi9sW89teajhSJA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773936984; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kSzfJu51IfOy1UEq0KOHRM7ctnyUfpNOAlgbFOZRhU8=; 
	b=i4OEJ4irdtfNq67p49ZvD/NSOBuDo0sKHHeBAMzbko+Ov6MmRMddMlGwx2xy4hjXKG3xZV+lx9unCeP82ArIy6gq+XVyRXo4v6XbDuyf4CS9lLdT7BjSjVP77uHKRXLnvyr2ESoZOQyTuphUkGQVk1eHbu+b1SQJK6N9H3ylouM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773936984;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=kSzfJu51IfOy1UEq0KOHRM7ctnyUfpNOAlgbFOZRhU8=;
	b=PZ1EAUfNuAt4xkB14D2sffseN1vgACG0eDvUu8GwDycAxeSJFtCCc0+pnD7cg7ja
	bZcNE7w3uJM1eb8Rsv1Wy460xJ1nUE4XoPYPC9njngndvZKQuj7jcyuHDmgySU6z20+
	Aay50qDM0MVv/Vn+XKFpbCrLcHR/9FpHXkmwTiqs=
Received: by mx.zoho.eu with SMTPS id 177393698328213.931315546403994;
	Thu, 19 Mar 2026 17:16:23 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 2/2] mm/damon/reclaim: fix min_age_region truncation from unsigned long to unsigned int
Date: Thu, 19 Mar 2026 16:16:20 +0000
Message-Id: <20260319161620.189392-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319161620.189392-1-objecting@objecting.org>
References: <20260319161620.189392-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

min_age / aggr_interval can exceed UINT_MAX with extreme but valid
module parameter values, silently truncating min_age_region and
lowering the cold-page age threshold below what the user intended.
Clamp the result to UINT_MAX to match the field's type.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/reclaim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 9b55df304e51..303c64a56073 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -170,8 +170,8 @@ static struct damos *damon_reclaim_new_scheme(void)
 		.min_nr_accesses = 0,
 		.max_nr_accesses = 0,
 		/* for min_age or more micro-seconds */
-		.min_age_region = min_age /
-			damon_reclaim_mon_attrs.aggr_interval,
+		.min_age_region = min_t(unsigned long, min_age /
+			damon_reclaim_mon_attrs.aggr_interval, UINT_MAX),
 		.max_age_region = UINT_MAX,
 	};
 
-- 
2.34.1

