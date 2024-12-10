Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB3123A577;
	Tue, 10 Dec 2024 21:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733867439; cv=none; b=Mbo2tZlcWP1U8K9rnOqDG/tsKQkEwG9BER9Sha7ixFr0w88KLSNpP7nLLAVUuxUx/g/sDlwWXHbUruEU+Stf9jPSh9K+Er/9Mbgdom2d7tNYyNB+5e9EyZ+tlvDgX/xl8wPXx4NO2iWER9r8mtmNL7CnN/rR+bB4QtUXwF1dCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733867439; c=relaxed/simple;
	bh=WhKbvDPjbuIBA/Td7/ebEpkfZLrMJgwOSAMpKKqqUME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQXyJUoctzUwLiAjZ6mlES225sAIDR4EjuJwaGV3AaGkOxWRWt1AoGZI6nOqkW4FSSS25fvUk8CfIoHu84lvoOtC3H/k4RBgjyRq+vF+ODxMHHTWrhXaKMwOaNsZ7kvjOwxUPCni+7cDaRQ/ak/w0r+RwN1dYH3YMiKObXaInAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmMRqjDE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmMRqjDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FDFC4CEDF;
	Tue, 10 Dec 2024 21:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733867439;
	bh=WhKbvDPjbuIBA/Td7/ebEpkfZLrMJgwOSAMpKKqqUME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmMRqjDEmysTyaTfmY/VxeGmtYNZm7cToJf/5OuUA/BWeBb5Wcre05Ccqb5qdayLZ
	 7F93iFBLS8q4pebZnd/TYpcySoLYarrtciHg4Hge3+ZALTkxtye8utueT89EXUmQed
	 OjrhDQ4wm84CWa1Ew1Cx3L7FsYZ+QwTVgFGZlpHikj5RITpsTDj4fU0UJp+NEtTUJl
	 N+mOlxI9BbGqSpB+c1dJJmuHPjcdhvfJfe8qcT0Ihx73vIc6wk//JUEaMt7K43Zahf
	 ixcOYKt7CNRTpQwjuhbbl8+XHlgtOna/Kdv2pT36zEQgvfyMmvcBDycQaSbaPc2/ny
	 uc/F7vl7pyvFg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 3/5] samples/damon/wsse: implement working set size estimation and logging
Date: Tue, 10 Dec 2024 13:50:28 -0800
Message-Id: <20241210215030.85675-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210215030.85675-1-sj@kernel.org>
References: <20241210215030.85675-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the DAMON-based working set size estimation logic.  The logic
iterates memory regions in DAMON-generated access pattern snapshot for
every aggregation interval and get the total sum of the size of any
region having one or higher 'nr_accesses' count.  That is, it assumes
any region having one or higher 'nr_accesses' to be a part of the
working set.  The estimated value is reported to the user by printing it
to the kernel log.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/wsse.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/samples/damon/wsse.c b/samples/damon/wsse.c
index 2ba0c91baad9..11be25803274 100644
--- a/samples/damon/wsse.c
+++ b/samples/damon/wsse.c
@@ -30,6 +30,23 @@ MODULE_PARM_DESC(enable, "Enable or disable DAMON_SAMPLE_WSSE");
 static struct damon_ctx *ctx;
 static struct pid *target_pidp;
 
+static int damon_sample_wsse_after_aggregate(struct damon_ctx *c)
+{
+	struct damon_target *t;
+
+	damon_for_each_target(t, c) {
+		struct damon_region *r;
+		unsigned long wss = 0;
+
+		damon_for_each_region(r, t) {
+			if (r->nr_accesses > 0)
+				wss += r->ar.end - r->ar.start;
+		}
+		pr_info("wss: %lu\n", wss);
+	}
+	return 0;
+}
+
 static int damon_sample_wsse_start(void)
 {
 	struct damon_target *target;
@@ -57,6 +74,7 @@ static int damon_sample_wsse_start(void)
 	}
 	target->pid = target_pidp;
 
+	ctx->callback.after_aggregation = damon_sample_wsse_after_aggregate;
 	return damon_start(&ctx, 1, true);
 }
 
-- 
2.39.5

