Received: from mail-yx2-f6.google.com (mail-yx2-f6.google.com [74.125.224.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF03A4521
	for <damon@lists.linux.dev>; Sat,  3 Oct 2026 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791061727; cv=none; b=pmzzljdPBnuS+tXXsqp5kCQjWue9dWHUUK/BRtbo6dPeN2dNoe0zQnU0B4MPJwKLUAjj2jww7b5rX3LJ8lt9DfEUC7Wfrkc37C6Z+Jsvkt0LbjGDR88BZTUZQZN8Cy4hVwfs+oZK7533bbftsTUpvWwR6+HY9WD5WgUHxIFXa6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791061727; c=relaxed/simple;
	bh=tAIEaZy66MiqjyAhvBIqHObw90APe1vijRLdD1hBJLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gt+b1OT5dy1+MBW4yWOEa6SL9MUwJGzKP2uPJOBwkFHhozhppcBaYZ7tDWtuwf6Vlt6AiR+y4CfhZ8LZ/WwvZxuDjAseUVNBl6+wVDzXq0Z8DUE7LUq2VOCp8Vky0+do0UNhO5hvXos9S1nxVWZWvzNTUO7N1GJkzCe1dnSATtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJjHf+Mt; arc=none smtp.client-ip=74.125.224.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJjHf+Mt"
Received: by mail-yx2-f6.google.com with SMTP id 956f58d0204a3-66e61475fa7so255016d50.0
        for <damon@lists.linux.dev>; Sat, 03 Oct 2026 14:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791061725; x=1791666525; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7T2njtLf+tsG9r8toysyAJNfleUrJXsFeeqkEldERK0=;
        b=EJjHf+MtrhbqzCMuKUJXzswE8GiO3BtJ7auK0e4LhpVyjBvcShqCV4XETTEu69T5Ib
         xXxUuneiiTmonGv72vFvlSGfzzLHSV41l0GBofOxtYPqL2WhFbPP6MPEPKDo4ZyvoSz1
         mMqxTA8V6N1wa0JDYk02p0WiVw/NStlqoUN97rEL6nTI48iLhen4c14RbC2Msag5yl6b
         Z4+hd+2VElAR2cYEb4qNLxFJpZCqn0UGdpe2SF0TcSpNx2ffO0Cf4jsOMHWe0ADE2+a7
         jbqgz/OSg8exYNKr4bExrNZqUrBCEdNdd/B6/5kwB61KC3ozq8AdzRLIxAgqZiEQOSX8
         yxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791061725; x=1791666525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7T2njtLf+tsG9r8toysyAJNfleUrJXsFeeqkEldERK0=;
        b=bJPX8Bi6pbjewAsPXDbty2s+0gjIhxxfzCS+v8yLs4Td7TRkATS5b3aqsZ8xoucTe/
         8U1UjLCTjoQ/kYr8FvvxuRWc7mn7opXKoT2WpeBpD/AQ/qu4xoWs6l+qNZRbkQLni+2J
         yPovzlrLWudd07vIBMetRMU1S7ooW64X9PIAy1ZFZ1D7L5lD2lQlNVQM9b63mOanHtNk
         slV/x88pCEbJNbQTegXKReBpyi8SjvYujJqxFgp1p42xn4MBp6GQnWMdlV4rkmNsBY6W
         J9q1UMw0zGV2LpZHVSBYrj4Z4w2+nVe/eRW27ODwPf0Yf75n+pteLtBSanRlNC+yLk5h
         h5Cg==
X-Gm-Message-State: AFq9FYLrM5bJng0w8FbJK/4ZN4C9pcbHOERwR60+mvNd+QsTDraoPj5p
	ljCC0j++9QEqt4GvQqlggaAEpwLpfYmeWQMEXxuv+NQafLYYOC3YUVM=
X-Gm-Gg: AYBFou0BMel+3Ccl3D4kUcvYk3TuDgGjzJckR2q7z3Q+jNASqGtT7V2hIz6DCh3j9I/
	iO3/Q8aqeQqjGr8Xt4gvVvQzIb+JEfATbknGwWh3iVPTorqFWztcHQikOdqB9J15DyLiduQUqFW
	H//dwXkbSJyiAGlCFQ++7Fd42kaxT5N+nsNuMgnP/zrzBM9wj+AmdnR8ST1FwU8Vvn6fGnVR5/k
	2xb7bvy23bdPJ8X9yAkT0x/9rMR7x126+quoifdm+GstPqMMl++7kK+IcZy1IDL9IjfPslsBuV7
	N6fTEY1v+IsdQk8iE7mojS8dyjpuevt9b3AA2m/xxBWC7CfHvaKfoS2cEZa3wrNXw5ijmlXY3jJ
	hwezprHKGqEjNvX4bHVWQI8L6/ws6SPZKCclpdYkOKxT+hNPoX+eJBD1XlOvUn3nxfIcXHyAsJi
	AuJ5YQ0LlPqU2jHmRqllWs8dnMHxksZkxnPXatmsGb2kkTrY6GrCRyqyPSWGx8/SWP5sONoa7Mh
	+Dxa9YO9ZolKu2hWHm2rTv3HJ2mZG/WsK3NS3rcWPeIdMOyx5f8yakF3lZPZV9x46ofb8NnSCsD
	ALuAr/19qGw/g4zZZdiojFQdpkFgPw36ew==
X-Received: by 2002:a05:690c:e3ec:b0:8a4:b0dd:c849 with SMTP id 00721157ae682-8ae3a5e66b0mr30220037b3.52.1791061724836;
        Sat, 03 Oct 2026 14:08:44 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:550f:9551:5468:60f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8af0d179d3bsm743537b3.40.2026.10.03.14.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 14:08:43 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Sat, 03 Oct 2026 14:08:02 -0700
Subject: [RFC PATCH v3 9/9] mm/damon/core: allow both primitives disabled
 when a perf probe is present
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-9-0f00417b41bc@gmail.com>
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
In-Reply-To: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-0-0f00417b41bc@gmail.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, 
 Wei Xu <weixugc@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
 Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
 Kunwu Chan <kunwu.chan@linux.dev>, 
 Ravi Jonnalagadda <ravis.opensrc@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0

The sample control validation requires exactly one software access check
primitive, page_table or page_fault, to be enabled.  A context carrying a
perf-event probe needs neither: the probe drives the access signal
through its report ring and the drain, so region access rates and ages
update with both primitives off.

That check runs in damon_commit_sample_control(), which sees only the
sample control and cannot tell whether the context has such a probe.
Move it to __damon_commit_ctx(), skip it for a context with event-driven
probes, and run it with the other validation of @src before anything is
committed to @dst, so a rejected configuration cannot leave a live commit
with its PMU events already armed.

Add damon_test_both_primitives_disabled_with_probe(), which commits a
context with both primitives off and an event-driven probe and asserts the
commit succeeds.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c              | 11 ++++++++---
 mm/damon/tests/drain-kunit.h | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c2c74d0daf95..04a1cccbc2f5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2357,9 +2357,6 @@ static int damon_commit_sample_control(
 		struct damon_sample_control *dst,
 		struct damon_sample_control *src)
 {
-	if (damon_primitives_enabled_invalid(&src->primitives_enabled))
-		return -EINVAL;
-
 	dst->primitives_enabled = src->primitives_enabled;
 	return damon_commit_sample_filters(dst, src);
 }
@@ -2390,6 +2387,14 @@ static int __damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src,
 
 	if (!damon_valid_probe_params(src))
 		return -EINVAL;
+	/*
+	 * A probe-driven context needs no software primitive.  Validate this
+	 * before anything is committed to @dst, so a rejected configuration
+	 * cannot leave a live commit with its PMU events already armed.
+	 */
+	if (!damon_has_event_driven_probes(src) &&
+	    damon_primitives_enabled_invalid(&src->sample_control.primitives_enabled))
+		return -EINVAL;
 
 	err = damon_commit_schemes(dst, src);
 	if (err)
diff --git a/mm/damon/tests/drain-kunit.h b/mm/damon/tests/drain-kunit.h
index 8e5023ebf6df..be44311617fc 100644
--- a/mm/damon/tests/drain-kunit.h
+++ b/mm/damon/tests/drain-kunit.h
@@ -722,6 +722,42 @@ static void damon_test_bsearch_unsorted_regions(struct kunit *test)
 	damon_destroy_ctx(ctx);
 }
 
+/*
+ * Test that damon_primitives_enabled_invalid() accepts the both-disabled
+ * configuration when an event-driven probe is present (this commit's
+ * relaxation).
+ *
+ * Before this commit this configuration was rejected (-EINVAL).  After it,
+ * it is valid: the probe drives access-rate updates directly via the report
+ * ring, so neither software primitive is required.
+ */
+static void damon_test_both_primitives_disabled_with_probe(struct kunit *test)
+{
+	struct damon_ctx *ctx;
+	int ret;
+
+	ctx = damon_new_ctx();
+	if (!ctx)
+		kunit_skip(test, "ctx alloc failed");
+
+	if (damon_test_attach_perf_probe(ctx)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "perf probe alloc failed");
+	}
+
+	/*
+	 * Explicitly disable both primitives.  With an event-driven probe
+	 * present, damon_commit_ctx() must now succeed outright.
+	 */
+	ctx->sample_control.primitives_enabled.page_table = false;
+	ctx->sample_control.primitives_enabled.page_fault  = false;
+
+	ret = damon_commit_ctx(ctx, ctx);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_drain_test_cases[] = {
 	KUNIT_CASE(damon_test_unified_vaddr_match),
 	KUNIT_CASE(damon_test_unified_vaddr_tgid_mismatch),
@@ -733,6 +769,7 @@ static struct kunit_case damon_drain_test_cases[] = {
 	KUNIT_CASE(damon_test_report_addr_space_keyed),
 	KUNIT_CASE(damon_test_ring_full_counter_increments),
 	KUNIT_CASE(damon_test_bsearch_unsorted_regions),
+	KUNIT_CASE(damon_test_both_primitives_disabled_with_probe),
 	{}
 };
 

-- 
Git-157)

