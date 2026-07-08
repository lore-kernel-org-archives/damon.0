Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C03AE707;
	Wed,  8 Jul 2026 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474381; cv=none; b=Kqlfcw26wa8EEtcVHSNZLRBkM2M5pgRek53MP9cjLXZbYQVhdOJOWz0qj0lN9rm5AWFk4HVTBi333wQxQZ64krC7PayYU7MFQAx//w9ptj53019i36Q477JyaopvsScVvGX4HxQyF5yhLZLGv7C+R3pS3rykue7r5fib8GKhL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474381; c=relaxed/simple;
	bh=N+xN3CluLOBOkn9xtHqn16aeWaAwK4USSNvEYrH9q98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRvft+F3Q9x8vyaOLUZlGjldXSYS27lNZmenlqy/S6GZil+xQHxUVgzSooq2KMalObcKyxo1QeAoWaFkNOf84G1tYseWRUB1mJn4sknr7RZjWDN77b8iHJOjNN2AwwiEfXo7fSJr7LyB37uLYvN5qUlLSwRp0KELCUlbLhTY/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL88cXuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL88cXuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61EC1F00A3D;
	Wed,  8 Jul 2026 01:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474380;
	bh=oA5QgRVwAQqXAsPa92ekv3Nt4l6hxznyCttmnCPVif0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oL88cXuuN8395QUQrNiGFeS/FEhjboGc03PzRq3F8Ry62o72w9e6zoUHoVtcnd6do
	 OE798hXX20x+FHZaHbOoz6U+lzWzhRrLbQGsYZj/+wHM+hdesWMQgiMWDDVWLzrqWa
	 /2oU1gnFB872VGjGYubgjFoWaQMA6zVHdCL56NX74mpo32E+hF6N+d0yrG9m8u3a2g
	 /1Qpc7Psaw/yknQ37PP6I2MTKOicvv9z13FB8GC7pbntqTosTj+I85b+maxxDhm550
	 67wjnrT3lzOnoaAzgE9xKW1tOdPyutfKD1r1mn6GSstGZEDiqD4d30Inp60fr6V6ss
	 aA0L1YendXmaw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 4/7] mm/damon/core: s/nr_accesses_to_accesses_bp/sample_count_to_bp/
Date: Tue,  7 Jul 2026 18:32:47 -0700
Message-ID: <20260708013252.95888-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708013252.95888-1-sj@kernel.org>
References: <20260708013252.95888-1-sj@kernel.org>
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
