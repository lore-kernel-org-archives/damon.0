Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD71EB5C7;
	Thu, 27 Feb 2025 05:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635458; cv=none; b=rQNfjQcu02rYNoZetz4g+6wnNWT6p3R/lHIW56AGVE7748svdpEs3vf6WKI0DH3urKMiBDOhpNsLh6K3j9R5fDDBf5VKXazQmSaQymkxTvtDP4/VAa/+VH7mUSi9uRJx2zTT29KyoJ5sJ3sxouTF4PCEdP0UBi5QxshbJVcf/Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635458; c=relaxed/simple;
	bh=JkCJgg3pXcFKl7jwQLtss0Q7N/vh0YlTKOc0U3CUB54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZHJAnhnlpYmMd0+kaGgbxpi7q1Ix9Zoft+aGCuup3KqkxaexQuhpf+cM8IPZ0xN8MbfCj0NHWcdC/ECF5gzLiEss/eCqqWB8CF3+sE9Gl2rHwKnd4fI0AdYEw7spfJEJ2cRRM1h+BaIzz6Wd5lliOlu+rPSdomOshX8epxyBGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3iAqjPy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3iAqjPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DDAC4CEDD;
	Thu, 27 Feb 2025 05:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740635458;
	bh=JkCJgg3pXcFKl7jwQLtss0Q7N/vh0YlTKOc0U3CUB54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3iAqjPyhw+BgraAZGgf7zQsZiPtqrwhFBzAVPN2s/aWADqK8fJwGd9a95ZBjyyPX
	 fgQitOJ+wPHuUiZTMlbMa9h3F/T7r5QnMZrdtcJ9VqwFDElo7XywCiAp2VMMZS/Qjo
	 01syAXuMiQnGuEvUS08DeN5M85grmC01TgIiYKeb03Re+mySGYPpEg389ZsaSgHaTj
	 4xWjcCv9MUayu/NOj7ZCa6qmNFMhR5mdd46dXRO9EUBhsmR274X1G2rm07obWxVmVB
	 C90HerYeOI/+AoqGCv+9+iaW//lDSQFEpM9Ic2ga1PAT8cgtqu+cNVLNZsGszMDbyh
	 Snps/d3ZPtQEg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 7/9] mm/damon/core: set damos_filter default allowance behavior based on installed filters
Date: Wed, 26 Feb 2025 21:50:54 -0800
Message-Id: <20250227055054.22813-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227015754.38789-8-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Feb 2025 17:57:52 -0800 SeongJae Park <sj@kernel.org> wrote:

> Decide whether to allow or reject by default on core and opertions layer
> handled filters evaluation stages.  It is decided as the opposite of the
> last installed filter's behavior.  If there is no filter at all, allow
> by default.  If there is any operations layer handled filters, core
> layer's filtering stage sets allowing as the default behavior regardless
> of the last filter of core layer-handling ones, since the last filter of
> core layer handled filters in the case is not really the last filter of
> the entire filtering stage.

This is not sufficient enough.  Even with this change, core-handled allow
filters after core-handled reject filters are still meaningless.

If a region is matched to a core layer handled filter, the allow/reject
decision should be respected while ignoring all remaining filters, regardless
of on what layer those are handled.  It works in the way for reect filters,
since core layer-rejected regions are not passed to the ops layer at all.  In
case of allow filter, however, the region is passed to ops layer without the
information about whether it has passed to the ops layer because it was
allowed, or just not matched to any filter.  Hence, all ops filters can be
applied to the region.

We can implement this missing part by storing the core layer filtering stage
decision somewhere and let ops filter filtering stage repsect it.  Changes like
attached diff at the end of this mail may work.  I will add such changes to
next version of this patch series.

Thanks,
SJ

[...]

=================================== >8 ========================================
diff --git a/include/linux/damon.h b/include/linux/damon.h
index b7a4d12ce532..8d8621d8b58d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -528,6 +528,7 @@ struct damos {
        unsigned long next_apply_sis;
        /* informs if ongoing DAMOS walk for this scheme is finished */
        bool walk_completed;
+       bool skip_ops_filters;
        /* whether to reject core/ops filters umatched regions */
        bool core_filters_default_reject;
        bool ops_filters_default_reject;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 783cc05a9fcc..a2e4bdbb6b19 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1662,9 +1662,19 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 {
        struct damos_filter *filter;

+       s->skip_ops_filters = false;
        damos_for_each_filter(filter, s) {
-               if (damos_filter_match(ctx, t, r, filter))
+               if (damos_filter_match(ctx, t, r, filter)) {
+                       /*
+                        * ops layer filters should also respect the decision.
+                        * Store the information in s->skip_ops_filters.
+                        * If the decision is reject, the region will not be
+                        * passed to ops layer, so no need to set the flag.
+                        */
+                       if (filter->allow)
+                               s->skip_ops_filters = true;
                        return !filter->allow;
+               }
        }
        return s->core_filters_default_reject;
 }
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4a170086852a..8568b5a34888 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -393,6 +393,9 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 {
        struct damos_filter *filter;

+       if (scheme->skip_ops_filters)
+               return false;
+
        damos_for_each_ops_filter(filter, scheme) {
                if (damos_pa_filter_match(filter, folio))
                        return !filter->allow;
