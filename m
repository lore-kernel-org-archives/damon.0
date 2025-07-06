Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E62BCF4B;
	Sun,  6 Jul 2025 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751830333; cv=none; b=C6iKXlMoHFPrk7n8jq0hE/BQcXQ+S+fGS3UbGBw0/Ksz6uRteEWhbmCLn0QKYeBvVG6Q2s1MT1MMNeUO8UX05VgQ5DN34PxgUNjsZe05DLWuLcqICNdAmBJ98iQ+2Qg0PhWsalxxeVReoBsSp5aG7Fw4c6Zhmsh7KtgCMkcDk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751830333; c=relaxed/simple;
	bh=ItdKrZvjvoLfJbg0R8zs5Hictw962k8iIPOxGamn4Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=teyrtdPMkj/zBSbr8PkS1Z89qId+K/VZp7vLLsfDbxQMnOLei7htT9HVIkO3yg66Q4GtLg6wxGKEYEsVgzZPG8XLzfK682sHBg8azGcGEiiLj7F0+MFqsh7AMJbfQEsWcjIvWtp0Pz7HFOviS+5fRo7Pr1CWueVGI7iUVxQ5FwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnUauxP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnUauxP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F2AC4CEEE;
	Sun,  6 Jul 2025 19:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751830333;
	bh=ItdKrZvjvoLfJbg0R8zs5Hictw962k8iIPOxGamn4Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LnUauxP53NuIKsYA+Jp/AghJ+OGnIGLIvW9Sdra0SjiFWxC9gQEz7ZiW10YBNQG76
	 k4WGRJf59ArnLzCNPxNkCtiDY5EMvWY8a0ttN5xlqhgJpxgkrBPkssF2sh9Gd+YPZs
	 pIlWVnvpKtLfO4tYM7k8bbArmJPm6fqtE0Mhg9q621EtekOiUe1yjyeNTW3FN0dyZ5
	 vDr5Ylz7j8UZlhZZyB6tgYuTMj6+EGL7kfVpGypNq1kTNAlBVQUAUGfLhrtbyksHtF
	 o9SJvNRehFZOTTefDTQcp6HZavj6in5HXpQ9OiCFLNyQ9pkAyxwFUKGea6nsH5kLjD
	 OOYY2ZJSAUcvw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/6] samples/damon/prcl: fix boot time enable crash
Date: Sun,  6 Jul 2025 12:32:03 -0700
Message-Id: <20250706193207.39810-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706193207.39810-1-sj@kernel.org>
References: <20250706193207.39810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'enable' parameter of the 'prcl' DAMON sample module is set at boot
time via the kernel command line, memory allocation is tried before the
slab is initialized.  As a result kernel NULL pointer dereference BUG
can happen.  Fix it by checking the initialization status.

Fixes: 2aca254620a8 ("samples/damon: introduce a skeleton of a smaple DAMON module for proactive reclamation")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 5597e6a08ab2..f04a18a8626a 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -109,6 +109,8 @@ static void damon_sample_prcl_stop(void)
 		put_pid(target_pidp);
 }
 
+static bool init_called;
+
 static int damon_sample_prcl_enable_store(
 		const char *val, const struct kernel_param *kp)
 {
@@ -122,6 +124,9 @@ static int damon_sample_prcl_enable_store(
 	if (enable == enabled)
 		return 0;
 
+	if (!init_called)
+		return 0;
+
 	if (enable) {
 		err = damon_sample_prcl_start();
 		if (err)
@@ -134,6 +139,14 @@ static int damon_sample_prcl_enable_store(
 
 static int __init damon_sample_prcl_init(void)
 {
+	int err = 0;
+
+	init_called = true;
+	if (enable) {
+		err = damon_sample_prcl_start();
+		if (err)
+			enable = false;
+	}
 	return 0;
 }
 
-- 
2.39.5
