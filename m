Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA363DB636;
	Tue, 30 Jun 2026 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792506; cv=none; b=U3ZCnbxk6WWF+cKimeJNGFr6TDhUi9qKjEGbAPsCwNBQnDQ10EVY7U+G7+jI3J+Ie2QCtw9z4/+J82UxAoDz5C0JP23/IWgRgScdKzJ7h3G4sd+WT72q3sAe1xIoP8+wAWgIKuQqXv9dHzQjEqLbFYstI2dgHjxU9Ux5lAgP060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792506; c=relaxed/simple;
	bh=HVnf3HIpvRMYnSf0qQ+hCPt26HRnxKQMdii3XXCWTWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxuYh47fDB7DwXek1rJA6q6boDf41CvytivOKLO4iWtrIyyap7FBLWoL7Gfgy1AF9oJHEe2sUNREqBzTV2oM43bQgtWmertN7VuwHCoZXnaM3Srqy68NiSuJP1C2Vw38IJnthM3zQgSenichalx1kTQe6dieKrDkWoR2C0GEqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kcr+VZa0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kcr+VZa0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBD01F00A3F;
	Tue, 30 Jun 2026 04:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792505;
	bh=CUnTNnIb74vuucSNXoGi9/IfHGsNCXgoVOsKdS+73Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kcr+VZa0lHJCaMhWhwVq1oHyKcy9hfbk8LDqi33TOlC7ZG/49SthhgupQ/aWbwJI9
	 1JoCtIyPIKsI3h4jnDtkTdGR9TtgdXO2ZFAXihqPfJu75Dxe5P9bt1AzCbwOkaMFOE
	 +pBeiqptnxIVQzVQ6j+DG8XHick0tG3zxnnBM3y3Fp3QDh8VHhX5Iu7StqPehXjAYk
	 2Czwr2DXjqtyZzjhwjMXzEBsWX7TCiFIlGbt0VjhtPMM+pwWiSlf9yeQP18cYnH+1O
	 V4AA5sjm7WUj+GXN3WfzGId6JDH14FszaalCO3Ii0rn94IKHlELAHeF/+swn5/DAJF
	 1L7VuSprHtTog==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/18] mm/damon/core: handle unreset nr_accesses in damon_nr_accesses_mvsum()
Date: Mon, 29 Jun 2026 21:07:57 -0700
Message-ID: <20260630040812.149729-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_set_attrs() works like reverting aggregations that were made so
far for this aggregation window.  If this is the end of the aggregation,
however, kdamond_fn() will do the operations at the end of the
aggregation interval, using cached timestamps.  For such operations that
rely on damon_region->nr_accesses, damon_update_monitoring_results()
doesn't reset the nr_accesses if it is called at the end of the
aggregation window.

damon_nr_accesses_mvsum() works with fresh timestamps, though.  The
nr_accesses that are not reset in this case can make the logic to
unnecessarily count nr_accesses, resulting in returning
higher-than-expected pseudo moving sum nr_accesses.  No code is using
damon_nr_accesses_mvsum() yet, so this is not causing a real problem.
Following commits will add usage of the function, though.  For safe
usages, calculate the pseudo moving sum without nr_accesses if the
remaining window is full.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 669b701e50a7d..70cbc382bec04 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -266,6 +266,9 @@ unsigned int damon_nr_accesses_mvsum(struct damon_region *r,
 			ctx->passed_sample_intervals;
 	left_window_bp = mult_frac(left_window, 10000, window_len);
 
+	if (left_window_bp == 10000)
+		return r->last_nr_accesses;
+
 	return damon_mvsum(r->nr_accesses, r->last_nr_accesses,
 			left_window_bp);
 }
-- 
2.47.3
