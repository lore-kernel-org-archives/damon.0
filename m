Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F5A3612D5;
	Tue, 21 Jul 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642020; cv=none; b=ejFjuq7NBEtvanoHzDHMpUj3tOf/vPfytuJv88ZcUZl7K+6A8jvs2coG8Fs+FsDzLVFL6UEfO96Ya2TuTJVuisx4C+88ligJrGNWY2lpQBcZBMJE5iH1r+9Xnt7bbVeUsGjsJc7e+BkRZey+qh9bbqMZfhpjy5oEszueQ9g5LtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642020; c=relaxed/simple;
	bh=zuSg7CfhprTa8DYZEvqa72samB9ZSfwro8aqNan+d2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i92HEbe+7zTj9Qp/JoMPOGqiR9AhTw70yiiAGHxoAdmDv3o1YEN9wU4BSioxgAyLNBQivcWQxWB1Rcn7VAOlI4VTSlQ2DcGMgklCTfym7DraZI6HySDz+9i/xc7X9WZftLeYT2gwOXG1DrZwGr95wk6g9NtVRot+qTtSQizVh1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUeIFeUP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUeIFeUP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1751F00A3D;
	Tue, 21 Jul 2026 13:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642018;
	bh=mNf/cdUew/gFGj0UFSuzSVbRHcS8f/SY3lXxbgCeCu4=;
	h=From:To:Cc:Subject:Date;
	b=QUeIFeUPOXu3qMfEeS+/Rqs9h9/7NJsOupUeDwYD7GSAlbFjqoilBhGwPe4jwcvC2
	 AMbAFEbCQpr1VD9E5QXep4JTCjj+OZzRzWfJd8X0Wp+nw6gWPU34OiJzZAleZPTtoF
	 V7VS0ioGlZ19N631rBoQxZc8Iczav011yqFA30FidUWH2fIvZBcUOybfKDWLM5UvXp
	 ERxkSFfTnpxx/V/yl0NSJX94ENzNNwBkZuYjVj5VnFSct4n2V11BFYUtwsLAuJeVJ/
	 KPlqv3DuutJ5QXVbnmG/JvL22MYJOgqLnGev/ndwKqR6NUGFzpQFARvEPsDrqHFgXt
	 pjawHD4fZ3XVg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Xuewen Wang <wangxuewen@kylinos.cn>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm/damon: remove trailing semicolons after function definitions
Date: Tue, 21 Jul 2026 06:53:31 -0700
Message-ID: <20260721135333.241106-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuewen Wang <wangxuewen@kylinos.cn>

Three function definitions terminate with '};' instead of '}',
which is unnecessary and inconsistent with kernel coding style:

- damon_pa_initcall() in paddr.c
- damon_va_initcall() in vaddr.c
- damos_get_some_mem_psi_total() in core.c

No functional change intended.

Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260714075358.1592393-1-wangxuewen@kylinos.cn
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 mm/damon/core.c  | 2 +-
 mm/damon/paddr.c | 2 +-
 mm/damon/vaddr.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e0122376f43d4..644daf5a16560 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2791,7 +2791,7 @@ static u64 damos_get_some_mem_psi_total(void)
 static inline u64 damos_get_some_mem_psi_total(void)
 {
 	return 0;
-};
+}
 
 #endif	/* CONFIG_PSI */
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e4f98d67461f5..5a6a78054784a 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -447,6 +447,6 @@ static int __init damon_pa_initcall(void)
 	};
 
 	return damon_register_ops(&ops);
-};
+}
 
 subsys_initcall(damon_pa_initcall);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index d487b7a4a1042..4976775fe2762 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -959,7 +959,7 @@ static int __init damon_va_initcall(void)
 	if (err)
 		return err;
 	return damon_register_ops(&ops_fvaddr);
-};
+}
 
 subsys_initcall(damon_va_initcall);
 

base-commit: 4304be1e26c22e99b8719c5093ece877708b53e7
-- 
2.47.3
