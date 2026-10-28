Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793146005;
	b=jcdapvF6guWkah3wNrykGGRWMx+VAFDzpl58LVaaWUCKzIFlP+RoV5mMwkUFJiCNMpCE
	 KS151/OpcAr2sNWWZ3c6GevP4VQbHQrDq3BRce4canJu3YG+BI47jFwmobm35D16Ok1zo
	 REjQ+tk/xNILFBCsf4dZy94kuO37hwtt0Z6VgG7EQjaflnr3i1mVROwK70dOwhtVTcvp0
	 Zt10jb2a3+B/cTX35xd755wkF3exCcRcZmDfupflgFRt93YFUU+VR/aEM1p2mT82tDgOz
	 ugKOsjyAGI9b2svbOAW9wVyhhF7jVXXKW0L7G7RZBWLQBMNqQ94wX4N3tKgCzo9WE7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793146005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=skEiRkHWE+hnvc3/6Bu0ehaCi2IzacU7F2ubFvDKDvI=;
	b=FJd18IHe4lXQxGzjJrmrOj5K5tN/EJ3kGhLySskT+WZ1A82shHbvkZhfomOfJSQMnZjk
	 9l/SCWNFq7IsSWSFxHRm6WYI/FOSMlzEuY8dhcVUNKPa+BNI0cRozJqqCgh1e1GK5PIna
	 NutgPISP/YrhoihFCJr8GTXLEdFK2u1oECoKumPtQWhVxFS7uDgYGbzXehX+HazHjqap+
	 9XfPCWJ5kwgtzb7ZhJpY5CReNWB3yRcqnrNJmOQtOrbuDILjpW86z0Nln0sxpaSZo+EzF
	 XSWCPPq6+tlluVMNBgeDMjmolFa6d2pp8ADyp6KewIJkkHrzxQHZSo95uYCpK//8Bpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aw5uQyVc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DBC606A31A;
	Wed, 28 Oct 2026 00:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aw5uQyVc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B71B1F01825;
	Wed, 28 Oct 2026 00:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793146004;
	bh=skEiRkHWE+hnvc3/6Bu0ehaCi2IzacU7F2ubFvDKDvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aw5uQyVcvUVcveSh7K0iQyIeOrp93TXa37xDmxv8jtEjFdd+gd12i98k4oFF+dLH7
	 Oc4j52g38SdjU3js+RwKx6LxGjjebgJAKoEDrJCIYpEBTKEpNo6QM8zB+4IRhiH3xU
	 wXNcyQ6m36F8wiWEPFEpfd32LGh6R/MRBDZWfuPWyhZOWymY2uzK/KTRwKpN+NWLlv
	 2rOZWzSSRgNaHglsAcvMsafcZCaqlqV2RQ3Cx5ITiIeCeakq+Np6KEh4aOkhbywjWG
	 DfU3ELOPRgKOPswvZAAQGZqpb3/yc/0Zb5gnbwqeuPrgwVGgF6r0RLinVG8tYXMxbd
	 Y7RNSFD+Y4Ddw==
From: SJ Park <sj@kernel.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: SJ Park <sj@kernel.org>,
	corbet@lwn.net,
	damon@lists.linux.dev,
	jm5905938@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] Docs/admin-guide/mm/damon/reclaim: improve grammar and style
Date: Tue, 27 Oct 2026 17:06:36 -0700
Message-ID: <20261028000637.157110-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027190503.2526945-2-manuelebnerli@mailbox.org>
References: 
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 Oct 2026 20:05:04 +0100 Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Fix upper case. Fix tenses. Replace 'set as' with 'set to'. Add space after
> sentence to make it double space.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> CC: Aveline Noir <jm5905938@gmail.com>
> ---
> @ -113,8 +113,8
> Choose as you wish.
> 
> @ 20
> should be:
> -Free Pages Reporting [3]_ based
> +Free pages reporting [3]_ based
> or
> +'*Free Pages Reporting'* [3]_ based
> * the right kind of quoting/ kernel-doc highlighting.
> Choose as you wish.
> ---
>  .../admin-guide/mm/damon/reclaim.rst          | 36 +++++++++----------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
> index e4e2ffa52e..0bab2299ea 100644
> --- a/Documentation/admin-guide/mm/damon/reclaim.rst
> +++ b/Documentation/admin-guide/mm/damon/reclaim.rst
[...]
> @@ -30,12 +30,12 @@ guests could mitigate this problem.
>  How It Works?
>  =============
>  
> -DAMON_RECLAIM finds memory regions that didn't accessed for specific time
> +DAMON_RECLAIM finds memory regions that weren't accessed for specific time
>  duration and page out.  To avoid it consuming too much CPU for the paging out
>  operation, a speed limit can be configured.  Under the speed limit, it pages
> -out memory regions that didn't accessed longer time first.  System
> +out memory regions that weren't accessed longer time first.  System
>  administrators can also configure under what situation this scheme should
> -automatically activated and deactivated with three memory pressure watermarks.
> +automatically be activated and deactivated with three memory pressure watermarks.

Let's keep 80 columns limit.  Same for below.

[...]
> @@ -113,10 +113,10 @@ quota_sz
>  
>  Limit of size of memory for the reclamation in bytes.
>  
> -DAMON_RECLAIM charges amount of memory which it tried to reclaim within a time
> -window (quota_reset_interval_ms) and makes no more than this limit is tried.
> -This can be used for limiting consumption of CPU and IO.  If this value is
> -zero, the limit is disabled.
> +DAMON_RECLAIM records the amount of memory which it tried to reclaim within a time

Didn't we agree to keep use "charge" ?

Other than the above two things, looks good to me.


Thanks,
SJ

[...]
