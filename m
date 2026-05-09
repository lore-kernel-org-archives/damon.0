Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68CC3822A1;
	Sat,  9 May 2026 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778350298; cv=none; b=aPixghS5qxqSp92gNiLepWzbkx29XHH+oaAHTTUtPl2LuWApeBueBTo29Zso/BsfQ1Mk79j4r1ctF+KlAwTT17p46reRfD8TD1oIij0+oNV1q/HS/YGKkvuzJWSaA3Qy0gdznywDo1zcMsGf2OqwssGqjdXvTouhy3GHGgMQJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778350298; c=relaxed/simple;
	bh=IGMq8mi6hHq7SDD0BLIxCadD5846xRlgej0IXkRiUfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClVcOb/mxTid+y67fhj66oToHWHkBatf+OkMaXKQ8a115JgYBUd/Xek5AlZM5hS/vpuR/n/aeeLvPNzBjAdU5LN27vsOGf4Sg3NGA6zMED+K867yeBsNyFpE4b6J5yRaoOYDY4tem5eAmWQPkJUZ/hto9jt6QyRXNNu0uE2UUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5PV0WQp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5PV0WQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD26C2BCB2;
	Sat,  9 May 2026 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778350298;
	bh=IGMq8mi6hHq7SDD0BLIxCadD5846xRlgej0IXkRiUfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5PV0WQplgApZUAP8P3zsx3fG9hdsKeQOVFacyaqZxuzwEUGWqGJ9aSbLK7p4/hdj
	 LZG8/NBLtDhyONdpFRdaTYRxYYdMGzzYAXjUEJyv0i/gQxD1C/+9iY+Inq4Dn7xsh9
	 WQL4Z4pkWWz1lU6dW2rgq+F/wKx1v5wDCNHzaN2pNni+GBeOZG6Y2JSXSPNmh3Vc73
	 vk0Mcz/0gZrWptgEm6tMGqJb7ZptqvjfGZHNlpJX41vFaOvVf6+CXd8FM/YKjdVgoM
	 TLHnvXIeIjpeDcPlyFTGMQNBX0415m5SIA8yuVKppQB9nYw0wIiCHf0K7R51rwbpS+
	 I2PBSBBflzkpw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 03/19] mm/damon/core: introduce damon_filter
Date: Sat,  9 May 2026 11:11:30 -0700
Message-ID: <20260509181130.90203-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426205222.93895-4-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 26 Apr 2026 13:52:04 -0700 SeongJae Park <sj@kernel.org> wrote:

> Define a data structure for constructing damon_probe's attributes check,
> namely damon_filter.  It is very similar to damos_filter but works only
> for monitoring purposes.  Also embed that into damon_probe, implement
> essential handling of the link, with fundamental helpers.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 36 ++++++++++++++++++++++++++++++++++++
>  mm/damon/core.c       | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 65d7ee0a70ac0..3290792eab547 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -732,12 +732,38 @@ struct damon_intervals_goal {
>  	unsigned long max_sample_us;
>  };
>  
> +/**
> + * enum damon_filter_type - Type of &struct damon_filter
> + *
> + * @DAMON_TEST_TYPE_ANON:	Anonymous pages.
> + */
> +enum damon_filter_type {
> +	DAMON_TEST_TYPE_ANON,

I initially named it damon_filter, renamed to damon_test, and then returned to
damon_filter.  This weird name (DAMON_*TEST*_TYPE_ANON) is showing what I
forgot reverting while the final renaming.  I will rename this to
DAMON_FILTER_TYPE_ANON in the next revision of this patch.


Thanks,
SJ

[...]
