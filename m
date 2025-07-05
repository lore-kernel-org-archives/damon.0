Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918EB218596;
	Sat,  5 Jul 2025 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751737806; cv=none; b=hOQYaeFkgM8XLurXaj3XMS7avd4mVlS4GWSC0QgiMknBn7u70gvSx8Dsl7P3MPKymFEclBk17qsqTedWN/NvuzqwN3fLv3/v0bau3FQQjAyQMgi/RvaG412C1QbPgR9TxFMuL8QymuodifpXAVs6InQlRcFLtVH4dhCLlkQwfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751737806; c=relaxed/simple;
	bh=fYETpL+f1upa3B/qXNGXnfx6lOT4biyhqR1VQD/Q4xU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p6GC2XWLqxGQ6im227VQ9sSXPbWiCfDfUKbbpjJTLUc1zCaCEWtatrzUI7ZN5b6Do1oHvMXgLHkVue7vmAPAa1YjnEInUQWcLyue5VUxnv3gVxNNYoFEa+92hnB1PZ8fKYklxsxKMrdJTDoGtqI+kQMcpMV36DPXM5FVWwGywfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeEsYZlU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeEsYZlU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F142C4CEF1;
	Sat,  5 Jul 2025 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751737806;
	bh=fYETpL+f1upa3B/qXNGXnfx6lOT4biyhqR1VQD/Q4xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GeEsYZlUVA4ComSOYsPQItCAvirwszoClXY2ztKs1dphKOrlRbcupiEEwoxIHDnXv
	 alPyXDmu84zR7mwF0fepsVZmeCxeZtSmndnLTv+1F2c0BfsqhE7RtiS8VoAnz4OeDM
	 WJB4OBBBSbOsXucZGtyeqMSas2OYT91d9IT1ywQqIhy/LCevGwTwFu6dWGE+p8Y8ot
	 KIwsRHBwOnXadhV6XEt1WKgrcMWKnzYSd3Upg+cg6NoN2eQCy03KA3NBLY4rHcOCEM
	 zMug6Wp0Ol5e4bSiYRuSg/lUBKkgZzNe8LFfXCbJ80GvIxd5KwvtdctuUPMwDh/PpZ
	 ZQrbQlt61q8XQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/6] samples/damon/mtier: rename to have damon_sample_ prefix
Date: Sat,  5 Jul 2025 10:49:57 -0700
Message-Id: <20250705175000.56259-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250705175000.56259-1-sj@kernel.org>
References: <20250705175000.56259-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sample module, mtier has its name 'mtier'.  It could conflict with
future modules, and not very easy to identify it by name.  Use a prefix,
"damon_sample_" for the name.

Note that this could break users if they depend on the old name.  But it
is just a sample, so no such usage is expected, or known.  Even if such
usage exists, updating it for the new name should be straightforward.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/mtier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 97892ade7f31..af168e887f73 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -12,6 +12,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "damon_sample_mtier."
+
 static unsigned long node0_start_addr __read_mostly;
 module_param(node0_start_addr, ulong, 0600);
 
-- 
2.39.5
