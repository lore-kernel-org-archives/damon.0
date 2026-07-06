Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1796E37A832;
	Mon,  6 Jul 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346803; cv=none; b=Z4937HwOdpkLHVyMIN+ebiQbQwXoFBgDnHwCXk7bpDKW+q8V97yD8JdVaKeUGyE84W6CmaX6OQgkqVahcmBPpiR1PGetkcEBgfyrPfdck3V2GhoCx+hW1r7vhqwOdrb32qwC4x3V5TXkOoG/hN00CkdlrR/Qjp8qATMwvV75j70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346803; c=relaxed/simple;
	bh=lPK2d6dABp5xJhyP1SmYkyJ2enrHAy+L6wm1OON1zZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+Wbx3dXnk0LFlkWx7i1Erh9JRr+x41ggL3Vf6AUcbQBpT7YkP7euQaUcwqZd69bGayF749YPs02Js7zmjfzzML/4X1tB1Z9Ar3E/jjt+FdNYvARFlLLnBcZHxIJtjo8OI9G+fUX4dC44jKjmoA/rZ7qWyoKnFqyw4UgQV82zbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYnsi/7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYnsi/7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5631F00A3E;
	Mon,  6 Jul 2026 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346802;
	bh=uJKL9EayamVjhe1Npp/S+XhWMj93f4Odi2+yyGbNAgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EYnsi/7lQZk75h0SV8wYhQTZqr4/UE/7hSj79P8G8kQAW5S3GW5LySUcks8jymzal
	 cUVUlAA1tSa2+9qEXoJOXe7yT9ACOgCt6r+pCKrEFP3AW/fIug80/CUbo70UrzrCHV
	 SHN8J3xk1dqDyWJtTak5Umb8nlzrsJydNrE7iuwMfnfr5wQFlP/ewtXE+zFQfjgk94
	 sukhgPZ0kc8Kv1xOVtmxR6d3QpwMFKN2Qd9sKe03qQyzkUDRqHs0kyRkvuPEUWNr3Q
	 aJZq9cX0t5wTiMlGCeUFf//57E9xMC0K2m0KjyfdxnAvqMSmgKQ7wXQ03rEChD3XD0
	 EsJg21Sa1W2Dw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/11] samples/damon/wsse: do not stop ctx for damon_call() failure
Date: Mon,  6 Jul 2026 07:06:25 -0700
Message-ID: <20260706140628.87414-11-sj@kernel.org>
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
