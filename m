Received: from mail-yx2-f3.google.com (mail-yx2-f3.google.com [74.125.224.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512C419FDA
	for <damon@lists.linux.dev>; Mon,  5 Oct 2026 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190041; cv=none; b=cxPmyS3L5LYuV2Fr3EmAFS3Yd0LuFTwPePLAyamS05oxFl7WKTYoUNvrfGDhS8bLnLezJ4IOan5XllElw+x9hlqz/7qjDs/n3hC9OGLoxWNx9RXVVY0EWxVpo06nWJshrei4TO1S9wdFNhOpyE6LkYzw6/4dVygecF95xPStt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190041; c=relaxed/simple;
	bh=symTFEdsEz1iDbwVSvZBKTbueNku2GFz7sx5Y41Ynvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fxt9uRCl6AkSXhvrZbjSrxOBJdC4n16ACgc6w1p0MQFSAWvnTKW4AjrGB9iXy5PmxutWukFGR70NNmKCC88M8gYQTAOfuy/50RbE70BEtr4qczZpPyEKIFUHRCULUHA4GRDy8Peg3HfcEQdBHcZltB1LBjnPCVK4xUy4GclvfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsR2eZxB; arc=none smtp.client-ip=74.125.224.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsR2eZxB"
Received: by mail-yx2-f3.google.com with SMTP id 956f58d0204a3-66fd0af9eb0so450430d50.0
        for <damon@lists.linux.dev>; Mon, 05 Oct 2026 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791190038; x=1791794838; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yNNeYfS92dPvp0CaRE/I5c5+qwjZ49qCZegwTjKDnBY=;
        b=YsR2eZxBdYDEuMRE3DfXCip5cH64EQBEhr2hOYkIZzpItTP8YApj4cWb5GN542pv0S
         NWab9i+JMEHTeqfCa5/AflXgPi+RdE0PLoA7JfnubyqfjInm1RGyBvSEPvK7RhUMmm0E
         jb4zr1g3EA60toc0WoCAfLTS33sDnEXSe/Ajikkx0jNlf68Zzj1t2twRqnAmdd0SAWf/
         SuqtM239So4JuCKuumWZO1iknKdfet8Kh0VIri8HqJfQqs7AqmZ0nQ8u6Ex8i6Jr1Abd
         WegiRERed/e6Ortyb4sp74tucNvQewrwlo7E47UxG3Bb+rOce3w0qSOeRzkXFGKxPmn1
         noAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791190038; x=1791794838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yNNeYfS92dPvp0CaRE/I5c5+qwjZ49qCZegwTjKDnBY=;
        b=Q0t1V1djk5Qc2vHOvRUUk+ypaciMhiiQRbuNYtSycEw2BBK01abFmDvvNj1MTvZcTe
         SmdGtL5oUX1yfZuu32kBfmmGMIZmO0K7QLlc4GY0qNAn/OKlMEjOZ8CeOSWezGo/jTPQ
         dNLMcc3N+s+Iqw+aaJ/IlOeobpud9hmYSB1aLghukLtNvSKChCAQ/N2OKKZylgwKReKI
         rZT+5QHjuSqk4DsN4FKTqhgWZX95xDxuv6lLvHi2o1+80OgLx2qO4fpP1IUqVUk/wg59
         QphfFRTOj4fetzOD2TTjraibl3CzFORD+ds7tRlRQLbCbTgA+at5Ay/cW7Q6bk05NuWT
         TxMw==
X-Gm-Message-State: AFq9FYL2SmuiUAfsJF582b1tkYmSXGWar6GiXlO7t0d0nlqIMPQAnQde
	zUTe4lVMBBCqNHAOdoWc/od+DFCJoVwzpoYHIA1EDgOj0mo46WxhRus=
X-Gm-Gg: AYBFou32YX9ssCpN0hGVXGSRxbDnclnwL0Wm4SCc/+rdjUm6CZqrSCJqga0hCm6Jp/s
	ekyHbxPMGGRNgEBHvz2nzlYo0flxmQ52vG3aY5yLXNZGFjwHUsCLfU6E2WsVvW9vKl8uVuIseG6
	SRMdZLsxBnlfvb5tIR5jnf4amKp29QNWXAxmfNVZc4652PbhCsXf24Y/33QUhIYXnqo1+hYj8UQ
	gUIirzxWwnQ4nNe1KMTSBEYcuIHpQ/oT9mvwcYqNSgnmQqFlVrkDewC7nCbJ6d99/zdg8JwsHrl
	87tbhVY/a9WjVMSWQYss79zT12Wl/EA/4KzNJe/8bmdUzEnr/JPZUwSK18FSjNOU5brn37uyslL
	Qss1IjcR0AfhzN9II7Tp5nYpHxe2hU5IlM3vh7To6V6ICz0u3aSvZWpozd6DlrjOfs/ipHwpFaf
	D9cNUigZaL+IRQOYi+HQ+FPj/RkmEJ3SrCavnnOI3IYabO5CAAF+eisSXO5Gems+jEhcIoe2nyX
	4BrDAm6QMO87ZlEwtIoHZFg0GOre6+fPOVg6A0QtBW8VB+eRYmHOJz/PzHYHsuVnoz18uUpLUCE
	xTb6C/7g2N9+dLJ5WW4hLlyCThCBg6Euuek=
X-Received: by 2002:a53:c60d:0:b0:675:6161:4171 with SMTP id 956f58d0204a3-677ac159e1emr2637240d50.108.1791190037814;
        Mon, 05 Oct 2026 01:47:17 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:1700:4577:1050:1149:2fcd:c86b:8747])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c1b9c895sm2346306d50.13.2026.10.05.01.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:47:16 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Mon, 05 Oct 2026 01:46:53 -0700
