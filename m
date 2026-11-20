Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795154869;
	b=yJI7hl7sF8TEwdLH/KbuS1Ew3m1neUuJZbQ4yKexFJOAGhXGJcazNSBDdPKbtQE25iJn
	 rBc8emIpvx/8aVDZE9ohOFfbFkTQnCLQ8oU70x6NTJZXV0/rUHmNU+Ei4W0FyCN6+m6sT
	 O2qrpKM1PPCjfTvV7OZWddqqkc5eUtPPxeixa+XVkUwWhtgTa4XP5P5vop4Nqw35MH5+B
	 lGuRd2R2F2haJmLZHVFz1hmnHMi92qHLD4gJG5qSyj8R/o6PGSvxQw6+uK4+dlp0bctqS
	 oDhJb267FKuI8BFbNmWQ+vf/cQStFF6PDjELugeGCqea8Z2PxIDPqDtlzCbAcx1LaJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795154869;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sgy2HIqRDs7m+gqismXK/OQPULwkzU1byqrsLzKFNC8=;
	b=JUc4ytbY+seXVIBcWbHD/c9/PpdK3ZjgQ2JzOjwmmN1wiXAjCYrgBbn8SIaiWL1gV29C
	 c73rEFd8+OoDgTsG2rpfDuismGHdQN1y6Xrf8HBIjXrg3+BzOgpZ1GJoQDUVWZ8MOCo+n
	 jH3ZUjLyuH0KBIPjpdqNZ7FKgpfYWYQpzYLRiX74DNzDJTShMM5S7sD6K13b/OWwau4BS
	 4ndLxrTtdj2FtOf62e5SVGpcwJjUTEwK7HgYwTZ7ciTZdtJ/mFeSSHbL5gpXVxJm/IPQt
	 /tIBhXcKe362n1Q0yqpw2tgGzTwFK51Ky4XauLH56NCXK6XYk2OsomBdMaLk8V1mEVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odTTA3E9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F32606A523
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odTTA3E9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC2C1F000C4;
	Fri, 20 Nov 2026 06:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795154869;
	bh=sgy2HIqRDs7m+gqismXK/OQPULwkzU1byqrsLzKFNC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=odTTA3E9ruj1lmSPYq58HBpyJV42EJK0m7a/spYdlFG9ckTqxi1k84yFRQWnDRwUi
	 Thtqg3tkVjHbZhmoDbBSH4dJ2E9qLnDBqvoPixW1O11sfHQ0kEFiP3y7tYjysIejl6
	 qmSyDPVhsjbUSbs5hlW3OrRhESAhoM3ft4Z+jISMHvKrTiad8u9BYaNXE5MQ6wIheN
	 +n5rvaEIJT0LwI0uNYNUFYr1YKLsCgVdJkSBIwLDSZeeqVA2I5JcuHtrLQjqb7aXwY
	 IIttQX8Dz2GlGaGqvAprO+Ss8qaSiUIiFQw3zKWMZVTO3uOHWbbkHmpzO5GwUx+2Tw
	 wdf04U7Cx1YJA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/4] mm/damon/reclaim: enable monitoring intervals auto-tune by default
Date: Thu, 19 Nov 2026 22:07:35 -0800
Message-ID: <20261120060741.92121-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120060741.92121-1-sj@kernel.org>
References: <20261120060741.92121-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_RECLAIM provides monitoring intervals auto-tuning feature.  It is
turned off by default, though.  It is expected to be only better than
the default values of static intervals in real use cases.  Enable the
auto-tuning.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index a84cea070ec76..2241b3e9145ef 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -98,9 +98,9 @@ module_param(quota_autotune_feedback, ulong, 0600);
  * sampling intervals 5 milliseconds in minimum, and 10 seconds in maximum.
  * Setting this to ``N`` disables the auto-tuning.
  *
- * Disabled by default.
+ * Enabled by default.
  */
-static bool autotune_monitoring_intervals __read_mostly;
+static bool autotune_monitoring_intervals __read_mostly = true;
 module_param(autotune_monitoring_intervals, bool, 0600);
 
 static struct damos_watermarks damon_reclaim_wmarks = {
-- 
2.47.3
