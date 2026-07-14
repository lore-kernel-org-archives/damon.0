Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADB47DF85;
	Tue, 14 Jul 2026 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039759; cv=none; b=iJtYICyB7w2UibynqZD5GKu63vUUS69Ewykfa8qcEcHaBDn3o+jIoRN4YLStIRfrlqgZvZaVxqXnHBnLb9sXkmGe66q9WW85fL09v2XQvWeA6KTBuMTsKZq3t11zs88CoUYa+0/pgfpWWLPjCSRrzzhVlD/MgG3g0t+5FLob6DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039759; c=relaxed/simple;
	bh=dRXX2J+TsX65dbJuv4S6AqbJqGvS7BCYhLBktYK5WKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upCOqmNXUlIRE+2nuDIsk2zBH721T5vk4nbd8eXqpuuCq+/rjNMNjQcn6OFXnONG4VvSXrVDhoUyx3mGeHHZ3QfDVggO6F9V9B3fXS99HgAoIl2bEJiHY/YkbMocEozssV9sXPwH/KtFawHj5XtUA9yzutObDA1V3jJtegKJemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPizrGqx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPizrGqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B1E1F00A3E;
	Tue, 14 Jul 2026 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784039758;
	bh=UrQWXD0bifnsUsYgqcN+mYTdFMuNVs+95dSBQVBP0NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kPizrGqxSPrlQ0S99osZ0phDKd36Guwa0fDDzPkVnkKOq5VFh9VVdj3eS2argD0oy
	 +HDpzY5VSllxbPjICaKzm4WWEzlTu5/QxfV0QG1hnCWCFWHyoadn76/HbrC5s2/I9D
	 Ad6sZD4r9FKuklLhwdufn+NrESCE8OIIoqVjedHYsqR9kZQ7spqdA6Ursp7acIK6Ng
	 BCz7tgC1cC8eWw/16pFxoRjs3FaEb7OlRxbS6xhH5j+b984ShtOdYUaX3sbY3eAdbj
	 ECAV6F/sA2d0PDRDH1fR//7+2qCm9gZIOgfkZCe9vZxbX16nrGuXIVqigkjoSzVmOg
	 caL2SuWnLe3UA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 09/10] mm/damon/sysfs: do not directly access damon_ctx->ops
Date: Tue, 14 Jul 2026 07:35:42 -0700
Message-ID: <20260714143544.101305-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714143544.101305-1-sj@kernel.org>
References: <20260714143544.101305-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_ctx->ops field is intended to be used by only the DAMON core
layer.  DAMON_SYSFS is directly reading the field to find if it is for
physical address monitoring, though.  Use the API function for the
purpose, damon_target_has_pid(), instead.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 60a1a9e4ada34..228ceb4df5f97 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2051,7 +2051,7 @@ static int damon_sysfs_add_targets(struct damon_ctx *ctx,
 	int i, err;
 
 	/* Multiple physical address space monitoring targets makes no sense */
-	if (ctx->ops.id == DAMON_OPS_PADDR && sysfs_targets->nr > 1)
+	if (!damon_target_has_pid(ctx) && sysfs_targets->nr > 1)
 		return -EINVAL;
 
 	for (i = 0; i < sysfs_targets->nr; i++) {
-- 
2.47.3
