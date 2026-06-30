Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD83E1232;
	Tue, 30 Jun 2026 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792512; cv=none; b=rco7UDlIw/IGto+6AaHHnK6gkXIGef/XbK67Jid/er2p5s9wlF9hidVpaaih3m2qn7HeKeWRwWO+TyWYAp+wK7Ybq9DGzNynAw+U1A1YsBj/X8shPV//wZNd6WjvKZeXXGg+90hnNUXP9yBzbVrQ6+74xajX3mgQLvOb1VnlJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792512; c=relaxed/simple;
	bh=flbG3X0UrMvbJXX9mlqskcy9iAs0hAIRyR4ZWOIOTSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8xNWGKwbwguV5gReDmazOMhEzKHy8ID64K8NCuY1j+SBcgyrSPvebCrdFXPc2wZNdptl6da5bCxykxOSbXxxh3p0iB8NzSlqjq3zGdYOwFZa1aT4sEEs/33Ylh5hShAHlWZdv7h0+SbA2AkS427bb7tFlwNHqz08uT0j6xq2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyyUENg/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyyUENg/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9831F000E9;
	Tue, 30 Jun 2026 04:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792510;
	bh=REsPlW5rz/ejlgovHVfV3cC0b+76O7l13CD/hxOvCFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JyyUENg/cAqjSWQn4bv0oGWIwmqm8pgtqaZyga9Jvka1KwCzhMmeAZsKfg2bVxj2T
	 +YX4Ylc/1q5e2v46hikoith015fy3WE7EqmvQqAXZWqTp2e3Hh2zbFjQPoy0H3XBQ1
	 kMmWGgp2+hohBZi/2P7NIKAW2iO4Yow8zy11nMdyAUNjOY1Lu43zg0En+lVRthT60f
	 nSpzXPmmxKhu1fkdRYaJLtZeM+q2CNezNC32G9f8b5QMawZie8mYYXQeKC6Wfvpeat
	 WJDrmp706pp7u1OlIkbtPXuN3UY9q8b/V5A++W0rbFgNJnrldm2W3dmc3t0j0nFDsX
	 ci9AruMdQT8ag==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 15/18] mm/damon/paddr: remove attrs param from __damon_pa_check_access()
Date: Mon, 29 Jun 2026 21:08:08 -0700
Message-ID: <20260630040812.149729-16-sj@kernel.org>
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

The function is not using the parameter.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 8530213086691..6172464981730 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -80,7 +80,7 @@ static bool damon_pa_young(phys_addr_t paddr, unsigned long *folio_sz)
 }
 
 static void __damon_pa_check_access(struct damon_region *r,
-		struct damon_attrs *attrs, unsigned long addr_unit)
+		unsigned long addr_unit)
 {
 	static phys_addr_t last_addr;
 	static unsigned long last_folio_sz = PAGE_SIZE;
@@ -109,8 +109,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
-			__damon_pa_check_access(
-					r, &ctx->attrs, ctx->addr_unit);
+			__damon_pa_check_access(r, ctx->addr_unit);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
 	}
-- 
2.47.3
