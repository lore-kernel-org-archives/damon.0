Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3A4230268;
	Wed,  2 Jul 2025 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490206; cv=none; b=b8sLuiZ2biSfP8Oa2NReW6wncBNaB+iWI2RaYzHKk4TRRow+JxOZvlJs3YJDqqRQQ/skL1lhA0MGe1ORcjRTkRpgEUa+EM9kNhNVhYajTbD1YUBCM4Lud6jStuiX12hpYZIJF/HSJtQGzXAzz++Arj+6pTjQXoEigFz0FOZ29nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490206; c=relaxed/simple;
	bh=naRdjLcPdsggu6n8OxVx2EKzl9/toXIJWmrz5C5JylM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MLMHVH+N53FBAR/ToOd3dGuWHeYisCRhOFMFpzQLBdlOL17wogQHkLE4e2pFW/qr2/bH1ycrm9Ta9Yq1FlXY07Njfspw69EhMXWqxvaFFW3QP5/LbKA2ai7Ja0xIaLf24MnDrfmba6mtgbfUAzOwNO95/E4rq/ebxizowejS548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX0I/rpg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX0I/rpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F411C4CEEE;
	Wed,  2 Jul 2025 21:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751490206;
	bh=naRdjLcPdsggu6n8OxVx2EKzl9/toXIJWmrz5C5JylM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oX0I/rpgpOl+PVs1XtygJG+2K1aU2HQ8q4wtjjy4udHSeOjpmVYT24HzdG8aGF5MV
	 U3/qGl9K+kfAfMvCsHPbzlkocFUNXKB5Qj3H6T68UZadTHn7dUYsv7U/eHfa+GNIML
	 vF/N3EgqYEWzemLZDGS+Lt5YRqVjezKSckH2UBbmMzSmOPWjsU0Td0TBWJJWD5KNCG
	 qaZFavuctiBNZd5sB6niME2Z9Bd5ypP0ihIXyz7GIiK2mmcc2wptqoVumug4TOk8j1
	 J12Ad7CKXnwo3rLaUwB42yK89Ul1UdWwsS4UiEXAYipprdS4TZFkvVP9r3W85nJ9uL
	 7iTRKTu+bsmBQ==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	joshua.hahnjy@gmail.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v3 07/13] mm/damon/core: Commit damos->target_nid/migrate_dests
Date: Wed,  2 Jul 2025 14:03:23 -0700
Message-Id: <20250702210323.55199-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702201337.5780-8-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  2 Jul 2025 15:13:30 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> When committing new scheme parameters from the sysfs, copy the
> target_nid and migrate_dests of the source schemes into the destination
> schemes.

Fixing the missed update of target_nid deserves Fixes: and Cc: stable@ in my
opinion.  Could you please split and post the part as another patch?  For the
Fixes, I think 83dc7bbaecae ("mm/damon/sysfs: use damon_commit_ctx()") should
be appripriate.

> 
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>

Assuming my above request is accepted,

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/damon/core.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a4c3cfe531df..0565aae8d1fa 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -943,6 +943,41 @@ static void damos_set_filters_default_reject(struct damos *s)
>  		damos_filters_default_reject(&s->ops_filters);
>  }
>  
> +static int damos_commit_dests(struct damos *dst, struct damos *src)
> +{
> +	struct damos_migrate_dests *dst_dests, *src_dests;
> +
> +	dst_dests = &dst->migrate_dests;
> +	src_dests = &src->migrate_dests;
> +
> +	if (dst_dests->nr_dests != src_dests->nr_dests) {
> +		kfree(dst_dests->node_id_arr);
> +		kfree(dst_dests->weight_arr);
> +
> +		dst_dests->node_id_arr = kmalloc_array(src_dests->nr_dests,
> +			sizeof(*dst_dests->node_id_arr), GFP_KERNEL);
> +		if (!dst_dests->node_id_arr) {
> +			dst_dests->weight_arr = NULL;
> +			return -ENOMEM;
> +		}
> +
> +		dst_dests->weight_arr = kmalloc_array(src_dests->nr_dests,
> +			sizeof(*dst_dests->weight_arr), GFP_KERNEL);
> +		if (!dst_dests->weight_arr) {
> +			/* ->node_id_arr will be freed by scheme destruction */
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	dst_dests->nr_dests = src_dests->nr_dests;
> +	for (int i = 0; i < src_dests->nr_dests; i++) {
> +		dst_dests->node_id_arr[i] = src_dests->node_id_arr[i];
> +		dst_dests->weight_arr[i] = src_dests->weight_arr[i];
> +	}
> +
> +	return 0;
> +}
> +
>  static int damos_commit_filters(struct damos *dst, struct damos *src)
>  {
>  	int err;
> @@ -983,6 +1018,11 @@ static int damos_commit(struct damos *dst, struct damos *src)
>  
>  	dst->wmarks = src->wmarks;
>  
> +	dst->target_nid = src->target_nid;
> +	err = damos_commit_dests(dst, src);
> +	if (err)
> +		return err;
> +

As mentioned above, let's split and post this part as another individual patch.

>  	err = damos_commit_filters(dst, src);
>  	return err;
>  }
> -- 
> 2.43.5


Thanks,
SJ
