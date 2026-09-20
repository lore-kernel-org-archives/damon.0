Received: from mta1.migadu.com (out-212.mta1.migadu.com [95.215.58.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAAB187346
	for <damon@lists.linux.dev>; Sun, 20 Sep 2026 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867450; cv=none; b=ZrdzJuYrlmjkWyBA3j9ftfjLXexhHGzah10wJiwl4IPGAXn412fZUoaTJb6MmpZs2qRFA9huHaO/OE4EOzJ4EysEJQlpA30Y7uI2cJigfHQikrlrenihxfQ8a245Bm2JWvbFPLLCAxol3VadsvQOdnnNzx9Z6JTP52ojLnE0MmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867450; c=relaxed/simple;
	bh=cTTrp9axlZ0to3dCBI38xL4Ohm3ey8g4pSyLYyyl0KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OodFNYnOPQ/V634jDMGke8ktenb/jos44wMsguihVgPHXqKmA8XTxdVnE4Lm/gkro+Jsg7gXV0+bDyPSXT/ihOZup1K9TZpHuQl9p2YTkszvNTydmXpNgRyV44lgU4opP4bmnof5zjZC4n9YZ4wLcbltK0XSAdd1MfFweWM7jcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ckAnbcnU; arc=none smtp.client-ip=95.215.58.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ckAnbcnU"
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=cTTrp9axlZ0to3dCBI38xL4Ohm3ey8g4pSyLYyyl0KA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789867446; v=1; x=1790472246;
 b=ckAnbcnUmIo2zFVOXSRoH5KAorCkTD4kNL0/+8Ki5KdKNduaFVHKt8Uy88E+YTWOUpkDQlln
 Z+sSol+KPF1qSQPlhpztrCPd9kwVi123Z2euTt82yWH+u6iqJ0aKOAybEdrREXeIYZXPV8yQ24N
 EkhlOR4qH7Eo2lUKzOwcKJZI=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4d7949eb6cac6f80;
	Sun, 20 Sep 2026 01:24:05 +0000
X-Mizu-Trace-ID: 4d7949eb6cac6f80
X-Migadu-Flow: FLOW_OUT
Message-ID: <e2425a16-d57b-4786-86a2-d0f25537d605@linux.dev>
Date: Sun, 20 Sep 2026 09:23:55 +0800
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/damon/api: remove NR_DAMOS_FILTER_TYPES
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260919155716.86019-1-sj@kernel.org>
Content-Language: en-US
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260919155716.86019-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/26 11:57 PM, SJ Park wrote:
> On Sat, 19 Sep 2026 21:02:30 +0800 Zenghui Yu <zenghui.yu@linux.dev> wrote:
> 
> > On 9/17/26 10:21 PM, SJ Park wrote:
> > > Nobody uses NR_DAMOS_FILTER_TYPES.  Remove it.
> [...]
> > Similarly we have more definitions of NR_foo in damon.h:
> >
> >  * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
> >  * @NR_DAMOS_QUOTA_GOAL_METRICS:	Number of DAMOS quota goal metrics.
> >  * @NR_DAMOS_WMARK_METRICS:	Total number of DAMOS watermark metrics
> >  * @NR_DAMON_OPS:	Number of monitoring operations implementations
> >
> > and only NR_DAMON_OPS is actually used (I checked mm-new).  If the
> > preference is removing all unused macros, we should probably clean them up
> > as well.
> 
> Nice findings!  Please feel free to post a patch for cleaning those up if you
> don't mind!

Sent out now.

https://lore.kernel.org/damon/20260920012028.9565-1-zenghui.yu@linux.dev

Thanks,
Zenghui
