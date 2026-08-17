Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0164432E3
	for <damon@lists.linux.dev>; Mon, 17 Aug 2026 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975067; cv=none; b=akpjH8FwdjRP7dtsJ0G8zyGNPnLasZEcdmKn6REm8WEqY8rOenhWwje9YJieW5uK4vNZy5Vz5KW4YNqjKMpaUZAjDH7a7xcaf86l1PJO8xD0aJV0B+f1DBi7bBDDah+S5jZCxR3GhBZ6SIxkTYnc71xMlTEty/l+l9wznSRa8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975067; c=relaxed/simple;
	bh=m9BjX3P4aD/lWlxLdD0ZUJmxCrl9sQ81PCHyKpu4auE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RZlMXvub0SGlCez+D8WRa8Je1l6GARxMkJE6egMISxiF8LqCYDDAKX2L/OFbP/N2GWmcZv3gbxU9EElGVKkAGORTh2PxrfhWCtY15NTaMXsR8hwyCIXhJ25LPfvMkjvhDNWGI/ReHDdOJKhMCpO7B7mJ5x9j6k7wyn4/Qlfyy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0P36rRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0P36rRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CD61F00A3A;
	Mon, 17 Aug 2026 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975066;
	bh=ES9BarLU03IYodauY97E/GeGK8xroS0Axugnu0hpN0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A0P36rRiTo17s7bFS6DJ/dxmdeATDcB3rLU/n4ea6QiaEWa1r6C+mr+b1n/Fi3Myw
	 ++FAiSBK8NIlsMHRx+S0P5/97vyjHiVobruJlMwwop2sSBupPSg6/8653P8gWlB5S+
	 idyM/X2cxOkHZh62TtRivFWtg1EKuokd0IElyoxJi6Eh8JwGWvbMVfqUa3Jg5IZwZr
	 SzDTmVKSEY5kTjMmmrUS7AvoSqBu2oOYACLjZaABcerACHxzxhNHwLoSnAibAC3I9B
	 WfmFyHtEkwyWBaRRnAP9+sKPyCn3ucm1IMYsYczVa/oMMp69QfU/DbDm49hJ3hhmb1
	 z4wIBz6lhNbMQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	gutierrez.asier@huawei-partners.com,
	linux-mm@kvack.org
Subject: Re: [RFC/Discussion] mm/damon: Helping with alternative for watermarks
Date: Mon, 17 Aug 2026 06:57:42 -0700
Message-ID: <20260817135742.75706-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817083923.4374-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026 16:39:23 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Fri, 14 Aug 2026 07:54:13 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > I think watermarks is bettert to be deprecated due to following reasons.  First
> > of all, it stops monitoring.  It means the converged region age and addresses
> > information is lost.  This is the biggest problem.  Secondly, we already have
> > similar and better features including DAMOS quotas.  For your DAMON_RECLAIM use
> > case, I'd suggest using it without watermarks but quota_mem_pressure_us.
> 
> While quota_mem_pressure_us may not be suitable for my use case, I
> realize that DAMOS Quota does meet my needs - only proactively reclaims
> memory when 'MemAvaialble <= 30%'.  I used it on my machine by
> implementing DAMOS_QUOTA_AVAILABLE_MEM_BP, which can also be achieved
> through the user_input of DAMOS Quota.
> 
> I think DAMOS Quota is indeed similar to and better than Watermarks.
> The main drawback of DAMOS Quota at present is probably the lack of
> wmarks.low like Watermarks, but this can be solved by adding a parameter,
> which might be called fallback_value or some other better name.
> 
> Therefore, I agree that we should improve DAMOS Quota instead of
> Watermarks, as it is indeed much better than Watermarks.
> 
> > 
> > Hence I want to deprecate watermarks rather than improving it.  If we need a
> > better watermarks, I think we should improve/extend alternatives like DAMOS
> > quotas, or implement a new one.  But, we should first understand why we need a
> > better watermarks.  You mentioned you want to use DAMOS watermarks with
> > DAMON_RECLAIM on your laptop.  Could you further share why you want to use
> > watermarks, and what was the problem?  You mentioned it was problematic due to
> > page cache, and you implemented memAvailable based watermarks.  Why you use
> > wateramrks?  How exactly the page cache usage becomes a problem for you?  Has
> > the memAvaialble based one solved your problem? 
> 
> 1. Why use Watermarks? And what was the problem?
> 
> I now understand why we do not need better Watermarks, so my answer is
> based on my previous thought.
> 
> I used Watermarks primarily because it is the only mechanism I know for
> stopping/running a Scheme.  The problem is it can only monitor MemFree.

Thank you for clarifying.  I'd like to go one step further.  What is the
initial problem?  Why you need the automatic proactive reclamation?  Do you
have some data showing the problem?

> 
> 2. How exactly the page cache becomes a problem for you?
> 
> After prolonged computer use, the page cache can become full.
> DAMON_RECLAIM might then mistakenly assume there is slight memory
> pressure and reclaim those cached pages.  Unnecessary page cache
> reclamation can incur unnecessary overhead.

Thank you for sharing this.  I can theoretically understand the issue.  Maybe
you are concerned if page cache is too aggressively reclaimed and therefore if
file io becomes slow.  But I'm not really sure if it is only theoretical or
real.  Since the proactive reclamation reclaims coldest page first, and because
it works for not only page cache, the performance impact might not that big in
real.  Do you have some data showing the problem?

> 
> 3. Has the MemAvailable based one solved your problem?
> 
> Yes, using MemAvailable as a watermarks/DAMOS Quota metric can avoid a
> lot of unnecessary memory reclamation.

Great to hear that.  I'm curious if you have some data showing the improvement.


Thanks,
SJ

[...]
