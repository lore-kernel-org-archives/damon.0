Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3023ABD96;
	Wed,  8 Jul 2026 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518857; cv=none; b=s2pmOXYKHfjvmkcnAl82fv9d1elOfoIWseDzwUA/7ntwrbjGf9xdIxF0/u1DLAnSdWYESNFEs6peTmpKylbvNtuJ+dZseQvc3XXrpwW0z0f75IfPA05eKeCMsmDrZHzKbuhp+gMc9MAA8EM+uim2OJ9xHa8gux4hiqHaDbV6A+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518857; c=relaxed/simple;
	bh=N+xN3CluLOBOkn9xtHqn16aeWaAwK4USSNvEYrH9q98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5vC28RO7+AAeWPnLUP2Yfr3qeqEBUrjdMctZY/KVOBoqqFrKdpvosgcpTkU6kKZyq06QkhzvgJUF9STM7Ve6uAymDsCLAw/WGPs3iTbZbbRhG/IN6AhWXHyi3oSnc/TDOrY76XIpS62CUa+YD7h51nIJVoc+HH1mjUZAGUkiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxDAyIRI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxDAyIRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA48F1F00AC4;
	Wed,  8 Jul 2026 13:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783518846;
	bh=oA5QgRVwAQqXAsPa92ekv3Nt4l6hxznyCttmnCPVif0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QxDAyIRIBRlvvQBM8CFCQngny4rEoen3UAXeC8mg1FK5beBFCr3F0OMty+Nk1Jz4D
	 +2+ESGJOPXHhlmzmbGKRNciyC0Bfh3mzmkwS4/qS+OeCNIDa21Vc/gbjJ7XG/vbkGR
	 WxurHfb1JRxYJ5rqNXaDdb5m5FyX8zT9KGQfnWnZ11EXoUh7M3tRkguqx5PSR7vnMK
	 rOee7/97UkSQc6ptKZ4PoNyM2cLAVs//AqTiprBES/xypXmeER8IAJPw6Fn5Yb3ILW
	 9NVeAiztbDRcYY5f9lXCYhQH5sBnJAlTPy1uayfjbql2YOYnQc67/IuFKbK6VMCVTb
	 oRB+kh5aauSgQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/7] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Date: Wed,  8 Jul 2026 06:53:54 -0700
Message-ID: <20260708135359.122587-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708135359.122587-1-sj@kernel.org>
References: <20260708135359.122587-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_accesses_to_accesses_bp() actually converts a positive sample
count to the ratio.  Rename it to better describe what it really does
and not confusing for more general uses.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index dea63083917b0..718268df27fa7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -883,19 +883,18 @@ static unsigned int damon_sample_bp_to_count(
 	return bp * damon_nr_samples_per_aggr(attrs) / 10000;
 }
 
-/* Convert nr_accesses to access ratio in bp (per 10,000) */
-static unsigned int damon_nr_accesses_to_accesses_bp(
-		unsigned int nr_accesses, struct damon_attrs *attrs)
+/* convert sample count to ratio in bp (per 10,000) */
+static unsigned int damon_sample_count_to_bp(
+		unsigned int count, struct damon_attrs *attrs)
 {
-	return mult_frac(nr_accesses, 10000, damon_nr_samples_per_aggr(attrs));
+	return mult_frac(count, 10000, damon_nr_samples_per_aggr(attrs));
 }
 
 static unsigned int damon_nr_accesses_for_new_attrs(unsigned int nr_accesses,
 		struct damon_attrs *old_attrs, struct damon_attrs *new_attrs)
 {
 	return damon_sample_bp_to_count(
-			damon_nr_accesses_to_accesses_bp(
-				nr_accesses, old_attrs),
+			damon_sample_count_to_bp(nr_accesses, old_attrs),
 			new_attrs);
 }
 
-- 
2.47.3
