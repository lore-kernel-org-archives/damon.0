Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C137AA7F;
	Mon,  6 Jul 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346803; cv=none; b=dCel/g4p6Em51lMh+CY/u6jLTU/vgONkpjFRg9zu7eqLh8mhz16Vk8W0IRd35+LDpSjUkj5l4vATCfgLXA1SeH0APf+qotjXccYJI+e2VMrRtl1CKAIsuZyYZIeOHLHiITFubmjvBqfRVxTmdrc+F+E2vyPi5hbjKNQlsAkPzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346803; c=relaxed/simple;
	bh=HJQcidpUpSoaFDrjW7LdUf/3O9Ylf2kc/fs9bqgKr3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FaQVvYdMaw40I0WSFUKlKoBgu4e1ZiIZpPpOaKnIDZ60cCKTVOr/Ua7NWXZF6O/VYNJDeMyutf8GtffItTCOzRGQw+6fJ4rSEn+1+esq36KTUq1/5n6m1VZRPfqdjD0muDxxxFzbTxcbmA4yMqVmdirqzFBmaaMZJ21A30iWsVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQOChcpT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQOChcpT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7041F000E9;
	Mon,  6 Jul 2026 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346802;
	bh=d/v/dE+FlmtwJgj5yRteS0MOxCozSQuxW5M8Uj1RzSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQOChcpTl2TPuqL9zsUDGZ+EjokiOJc2Lp4UUOjGoOpJACafr4jv+G24ulD/GEY3D
	 e6qeQ2UmdhpK23fM9NNdmtACbucaJv223j4TYOfLiDCsMuR8NwexSo5CjPLAw6Feso
	 YL8NIhbGa5/6GfD/Od5elw6DycyAj3zNnEsOfkL+CU17dSVrdujevoxKZtjTuQFTTn
	 Q0iiMBIwLhXffJu59g7xXgaQIcabcA6MuWFajO7i+87YQuyLKu+YgZvHheXRvLA90D
	 OUvBwTs45z9o3I0SJ36jKKJNepVgplwYY9ANu8/B4h6hiidNTbU4rIok4j/jXyPI4M
	 5oy0VYb4dhgEw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 11/11] samples/damon/prcl: do not stop DAMON for damon_call() failure
Date: Mon,  6 Jul 2026 07:06:26 -0700
Message-ID: <20260706140628.87414-12-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706140628.87414-1-sj@kernel.org>
References: <20260706140628.87414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_call() failure was causing the context to be stopped, but
asynchronously by the kdamond thread.  To handle the race,   the caller
had to stop the context.  damon_call() is updated to do the stop on its
own.  Remove the damon_stop() call from the damon_call() error handling.

Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/prcl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index edeae145c4a8a..842099bd62286 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -113,10 +113,8 @@ static int damon_sample_prcl_start(void)
 
 	repeat_call_control.data = ctx;
 	err = damon_call(ctx, &repeat_call_control);
-	if (err) {
-		damon_stop(&ctx, 1);
+	if (err)
 		damon_destroy_ctx(ctx);
-	}
 	return err;
 }
 
-- 
2.47.3
