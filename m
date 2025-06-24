Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EFB284682
	for <damon@lists.linux.dev>; Tue, 24 Jun 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762695; cv=none; b=BZ3RknD6nOZDQQgw1QKB68M5p5+hzEyWx57sLjzodEeBNBg/Jd1eKMN8cIEjEo3s1O8TE52gHGjtuL+p7D8GY8UhM0JDiS44Ogrvi2+Rfw+u5Pr5JMJyY3KjY/4DWklD4T9/mlSBEqMvQwasR5ZiFrngZcoBOrJTj3kA4mYlaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762695; c=relaxed/simple;
	bh=0LfTKWHlWtRQaONktSiUW92BBd6Tfp+6mKRn9yPx+EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iC11XLA0Qbq2UHKTy2INbEf2i8VlTwgg7LYLoM61oqgIWhgufUrHCeg3EwAfO19BrAir8lU+PYA2vTiOnbKld3KXrSGaDV5pqw+VhFCBZ7Q/N6SIuHOmGJMwxSbwU6Tm6Nz2iIZLktIB6y+WsZEDwoWhBZ7Qxtiglhn1quxKR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d2m446pn; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d2m446pn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750762683; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=+NgBLhqy1L817I/jNzksXR2nN08H6Idgamz1I8pvVlw=;
	b=d2m446pnIaQCuB9GGRw7Y4JhCO8/kGyKR5XyyOLXDi9XcnR3515/dVNSg72/bWryuF059+d9GhH9Kx+n/KHuXEOsgkP+BW49lJ3X9jhFkcRGcy2eMnnE51DpvBkSKOYgrkNUbrYVtQmiAcrRXB2rAbMMUqyGR8YeUrYbzKPAlIY=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Weh-0Qo_1750762681 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Jun 2025 18:58:01 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: damon@lists.linux.dev,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  sj@kernel.org,  akpm@linux-foundation.org,
  david@redhat.com,  ziy@nvidia.com,  matthew.brost@intel.com,
  joshua.hahnjy@gmail.com,  rakie.kim@sk.com,  byungchul@sk.com,
  gourry@gourry.net,  apopple@nvidia.com,  bijantabatab@micron.com,
  venkataravis@micron.com,  emirakhur@micron.com,  ajayjoshi@micron.com,
  vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 1/2] mm/mempolicy: Expose get_il_weight() to MM
In-Reply-To: <20250620180458.5041-2-bijan311@gmail.com> (Bijan Tabatabai's
	message of "Fri, 20 Jun 2025 13:04:57 -0500")
References: <20250620180458.5041-1-bijan311@gmail.com>
	<20250620180458.5041-2-bijan311@gmail.com>
Date: Tue, 24 Jun 2025 18:58:00 +0800
Message-ID: <875xglo18n.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Bijan Tabatabai <bijan311@gmail.com> writes:

> From: Bijan Tabatabai <bijantabatab@micron.com>
>
> This patch exposes get_il_weight() in mm/internal.h. This patch is to
> allow other parts of the MM subsystem, such as DAMON, to make page
> placement decisions based on the global interleave weights.
>
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> ---
>  mm/internal.h  | 6 ++++++
>  mm/mempolicy.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 3823fb356d3b..b718ebe7cad5 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1169,6 +1169,7 @@ extern int node_reclaim_mode;
>  
>  extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
>  extern int find_next_best_node(int node, nodemask_t *used_node_mask);
> +extern u8 get_il_weight(int node);
>  #else
>  #define node_reclaim_mode 0
>  
> @@ -1181,6 +1182,11 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
>  {
>  	return NUMA_NO_NODE;
>  }
> +
> +static inline u8 get_il_weight(int node)
> +{
> +	return 1;
> +}
>  #endif
>  
>  static inline bool node_reclaim_enabled(void)
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 1ff7b2174eb7..b1713430ee9c 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -165,7 +165,7 @@ static unsigned int *node_bw_table;
>   */
>  static DEFINE_MUTEX(wi_state_lock);
>  
> -static u8 get_il_weight(int node)
> +u8 get_il_weight(int node)
>  {
>  	struct weighted_interleave_state *state;
>  	u8 weight = 1;

I agree with David on the function naming and "extern".  Otherwise, this
looks good to me, Thanks!  Feel free to add my

Reviewed-by: Huang Ying <ying.huang@linux.alibaba.com>

in the future versions.

---
Best Regards,
Huang, Ying