Subject: [RFC PATCH v4 9/9] mm/damon/core: apply probe_hits_wsum filters to
 node_eligible_mem_bp
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-9-b03452e137f3@gmail.com>
References: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
In-Reply-To: <20261005-damon-perf-rfc-v3-send-2026-10-03-v4-0-b03452e137f3@gmail.com>
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

node_eligible_mem_bp is the share of a scheme's eligible memory that is
on a given node, and memory is eligible when its region matches the
scheme's access pattern.  In data attributes-only monitoring nr_accesses
is not updated, so the access pattern cannot tell which regions the
scheme is for; its probe_hits_wsum filters do.

Count a region as eligible only if it also passes the scheme's
probe_hits_wsum filters, decided as the scheme's core filters are: the
first matching one decides, and if none matches, the region passes
unless the last of them is an allow filter and the scheme has no ops
filters.  The address and target filters stay out of the metric, as
before, since they scope where the scheme acts rather than which memory
it is for.

Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 mm/damon/core.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7c0df07f0a90..bae4569f0ab3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3609,6 +3609,31 @@ static unsigned long damos_get_node_memcg_used_bp(
 }
 
 #ifdef CONFIG_DAMON_PADDR
+/*
+ * Whether @r passes the probe_hits_wsum filters of @s, decided as the core
+ * filters of a scheme are, with the other filter types left out: the first
+ * matching filter decides, and if none matches, @r passes unless the last of
+ * them is an allow filter and @s has no ops filters.  These filters select
+ * regions by their data attributes, so they are part of what makes memory
+ * eligible for the scheme, unlike its address and target filters.
+ */
+static bool damos_probe_filters_pass(struct damon_ctx *c,
+		struct damon_target *t, struct damon_region *r, struct damos *s)
+{
+	struct damos_filter *filter;
+	bool pass = true;
+
+	damos_for_each_core_filter(filter, s) {
+		if (filter->type != DAMOS_FILTER_TYPE_PROBE_HITS_WSUM)
+			continue;
+		if (damos_filter_match(c, t, r, filter, c->min_region_sz))
+			return filter->allow;
+		pass = !filter->allow;
+	}
+	/* as damos_set_filters_default_reject(): ops filters decide the rest */
+	return pass || !list_empty(&s->ops_filters);
+}
+
 /*
  * damos_calc_eligible_bytes() - Calculate raw eligible bytes per node.
  * @c:		The DAMON context.
@@ -3616,9 +3641,10 @@ static unsigned long damos_get_node_memcg_used_bp(
  * @nid:	The target NUMA node id.
  * @total:	Output for total eligible bytes across all nodes.
  *
- * Iterates through each folio in eligible regions to accurately determine
- * which node the memory resides on. Returns eligible bytes on the specified
- * node and sets *total to the sum across all nodes.
+ * A region is eligible if it matches the access pattern of @s and passes its
+ * probe_hits_wsum filters.  Iterates through each folio in eligible regions to
+ * accurately determine which node the memory resides on. Returns eligible bytes
+ * on the specified node and sets *total to the sum across all nodes.
  *
  * Note: This function requires damon_get_folio() from ops-common.c, which is
  * only available when CONFIG_DAMON_PADDR is enabled. It also requires the
@@ -3638,6 +3664,8 @@ static phys_addr_t damos_calc_eligible_bytes(struct damon_ctx *c,
 
 			if (!__damos_valid_target(r, s, c))
 				continue;
+			if (!damos_probe_filters_pass(c, t, r, s))
+				continue;
 
 			/* Convert from core address units to physical bytes */
 			addr = (phys_addr_t)r->ar.start * c->addr_unit;

-- 
Git-157)

