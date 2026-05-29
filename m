Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C263EEAEB
	for <damon@lists.linux.dev>; Fri, 29 May 2026 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067258; cv=none; b=gNALC5lU320GyuG99gzFoX/G+SXcZQH40z8tPb3H2/gvp2uggoui0VFNL81EK5caFgij20L6JjSvra1tByaGli2Vpos48YhIWtLftSgmCGd1SjAde+xD9EmiUuCJpuzDv/JhWEN9KZ1I8r6Nn121ctoSwhqlYKm/m5xYl6USewg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067258; c=relaxed/simple;
	bh=Pil606WUH2ip76AQan+V+uJr/Ad8H1Jaot/pJ/IfzkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ET6WdsHLuhxP1egxUgbCkWzkhBS9A/iLmlrvvX55eWO0eaMcLyTgE7A/4Ebd9y/VBzMh8+IeON0dRVZEs7+cIeOrhp1QFbJyvGdxAULlR2ZawLCIngPbP9nuiIehzByLHwcoheHDU2UXaS+DjFWqpnekUBUSMhEWPB1eBrbWkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YHFXwrZp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YHFXwrZp"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 10C8440E37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1780067251; bh=ebIP9u+W/NdprxD2plfJ1x4u07OsUSk6F8cbjhxlAs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YHFXwrZpXpELJCTLz1aonU6ujOlC3U+3KBMyzDRJIeqAQxcKO89EUcmvxyoUQM96G
	 GofDbotXK9F4W+ymH9hdnOnS1IvDgr+Lwj66tJhtDzp5UmEbp+e5byw5Etm+YfUK7D
	 /Ecut4iJxA08ifiuuZA6Vcwyd0e4utrKgns8b6tGmNx2OtCMX5T+skVL1jEXVmAbCL
	 2QNrsrRMp72ArGrSCZhPWChA7mnro+R7Uv2NUXuEvWX6U49hDb9rCBCBah+o8+OAx/
	 +rLwQA0b7r+EZwuhVhdFVhVfiBkLpFeYS21diLH8um6X9eUyPadg/1mjT/mKpeCdmY
	 G6+x3PczFpJBw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 10C8440E37;
	Fri, 29 May 2026 15:07:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Barry Song <baohua@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: wangtao <tao.wangtao@honor.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com"
 <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>, "sj@kernel.org"
 <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>, "luizcap@redhat.com"
 <luizcap@redhat.com>, "zhangjiao2@cmss.chinamobile.com"
 <zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "liam@infradead.org"
 <liam@infradead.org>, "vbabka@kernel.org" <vbabka@kernel.org>,
 "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
 <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz"
 <jack@suse.cz>, "riel@surriel.com" <riel@surriel.com>, "harry@kernel.org"
 <harry@kernel.org>, "jannh@google.com" <jannh@google.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "baolin.wang@linux.alibaba.com"
 <baolin.wang@linux.alibaba.com>, "npache@redhat.com" <npache@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com"
 <dev.jain@arm.com>, "lance.yang@linux.dev" <lance.yang@linux.dev>,
 "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, "chengming.zhou@linux.dev"
 <chengming.zhou@linux.dev>, "nao.horiguchi@gmail.com"
 <nao.horiguchi@gmail.com>, "matthew.brost@intel.com"
 <matthew.brost@intel.com>, "joshua.hahnjy@gmail.com"
 <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com" <rakie.kim@sk.com>,
 "byungchul@sk.com" <byungchul@sk.com>, "gourry@gourry.net"
 <gourry@gourry.net>, "ying.huang@linux.alibaba.com"
 <ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>,
 "pfalcato@suse.de" <pfalcato@suse.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "damon@lists.linux.dev" <damon@lists.linux.dev>,
 "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, "ryncsn@gmail.com"
 <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>,
 "dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>,
 wangzicheng <wangzicheng@honor.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
In-Reply-To: <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer> <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
Date: Fri, 29 May 2026 09:07:30 -0600
Message-ID: <87qzmu2r0t.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Barry Song <baohua@kernel.org> writes:

> After coming back from Zagreb, I kept trying to find one or
> two full days to read Lorenzo's code and slides carefully and
> write a blog about them. Unfortunately, I have been completely
> busy with other work. Sigh... we always seem to have too many
> non-upstream tasks.
>
> If possible, I'd really appreciate it if you could take a
> deep dive into it and write a detailed blog post. I'd be
> very eager to read it and better understand the overall design.
> Otherwise, I'll try to find some time next week or later to
> go through it myself.

It's still somewhat superficial, but in case it's helpful:

  https://lwn.net/Articles/1072378/

jon
