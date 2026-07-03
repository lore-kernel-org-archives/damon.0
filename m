Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE952EEE83;
	Fri,  3 Jul 2026 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098372; cv=none; b=mT5ryqxxJq2A6vUmMA1AA/IQPrFz+ql7YWP3h46A1nivM9GoyQu42LjJ6AMuhPpsKO0Zul3OhHGG6tB7roKPFcq22TOCPH8k+vEZi8Y6AaRyLPfVt4Yky5xeRJUUkky2/sH7O9xEfh5bVkZSDHPGVkNHpsZ1ZvmQ1dNp2u9I9es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098372; c=relaxed/simple;
	bh=npR3s53VqU/knNxRjuMPifIX+g4J6zWNMvSfAmCzJoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5CXRVnX7f+iLnnsKkYM7HSwN3uHPe+lCR/TBYQMcK68dnfXFi3kdAA8Idy984ryY/Zr4JWsDp1DNOC/gIIAFFNKRezrcpI1p1qoaUdhW3wHGdTqV7b0vfmzvY6YGDAb1+olJPo/u7qVwa72VGkE+VKErWFGA1h9Fmz50aNGA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PraD7imw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PraD7imw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C89D1F00A3A;
	Fri,  3 Jul 2026 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783098371;
	bh=PtgVIn45F2jyWQFHDav9RTyiur9MFQyJ2Q0LK1nrhNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PraD7imw/5IQSWlUC9sVvd8yA2hPPxE25ax1vAwHdkpveOZvrxbKsngMpI3fQV/dC
	 MDNlO9/Jdia81RWJlv1HhTU56YaZGCXJH4uewnARWwDxdqmbPcAnmjHGkrepEg64DB
	 gsUKcURTnuE8dIEVU015jKAhFrm0DNkofCcGq3Q9pOZQB0NCL3PP4cJdu5YVcNS8hr
	 u7TjTEy2HrXwaWZ+jHGQSRo4Y12iA8q0ReKgXpu+h9wYndTrFUpvcQt8wg8UGc35ig
	 joZe6qgouYXGkfHY4YWQsmDUA4nyplvPecPVGPJA/wmLzB3u/k72nngA8fbYSAxN08
	 dsNY9kfB6/eZA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] mm/damon/sysfs-schemes: set probe hits as pseudo moving sums
Date: Fri,  3 Jul 2026 10:06:03 -0700
Message-ID: <20260703170605.94472-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260703170605.94472-1-sj@kernel.org>
References: <20260703170605.94472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface exposes damon_region->probe_hits via probe hit
files.  Because the counters are completed only at the end of the
aggregation interval, users can show incomplete values if they requested
the file content update (update_schemes_tried_regions command) in the
middle of an aggregation interval.  Set the value as the pseudo moving
sum value of the counter, similar to that for nr_accesses.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index dbf2b0515d582..32f495a96b17a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -110,7 +110,8 @@ static int damos_sysfs_probes_add_dirs(struct damos_sysfs_probes *probes,
 		struct damos_sysfs_probe *sys_probe;
 		int err;
 
-		sys_probe = damos_sysfs_probe_alloc(region->probe_hits[i]);
+		sys_probe = damos_sysfs_probe_alloc(
+				damon_probe_hits_mvsum(i, region, ctx));
 		if (!sys_probe) {
 			damos_sysfs_probes_rm_dirs(probes);
 			return -ENOMEM;
-- 
2.47.3
