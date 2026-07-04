Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA1377EBC;
	Sat,  4 Jul 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188709; cv=none; b=q4ieCrNDDOSgWTDBUvUjv7lR+Fb0ylW9jrNdg14tSm65uLAfMG8JoUH+dZd9YHAGCq/yOIrO53OEgD6eknys8akBcLoUGkqjFPM3tW82A0q+SuT8H5dzaqnjnKfEK6irdsQT4nRT4NhnAH5s5VxFXsr3NamgjG+O3jO9uLLZog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188709; c=relaxed/simple;
	bh=lPK2d6dABp5xJhyP1SmYkyJ2enrHAy+L6wm1OON1zZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZztxbBdGn1VwNqXYgnlS+GFSrw/BmDUBbI0C7V8UbQz+mIsyK4gds2OzV4KEZ1Z8j2WWTbctzrc9UzD2nrimdN3UXIimriN6mPFiX87eKyrpsb9Sjsv13nXyQjz7TpitSlCU/1jQGwklcgDw6hGEFKrITXBchobqoKZl2s4pSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgXbNCGO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgXbNCGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11351F00AC4;
	Sat,  4 Jul 2026 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188707;
	bh=uJKL9EayamVjhe1Npp/S+XhWMj93f4Odi2+yyGbNAgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kgXbNCGOm5ALXRQ8EPPQPiz36VyBYekMMbNUnGoHo4zYOoY1e67anoLPe3EziZ8yQ
	 ex6x61jzDw+WzBY+GTMdkZ7EjnPoSSoRwbpdHr+gWQTSiYgdJog6IvwfkdgojHZJhU
	 /4Y3Ke89nj0d/xW+e43ePUZaNolbZP2GVrIhy6/ICp8jmWIeeVehZue7EgsONxFEno
	 6F+QbLZIixiRKHVCCqmMg+qSkHbngWX4noKnF3yjVWvELXeeRJtp/rMrxUNcM7HzG/
	 YEOTJMqywJwZf6Djwmmn/WQYzXTYqxHLcxg9WuElDj9z/om3h07t3nlst+LmtQ1NWZ
	 egFMuSQHsnEYg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 10/11] samples/damon/wsse: do not stop ctx for damon_call() failure
Date: Sat,  4 Jul 2026 11:11:33 -0700
Message-ID: <20260704181135.132956-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260704181135.132956-1-sj@kernel.org>
References: <20260704181135.132956-1-sj@kernel.org>
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
 samples/damon/wsse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index ff5e8a890f448..37fd5da201588 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -93,10 +93,8 @@ static int damon_sample_wsse_start(void)
 	}
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
