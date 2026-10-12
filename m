Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF8491595
	for <damon@lists.linux.dev>; Mon, 12 Oct 2026 15:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817280; cv=none; b=XQAjgzadf/gV1aDDVQ7ai/J3I21KIxsFXwTHu8cnJqBQJZet3F5smCGtEvjB17ZN7eDEqwvIZeKLCupSfPFMRcqnWbaG6JXWdynzn5nbosIbw1ZN6CBTMApP6EP0jq00lYruMrXoTZQudqJ2Ej7FyfgtowtP8zKq7OsOVrOwqoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817280; c=relaxed/simple;
	bh=H9zvp0EZCSBXT12Fz3uC0fRgwE7OgP+2qL2EjG1W1Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+aFofRbTZve8jMqs54QMNS0fLjZ0KNlHryjruVuzPFkuxLGiLzkCw9efLFvw4SSoNASnUAlHwNUxkilsgsQWOLkHzH6PAspUti5OQnjhfhGrUUECVzcs3e6RFgApqy8RcgSXOK9ywaockN9jUmJSQKIVttxfcfUm3FbR0Y7QVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=n7jgmWrL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yanhjcLN; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="n7jgmWrL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yanhjcLN"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id E9D371301221
	for <damon@lists.linux.dev>; Mon, 12 Oct 2026 11:01:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 12 Oct 2026 11:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791817276; x=
	1791820876; bh=PvxGr1CFINA18KAk9q5F7ACBwRMayJ+m/9TUWydj6Y0=; b=n
	7jgmWrLc/K3sDfEtEQ/nK7i4LVonH8uz5RAbi3EaeTbeK5Nm5ljaehuKkMVaYpLV
	Obm0VUOP6w3kZFo3EVkX7YpfYDnif6bCwfTXmrwesMxq0vr1wUiosZ+V3a9VNcAa
	KXy21nqrMlUCAY4KhVc3CY8pG13wK4zEDDCf5R5uzrsiRc0Gl4pKmZhs6R6hB47r
	pQSY/4jgTkvy61cNGf5oWusNkqNbDgNFGL/bcGEt2O3JWiSG+OVLGL60H6Snt0U0
	8rXt5Hlq8iLQc6kI67qSFlR4mi9KzYVQSpjSheCIyYogxiGFSkNi+fu6qaRVcjhN
	ua0qTiL1d8suTnOkCJE2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791817276; x=1791820876; bh=P
	vxGr1CFINA18KAk9q5F7ACBwRMayJ+m/9TUWydj6Y0=; b=yanhjcLNwgFU0T6zS
	pdjj0ezh0Srgo34dirvhxhCAhm47AtVs744YLKHb+9bH9RCtbNmsKnK/A6YlPpF9
	9SsFAd/BhnLSqpkjR49iv0BnMuXDdjujNLQhllFcFa4KoXQ0HF+dF54EnzUc7ROu
	RbQCtmEEELJcQUBulqfuHWA/NR5ALiOGjZAIxEu8G8awZGztEFVnT0IIzbCHC10/
	uNFSYebaytRHBPjetbjMfAHREDPMm/Pg2mKEVNEC2XANvzskor2wKEeTxw+4Vuqa
	60AGOmxCjT0KS06UCOTOXSm+J6muvaDNCG/5fyPsj/NKtGFQRPdStlJcf8WUvrtk
	h44ig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791817276; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:p7MIzmQekDpdbXXhVoGJxZWOui4iJh83JH9KLPihKv8KLY/
	+i3UMlm9ZA5tW6BVfnQPlylDTTasBBUAafTIxxT7CsqSvjArnuFnj7H1ubhAFtgV
	8qiIZxmuG5qNICnutGY6efk3poG4k1E9Z0W34lc5bq26nZkanjnxXgaF7Chze980
	otmBgjdYuXB7/LjucwjbCGmBu5crTaZ91Ok0t4dal3kK5n8PsHsirQVRk4RCu021
	fvun5etZIS/GobZ2v3U1KNaIVpE0q4YAhJSovTzKuUTIP7D7x3lWl/sKtNDgrby4
	d7GiD/NMHCBV1LsZ5fgtfFhqIt4uNlw/KUruzpQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yQ2vvnXpzJzAkbIEAInqbfoEDRWPIj/3jLWBI3sjHNE=:H9zvp0EZCSBXT12Fz3uC0fRgwE7OgP+2qL2EjG1W1Ug=;
