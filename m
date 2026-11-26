Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727191;
	b=seVK1VN2cGJKGWvZcKxk4kOQCueskhlevlQSqkWGYYhrKq6nBsdJQxA74sA/N8QKUeNA
	 r1NRW8K9HjlwOdlhGvJMkzmguA4TyIWeZQgOIBFb0Nu6a8xT4Fzl0HsiPbewAJmTE7j/v
	 ID7hA/dcoqQlcWzfovQ0j5NmkscwWx4UJ3PkNeJv0byB0K31JJHAaFH5k0KGLBH04hgZ8
	 KKRPdthVB4PH6DcsVaql9/VWiT10uZzVqmZHTuAx1g1DjNWQtYFAbDNa4GBi/8+kpstlY
	 9/fOMICzfilZLjAWAw0azr7fQqFJSwGCXGPT+/M9o8PT87XhQ0PxKfseSiFIVew+l2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T1k7cS4T7fbvLQ9xtkf6Q3ovPqDp4JjE9Zd2xNYNrCk=;
	b=M3X0dy5Ynyclk91STK660LQIXLelsvjJKI8YoWJ/yoUFtQEQixlaCzsyYSEx5yJWXiVY
	 YrOxDD6Wv/hgc3nCn5k9OCytcSIhs1HwhPDTQabZgEZUdRK2KsRwHT+p7LYwC82J2AhTT
	 OxXIAYQ4zVzCoHezLBweab+jle6SnjN7XUhg8XhgSZWYJYOoQDveurN1aELiL8uINiLhL
	 GZWR4Z0+/rd37hBoZHG5pCVnbleiCoWZsgUTYNA61PWZCN9SK17U7JRrGK0bccX+PWUjP
	 9KqU8MYu1ZutBHXZFoezKr82RZ03VhUTzd6Pd+baaZK7ClvofXkVb28YOdrHV+Q36UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9XwZqXJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2572606A321
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9XwZqXJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BB81F0089A;
	Thu, 26 Nov 2026 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727191;
	bh=T1k7cS4T7fbvLQ9xtkf6Q3ovPqDp4JjE9Zd2xNYNrCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I9XwZqXJB5scNSM1baoexzAyL2kRqrqyeYxgSzd3BnJD/TwHHykcdUGhHm6mPfabp
	 y2drQbZaEUvBLcQj43YpQS64o4k77UOjBEc8X0m0u2vhxa1K7XXkoT5F7fxyNRusJY
	 82bEwcLwly75YNd9YzvcOnEBmD1JEMDSbe6zSYX57dO5ed12EJaI4c7dRfbKT3e5Wh
	 FbneKWNbKYs6EZKlYzujpJvKlQP5TDnB8g8TzgmloZ7Y1GRuoI9XupOWKC5tpj7Nz8
	 cB5OtaH4WCRQQyeJ8asN2i+2Wk6bocTWJbTo0q9viK+mP/HzVJTTASLma3ixZq10wV
	 EdQTKBR6IZMlA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/4] mm/damon/sysfs: remove damon_sysfs_cmd_strs
Date: Thu, 26 Nov 2026 13:06:17 -0800
Message-ID: <20261126210619.97634-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126210619.97634-1-sj@kernel.org>
References: <20261126210619.97634-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove damon_sysfs_cmd_strs, which is not really being used.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 5a91a1c3e4389..3e41e030ae731 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2240,20 +2240,6 @@ enum damon_sysfs_cmd {
 	NR_DAMON_SYSFS_CMDS,
 };
 
-/* Should match with enum damon_sysfs_cmd */
-static const char * const damon_sysfs_cmd_strs[] = {
-	"on",
-	"off",
-	"commit",
-	"commit_schemes_quota_goals",
-	"update_schemes_stats",
-	"update_schemes_tried_bytes",
-	"update_schemes_tried_regions",
-	"clear_schemes_tried_regions",
-	"update_schemes_effective_quotas",
-	"update_tuned_intervals",
-};
-
 struct damon_sysfs_cmd_name {
 	enum damon_sysfs_cmd cmd;
 	char *name;
-- 
2.47.3
