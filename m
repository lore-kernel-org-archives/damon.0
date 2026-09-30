Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C2483BF1;
	Wed, 30 Sep 2026 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764421; cv=none; b=DSPpdVrA+A0DMx2jo1vsNdseFt9c5PNLqCrALUO6gth6MX1SoNGfFYDSaball48p6vn2bSyFsPoDFkngPAs3jmUAy9jQTavdL/5QJWbicH9VsU1zEbowrz5p7wzXX+w/t7MIq8vaZfH+JeP66C76ZLIhE6p4WN/XEzvR3IVxnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764421; c=relaxed/simple;
	bh=XUXsuBcRAysMuaa5IFwWmmuXxHPIpZZNg9s0slH8TlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPmDc+dpkTYABFtG6BJptAQJfIFrWBmdTrafSQSKB7T9GljVevogfm5sBSaWo+N3KudG1NGUCvNgEW0RGHcxOneAUVbt+tc2rGFv7d/lIIviFioQ7Y4vwZ9YhPNIDsFCHa3TUo7t4IKrVLpwf+Fq4BWfzxtJS06OXWulINgqhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFYtGKpD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFYtGKpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7321F000FF;
	Wed, 30 Sep 2026 10:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764420;
	bh=+DHevYFtTq9LXip3P6yx2LmGPrDIe2gZf1mJcG2SySg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mFYtGKpDX0b9KjPmZS692yinOoPah6ZGGq0I1FramSDyXTiA7QYBhBVI/JblfVCfr
	 N57pJP5APLX6fXbpxyr4r/3q72ud866zC8eDGWyH95Sy2BrvvNZpGW4WAW356UJ/JG
	 2laHbLBfqLu/EvUNG2afTr6QYgcVIXFJbCDhQPubqAf4Xr9zPpZTfwQE0QkvsuIxxp
	 ssMKDyL6dwhgqaxlnvnJncyNWYTqjTfBsEJt9lkDJG/HxtXSOhga4P2W0xTW9w7BHZ
	 w8N1xYJZYAKmabHd63kHkYjxZWrJ6NxdQ2MMo6qBPV5Q2IRZSkmtg9EhMo8PyVPQcV
	 e0e4IPAjn50vA==
Date: Wed, 30 Sep 2026 12:33:33 +0200
From: Gao Xiang <xiang@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Gao Xiang <xiang@kernel.org>, Jialiang Huang <huang-jl@deepseek.com>,
	lance.yang@linux.dev, baohua@kernel.org, damon@lists.linux.dev,
	david@kernel.org, kunwu.chan@gmail.com, lianux.mm@gmail.com,
	linux-mm@kvack.org, mst@redhat.com, ryncsn@gmail.com, sj@kernel.org,
	virtualization@lists.linux.dev, xueyuan.chen21@gmail.com,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [FYI] DAMON and virtio-balloon in DeepSeek's DSec paper
Message-ID: <arzlfSOgtC-CLoZt@MacBookPro>
References: <20260925054408.10431-1-lance.yang@linux.dev>
 <20260929123241.1408414-1-huang-jl@deepseek.com>
 <aruyFPzEe3pS_Qzx@XiangdeMacBook-Pro.local>
 <AA71E56E-F29A-44B2-B5A0-7806CD684B21@linux.dev>
 <ary5Nn9le4xG7_-N@MacBookPro>
 <CEE47F27-874B-486A-995F-E223249659FE@linux.dev>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CEE47F27-874B-486A-995F-E223249659FE@linux.dev>

On Wed, Sep 30, 2026 at 05:37:11PM +0800, Muchun Song wrote:
> 

...

> 
> > 
> > Anyway, it'd be better to get some numbers with RL or agent workloads
> > (especially the host memory is under reasonable pressure) before
> > landing all these new infras upstream if proceeding in this way.
> 
> At least for now, as far as I'm concerned, I don't intend to land all the
> features mentioned here. The first thing I want to address is on-demand
> allocation of struct page.

From my point of view, on-demend allocation of `struct page` for FSDAX
is indeed useful and can be landed upstream, mainly because `struct page`
initialization takes much long time for large FSDAX devices even a small
range is used, that impacts the guest startup time a lot.

But in order to make it safe for production, I suggest reserve the
guest memory in advance for the worst cases of `struct page` at the first
stage, otherwise it could cause unexpected issues for many guest workloads:
it's hard to perdict if the guest memory is still enough, it's unfriendly
to system designers as well (that would completely based on their
experience and hard to ensure the service quality beforehand.)

Since the guest memory for `struct page` is touched on-demand, the memory
over-committing on the host is still workable, the memory reservation
can be removed after the reclaim path is done.

Thanks,
Gao Xiang


> 
> Thanks,
> Muchun
> 
> > 
> > Thanks,
> > Gao Xiang
> 
> 
