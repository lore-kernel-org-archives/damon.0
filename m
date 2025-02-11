Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0601D90BC;
	Tue, 11 Feb 2025 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739250003; cv=none; b=mgqAXKwSkiZvyp/J+GIxezyoIgs5o92hVEeNix+cXjYUMyy/rr6sp7Duewt5oWTOuwrHMtbYnw0Rg0pyzi1+ZlonXAkDzS/iCrRCWN998kvJHlWsIaHHOJJy/Z+vq13YHo/GmCPmTWU6RJYsGEGNTGkk0TIu3/OKFAVfuK/Enqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739250003; c=relaxed/simple;
	bh=hSVMPStI+Sa06Zw2UUdsDpFB6PeSjrO7Ar0sTb6ValY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iN/iE6aCnbe25Ly5jfrkWoEGfzxAnuB+4jlZHjcuzl0K/3YGIwIZ111N0qOWcc53sIFFdQh9HLAdx8LzTtugsDQVSZsZ1/t0wKQKy6+2x2WwMTlPBUdsKWr1RSiY1VyeO3fLTTcU8MYZL2c4JJhBNvvNFrdD/ZfejdQ/v5Dcf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S9loGqeQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S9loGqeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1665BC4CEDD;
	Tue, 11 Feb 2025 05:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739250003;
	bh=hSVMPStI+Sa06Zw2UUdsDpFB6PeSjrO7Ar0sTb6ValY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S9loGqeQDU7+vM38oniXF9UbZSirIh9+AO7Zw4TASDwdfymSr+mlfND6bI6t+H591
	 EasGPa45my4fsaWku4WH92kHww4+2JkBwnl465H/iEUc11XXeQH/XfB+bBTEoAU8I8
	 4Q+hnPRTreXNg78LWQqzxO4EbCx+u8jUUn5NvycY=
Date: Mon, 10 Feb 2025 21:00:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 nouveau@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev, =?ISO-8859-1?Q?J?=
 =?ISO-8859-1?Q?=E9r=F4me?= Glisse <jglisse@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <si.yanteng@linux.dev>, Karol Herbst <kherbst@redhat.com>, Lyude Paul
 <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, SeongJae Park <sj@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, Peter Xu <peterx@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v2 03/17] mm/rmap: convert make_device_exclusive_range()
 to make_device_exclusive()
Message-Id: <20250210210001.5dc68b38eb1bfa44d0fd78f6@linux-foundation.org>
In-Reply-To: <20250210193801.781278-4-david@redhat.com>
References: <20250210193801.781278-1-david@redhat.com>
	<20250210193801.781278-4-david@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 20:37:45 +0100 David Hildenbrand <david@redhat.com> wrote:

> The single "real" user in the tree of make_device_exclusive_range() always
> requests making only a single address exclusive. The current implementation
> is hard to fix for properly supporting anonymous THP / large folios and
> for avoiding messing with rmap walks in weird ways.
> 
> So let's always process a single address/page and return folio + page to
> minimize page -> folio lookups. This is a preparation for further
> changes.
> 
> Reject any non-anonymous or hugetlb folios early, directly after GUP.
> 
> While at it, extend the documentation of make_device_exclusive() to
> clarify some things.

x86_64 allmodconfig:

drivers/gpu/drm/nouveau/nouveau_svm.c: In function 'nouveau_atomic_range_fault':
drivers/gpu/drm/nouveau/nouveau_svm.c:612:68: error: 'folio' undeclared (first use in this function)
  612 |                 page = make_device_exclusive(mm, start, drm->dev, &folio);
      |                                                                    ^~~~~
drivers/gpu/drm/nouveau/nouveau_svm.c:612:68: note: each undeclared identifier is reported only once for each function it appears in


