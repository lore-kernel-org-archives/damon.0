Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C4140DFB1
	for <damon@lists.linux.dev>; Sun, 22 Mar 2026 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774221329; cv=none; b=hmtZZ7Srx/k1mqdKArZ3CZpChpzvpdEOLkCF1vdLWZ9iUdNpcupr/PiyxoRvMFUAtWVjAyuTSVGokHtwN9nq6+SFNqK4yl1EkEsGxfzDPhhw0zH2PqKYRd+u8s6Yu122kbg9MEfwMHkx18uz59FKBWRa+lH5Q3SrTmHDlOa9kDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774221329; c=relaxed/simple;
	bh=rND0ywhj6cUnMoJdoOCvA9q3eVA41oqU5NrSBCXKMgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNJMcnHKe2CfDAgju+qKq4dqmrFt1yZpMJKMg6MCWMh1Txh8FLCjgF6qM+lChgq5uj0gMMsSZXnH+emJaPcc9qbQwhWB11tTShGVY48RZnJ+LfFdclx33ltzr46OKZhBJCzP+ziVdXMK8/IQydZWmCCSeU39qzZxxZiIHYIfrjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SufvXVkg; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SufvXVkg"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-356337f058aso2015558a91.2
        for <damon@lists.linux.dev>; Sun, 22 Mar 2026 16:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774221328; x=1774826128; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=As5XgDr7xQm/xLgUgi0Yg0ks7rPFLaYaanrZmVlDo8c=;
        b=SufvXVkgDQHhxSHeRRBb5AJsKz1m4DIGNcPskWsS9ovQAMPaGlNkje7HuBcK3E/jxH
         RcuwSVqNKkY59qB89wlwCmaIWy865hd5t9mMK7xw6hu+YEKdi2U8NCJ+hSCvF17Wqv1/
         +uPT7Lbj3SJwhvVJwshOu0xtBLH4XmNFEfwX67Xac6zqc+2VDwf5AUBYHRxBqCE0G336
         0H1Sx7780PLBPuZfHEc8XsOnCwDygBj6kQH0xAVUrFujAFwjHnnoersrj9BGguTsoux6
         zOZpm19+KvzJzOqSYlbxOblvx7inAmL1xt3Sf113HMFOw38g8v0G4UH9E+eFy9W8oO+Z
         V2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774221328; x=1774826128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=As5XgDr7xQm/xLgUgi0Yg0ks7rPFLaYaanrZmVlDo8c=;
        b=POZiSTXgI44Ea4Dr4KbyhkwxOOpCE8CPaAbpjt0cueO3tQ4wxlaxkwtICiVWMFu9j2
         ftaYUSoimaF4M3EAWiGJEQYqR9rkSi5GFkYKH2mePxH/15nMZ2Cggz/xGnRN3k6orO0z
         ZNKJYkiEQfi0VIjkQFa/VefRaFzrVepIazwEjO/9FYrZ37hFUsN19eBvUZMZHhBKSTXk
         jir/xVkMu8d8DP8VVJH00RhwGxMaZoWfWFFZWj3hVlZpFmqTI1LHjS0Qv4TsMqlzqWWj
         oExJ/1DXzmMuis4hbEiu1te/f5VooVMxpD+JkmcvATcjPY/Gx6Db1XfsD6hc1T8MEXqT
         AqEQ==
X-Gm-Message-State: AOJu0YzK7XkkDe44IZJfQavTSEcHwFqmHlII0sMh8aFdpkmjVfnB70WT
	g9rJSuUWEDMnGQEk2j+qGkFIIKd8CtgP3ks4KeP49hwcs3wNi1z9N+pl
X-Gm-Gg: ATEYQzxYDwAPb7Qo8ROo4NpQ9pCNCYaK6rZhRiSOpfu4t9T7RVBF5ZmVTRALhfb8ZuI
	QeQpfbYqc/Z6N0DT8oP/7lWvheqHTJhzBAqCbc0us4kZDP7LIobcfSX1hf/GQ2Cn5sCsewAIAIM
	3uJSCx3yKqo/E67RIYX1hIZbqRSYCG+TBALQAkU4mQTvBV5WIEv9nL4LkZrqPjlBZwibZbVRoNg
	CMQe3VMKD9Yaai+Wcnxz9fNLje8cFGl+wVZH66aN0uhDbYGwOUWQdnVNJyvCkh4khJW9+MMdEPR
	FmICyV972Um0HG1znoKU04XvQk92rjkltCcaCb1Mj4w4DTRdbyZtz1qWG9O8EvaIZktTs4JiNWO
	idwfc9lR2fTSMziKr5UIO3A6YAYXzLxcJ+aZi+vADTxPfWUYT/0CFpVv9sijUOc7YCx+Q+kxAL2
	IiCIxYKI2DTepoHM8dQ4Pjb4kbr1E=
