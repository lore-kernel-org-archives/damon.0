Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611914A4F0
	for <damon@lists.linux.dev>; Wed, 21 May 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747847892; cv=none; b=f5oGP6LW62Mi3GNR6/sFGt/pEY+8utK/REFpRLHC/2afOUGqgM0/LzUnjGlsGdNFNhKTh4GyFRmFGbywjcd/ysjUoccBAjmYbs+z2gDb36Ai0Prt1WtNueuAsUA/yWq6YA+fYHBH86VwlBAUWwLDHSqgEbEKDV2CQ5GI1HhOKXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747847892; c=relaxed/simple;
	bh=14JYG8vIqT62fjB/bSsVNtFZxojGaAGPVSvNx2IgS+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Au+Cu0Bra4lhsqFoRFNQn7CigCK5JoUKtWvhL0hSkTsXprPVI3BQ2BM77izs4XIRf9+A5Sp6WwGSymMEJH03Da6EqFxdr1rnQQ0/0n1C+MPnzxFl6PQTq6DNWKSfyVPPTKCoKWXIeiasnhtUKri4SgqZycWLYpITk7tcEmYs9XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UffSjrmF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UffSjrmF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175FFC4CEE4;
	Wed, 21 May 2025 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747847892;
	bh=14JYG8vIqT62fjB/bSsVNtFZxojGaAGPVSvNx2IgS+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UffSjrmFJqDcpb/gBmEqemkvG/b4uaR1tXmf2pOBSntNmZxwiUo0thojN0n54lppg
	 fMjMqKvlK8Kmd4630V4lZcD8dPdH0DPzIfjjOUuoc91p9gaZt6q6YWhdHMsand5vQn
	 BWSREDj+JgfRoIEtaMVftA9hdrdsECrgbemFC+of2jzH4AzAtcBGZ/2KlKHLgYM2hS
	 TlfbCht+JIQv/acYI3T6ID/sAXb5MZqJ7HAlMQWbwGbWBZX3+u4BC0zMvW+tRT3Lwp
	 rK7YEk5mntoYsSsFBMCqBAcCFz9aSBXuyytcv0VQQpZ7mHB0Qd330+WX7VPMOK0ZnA
	 UfiK8X0ssx/Mg==
From: SeongJae Park <sj@kernel.org>
To: Enze Li <lienze@kylinos.cn>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon: make region calculations more precise
Date: Wed, 21 May 2025 10:18:09 -0700
Message-Id: <20250521171809.45618-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521070747.1458270-1-lienze@kylinos.cn>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Enze,

On Wed, 21 May 2025 15:07:47 +0800 Enze Li <lienze@kylinos.cn> wrote:

> The damon_sz_region() function misses counting one element when
> calculating region size, which leads to inaccurate results.  This patch
> corrects the size calculation by properly accounting for all elements.

Thank you for this patch, but I don't think the current calculation is wrong.
Please refer to the below comment.

> 
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  include/linux/damon.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 47e36e6ea203..70473863f7fe 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -808,7 +808,7 @@ static inline struct damon_region *damon_first_region(struct damon_target *t)
>  
>  static inline unsigned long damon_sz_region(struct damon_region *r)
>  {
> -	return r->ar.end - r->ar.start;
> +	return r->ar.end - r->ar.start + 1;
>  }

'ar' here is 'struct damon_addr_range' which is for a half-open range.  Refer
to the comment on 'struct damon_addr_range' definition on include/linux/damon.h
for detail.  So I don't think the current calculation is wrong.

If you think this function also deserves a short comment for clarifying this,
your patch for that wil be welcomed :)

Please let me know if I'm missing something.


Thanks,
SJ

[...]
