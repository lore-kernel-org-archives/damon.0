Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D01D3621;
	Fri,  6 Sep 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639965; cv=none; b=jvYJRhNtR55EGjBVYSqGeiL/U8zZn9T1R/8di/ZP4BkN/dobdiD3kCTbLluiRL81BnQkTiF39HSoRffXCt7jD+g+HgbDGI1JvokgP3sKGRvgb5q+/Q6O66kkHD8R/GUkXmExPKOhuKAFDsR2tQUpiNJyULYSBBfvfBbJM64PcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639965; c=relaxed/simple;
	bh=vcgHtoa6Cxj1gRGeyoTDpvizy+JeUW/QNtJF4/J0g7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To; b=SRVlEdCDazeNyUvcOpYv8JTMq96WkKLEU7tlrJki2NHPa1yiIzgS1CJxauauBSw89RBku17K4zQpagRrzbcBl3p+bdIb/ujtXudWRox0rRDftLPxADzXkfz9gHyCZXqIJLJ7PUv2Vff+rcnR9er2e4itXya2Pt1/nEzvE099UDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR5V1slU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR5V1slU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B277C4CEC4;
	Fri,  6 Sep 2024 16:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725639965;
	bh=vcgHtoa6Cxj1gRGeyoTDpvizy+JeUW/QNtJF4/J0g7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:From;
	b=ZR5V1slUo/fZjqW36cJK3VJmNpB0Rt08eTb4+qXRItTfE6xi03glGVgZWLS9orduW
	 Gputj6k32noq63FpOT2MH905LPz6a311ghM+Ug6EPM+aWiUtcOE13s/Jl+QjOI8C8r
	 g0TxUKBL2TLjYnBQwm1hvm2+MGVS07jJhnQhwjhu4WLx/pGDenr3LvTedNO0sLZXHo
	 ZkiA9Rd/IH1TmMm1CMzb2VsQvCM0FTlmLnaJAHOBUHKMbpzOm29TMLFsVwWcIL/2Ou
	 qmqM2MbX7dUmq+8Ol6Kj0l8YGgbsUghlPjyVL/cFuyDUDm21n3SGsdNij07PSbHtcy
	 rCvI55keeldRQ==
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
Subject: Re: [PATCH 05/15] timers: Rename sleep_idle_range() to sleep_range_idle()
Date: Fri,  6 Sep 2024 09:25:55 -0700
Message-Id: <20240906162555.30071-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-5-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

On Wed, 04 Sep 2024 15:04:55 +0200 Anna-Maria Behnsen <anna-maria@linutronix.de> wrote:

> sleep_idle_range() is a variant of sleep_range(). Both are using
> sleep_range_state() as a base. To be able to find all the related functions
> in one go, rename it sleep_idle_range() to sleep_range_idle().

Nit.  s/sleep_/usleep_/?

> 
> No functional change.
> 
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: damon@lists.linux.dev
> Cc: linux-mm@kvack.org
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  include/linux/delay.h | 2 +-
>  mm/damon/core.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/delay.h b/include/linux/delay.h
> index ff9cda975e30..2bc586aa2068 100644
> --- a/include/linux/delay.h
> +++ b/include/linux/delay.h
> @@ -68,7 +68,7 @@ static inline void usleep_range(unsigned long min, unsigned long max)
>  	usleep_range_state(min, max, TASK_UNINTERRUPTIBLE);
>  }
>  
> -static inline void usleep_idle_range(unsigned long min, unsigned long max)
> +static inline void usleep_range_idle(unsigned long min, unsigned long max)
>  {
>  	usleep_range_state(min, max, TASK_IDLE);
>  }
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7a87628b76ab..94fe2f1f9b0e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1887,7 +1887,7 @@ static void kdamond_usleep(unsigned long usecs)
>  	if (usecs > 20 * USEC_PER_MSEC)
>  		schedule_timeout_idle(usecs_to_jiffies(usecs));
>  	else
> -		usleep_idle_range(usecs, usecs + 1);
> +		usleep_range_idle(usecs, usecs + 1);
>  }
>  
>  /* Returns negative error code if it's not activated but should return */


Other than the trivial nit,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> 
> -- 
> 2.39.2
> 
> 
