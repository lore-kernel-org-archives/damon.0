Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D4390600;
	Sat, 12 Sep 2026 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243704; cv=none; b=AWr4b8ivqnJtrntgwfShipCqBz6iaLeLDIh7Q4tom8XrbbxnHF7dUxjU/8RGu9Hc9FF8RbineDgixJnYm4viO/QBBoMI8AqRfaFyOjyHG0mln/4SXfiYOUbLbQhrDpkj3IwMPH/LAdN23v+uGPen+U1WqsuGCjEBs/RHyW3p22U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243704; c=relaxed/simple;
	bh=RHEnPUtKbugmvApBe6kv6XYoB1fT4VCFb1F/7/ZoVow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgVcYKMIYOhZSDIpRQQdSibxwJv6MPxAFvVCkMDQ/WLrjfQXsBWp1mJdYm3ERynijrYoX+hBm+AcnEljzNpL7YU54BbTR5zShJgVvM1Vir0fv9oblg5EkLGFy+a2rUbmgc5cU1t/w6ODfFxx3SDczphAaRUtHjntkksNRd34ouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwJ38vZj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwJ38vZj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E871F0089D;
	Sat, 12 Sep 2026 20:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243702;
	bh=jEdT1Tx29QJewgZvxzEFx+LhCVGEN67F9XSIdtQFFFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LwJ38vZj+WJ+Sh0eZvH/h2N5n01NFFFCBdQqBk1X8PFWginfJnDCkpbraBEWkKQ8r
	 NM7czumnfsJL2eVYh3S4vojLSwu4ttQlsd9BH5bxKqJxRWc/a6ZJTwcxMJ1xyYYqei
	 oxr80FF4dCjnOnIB3gDcGzLUsIs2m7j06LOW8Ef8J3taXpYZNn3pl8ZEG04Fdjq3KJ
	 DDI/JipUvSw7AkX79xtRaDhIqIFK77oU94qWM7UBNyyqmHVWuA3TDxaiXL15l09u8O
	 WZ/kiDMso543xeQe7526fb74O7ozTz9ydDzbHSs3Iq1IhrjPIi3rA9LS3XohqRHvZg
	 zQjsr6WsDtjPQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/9] mm/damon/api: remove NR_DAMOS_FILTER_TYPES
Date: Sat, 12 Sep 2026 13:08:02 -0700
Message-ID: <20260912200814.145612-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260912200814.145612-1-sj@kernel.org>
References: <20260912200814.145612-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody uses NR_DAMOS_FILTER_TYPES.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 1606edace52e4..754752d891ca2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -402,7 +402,6 @@ struct damos_stat {
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
- * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
  *
  * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
  * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
@@ -424,7 +423,6 @@ enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	DAMOS_FILTER_TYPE_PROBE_HITS_WSUM,
-	NR_DAMOS_FILTER_TYPES,
 };
 
 /**
-- 
2.47.3
