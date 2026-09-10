Received: from mail-yx2-f5.google.com (mail-yx2-f5.google.com [74.125.224.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A954A7DD
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060622; cv=none; b=SuBDaCSjpxKRsXK7ByDE9J2PF+S6g4RRXp80jjLYovxPTrJjSrddgAnXHFKDh340FdZoI8Bop/33MJGf38juborsGVS9mrQhx4/dP+uwSxLutzVJCb9PdrGCb/l/h4Ny4LPbt2rvvaUzi607XTBge/n3DB0CVlbT+aodAJ4jX8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060622; c=relaxed/simple;
	bh=FWOV55/3vGD+VdA6FUY/zNKrvVLuEsU8r1gv1G/TCiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuvpgmGHkNL3pZrE6pWrig7aDQQGymJsq3IbYGlPR5vGkIqARuesHf0Hk8u322KTjZz5ezq/dsZXoJJZ2GzpPBKAIpurfJ14F0YB1HIvF/wJV6EvTVvuCIeNgGOD0XtwpvTjklQW0bc4+7+9cpVvbzJgG6keZx4/+zNsYUNa/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gId/vtZb; arc=none smtp.client-ip=74.125.224.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gId/vtZb"
Received: by mail-yx2-f5.google.com with SMTP id 00721157ae682-86337316fceso4463577b3.1
        for <damon@lists.linux.dev>; Thu, 10 Sep 2026 10:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060603; x=1789665403; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58wdEMpjvnsgClzUj13f3cAStl17GU2Ynr7IJ0GHfaE=;
        b=gId/vtZbaRMkiy+IcOi2nqfyfogGSQlFABb0tlOKf8rXXoAOO+mSX8L/ZNuR5t6ZCP
         DDcmUrSosV6+kZuA3I81tbCYnhzEzJ5Pa96lej+j0HiVbpa36BCTiG7YlN+Cy3goUEGE
         WGpjR/Zlms5eny5Wibn3ijt+SrmwIzSwq7uXc+vIWPuqCFAW7wXNYNv/z9pTc6+12e7t
         2LOFNibw8zNPAWQtvGJwj0GBCLCl5jWFUWev48kEzie18sxiBuY1JfbtNMwckBPTL3uf
         6sAAHQJK4HnQO0dRFk/fl7gU4GWjPjvRKSS5+ZAmCffKS3rQ1SWpvJQ3HzgwSyJDsvjS
         5Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060603; x=1789665403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=58wdEMpjvnsgClzUj13f3cAStl17GU2Ynr7IJ0GHfaE=;
        b=Qdzr8XKnoP0HpZeuNlVPiE6W71VzRCXFCgWosNn/Cgb/4ccnQJeKjIZmPn2hcwm2C+
         4UKddEd7o4DBdzXFldZ//lKxMhGhkOmeVSVoai5LaeP1EX+7ohzy6alwmuXxi3FzIVqY
         rRRm0thgko1Mq2o942krqLqfPCuTZK08XUHjzqNtWan9qp+jIh+58/iagQtW3EhxHMsi
         Lns8Po3ZrG/fGiRYoiF6nDWXYx0SdjTr9dX6p0SUwhIeHoKaCix++xrn4DnDMHXf3Q5h
         MEO76AIZWh8BbOH06Bvrju695F0el94XIGNmjP3fpDLAsCZm1LanTw5QgWmHyooy5kid
         Z5kw==
X-Forwarded-Encrypted: i=1; AKwUvBy4H5L2zFe53kFcznO3sYtWDDb+theu8YqqVsix9KG++XkPniZscpIlB0OlMiSwpSB1Qzhw0Q==@lists.linux.dev
X-Gm-Message-State: AFuF++lOScy29v/MKeNTT0Ru52nG8yXKijDJPXo0VsSnOqgI8Qvz2loA
	DN0IM3FxSihdO0Ep2B1OsLegUyFiPZ50kA6o7xILNRfylpy+KHNPXsM=
X-Gm-Gg: AYBFou3twWhnjt8ag6E0+lziSY7iERyylUmQ2vN9I3N4l+oKyVPFN3nwyq/fwTbHVuZ
	qiyqBOadaYsJIdyevmpHipvwuh41XxEqpeVbZfwY8DiMStt8ofbd7KR45dQDQTZInRcLnXVoKYT
	b/dqhv+VXzCRuwW69KNo6s0RdAIz37095UuBb8J7DbCXmbTiEvnwe3AG4ho3bP6wKOga79R0So3
	6vD4t1c0gyNfliOrsq83zIJjhk5jo/AcnCcdPtCDdzcg8OiwSukTI91Zd2XpnxDJAahpaHlxW0g
	P3Ppbtms5vhDM0oHf5X/eoeuEmXdImUe4JA+KdiDEXNXetMDwjEKRx8ZdpilLkqdEJw19TJJbXy
	8556gIYOdNrnilDHFv0DVIIGjTocXb3KuhWphZyTfDYZX4/Dt2iL2y9FgViH08sap8xnuLihHdp
	csxHmbG17zHX2FDaIQI/Cdz5l+zu6dnoW/RZV+85KYm6W909QOeTPnZ2k4sKVf1njZS8HvsvKSu
	1VSJ4r2Kd/70mz0YOMrWgwQ3yh2x+rwieUGOjWN6oo0V4i0yQ==
X-Received: by 2002:a05:690c:c505:b0:873:5c6b:a31e with SMTP id 00721157ae682-884a1163a16mr1213737b3.24.1789060601165;
        Thu, 10 Sep 2026 10:16:41 -0700 (PDT)
Received: from localhost (23-116-43-216.lightspeed.sntcca.sbcglobal.net. [23.116.43.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88487ea6026sm2285967b3.32.2026.09.10.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:16:40 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: sj@kernel.org,
	akinobu.mita@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	bijan311@gmail.com,
	ajayjoshi@micron.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	ravis.opensrc@gmail.com,
	rientjes@google.com,
	weixugc@google.com,
	jic23@kernel.org,
	gourry@gourry.net
Subject: [RFC PATCH v2 7/9] mm/damon/ops-common: use probe-weighted score when probe weights are set
Date: Thu, 10 Sep 2026 10:16:21 -0700
Message-ID: <20260910171623.6638-8-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910171623.6638-1-ravis.opensrc@gmail.com>
References: <20260910171623.6638-1-ravis.opensrc@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When probe weights are configured (damon_has_probe_weights()), use
damon_probe_hits_wsum() for the frequency subscore in damon_hot_score()
instead of damon_nr_accesses_mvsum().  This routes hardware event counts
from a perf-event probe into the tiering decision.

When no probe weights are set the frequency subscore comes from
nr_accesses_mvsum, so page-table-only monitoring scores from the
page-table access rate.

Export damon_has_probe_weights() so ops-common.c can call it without a
static dependency on core.c internals.

Guard against integer overflow: clamp the probe-weighted subscore to
DAMON_MAX_SUBSCORE via min_t after the mult_frac scaling so a large
weighted-hit sum cannot overflow the subscore range.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       |  2 +-
 mm/damon/ops-common.c | 21 ++++++++++++++++++---
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 88a459a60b296..3147ce30951f5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1307,6 +1307,7 @@ unsigned char damon_probe_hits_mvsum(int probe_idx, struct damon_region *r,
 		struct damon_ctx *ctx);
 unsigned int damon_probe_hits_wsum(struct damon_region *r, bool last, bool mv,
 		struct damon_ctx *ctx);
+bool damon_has_probe_weights(struct damon_ctx *c);
 
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 		unsigned int nr_ranges, unsigned long min_region_sz);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 850880f791c9e..6b3aa86386b76 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -391,7 +391,7 @@ static struct damon_probe *damon_nth_probe(int n, struct damon_ctx *ctx)
 	return NULL;
 }
 
-static bool damon_has_probe_weights(struct damon_ctx *c)
+bool damon_has_probe_weights(struct damon_ctx *c)
 {
 	struct damon_probe *p;
 
diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index c36cc39cd2c70..3033a5c0ba690 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -170,9 +170,24 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 	unsigned int age_weight = s->quota.weight_age;
 	int hotness;
 
-	freq_subscore = mult_frac(damon_nr_accesses_mvsum(r, c),
-			DAMON_MAX_SUBSCORE,
-			damon_nr_samples_per_aggr(&c->attrs));
+	if (damon_has_probe_weights(c)) {
+		unsigned int wsum = damon_probe_hits_wsum(r, false, true, c);
+
+		/*
+		 * Route perf-event hardware event counts into the score.
+		 * Clamp to DAMON_MAX_SUBSCORE so a large weighted-hit sum
+		 * cannot overflow the subscore range.
+		 */
+		freq_subscore = min_t(int,
+				mult_frac(wsum, DAMON_MAX_SUBSCORE,
+					/* +1 guards divide-by-zero: samples-per-aggr can be 0 */
+					damon_nr_samples_per_aggr(&c->attrs) + 1),
+				DAMON_MAX_SUBSCORE);
+	} else {
+		freq_subscore = mult_frac(damon_nr_accesses_mvsum(r, c),
+				DAMON_MAX_SUBSCORE,
+				damon_nr_samples_per_aggr(&c->attrs));
+	}
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
 	if (age_in_sec)
-- 
2.43.0