X-ME-Sender: <xms:PPbMalQ8qBdcjd2efg9vFXpG2-44XYzmV9Jd7MuiKkLsvuC6FSXDqQ>
    <xme:PPbMaoGXMpL1xp7JWNdX2gULol8XLDJqw7Rpreb26jPY3AhgNO1hfev5rS7bEQcOs
    ayi-5tYJwXV6K-zEcEkvgy-UFQCFWjFMSPtcrXvCc6CLgXyKP2gePdp>
X-ME-Received: <xmr:PPbMaiE3CqP4AFhrvbNsIQP2R5wqP3Uv1f3HFi0wRYaI8SlQKEhJa_HbBQ>
X-ME-Proxy-Cause: dmFkZTErDdaJDRXdtNCIjl4zaEaVlPSB06aAVyOQ6x1o5VxLbYfiAOQZRbFQpiPBT4JjpM
    tDDI7yio8aZDSIOhcndLp0t0KWZA5KFWQuFr5wvn0bxS8NTlaio24CI42iTSPQ+jhdFgjF
    9a89afYLD7UDgWgHlCtnjqs6Q9S41kdWMiMdVZpux+Rgb0n85xFK3b7eAp+V0pNy8RMJgK
    CayOV2kkOCvfZdzAoAfDYmuTcDkowsDl+/OMHHO78fF3wVxHwXD6id87zrcCs/36ianAUH
    cRx8fJJXQ5C3FdQl14ni8vbJerSrPEYHDsxpwjVRRLepXJM83WpLvXryW22obvm47sN8p4
    sOgjlSG2B2Lnh6U1picS3Iijh6qWXyMuyuhCLCf848a9Kns56LgnSR+He6/g8EAiY+qixH
    GqXHN3qNtOT9M8McX3XfbHYPhvzDg5T21NEhiof5HKWZ1oJ3gOkJP1MKzw2LLP+XCEXFDO
    sjamdtMwlyY7dm38+eeoCTe84dDxlvPxlSTkq1em9KduNx8XtFgJm5VXicXD9GBnByF8zl
    9S3nYZTgSk9sk4FfGCaIvpf+Ucg3IhAnZ2fd3jl9odbOQMeaHG0UqARkfRoKuNS9agSnM4
    Xc5oGW0XFlXMdlz1j/HKIUBXqMdDEtKKAqrOAhvVfheHq/AP3GZrH0/PMRGw
X-ME-Proxy: <xmx:PPbMauQ9fZgP1QLW3kNcmnnBfLwi1XsrM-jnP6FL2i9z4JcXawDq_A>
    <xmx:PPbMarKoJkfOVB90zM9QzYTkYhROah9323lF3uv3-deVUWHYolDd3A>
    <xmx:PPbMahbE6-WwE3--rhkjpsTLWLBda233T4ovmFw0cXzx_V0INI--RA>
    <xmx:PPbMal8dGnvU1K1rcYIwf4Qjixf-sujhFAGClbUfftxpFGmyXGYgbg>
    <xmx:PPbManqMNHDUg43k7YlVeIdKkJdH-sChtmTQedFaQmWYTpa2y_q4UjK->
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 11:01:14 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm/damon/core: Use only installed probe in damon_merge_two_regions()
Date: Mon, 12 Oct 2026 20:30:39 +0530
Message-ID: <20261012150045.169377-1-suhaas@s-joshi.in>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012145636.168436-1-suhaas@s-joshi.in>
References: <20261012145636.168436-1-suhaas@s-joshi.in>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While merging 2 regions, we iterate over the entire probe_hits[] array,
whose size is determined by the DAMON_MAX_PROBES macro. However, it is
possible that we have fewer probes installed than DAMON_MAX_PROBES. In such
cases, we end up making redundant iterations. Therefore, to remedy this,
iterate over the list of installed probes instead of iterating over the
entire array. For doing this, start accepting a struct damon_ctx in
damon_merge_two_regions(), and update calling functions to pass this
argument.

