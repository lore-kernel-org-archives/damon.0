Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFC1922C7;
	Wed, 26 Jun 2024 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719439518; cv=none; b=EcnRAKm2vXvkrtEu/Cm9DYJKUYIIZvRtUwBs2cu6EqM36kjCzA+npBhkcybrTTimcsj+IeiMiFLJWTnKYGNr7rW5ZwyFTLCIgVhAQ+RXRuiveMihYtOiWixfbrA+g33BbZd4c7BZDjwziWXC2BJjyuX/YVR/Oi4svaQ3Lu5SA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719439518; c=relaxed/simple;
	bh=jkxRntFuaW4JvkXSVFtxygzIMltJr+aE/04dsBHFb94=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=juDKEGJOeUYtASgToDUsBS1rnSuAkBm2pi8WWuu52JjGupRkBExUnL3XfJ8C6mH2OogfvjrlBu+hR8xdTYL1LsjjZRDllMKiXTar6a9zP5ElMljHfPT0VuWJWndqNDQTDKeiL3CdFNcllpOQK1FzJwe0VsvQMaCo08hajJu06hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M2Sd42ei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M2Sd42ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9ADC116B1;
	Wed, 26 Jun 2024 22:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719439517;
	bh=jkxRntFuaW4JvkXSVFtxygzIMltJr+aE/04dsBHFb94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M2Sd42ei168CkIcoFj+EnXn8NFVRO/GBD28yMg2UOJutE9w1z+R75Jj6hyqVWZszB
	 953lA3OhFL0avCE4wm2nrLVjw5iwDyPvhaFSU+LUy1ffVI8niqW0NOnCT7514H468E
	 rAwzsVeKtONYgjsJMDzZplBo4OG75BvMjtXeq3TQ=
Date: Wed, 26 Jun 2024 15:05:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable] mm/damon/core: increase regions merge
 aggressiveness while respecting min_nr_regions
Message-Id: <20240626150516.fb14ba5e65ae9d59ece0d390@linux-foundation.org>
In-Reply-To: <20240626214954.46143-1-sj@kernel.org>
References: <20240626164753.46270-1-sj@kernel.org>
	<20240626214954.46143-1-sj@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 14:49:54 -0700 SeongJae Park <sj@kernel.org> wrote:

> > @@ -1716,8 +1717,8 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
> >  			nr_regions += damon_nr_regions(t);
> >  		}
> >  		threshold = max(1, threshold * 2);
> > -		sz_limit = max(1, sz_limit * 2);
> > -	} while (nr_regions > c->attrs.max_nr_regions);
> > +	} while (nr_regions > c->attrs.max_nr_regions &&
> > +			threshold <= max_thres);
> 
> This code means that kdamond_merge_regions() stops this repeated merge attempt
> if the merge threshold that increased for next attempt is higher than the
> possible maximum threshold.  And because the increase of the threshold is made
> by picking a maximum value between one and the last-used threshold multiplying
> two, the merge attempt with maximum threshold will not be made unless both the
> maximum threshold and the threshold to increase are powers of two.  In maximum
> situation (e.g., region 1 has 100% access frequency, region 2 has 0% access
> frequency, so on), this means the max_nr_regions violation cannot be recovered
> by the attempts.
> 
> This can be fixed by changing it to stop repeated attempt if the last-used
> threshold is same to or higher than the maximum possible threshold, like below.
> 
> I'll send the fix of the fix as a formal patch soon.
> 
> FYI, the original fix is definitely better to be merged in stable kernels, but
> not urgent in my opinion, since the problematic case is not common and the
> behavior was same since the beginning of DAMON.  Andrew, if you feel the
> original fix is not stable yet, please feel free to delay moving it to
> hotfix-stable for one week or two.

That's fine - we can merge cc:stable patches any time, really - they
will still get backported.  There's only a hurry to get fixes merged up
if they're security-related or if the issue is causing people problems.

In this case I'll await your -fix-2.patch and we can merge the patch
next week.

