Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DDC190697;
	Wed, 26 Jun 2024 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719438598; cv=none; b=USUY2Crd7mf+T7IZ3mX3QpHUPyRAK4fs+n+B2tFaM49h8TuzJYCMEyc0CnFbYSx7nKhTr1d7cly6ANYpkM2n9aXs751tmiC2pia8ZooGR0mWQ3x4MMP3ZdjvtDl2CgQW/xWFkkEJ/x5Wbou5FizJT/FxPsP/89E7akGTn4TgIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719438598; c=relaxed/simple;
	bh=vbEkrfUjgmgKqdl2dZG8HUfOBAyAIBXP7eZIOo4QAUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ck5YVpRSUIYG5wrsVylkwFRWC96iC/a2KETAA8O0p/DECAnXVuGHGgtUkiIZWc451r1f3au6CRp9EEFCjdVC/yOG1zBqKbMSXY8vJ7jaHz5YxVJk9tIE2QEOI/UuoPe2WmCXxP1Up05auyWXhWauA59w6FO2pao9+yhPsssOO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M51PKDuK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M51PKDuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D5FC116B1;
	Wed, 26 Jun 2024 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719438597;
	bh=vbEkrfUjgmgKqdl2dZG8HUfOBAyAIBXP7eZIOo4QAUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M51PKDuKttI5HYYW8JwcELqr83G0iDFtXFaA3vZk47MOIbPNwORjBid45M/+61AlT
	 oUHLfS3wQVrxLLaPnoJwlHscJJXHQj32r6t+h2Boj6ZCbVl2vHDFJqjq1jKGvorXSf
	 HmkNJanzFpzsuf3ucoCqcI0wdhMLlhuU3JI5wHMRq7kGtZH+X8TQwNrqgEfdjh84GO
	 Ax5eH6vydpS9H5PM9o4MipJ84h+nPd2wuB64h3O5D6IjbPdLG2sX7ZgRmF3LpqEJx+
	 Me/9kB1kmpHYvoxYgk93LMLrnmFF1EvyzU/up5jZpaj90XOlPkw4QMio5hBpcLEC3I
	 QKx/zcf/OiJ+g==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable] mm/damon/core: increase regions merge aggressiveness while respecting min_nr_regions
Date: Wed, 26 Jun 2024 14:49:54 -0700
Message-Id: <20240626214954.46143-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240626164753.46270-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Jun 2024 09:47:53 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON's merge mechanism has two thresholds, namely those for access
> frequency and size.  The access frequency threshold avoids merging two
> adjacent regions that having pretty different access frequency.
> 
> The size threshold is calculated as total size of regions divided by
> min_nr_regions.  Merging operation skip merging two adjacent regions if
> the resulting region's size can be larger than the threshold.  This is
> for meeting min_nr_regions.
> 
> Commit 44fdaf596984 ("mm/damon/core: merge regions aggressively when
> max_nr_regions is unmet") of mm-unstable, however, ignores the
> min_nr_regions by increasing not only access frequency threshold but
> also the size threshold.
> 
> The commit also has one more problem.  User could set DAMON target
> regions with more than max_nr_regions discrete regions.  Because DAMON
> cannot merge non-adjacent regions, the number of regions will never be
> lower than max_nr_regions regardless of the increased thresholds.  As a
> result, the function can infinitely repeat the loop.
> 
> Increase only access frequency threshold, up to only possible maximum
> value.
> 
> Fixes: 44fdaf596984 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet") # mm-unstable
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index e6598c44b53c..dac27b949403 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[...]
> +	max_thres = c->attrs.aggr_interval /
> +		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
>  	do {
>  		nr_regions = 0;
>  		damon_for_each_target(t, c) {
> @@ -1716,8 +1717,8 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
>  			nr_regions += damon_nr_regions(t);
>  		}
>  		threshold = max(1, threshold * 2);
> -		sz_limit = max(1, sz_limit * 2);
> -	} while (nr_regions > c->attrs.max_nr_regions);
> +	} while (nr_regions > c->attrs.max_nr_regions &&
> +			threshold <= max_thres);

This code means that kdamond_merge_regions() stops this repeated merge attempt
if the merge threshold that increased for next attempt is higher than the
possible maximum threshold.  And because the increase of the threshold is made
by picking a maximum value between one and the last-used threshold multiplying
two, the merge attempt with maximum threshold will not be made unless both the
maximum threshold and the threshold to increase are powers of two.  In maximum
situation (e.g., region 1 has 100% access frequency, region 2 has 0% access
frequency, so on), this means the max_nr_regions violation cannot be recovered
by the attempts.

This can be fixed by changing it to stop repeated attempt if the last-used
threshold is same to or higher than the maximum possible threshold, like below.

I'll send the fix of the fix as a formal patch soon.

FYI, the original fix is definitely better to be merged in stable kernels, but
not urgent in my opinion, since the problematic case is not common and the
behavior was same since the beginning of DAMON.  Andrew, if you feel the
original fix is not stable yet, please feel free to delay moving it to
hotfix-stable for one week or two.


Thanks,
SJ

================================= >8 ==========================================
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1773,7 +1773,7 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
                }
                threshold = max(1, threshold * 2);
        } while (nr_regions > c->attrs.max_nr_regions &&
-                       threshold <= max_thres);
+                       threshold / 2 < max_thres);
 }

 /*