Update the damon_test_merge_two() test to use this new signature for
damon_merge_two_regions() as well.

Signed-off-by: Suhaas Joshi <suhaas@s-joshi.in>
---
 mm/damon/core.c             | 15 ++++++++++-----
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b63e60ef8990..bebd2889c2c8 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3524,20 +3524,25 @@ static void damon_verify_merge_two_regions(
 /*
  * Merge two adjacent regions into one region
  */
-static void damon_merge_two_regions(struct damon_target *t,
-		struct damon_region *l, struct damon_region *r)
+static void damon_merge_two_regions(struct damon_ctx *ctx,
+		struct damon_target *t, struct damon_region *l,
+		struct damon_region *r)
 {
 	unsigned long sz_l = damon_sz_region(l), sz_r = damon_sz_region(r);
 	int i;
+	struct damon_probe *p;
 
 	l->nr_accesses = (l->nr_accesses * sz_l + r->nr_accesses * sz_r) /
 			(sz_l + sz_r);
 	l->age = (l->age * sz_l + r->age * sz_r) / (sz_l + sz_r);
 	l->ar.end = r->ar.end;
-	/* todo: do this for only installed probes */
-	for (i = 0; i < DAMON_MAX_PROBES; i++)
+
+	i = 0;
+	damon_for_each_probe(p, ctx) {
 		l->probe_hits[i] = (l->probe_hits[i] * sz_l + r->probe_hits[i]
 				* sz_r) / (sz_l + sz_r);
+		++i;
+	}
 	damon_verify_merge_two_regions(l, r);
 	damon_destroy_region(r, t);
 }
@@ -3590,7 +3595,7 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 			goto set_prev_continue;
 		if (damon_sz_region(prev) + damon_sz_region(r) > sz_limit)
 			goto set_prev_continue;
-		damon_merge_two_regions(t, prev, r);
+		damon_merge_two_regions(ctx, t, prev, r);
 		continue;
 set_prev_continue:
 		prev = r;
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 3fbb4e4e36fa..385d32901650 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -182,6 +182,8 @@ static void damon_test_merge_two(struct kunit *test)
 {
 	struct damon_target *t;
 	struct damon_region *r, *r2, *r3;
+	struct damon_probe *p;
+	struct damon_ctx *ctx;
 	int i;
 
 	t = damon_new_target();
@@ -206,7 +208,21 @@ static void damon_test_merge_two(struct kunit *test)
 	r2->age = 21;
 	damon_add_region(r2, t);
 
-	damon_merge_two_regions(t, r, r2);
+	p = damon_new_probe();
+	if (!p) {
+		kunit_skip(test, "probe alloc fail");
+		damon_free_target(t);
+	}
+	ctx = damon_new_ctx();
+	if (!ctx) {
+		damon_destroy_probe(p);
+		damon_free_target(t);
+		kunit_skip(test, "context alloc fail");
+	}
+	damon_add_probe(ctx, p);
+	damon_add_target(ctx, t);
+
+	damon_merge_two_regions(ctx, t, r, r2);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
@@ -220,7 +236,7 @@ static void damon_test_merge_two(struct kunit *test)
 	}
 	KUNIT_EXPECT_EQ(test, i, 1);
 
-	damon_free_target(t);
+	damon_destroy_ctx(ctx);
 }
 
 static struct damon_region *__nth_region_of(struct damon_target *t, int idx)
-- 
2.55.0

