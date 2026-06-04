Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003B21474CC;
	Thu,  4 Jun 2026 09:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566068; cv=none; b=HG+vfI/TgrNawGhKz8G4ObHtfgIUiyt6YzeWssu+KzEHKtLQpZz24Gk2LBemuY8QEXwAv/1mc+fSwgCwl7/Ii2Mi6YKIJgtirvunNxdv7pozYqlQWowIjgOMq6sLs3d4/ZzexJ99kldw3iv/3NghNjVovN0yepy0m/trR8ClwWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566068; c=relaxed/simple;
	bh=mnjVaJX+R7uCbO3jClwNLliInzV5QanTPnKFMHuMuas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlY50e4CO845VIE2hKr2LK0pmDoCuMXwE6xtmFAM6r0aNyLuDGkqHcGoWOSSrNJr8/CwVebOztbqCBcnjgiZL8adFjMY7ZxrkQZjchXAQ5sbovE0adTyhm5iQpiqPUNRr6yj0wNsgKbtuEsZNykgx9C4Y1yuuo4kfB9VEVqzMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1XM8VeW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1XM8VeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B081F00893;
	Thu,  4 Jun 2026 09:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780566067;
	bh=mnjVaJX+R7uCbO3jClwNLliInzV5QanTPnKFMHuMuas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f1XM8VeW9YiBPOV7xsp6RjWrfLgcqlz5ytLuWbxe9s6CrVt44fS1UvYE7GV5NQIt7
	 sopJ13tqkwmI/XyC8MpBwZouwgOSbMk8iVik2o+ZU7c281S9CTFBvgIkDrM+4ZdqWV
	 2WGnIWao69+I0v6Z76n/kKt4YUfz3qmFsQ1PRzpCGaRmr2erSDCJPApnP6CidYDXMV
	 wVx8GxOh0qoC3i30sBheccc56PRGVa9YP6PEko8JAoo8n1cgMhz10crJR6NENzssqD
	 PaHgWdUSzzxcQBj5BKgrhnIAnOARH7gvvtYwlzW1B4w/L7VUJnDDWEUOOyXyzuOREw
	 sgzKoew4rxb7w==
Date: Thu, 4 Jun 2026 10:40:52 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: tao <tao.wangtao@honor.com>, catalin.marinas@arm.com, will@kernel.org, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	kees@kernel.org, luizcap@redhat.com, zhangjiao2@cmss.chinamobile.com, 
	kas@kernel.org, hpa@zytor.com, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz, 
	riel@surriel.com, harry@kernel.org, jannh@google.com, jgg@ziepe.ca, 
	jhubbard@nvidia.com, peterx@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, 
	nao.horiguchi@gmail.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, pfalcato@suse.de, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, damon@lists.linux.dev, shakeel.butt@linux.dev, ryncsn@gmail.com, 
	21cnbao@gmail.com, jparsana@google.com, dvander@google.com, zhangji1@honor.com, 
	wangzicheng@honor.com
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
Message-ID: <aiFH5_rjl-mJyXBs@lucifer>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>

On Wed, Jun 03, 2026 at 10:25:05PM +0200, David Hildenbrand (Arm) wrote:
> I was excited when Lorenzo started working on a completely new approach that
> would focus on improving the common cases while trying to reduce the overall
> complexity. Because I think most of us really dislike anon_vma. It's still work
> in progress, and I am sure there are some rough edges.
>
> But fundamentally, I think we want to find a new design that is just naturally
> simpler.
>
> Lorenzo has been hard at work exploring various design options (and I'm afraid
> he might be one of the 3 people on this planet that understand anon_vma in full
> detail), so I suggest we wait for a redesign proposal from him and see if that
> is doable?

I'll spend the next month focusing on shipping something as a priority, even if
partial.

Thanks, Lorenzo
