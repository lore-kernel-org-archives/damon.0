Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4137702B;
	Sat,  4 Jul 2026 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188708; cv=none; b=jOoxbl067c4bAEyBEQelN4KkMpwvAZr00bk69chmZKFRWANMucHxokxUlxja3NU0ayHC2j0ewW7VzWZTgAyXSMm4FbW1AY7zcFUz4csxOjUWmR3bDVTWXfCVR8TLDoTnyMv5WH7ewPvdTYeo1D3TaxOiAYVSRjWHXcTk+DyLGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188708; c=relaxed/simple;
	bh=apYwkYgjta09iatlAqcBQzxffoVQ7J1TTsvqhGbrFRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iA/le8UiJRXs8YuwwZJYyOZHSgLbU2CTt7CldDC5Pla1yPlxgJ0Ufnyc6oWU5k/gaW3uDTeFn/XTwfBE3nAjxTuh9t9dIBsP+H5F1oGuEW+YGX3YaMXzRpztfkID3ThmjvLVyoxyVa8SfegFBt0DKIdGdLNbZLtFJIy8+9Na1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JwjGmKH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwjGmKH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBDC1F00A3E;
	Sat,  4 Jul 2026 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188707;
	bh=LS4CO1+OYp8+pSPAS3NbVTVyYCl94ZecPiNEYxC3hmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JwjGmKH8EFGhoDc831CIAQSrtTGXEUzuPUo/drzvqVbSey/lZGCwsp++HLFvK8Ci8
	 0ZwaKWeXPMjXieC/ALlqSwTXyaHUx95hH6XpL7nUeOB5Fws1aMqx8CIuX6yKtYwhJ+
	 lcj4RAd/d8qUrKXV7IRufXex9bJddFpAKI9d9p03t45Us5pgzmh9bzsqFK2rfNEf5q
	 DOYGDLhxo10R8YtJ8aZnvi7Hzn63kQTMY2ZiblwTUuCveq+EDxBvKiVXJlBykk9veF
	 WS8uH842NJmjvX5v4+1pMlqrL8SDLQbKBUSVcxuvtD3ydhikrd8OwatiG+rj2XU/Nv
	 UzPHHDHyCSdMA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 08/11] samples/damon/mtier: stop all contexts with single damon_stop() call
Date: Sat,  4 Jul 2026 11:11:31 -0700
Message-ID: <20260704181135.132956-9-sj@kernel.org>
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

damon_stop() was theoretically able to return failure while keeping the
second context for mtier running.  mtier stops its contexts one by one
with two damon_stop() call for the reason.  damon_stop() is refactored
to always successfully stop all requested DAMON contexts.  The two calls
are unnecessary.  Use only single damon_stop() call for all contexts.

Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/mtier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 90881e8bd441f..ac9c24b92ead8 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -200,8 +200,7 @@ static int damon_sample_mtier_start(void)
 
 static void damon_sample_mtier_stop(void)
 {
-	damon_stop(ctxs, 1);
-	damon_stop(&ctxs[1], 1);
+	damon_stop(ctxs, 2);
 	damon_destroy_ctx(ctxs[0]);
 	damon_destroy_ctx(ctxs[1]);
 }
-- 
2.47.3
