Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB9E1D47AA;
	Fri,  6 Sep 2024 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640303; cv=none; b=UbDizy9Tw6PZiZOe2Opc50lzCGx1gCCEzVcF/Ec9PSylBzoVjtpV2EHS/srSOMGUzJ4CLRMsrcZeI4iVe2nkiF0oVp9a/DVBIQb3dxDs/pUvSidFW1maCPwf3y82EUFDsGEwLURMaIgGiDz06OadpGT44qCJWBKGBaIxV2x8IXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640303; c=relaxed/simple;
	bh=P42yeXkNnTmRaVvRlLuHDgj7xNa3QrbZEA882GWSS2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=ZewiXXJVsxryv4YUTo4nNdLP9KvVJEY0i/FtiJV7ecm/KHkOZXdYQTwc3O1r1+uCAW54Lenaln3Vy2nUgPnLuUR8rUCzzIDkqx/0tE7BKxQKcHlp50Qz8QftbM/cB680E72/FL8TrvcTHXIPluui3f8v3krKlJ/rAe4AV/GJe6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+7JWFja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+7JWFja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF82C4CEC6;
	Fri,  6 Sep 2024 16:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725640303;
	bh=P42yeXkNnTmRaVvRlLuHDgj7xNa3QrbZEA882GWSS2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=i+7JWFjaAN3R9CBGzFdd2W6vVxQ3srhGcCZIyFR/Xb+pgzX8SsfRn/mLVLolb68Jv
	 EZwkziMJgXvQ58fSMOnv5sFlVc6Jt4nZUxB9XTm/GyWGXVtrDcAgaKisH2qoUekd3j
	 OFeWCYFD2zOn53NzR+8MTMb+Jmh5/Uxp+tbto3s/uYB+K5ape/tiNKz47La3njq1xo
	 a1cPe2RYAqh6GR6EUq5fC6Hzj7SmyIFJp7+JjwzecAgjj9t4OasIZqP0oWJe/zSNLX
	 JFrLg/hHPQLAqwiJqu1ufdZDMYHJBsBaj6O5LSSh1MvYMyhmx8BPjs6BecDE2ZtbI2
	 R4zQ9cfNiCcqQ==
From: SeongJae Park <sj@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: SeongJae Park <sj@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 08/15] mm/damon/core: Use generic upper bound recommondation for usleep_range()
Date: Fri,  6 Sep 2024 09:31:41 -0700
Message-Id: <20240906163141.31088-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-8-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

On Wed, 04 Sep 2024 15:04:58 +0200 Anna-Maria Behnsen <anna-maria@linutronix.de> wrote:

> The upper bound for usleep_range_idle() was taken from the outdated
> documentation. As a recommondation for the upper bound of usleep_range()
> depends on HZ configuration it is not possible to hard code it.
> 
> Use the define "USLEEP_RANGE_UPPER_BOUND" instead.
> 
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: damon@lists.linux.dev
> Cc: linux-mm@kvack.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/damon/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 94fe2f1f9b0e..4b971871da75 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1883,8 +1883,7 @@ static unsigned long damos_wmark_wait_us(struct damos *scheme)
>  
>  static void kdamond_usleep(unsigned long usecs)
>  {
> -	/* See Documentation/timers/timers-howto.rst for the thresholds */
> -	if (usecs > 20 * USEC_PER_MSEC)
> +	if (usecs >= USLEEP_RANGE_UPPER_BOUND)
>  		schedule_timeout_idle(usecs_to_jiffies(usecs));
>  	else
>  		usleep_range_idle(usecs, usecs + 1);
> 
> -- 
> 2.39.2
> 
>
