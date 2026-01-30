Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8689C3009D6
	for <damon@lists.linux.dev>; Fri, 30 Jan 2026 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769744330; cv=none; b=VKvgVlWgo+iQMhU58oW+nTOqcQPDlwApImI3oG5D4kzS8MXrMtmjVrlT+qF2pN7uqArQmHrPECKrEAaVxv3eMWwk+/hwHioj2PYp8jW5+qPdCxaamaa9Uf35Ajk5uD3FzQkIf2kuTLv4EUGuBMnZZ6T1PUgifmqh3j5b3KMkmrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769744330; c=relaxed/simple;
	bh=PcU4J+1T8KCZw9aj5ccmBmFCCv5uz3Z87kxcvNbBpmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CfqC930W6WKNmhLiCAtIuCPCNkYazDgc1405Byf6e32PVQHxTs3sf0FDp09bz+yPPoCYNwVIDke19AdnVOqliID7v3SKeCFFChqJ+4KlpefOI0yw7uEe6GcXckytjUv2MXVkR+1n7r8mLn01E8puptkffSk75T8d50VMFcnFHyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+vNnYoK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+vNnYoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADB5C4CEF7;
	Fri, 30 Jan 2026 03:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769744330;
	bh=PcU4J+1T8KCZw9aj5ccmBmFCCv5uz3Z87kxcvNbBpmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+vNnYoKX83+BZ/wrxS60O9cONAosp/uo1vSJBonytXxClVKjSFgEgx3RfADWJBks
	 AiuKWttCkk6fsIIGrCZvosh4VUoQuiGHiArQU8ObOa5ceZNdDVwFmfAj1C7YKih2nk
	 ihU9jOWvwc9jjvDwuwJDFoasPenrWZ8UioojNaLJtB/BOEYOx9gLWhxwlVEX7nb9QW
	 hU5aNCBij6uzl5MQM0jGgz+GZANhqqb/syOk6DgMz3h8+fTsL158y/4D6dKwP4r7Uf
	 K6fSEei4xoRSPuocW2Pb6Lc2CISLuMMwsI4DGTOsMCWAZqTFKXENHxdKmPCsKvZuVF
	 1RJx1tfeEOFzg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	enze.li@gmx.com,
	sunnanyong@huawei.com,
	Enze Li <lienze@kylinos.cn>
Subject: Re: [PATCH] mm/damon: unify address range representation with damon_addr_range
Date: Thu, 29 Jan 2026 19:38:45 -0800
Message-ID: <20260130033847.52289-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <71e02d8a-94b7-4b9c-877e-5efd4f7aba44@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Quanmin,

On Fri, 30 Jan 2026 11:07:08 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

Thank you for jumping in and giving great comments!

> 在 2026/1/30 10:26, Quanmin Yan 写道:
> > Hi SJ,
> >
> > [...]
> >
> >> Actually, there is another bug that need to be fixed.  Nonetheless, 
> >> that's
> >> orthogonal to this patch, so it is not a blocker of this patch in my 
> >> opinion.
> >
> > Are you referring to the scenario where, on a 32-bit system with LPAE 
> > support, the biggest System RAM address found exceeds the range of 
> > unsigned long? Actually, DAMON only actively searches for the biggest 
> > System RAM address when the user does not set a monitoring region. In 
> > this case, we always reset addr_unit to 1, which essentially restricts 
> > DAMON’s monitorable address range to 0–UL. Therefore, the described 
> > situation does not occur. For details, please refer to commit [1]. 
> > However, we could perhaps further optimize this by finding any biggest 
> > System RAM address, setting damon_addr_range, and dynamically 
> > adjusting addr_unit. However, there are currently no specific 
> > requirements for this, so this work has been temporarily put on hold. 
> > [1] commit dfc02531f413 ("mm/damon/reclaim: use min_sz_region for core 
> > address alignment when setting regions") Thanks, Quanmin Yan
> >
> > [...] 
> 
> (Sorry there was an issue with my email client. I am resending now.)

No worry!

> 
> Are you referring to the scenario where, on a 32-bit system with LPAE
> support, the biggest System RAM address found exceeds the range of
> unsigned long?

You are right.

> 
> Actually, DAMON only actively searches for the biggest System RAM
> address when the user does not set a monitoring region. In this case,
> we always reset addr_unit to 1, which essentially restricts DAMON’s
> monitorable address range to 0–UL. Therefore, the described situation
> does not occur. For details, please refer to commit [1].

Again, you are correct.  There is no user scenario that can trigger the
problematic situation in the real world.  Nevertheless, assigning
'resource_size_t' value to 'unsigned long' storage makes no sense, so I'm
calling such things a bug.  Not impacting user world, but still a bug is a bug.
In my opinion, all bugs are better to be fixed unless it makes maintenance
overhead increased too much.  Also, who knows if I will introduce another code
calling it with >1 add_unit.

> 
> However, we could perhaps further optimize this by finding any biggest
> System RAM address, setting damon_addr_range, and dynamically adjusting
> addr_unit.

I agree.  I think we can fix the function first, and later consider further
allowing users to use its full power.

> However, there are currently no specific requirements for
> this, so this work has been temporarily put on hold.

You are right.  As long as there is no requirements, there is no reason to
expose the full power to users at the moment.

By the way, one thing that may better to be clear is that I requested you to
make the implementation in this way.  Nobody should be blamed, but if someone
has to be blamed for the current shape of the code, it is only me. :)

> 
> [1] commit dfc02531f413 ("mm/damon/reclaim: use min_sz_region for core
> address alignment when setting regions")


Thanks,
SJ

[...]
