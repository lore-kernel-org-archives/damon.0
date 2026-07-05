Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922F826ED37;
	Sun,  5 Jul 2026 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783267316; cv=none; b=lvjDJTPpW8QeeowgIlKwFZJ35hpu2Mk5MmkalJ4S9hxvKZNCmwfPgaQObnqqF/RLP8+nynE1tD+vjSKp51NoToO2Xy8TlTrSwygeCXwWL0TUjlAQrAsAHe9fWWSXguzxLRKM12P0ELarOLWEETnl0J01vrmOYw4J2IZwCuFp56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783267316; c=relaxed/simple;
	bh=lPK2d6dABp5xJhyP1SmYkyJ2enrHAy+L6wm1OON1zZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHftkF8Jv86UVqP7LDMzYJdjFV11wVp6nDn2suKERlclIhgSmhE3e4beT0tqLkMbGAgWb0g79dFaZ85SKqvtk4pTvVO1wKKdEmPyA4cWWG7JL80t7G0ttYDX+Z41suAptuGN6LFf7l7DVXucilbbWHA+d8xxep1U7qr6YUwlMtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j44vOO7k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j44vOO7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E79C1F00A3F;
	Sun,  5 Jul 2026 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783267315;
	bh=uJKL9EayamVjhe1Npp/S+XhWMj93f4Odi2+yyGbNAgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j44vOO7kQjAviWEITHTfruBjxIkGUmjYfFahmebFenaPcWLmgkypq6CaixJw48xUk
	 gT1udXlgeWutyObvHy7QbGSjS+wcn7PnmNPC9c3pCpCj1MCDFaT9tGGuPki2S7I0Oj
	 ddfYPk4BIrkS0WWa7u6xC+gfEwGVngGKk7W9/QCI20/21I5FW6K6HZQi3ScLpCpfqv
	 FoLvcVTwHIbKDFwte9mzin7gLhSp+77/tMRVGJSDUHZ0LVzjaUsko9SuB/bCKZsD0Q
	 qw0aFibpXm+5R9YGdGnLYsWF9Kl3reDBs/+RgJagFZbhYq28OjlWWOkXg/dir5/9DA
	 u46JbaVm/b7ww==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 10/11] samples/damon/wsse: do not stop ctx for damon_call() failure
Date: Sun,  5 Jul 2026 09:01:37 -0700
Message-ID: <20260705160142.97308-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705160142.97308-1-sj@kernel.org>
References: <20260705160142.97308-1-sj@kernel.org>
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
