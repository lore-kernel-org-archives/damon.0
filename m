Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.247.232.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613868;
	b=NTOvLeSRtOZeJWTD0k8kruhYkOlEC7Tb8/ikhi+iFXN6c9PHUw8HLnfMh9qOdRKjHQoF
	 5LZHqo2v+KUZG300H2pecyCNZuzmHHUvSNtUafsrqL0FnsYuv85C2iaPOZovH669biyX6
	 79mKDpkiqzwO4f5RgldLrgkh6Rt7BMQPEvX3wWthVInA1gFf6Zl+nsnUUOxF5kGN1QDkp
	 pP0qXToU8P0CHb9uFcnnpGz+WLGbRDWMZW1gsGD03NZqG9iC07Wel6gMZEo2WeRtbqa31
	 9eiceP9oXgiYc5ovaB3kcbv4rMP7VbDL8mv0WcXZ8Q85fiFJt/rFCL7uMNrw7d2tHHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613868;
	h=DMARC-Filter:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=bsgXfputfPQiAxudDpHtBy77ru0u4ys8CRqHYkfdZLs=;
	b=0NANkJI8eWEz617ROor2q6YsMJ0oHJZsM7rY6P6mPp8/w4YmqnHbFtrEG5VnQNtjtxlz
	 VqQJKG78gt7xmjkl+Zk/d1tP5G4RsBo/8Q9X/pNk/hY7Kg1o8JSr/EOHX6SBuftRsopPn
	 ZaBj+yD4Eugu2cGlbJMZxuMfDEuGCHbzBY4muNnNVkr8XCABx/65NRcuVYJZ/kj65yzov
	 QSDRCLDDZPBlfNpeK+odiBj09CqLyZEFPjZBH1kYnul2DCACZeCLfJv6GyLDsFd7W+4/A
	 DRkh4JQINYlvk+KpByDjEbmWXBEX5HvWjWQAE9McTp8Huyhq+HSRGjzspHK1YZSSs5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linx-info.com;
	spf=pass smtp.mailfrom=linx-info.com;
	arc=none smtp.remote-ip=114.247.232.78
Received: from mail.linx-info.com (mail.linx-info.com [114.247.232.78])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD35606A326
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 10:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CD35606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linx-info.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linx-info.com
Received: from localhost (localhost [127.0.0.1])
	by mail.linx-info.com (Postfix) with ESMTP id 5FD36321215;
	Mon,  2 Nov 2026 18:04:24 +0800 (CST)
