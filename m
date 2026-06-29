Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A7B3FBB6F;
	Mon, 29 Jun 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744947; cv=none; b=ecUsL06+Dil6PQiGNCQlrlnVrxO7Ub8o5Udm7fdmnPIlikdK1d+QESZkqzaIsnA3YlpmKLRzVR1ugwr8Ldj92A6iicFE4t+FqCk/F+jfsXTkO3I9bwiqSXRE9L0e7Q/RUpHhg6V7J61pcuPPNxL57ePWAYveq0yhw+HsunaBc1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744947; c=relaxed/simple;
	bh=TM/V8E65AWi/ur3AYnithBcb6GpJSD9vvphF4jYaaRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrBOIRrcqkhOtqIFdf+o2IgGExKDwH2b/xiTQknfpB2c2X5KqzR1e5y6kkjUHwS+GpPfLKuYhaZjXodcXpAz7GNj3Vbd3B5nBUkrE61uI0fxG9hMC73TmjohC2slQr9hcQIIhJUHbKEtmF7Y4aC93L4J9LVgqs21EOmKjAszt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDXoE4r+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDXoE4r+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72971F000E9;
	Mon, 29 Jun 2026 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782744945;
	bh=PmG2gg8tRrgzpTnWK4727CnmxNa5ZlUXqEpxl0pzTvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VDXoE4r+74Y296coPt1frx1kzyLDNql3DFMMOIzlslvyJFTNPeKJqSeOd1BDGHscn
	 7JxWBT1rCvA81uHJy/isaEosOp2DZGHkNoGD4HLn7ogayUzWJ5zwg2x+07rkEtpRaw
	 8blA/qmadJwueO/Rdnjs8v3bGmYMlO82Dn90EOYVDAnWNUqA7/YKH+U7s7tGYpzed7
	 rK9ch9+t8IbKto8G+dMJ5sXLTueItloeyuqj7aP5RcAJ2Vuymeig0gwzKEAAuMmUhe
	 qAqTSwke8+1IpOiHyxeO9XEfWO97aI6ag7574rgyB0OFWqfTHWItsgEeJuobPoeZ/w
	 pKCprFZAKr7IA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Asier Gutierrez <gutierrez.asier@huawei-partners.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/5] samples/damon: Fix typos in Kconfig help text
Date: Mon, 29 Jun 2026 07:55:35 -0700
Message-ID: <20260629145538.134832-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260629145538.134832-1-sj@kernel.org>
References: <20260629145538.134832-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>

Fix a couple  of typos in samples/damon/Kconfig help text. Change "Thps"
to "This", and "tierign" to "tiering".

Changes from v1
- v1: https://lore.kernel.org/20260617065716.750179-1-gutierrez.asier@huawei-partners.com
- Fix one more type: s/tierign/tiering/
- Add R-b: from SJ.
- Rebase to latest mm-new.

Signed-off-by: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 samples/damon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/damon/Kconfig b/samples/damon/Kconfig
index cbf96fd8a8bf9..00be3e6bdd659 100644
--- a/samples/damon/Kconfig
+++ b/samples/damon/Kconfig
@@ -31,7 +31,7 @@ config SAMPLE_DAMON_MTIER
 	bool "DAMON sample module for memory tiering"
 	depends on DAMON && DAMON_PADDR
 	help
-	  Thps builds DAMON sample module for memory tierign.
+	  This builds DAMON sample module for memory tiering.
 
 	  The module assumes the system is constructed with two NUMA nodes,
 	  which seems as local and remote nodes to all CPUs.  For example,
-- 
2.47.3
