Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739721C84BC;
	Fri, 17 Oct 2025 18:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725215; cv=none; b=jX0Fq5lhW8YjRCtSBWo82VkGoyR5MWjvHJvmAG3nsmqA1z7OgYFcd/ki8fgpuNufn2l+OJv3SCvsMH+LDiYgHobuPWuuugpA73U4RDPeHpXEHxKCkI3DdMFYtBnfLFROS+p2lpd6VPC8z/iHsarlRlB4BbbNpjrQjACuK4HO8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725215; c=relaxed/simple;
	bh=N7DJTkgdFq2cVtwSeDRgEDmegzhxtatOlmC9hFsx/jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAoIPjmOeo+XdIHjUOLVotAA50K+gqaq/3gVMTMi0BZ9YZrXSLrlf6Sk+RSvhB7nB6RxA4yPj+OvnlJQLNkxdf8pLdIHTrxcOm6IHMwdhNNgGQMC6FbueCvNtqlqgWMsLXlOsqqY/gGU/3c+/dTg5ligeeBcK/vMDJr8VGSCOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vwq2wUjl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vwq2wUjl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6BBC4CEE7;
	Fri, 17 Oct 2025 18:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760725215;
	bh=N7DJTkgdFq2cVtwSeDRgEDmegzhxtatOlmC9hFsx/jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vwq2wUjlPQJ305VOVK2SUdxUZv760Gg2pHU/yKSLZwbT+CW2S4XSTDxOuK8fXDRd4
	 GsPNGXzw6fKokxPiVFRR1goVQ7VTX6Ah5i9z1BDLQceUOCTibvomTJpiiP6ZLr2du6
	 S02vW7CQLJ/YgK5IYYldYJghS+ADZYHw4qzM/x4bXsQjDoGj0fM3F58xYTGd6fCHlo
	 ksPaoup8k/GOIAZOh1+ew70+l/6K2YIuE7q/7mw3go4kCoHUzMGrYYmlwKU5rIQH2N
	 7qPAXa9d1qjFJ8KwKrDUqRrfYw+lrT+zsecq9IcP5ZhBo/wyMIfCFRKwe9v7th2hUP
	 CUZYfpRtzAsfA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 03/10] mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP
Date: Fri, 17 Oct 2025 11:20:03 -0700
Message-ID: <20251017182006.124211-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251009212042.60084-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  9 Oct 2025 14:20:35 -0700 SeongJae Park <sj@kernel.org> wrote:

> Implement the handling of the new DAMOS quota goal metric for per-memcg
> per-node memory usage, namely DAMOS_QUOTA_NODE_MEMCG_USED_BP.  The
> metric value is calculated as the sum of active/inactive anon/file pages
> of the given cgroup for a given NUMA node.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 93848b4c6944..1eacf78aa358 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[...]
> @@ -2058,6 +2093,9 @@ static void damos_set_quota_goal_current_value(struct damos_quota_goal *goal)
>  	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
>  		goal->current_value = damos_get_node_mem_bp(goal);
>  		break;
> +	case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
> +		goal->current_value = damos_get_node_memcg_used_bp(goal);
> +		break;
>  	default:
>  		break;
>  	}
> -- 
> 2.39.5

In addition to damos_set_quota_goal_current_value(), this patch should also
update damos_commit_quota_goal_union(), like below.  I will add that on the
next spin.

--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -825,6 +825,10 @@ static void damos_commit_quota_goal_union(
        case DAMOS_QUOTA_NODE_MEM_FREE_BP:
                dst->nid = src->nid;
                break;
+       case DAMOS_QUOTA_NODE_MEMCG_USED_BP:
+               dst->nid = src->nid;
+               dst->memcg_id = src->memcg_id;
+               break;
        default:
                break;
        }


Thanks,
SJ
