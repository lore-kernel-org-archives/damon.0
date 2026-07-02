Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0435431E68;
	Thu,  2 Jul 2026 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987844; cv=none; b=cojbH/WTiWmv9ZZ8qTIxCOkW/vWQ7q6NnKP6xtn6h04qkJhBbVJgs9qFO3I/6ui9md1rBXh9+cpfUiuyFRROLWqfyfZpoZNw12LPMKxxaGxtLOk0CWrFCLJ7B/hM1x1/Nwd8k/46vwDmHvNGdJOCj6HAWlHwcwCiF8HT433VbgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987844; c=relaxed/simple;
	bh=OGcz5nFpJT7/819veniNCxoWNDvDubeWKYTlxYZzcN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDphgNPd/FGHnwJ9fC1DRwiHFAgNJtc+B1HOMH7kSQOSbOHaNrfNw6zB8BEShAmiEc5kW4VG1BYovvzEf8czm/zL6Q6XJhSfP9S/2aTqbNkXwJncFU91aU9dX2JzUmQ892hePxJe1X6tsYSse2xNTp1g4KJlJVSEv22nyW7g/X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmePY3SJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmePY3SJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED221F000E9;
	Thu,  2 Jul 2026 10:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987842;
	bh=x41dzmPIh8BFvMrp+WHPC2Q6gxG4jWiV4wqOzoJYo7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RmePY3SJoW7j44vSGP2lOd1JwcLDzo6DXm8DRbPXFtXzYI8K2MP/QMaMhYw1WAKrv
	 HLXngjAwEPtnex5RVLBCYgeqsXd6kgsdQ+/7cm4S9k/GhHX73h4aD+6+qg0OGvrWLj
	 3t3KRJge9NvvjVUXeLiKk8PfDwVfhmPdyS7nn9NgffiYTdWRtIMtjW4u3hgJFWS7dQ
	 g99pLdR8RByLH+8TV2aqgnC6zRgn5nlmFr3EeJ2vlapNFZPohcprxt3q3InD7iR8sP
	 jaNXuzscThIbbrK8aK1lmHBZHMmrKxp8IoTUT4FDtDfXGDjkjUOl38fYu8AqMuNV4y
	 PPeOm/ThvbcAw==
Date: Thu, 2 Jul 2026 11:23:55 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Lian Wang <lianux.mm@gmail.com>
Cc: sj@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	daichaobing@sangfor.com.cn, kunwu.chan@gmail.com, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v2 0/5] mm/damon: add mTHP collapse and split
 actions
Message-ID: <akY6ZzPnwk-CToMp@lucifer>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702094633.75658-1-lianux.mm@gmail.com>

+cc all those you missed.

I really need to write a bot to do this, because I'm getting a little tired of
pointing this out :))

On Thu, Jul 02, 2026 at 05:46:28PM +0800, Lian Wang wrote:
>  include/linux/damon.h      |  10 +++
>  include/linux/khugepaged.h |   9 +++
>  mm/damon/core.c            |   2 +
>  mm/damon/sysfs-schemes.c   |  77 ++++++++++++++++++++++
>  mm/damon/vaddr.c           | 128 +++++++++++++++++++++++++++++++++++++
>  mm/khugepaged.c            |  46 +++++++++++++
>  6 files changed, 272 insertions(+)

You are doing damon changes, and that belongs to SJ, sure.

But you're also changing core THP code? Please ensure you cc- THP people because
without our approval this cannot be merged:

$ scripts/get_maintainer.pl 20260702094633.75658-1-lianux.mm@gmail.com.mbx
SJ Park <sj@kernel.org> (maintainer:DAMON)
Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
David Hildenbrand <david@kernel.org> (maintainer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
Lorenzo Stoakes <ljs@kernel.org> (maintainer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
Zi Yan <ziy@nvidia.com> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
Baolin Wang <baolin.wang@linux.alibaba.com> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
"Liam R. Howlett" <liam@infradead.org> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
Nico Pache <npache@redhat.com> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
Ryan Roberts <ryan.roberts@arm.com> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
Dev Jain <dev.jain@arm.com> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
Barry Song <baohua@kernel.org> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
Lance Yang <lance.yang@linux.dev> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
damon@lists.linux.dev (open list:DAMON)
linux-mm@kvack.org (open list:DAMON)
linux-kernel@vger.kernel.org (open list)

>
> --
> 2.50.1 (Apple Git-155)
>

Thanks, Lorenzo
