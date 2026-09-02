Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA64638DC5F;
	Wed,  2 Sep 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328077; cv=none; b=F2dkD/e4e6fhPU3fUZ/+pa5HHnGIvNWPgPObpBEYH2EWpVjtkpy1gsDdlAo9f6E5g/rWaftzeWd54chFKXYr1Ak16sqEaaYDr1XZMbVmB+p7k1Le6ewpKSQtOzIE19Rb4wNyoM9ipATPJK8hLTXT3KQuQmHGrN4ps7hURaVuELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328077; c=relaxed/simple;
	bh=Nvdizo8PsCsBXGtfZpWwiTQ5zJFcYq/b002rCuTt2RM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEmd0EKCHGQlJVirI/NT/cs7Di1rrAveA8uHbzuL4S+BehBcObDovmGoACH4gFfdlBWs73iUHPayFGj9JHNS0hDF9LPfm5bV8yMtJ4PJMMuEzV3KQ2KP83g9LlX9LXwLGfXIMewEKrYRTfp9LHxecJSdk9zMH8nDY8O8Ohb3D9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaOrtRB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaOrtRB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29401F00A3E;
	Wed,  2 Sep 2026 05:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328075;
	bh=KapXeO7OndJodgXvsAPTUdwLTA5ybEOS8WtNM8GGre0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OaOrtRB31+vdvxxaQTsVcdtksSf8AUVnGY2FQ1ubJilAVPbuppVruEKp/YmmPB1Lw
	 +oEr8eQ/dJtc7TCCvA3rXvhnc/cWsS8UEsPNwFlQ6l/qoCIWnZQ3ZmJl0gG3dMglqN
	 BfocpI59IRFjL4DyCB4CrWqtrDWYNWhDqQgGwXorFOKLIUHgvyj9Kv60UHD9emSOzE
	 4gjQkBncrHHdsT/V1ImAcw2RlxWVCP4SOLfiJOgFqDxkHnmKpGK3N8a3eyrGvgg4DR
	 ZvuTyHdMvOblzcqAKbIn5wH9bZT/B9T2Q8LHB4YVnhtuyzv0iZPlE9YYIt/ezsFVSh
	 pDf2isDehJetw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/12] mm/damon/core: validate number of probes in valid_probe_params()
Date: Tue,  1 Sep 2026 22:47:37 -0700
Message-ID: <20260902054747.99370-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each DAMON context is allowed to have only up to DAMON_MAX_PROBES
probes.  The central place for validating DAMON probe parameters,
damon_valid_probe_params(), is not validating the upper limit, though.
Do the validation.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 4d28eb033fc4a..c010f686d033e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1420,6 +1420,13 @@ static bool damon_valid_probe_params(struct damon_ctx *ctx)
 	unsigned char max_probe_hits;
 	struct damon_probe *probe;
 	unsigned int wsum, wsum_to_add;
+	int nr_probes;
+
+	nr_probes = 0;
+	damon_for_each_probe(probe, ctx)
+		nr_probes++;
+	if (nr_probes > DAMON_MAX_PROBES)
+		return false;
 
 	if (!damon_has_probe_weights(ctx))
 		return true;
-- 
2.47.3
