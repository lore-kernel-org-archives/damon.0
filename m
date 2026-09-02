Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2B4A0EF5;
	Wed,  2 Sep 2026 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357820; cv=none; b=IDqCxirN1A1mtsQLVKFpjd9H2QNmuIiaOp5tcPnOjyt6OJUaNtO9krSixDe2Seu62t/otXyvyDz8saeCrGtiC2WA7FM69RieAHWZsf+2uFu9Lb3G3XEOWcy5SiHxHaP7K8ZRzcCTeoEH57tGl+AlwZLzKa9gX6UxOY0T/uvZpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357820; c=relaxed/simple;
	bh=DJPYvh3BoeDGZsI6ipGISBHF/SQmPmzJIQyhoWHeFFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ir4R3RkZrQu6A/pZ7h4TtDA7urkgGZk2YX7qeAORNTRDBVQ2/SnGLVQ+eWJZx+KKkiMZJUP6dt1khaldNGwEFIlPamWi6i3gdf/pixJM/lNhH0lmTHMC7TcccZDPlBl0xwMHmDgwxbGKqrSylMpONHJCvjOJNgdAiBh4S3c3KNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep7T5umy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep7T5umy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D26E1F00AC4;
	Wed,  2 Sep 2026 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788357819;
	bh=MtDpGEkDh7eFQBN1dloGGbcdOXn6qckrmCm8+BjUBow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ep7T5umyQPsaQIuxBEjumOhQlbQ6KcBV9dQNiJD3+3dTJb2dztfr3aHL5vmczrWjA
	 cXBm21+OWPnSjsnD8FIij3l8BzZ2UKed60ObsRunCyGG5YXeP6Q5L28a1PMsvqKGSu
	 P0zGLpDTUXqFttIyEsqNQYcPr/ObNSLd8gOd3SFBTuqsl+24UxLiEnu066WYvWhDPS
	 EYitdTC6bVj7x6LwAGAFVbiP5EVx9bSFL/wR4vMRJr6oRq1DWuDQkjxaqqc8QH7y1L
	 d1z1XZ0AsRckAlxG0qoGawcypHeIaCh8jJ4RYxA5eCpij96/ZDZeTnyKMvN2k2cUhG
	 juLQnHGGMFIZQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/6] selftests/damon/drgn_dump_damon_status: dump probes
Date: Wed,  2 Sep 2026 07:03:10 -0700
Message-ID: <20260902140313.85983-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902140313.85983-1-sj@kernel.org>
References: <20260902140313.85983-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend drgn_dump_damon_status.py to dump damon_ctx->probes.  It will be
used to see if in-kernel DAMON status are changed as the user sets the
probes via sysfs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 .../selftests/damon/drgn_dump_damon_status.py | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/damon/drgn_dump_damon_status.py b/tools/testing/selftests/damon/drgn_dump_damon_status.py
index 09552e91bc782..4622046fd0118 100755
--- a/tools/testing/selftests/damon/drgn_dump_damon_status.py
+++ b/tools/testing/selftests/damon/drgn_dump_damon_status.py
@@ -48,6 +48,37 @@ def attrs_to_dict(attrs):
         ['max_nr_regions', int],
         ])
 
+def filter_to_dict(damon_filter):
+    filter_type_keyword = {
+            0: 'anon',
+            1: 'memcg',
+            }
+    dict_ = {
+            'type': filter_type_keyword[int(damon_filter.type)],
+            'matching': bool(damon_filter.matching),
+            'allow': bool(damon_filter.allow),
+            }
+    type_ = dict_['type']
+    if type_ == 'memcg':
+        dict_['memcg_id'] = int(damon_filter.memcg_id)
+    return dict_
+
+def filters_to_list(filters):
+    return [filter_to_dict(f)
+            for f in list_for_each_entry(
+                'struct damon_filter', filters.address_of_(), 'list')]
+
+def probe_to_dict(probe):
+    return to_dict(probe, [
+        ['weight', int],
+        ['filters', filters_to_list],
+        ])
+
+def probes_to_list(probes):
+    return [probe_to_dict(p)
+            for p in list_for_each_entry(
+                'struct damon_probe', probes.address_of_(), 'list')]
+
 def addr_range_to_dict(addr_range):
     return to_dict(addr_range, [
         ['start', int],
@@ -199,6 +230,7 @@ def damon_ctx_to_dict(ctx):
     return to_dict(ctx, [
         ['ops', ops_to_dict],
         ['attrs', attrs_to_dict],
+        ['probes', probes_to_list],
         ['adaptive_targets', targets_to_list],
         ['schemes', schemes_to_list],
         ['pause', bool],
-- 
2.47.3
