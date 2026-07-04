Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31C374A17;
	Sat,  4 Jul 2026 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783188709; cv=none; b=PePBsaWVDF2B2C5esdKRdnZBmHWsSIm7z8LE5KAKPUzTjPX0Thka9CLKs3lxoN3tSL5JTj5oprSx0vs8j0UQN52uEbEwUkCbi+P8EzzDwi0jYSl6DvTpaH10kCzMo9SFqWezm3amAYa3GrNTjlBcLdVsY5aUmDN24XzuHnFQiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783188709; c=relaxed/simple;
	bh=HJQcidpUpSoaFDrjW7LdUf/3O9Ylf2kc/fs9bqgKr3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwpFbpwcUwdHOEA5NRx9f47VrZOU+qr4VpasZa64AMy0XQZy4Xgs5It64IXxJnAldjC/ex6Rq89hZw0XIuSnn3U+5vEO0DUFblHbgbThtYQPvu0h6e/AxmAJ4pT243mrQ6PUr4vAqQ35l/EpltDV5XUT8JUjWEJY1MyAReMnDGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5ZJUxpW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5ZJUxpW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D7F1F00A3F;
	Sat,  4 Jul 2026 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783188708;
	bh=d/v/dE+FlmtwJgj5yRteS0MOxCozSQuxW5M8Uj1RzSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V5ZJUxpWz862HugfoX3aFjblmAT973RDwU1aVjQ/Q7JOJ19iIufweaC8WF5ef9w6x
	 EXlmDtjp5nwROCpEyb1pmIEOxFPCIFm1f/Ml18c4ntIBh7FF7keFtZizhdxvPluorR
	 Ih0C8Zn0dgWnCWf3zlpVzb2bGrZ8C7mDH+A5Lwrn6Wp1ngUtLm+nVUywYGi99B551o
	 iUG8qjkKnRjUYvouHuXiLhfw1NlnoHynBxwOcpjNOmiKgSty9VtVHYz6raltLA07zS
	 MvEKxcicnY28RVv+eiYgYJXY3qx69ZS7374EofmWivo+imw1wrVm4evap2Bxjfqzip
	 KZXaPwLFE/veA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 11/11] samples/damon/prcl: do not stop DAMON for damon_call() failure
Date: Sat,  4 Jul 2026 11:11:34 -0700
Message-ID: <20260704181135.132956-12-sj@kernel.org>
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