X-Received: by 2002:a17:90b:5108:b0:35b:9cd5:232e with SMTP id 98e67ed59e1d1-35bd2ce4493mr9099147a91.29.1774221327912;
        Sun, 22 Mar 2026 16:15:27 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3eb467fsm7529611a91.3.2026.03.22.16.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 16:15:27 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC v3] mm/damon: add synchronous commit for commit_inputs
Date: Mon, 23 Mar 2026 07:15:22 +0800
Message-ID: <20260322231522.32700-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem
=======
Writing invalid parameters to sysfs followed by 'commit_inputs=Y' fails
silently (no error returned to shell), because the validation happens
asynchronously in the kdamond.

Solution
========
To fix this, the commit_inputs_store() callback now uses damon_call() to
synchronously commit parameters in the kdamond thread's safe context.
This ensures that validation errors are returned immediately to
userspace, following the pattern used by DAMON_SYSFS.

Changes
=======
1. Added commit_inputs_store() and commit_inputs_fn() to commit
   synchronously.

This change is motivated from another discussion [1].

[1] https://lore.kernel.org/20260318153731.97470-1-aethernet65535@gmail.com

Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---
Changes from RFC-v2:
- Removed damon_validate_attrs(), now using damon_commit_ctx() for
  synchronous validation in the kdamond context.
- Following DAMON_SYSFS pattern for synchronous commit via damon_call().
- Link to RFC-v2: https://lore.kernel.org/20260321140926.22163-1-aethernet65535@gmail.com

Changes from RFC-v1:
- Remove question from commit message area.
- Added synchronous validation for DAMON_RECLAIM.
- Rename damon_valid_attrs() -> damon_validate_attrs().
- Exported a new function damon_validate_attrs() and declared it in
  damon.h.
- Link to RFC-v1: https://lore.kernel.org/20260321002642.22712-1-aethernet65535@gmail.com

 mm/damon/lru_sort.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 mm/damon/reclaim.c  | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..445e7aa19366 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * the re-reading, DAMON_LRU_SORT will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Desired active to [in]active memory ratio in bp (1/10,000).
@@ -361,6 +360,47 @@ static int damon_lru_sort_handle_commit_inputs(void)
 	return err;
 }
 
+static int damon_lru_sort_commit_inputs_fn(void *arg)
+{
+	return damon_lru_sort_apply_parameters();
+}
+
+static int damon_lru_sort_commit_inputs_store(const char *val,
+		const struct kernel_param *kp)
+{
+	bool yes;
+	int err;
+	struct damon_call_control control = {
+		.fn = damon_lru_sort_commit_inputs_fn,
+		.data = ctx,
+		.repeat = false,
+	};
+
+	err = kstrtobool(val, &yes);
+	if (err)
+		return err;
+
+	if (commit_inputs == yes)
+		return 0;
+
+	if (!yes) {
+		commit_inputs = false;
+		return 0;
+	}
+
+	err = damon_call(ctx, &control);
+	if (err)
+		return err;
+	return control.return_code;
+}
+
+static const struct kernel_param_ops commit_inputs_param_ops = {
+	.set = damon_lru_sort_commit_inputs_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
+
 static int damon_lru_sort_damon_call_fn(void *arg)
 {
 	struct damon_ctx *c = arg;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da14778658..5d0c02d4ff74 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -39,7 +39,6 @@ static bool enabled __read_mostly;
  * re-reading, DAMON_RECLAIM will be disabled.
  */
 static bool commit_inputs __read_mostly;
-module_param(commit_inputs, bool, 0600);
 
 /*
  * Time threshold for cold memory regions identification in microseconds.
@@ -267,6 +266,47 @@ static int damon_reclaim_handle_commit_inputs(void)
 	return err;
 }
 
+static int damon_reclaim_commit_inputs_fn(void *arg)
+{
+	return damon_reclaim_apply_parameters();
+}
+
+static int damon_reclaim_commit_inputs_store(const char *val,
+		const struct kernel_param *kp)
+{
+	bool yes;
+	int err;
+	struct damon_call_control control = {
+		.fn = damon_reclaim_commit_inputs_fn,
+		.data = ctx,
+		.repeat = false,
+	};
+
+	err = kstrtobool(val, &yes);
+	if (err)
+		return err;
+
+	if (commit_inputs == yes)
+		return 0;
+
+	if (!yes) {
+		commit_inputs = false;
+		return 0;
+	}
+
+	err = damon_call(ctx, &control);
+	if (err)
+		return err;
+	return control.return_code;
+}
+
+static const struct kernel_param_ops commit_inputs_param_ops = {
+	.set = damon_reclaim_commit_inputs_store,
+	.get = param_get_bool,
+};
+
+module_param_cb(commit_inputs, &commit_inputs_param_ops, &commit_inputs, 0600);
+
 static int damon_reclaim_damon_call_fn(void *arg)
 {
 	struct damon_ctx *c = arg;
-- 
2.53.0

