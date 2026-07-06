Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751542465E;
	Mon,  6 Jul 2026 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347562; cv=none; b=ScWX80wdMyspbET9zifxoiaM4fL3OaJsCNCs/niOPZ5QbmfrCmUI1j5Q9dM89HHrESTqOSXcw2p/RnOFzTFjLgDrccsDgb36P8MdhDlvVTsv3cutS8OixMyoEDiPec08L47SVSQ1K+tMs6s+ijRhlb4xkclMey8txYHJjQgsXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347562; c=relaxed/simple;
	bh=RQ2rlxFHdwSG/upgmjkGZQ1xYTrL37W/RTg+2FEFktw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9gzyTE1ng6TLeKz3jQEppHyW4u0GLA8xoOlNBusFXsMhOOvRMC6YCk9nB1dGk94iBq2YlieX2aZOnw2hYM6Vw3lS6BLLno/VwdqObpHUUJ85RQ1WAYyQtT56tsboHhLLQrxsKg3qHTJ2PtLByNQDE7P9WHFhczcIdlQnhDQQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSunxpRj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSunxpRj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4970E1F00A3D;
	Mon,  6 Jul 2026 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783347561;
	bh=kxd4/9TvByhr/rgk5a0bpEO5crurTcFohmlFktpxcC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oSunxpRjE28G9GA0pIiKIBiciz9OXBfj0HCCNt35BZmbbKfunTBrJacFk9cRfWWPS
	 JBlWqj4jpLWM14tYAQtokzZqixToRVeG57Aw/SO9VcYZL14zRYsuA7voGv54V83R8r
	 KCDqQLx12eLDiteQQe5vinWoQOS0vQFveQi2L/XEwccnt5/yasFo6OsmCBu330tCor
	 nBknJtSAqRu7d/l3X+gtMeZ+iElWw0TTaji3O34nvvuMI3KosTcJpEL3B9HyBlUC2y
	 IMadUo5NjiRZxIK5QKocT81JnlQioDKAc5Hkhn699/TDKCcYYelriG50KrsEv1zJdE
	 uXJITsdwXnPbg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 03/16] mm/damon/paddr: set samples in apply_probes() if requested
Date: Mon,  6 Jul 2026 07:18:57 -0700
Message-ID: <20260706141912.88445-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706141912.88445-1-sj@kernel.org>
References: <20260706141912.88445-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

apply_probe() callback implementation in DAMON_PADDR is ignoring
set_samples parameter.  Respect it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b13bf7c6eade3..ff4fcca949660 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -178,6 +178,10 @@ static void damon_pa_apply_probes(struct damon_ctx *ctx, bool set_samples)
 			phys_addr_t pa;
 			struct folio *folio;
 
+			if (set_samples)
+				r->sampling_addr = damon_rand(ctx, r->ar.start,
+						r->ar.end);
+
 			pa = damon_pa_phys_addr(r->sampling_addr,
 					ctx->addr_unit);
 			folio = damon_get_folio(PHYS_PFN(pa));
-- 
2.47.3