Received: from mail.linx-info.com ([127.0.0.1])
	by localhost (mail.linx-info.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UpQ_qoaeNUmA; Mon,  2 Nov 2026 18:04:24 +0800 (CST)
Received: from DiGouShu (unknown [172.22.21.200])
	by mail.linx-info.com (Postfix) with ESMTPSA id 485823211C6;
	Mon,  2 Nov 2026 18:04:24 +0800 (CST)
Date: Mon, 2 Nov 2026 18:04:23 +0800
From: Wang Guangke <gkwang@linx-info.com>
To: SJ Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid overflow in
 estimated_memory_bandwidth calculation
Message-ID: <auhgJ74TeQOIvTtO@DiGouShu>
References: <20261101180001.167198-1-gkwang@linx-info.com>
 <20261101191344.85683-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101191344.85683-1-sj@kernel.org>

Hi SJ,
Thanks for your review.

On Sun, Nov 01, 2026 at 11:13:43AM -0800, SJ Park wrote:
> Hello Wang,
> 
> On Mon,  2 Nov 2026 02:00:01 +0800 Wang Guangke <gkwang@linx-info.com> wrote:
> 
> > The calculation of estimated_memory_bandwidth computes
> > access_bytes * USEC_PER_MSEC * MSEC_PER_SEC / aggr_interval directly.
> > On 32-bit systems, the intermediate product
> > access_bytes * USEC_PER_MSEC * MSEC_PER_SEC may overflow before the
> > division is performed.
> 
> Do you find this issue from real usage?  Or, jsut theoretical?  Could you
> please clarify it, and user impacts of the issue?

I found it by code inspection, not from real usage on a 32-bit system.

The parameter estimated_memory_bandwidth of the damon_stat
module is calculated from access_bytes * USEC_PER_MSEC *
MSEC_PER_SEC (= USEC_PER_SEC) / c->attrs.aggr_interval,
and users read it via
/sys/module/damon_stat/parameters/estimated_memory_bandwidth.

The maximum value of a 32-bit unsigned integer is 4294967295. Therefore,
in the product access_bytes * USEC_PER_SEC, once access_bytes exceeds 4294,
the 32-bit value is bound to overflow. Users reading
/sys/module/damon_stat/parameters/estimated_memory_bandwidth
on 32-bit systems will get a wrong value.

To see whether real workloads exceed this threshold, I printed the
intermediate values of the computation via a tracepoint on a 64-bit
system.

on 64-bit system:
    ~ # echo 1 > /sys/kernel/debug/tracing/event/damon/estimated_memory_bandwidth
    ~ # cat /sys/kernel/debug/tracing/trace
    ...
           kdamond.0-78      [003] .....  7507.959114: estimated_memory_bandwidth: access_bytes=5536956416, c->attrs.aggr_interval=200000000

I observed that access_bytes can far exceed 4294.

In addition, I used qemu-system-i386 to emulate a 32-bit system and
performed the same verification:

on 32-bit system:
without-patch:
    ~ # cat /sys/kernel/debug/tracing/trace
    ...
           kdamond.0-45      [000] .....  1809.507372: estimated_memory_bandwidth: access_bytes=15237120, c->attrs.aggr_interval=7910660
    ~ # cat /sys/module/damon_stat/parameters/estimated_memory_bandwidth
    362
    ~ # echo "15237120 * 1000 * 1000 / 7910660" | bc
    1926150

The module parameter value (362) does not match the expected value
(1926150), so an overflow has occurred.

with-patch:
    ~ # cat /sys/kernel/debug/tracing/trace
    ...
           kdamond.0-45      [000] .....   212.682057: estimated_memory_bandwidth: access_bytes=7503872, c->attrs.aggr_interval=3615680
    ~ # cat /sys/module/damon_stat/parameters/estimated_memory_bandwidth
    2075369
    ~ # echo "7503872 * 1000 * 1000 / 3615680" | bc
    2075369

The module parameter value (2075369) matches the expected value.
> 
> > 
> > Fix it by splitting the division into quotient and remainder,
> > multiplying each part separately.
> 
> Thank you for this patch.
> 
> > 
> > Fixes: fabdd1e911da ("mm/damon/stat: calculate and expose estimated
> > memory bandwidth")
> 
> Please do not wrap Fixes: tag line.

Sorry, I will not wrap it in v2.
> 
> Could you clarify why you do not Cc stable@?

Sorry, I missed it. I will Cc stable@ in v2.
> 
> > 
> > Signed-off-by: Wang Guangke <gkwang@linx-info.com>
> > ---
> >  mm/damon/stat.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/damon/stat.c b/mm/damon/stat.c
> > index b05b68f73e10..7cfa3a8d6801 100644
> > --- a/mm/damon/stat.c
> > +++ b/mm/damon/stat.c
> > @@ -32,8 +32,8 @@ static bool enabled __read_mostly = IS_ENABLED(
> >  module_param_cb(enabled, &enabled_param_ops, NULL, 0600);
> >  MODULE_PARM_DESC(enabled, "Enable of disable DAMON_STAT");
> >  
> > -static unsigned long estimated_memory_bandwidth __read_mostly;
> > -module_param(estimated_memory_bandwidth, ulong, 0400);
> > +static u64 estimated_memory_bandwidth __read_mostly;
> > +module_param(estimated_memory_bandwidth, ullong, 0400);
> >  MODULE_PARM_DESC(estimated_memory_bandwidth,
> >  		"Estimated memory bandwidth usage in bytes per second");
> >  
> > @@ -55,15 +55,20 @@ static void damon_stat_set_estimated_memory_bandwidth(struct damon_ctx *c)
> >  {
> >  	struct damon_target *t;
> >  	struct damon_region *r;
> > -	unsigned long access_bytes = 0;
> > +	u64 access_bytes = 0;
> > +	u64 remainder, bytes_per_interval;
> >  
> >  	damon_for_each_target(t, c) {
> >  		damon_for_each_region(r, t)
> > -			access_bytes += (r->ar.end - r->ar.start) *
> > +			access_bytes += (u64)(r->ar.end - r->ar.start) *
> >  				r->nr_accesses;
> >  	}
> > -	estimated_memory_bandwidth = access_bytes * USEC_PER_MSEC *
> > -		MSEC_PER_SEC / c->attrs.aggr_interval;
> > +	bytes_per_interval = div64_u64_rem(access_bytes,
> > +			c->attrs.aggr_interval, &remainder);
> 
> This is not bytes per interval but bytes per microsecond.  Let's rename the
> variable to bytes_per_us.
> 
> > +	estimated_memory_bandwidth =
> > +		bytes_per_interval * USEC_PER_MSEC * MSEC_PER_SEC +
> > +		div64_u64(remainder * USEC_PER_MSEC * MSEC_PER_SEC,
> > +				c->attrs.aggr_interval);
> 
> Let's use USEC_PER_SEC instead of 'USEC_PER_MSEC * MSEC_PER_SEC'.

Thanks, I will rename the variable to bytes_per_us, and use USEC_PER_SEC
instead of 'USEC_PER_MSEC * MSEC_PER_SEC'.
> 
> >  }
> >  
> >  static int damon_stat_idletime(const struct damon_region *r)
> > -- 
> > 2.47.3
> > 
> > 
> 
> 
> Thanks,
> SJ
> 
Thanks,
Wang Guangke
