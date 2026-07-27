Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8443D3486;
	Mon, 27 Jul 2026 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163117; cv=none; b=Ff0Cp2lQv+omrjGO2C+RQiJGnTS/sMk1scxhI2Q+/4gIMYMogrQvTClG+2DT7E9HM8nq9a41CVMQhPAj5/yzrTNrPnqlqSoEYXLgdjsnkyrk5nsvutYLphaWfT1BK9Iq5uPWvnjCPtoESIVR5TDhNSfJ6sOeoGhXMt7peUTlSyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163117; c=relaxed/simple;
	bh=RlII/+bxZALx45h8wxz+V5lWsOUPfHwlNy6XORJIOTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpC+o2Lut4d8ax68f+HvF90k4UXorZQbBqK1DK4MAQ3AhoyZC6t9zQRSlEaFlLy9FRAix1oNx0PfCvvF5QN0oVtQ5f2IPYx5ZMb0hDRZRKWeLLud/3IQEs6QOEdSYcNXE7m6RSO+9hT7pYjAQB+eaAOvfG7QtsYPAbtuwmQm8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EplgybDG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EplgybDG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A051F00ACF;
	Mon, 27 Jul 2026 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163115;
	bh=dLFzt3EcCEm4IM9i5M5f2Ly9bLRqeWPD/3m4Jo0md2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EplgybDG2pjc7qULp8NAbQU4eO6g01ccQc6WIq6Wsvc3TpeY8z8eRZEHz8VAMw09L
	 CzXyuS7nU4FT6414bVzvUqJuWb5q8XedVv7flNhuaq7VR+FHtpR52LdZkHg1+lDuJr
	 IFZjjTnPqcJ1+DMwgNL9T3RJE45r/PRA40VWywnOxE8l8KW+oszHGih4M4kIS23zxz
	 nWEQWwy2FhGoftMh8NfH7ia1zCK4/uTgbtJazAGHyUZOJ0cF0aoJAsF0G2Pi1Xulx/
	 mMqo9Kq4zT4XQDXfP5zkjE2NJ69td7ShaQz0A4mCJ7kMueJBsPbMyq7Rho0siOnGLN
	 5W6IaRYF2GnUg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 08/17] mm/damon/paddr: support damon_prep
Date: Mon, 27 Jul 2026 07:38:17 -0700
Message-ID: <20260727143829.86236-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement damon_operations->prep_probes() callback.  Support the only
existing prep action, DAMON_PREP_SET_PGIDLE in a way similar to what it
was doing for the access check preparation: unset page table accessed
bits and set PG_Idle flag.  Reuse the function for the access check
preparation.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5b307dcbb2a50..8fb71183b76c0 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -105,6 +105,40 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
+static void damon_pa_prep_probes_region(struct damon_region *r,
+		struct damon_probe *probe, struct damon_ctx *ctx)
+{
+	struct damon_prep *p;
+
+	damon_for_each_prep(p, probe) {
+		switch (p->action) {
+		case DAMON_PREP_SET_PGIDLE:
+			damon_pa_mkold(damon_pa_phys_addr(r->sampling_addr,
+						ctx->addr_unit));
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static void damon_pa_prep_probes(struct damon_ctx *ctx, bool set_samples)
+{
+	struct damon_target *t;
+	struct damon_region *r;
+	struct damon_probe *p;
+
+	damon_for_each_target(t, ctx) {
+		damon_for_each_region(r, t) {
+			if (set_samples)
+				r->sampling_addr = damon_rand(ctx, r->ar.start,
+						r->ar.end);
+			damon_for_each_probe(p, ctx)
+				damon_pa_prep_probes_region(r, p, ctx);
+		}
+	}
+}
+
 static bool damon_pa_filter_match(struct damon_filter *filter,
 		struct folio *folio)
 {
@@ -448,6 +482,7 @@ static int __init damon_pa_initcall(void)
 		.update = NULL,
 		.prepare_access_checks = damon_pa_prepare_access_checks,
 		.check_accesses = damon_pa_check_accesses,
+		.prep_probes = damon_pa_prep_probes,
 		.apply_probes = damon_pa_apply_probes,
 		.target_valid = NULL,
 		.apply_scheme = damon_pa_apply_scheme,
-- 
2.47.3
