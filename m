Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED644229C8
	for <damon@lists.linux.dev>; Tue,  7 Jul 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441161; cv=none; b=h13SfsOYH/uhYkPt3OnORAH8Aq9bF+ESqROgdMPW6dw3HPFJrTsQ8K+IOSdM/J16npDTaE2syrmdFkCud6QTB1jfPtxMMRdUvwndW9OM9cyfF8Sd7XBDVN1D+bwjSriM5Zetz4T+v3RXsLEeqnL6gxn6+ZvhcGnagn2sDWw1tQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441161; c=relaxed/simple;
	bh=zSkYvM1j3bXBVN3GN9JHi3PTLk/FUppI2uWt99Lug5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9ZTwEVjZWJS9RwaT2tbiecJtv6/8X9SJHPPOwdmJSiKbZz6YynNIDp8vujBGd6NU6brxJmZISFXT8E7QLaYHwUD8Tl1pbgJFQ0BbqCD32Z1O7yelExYUWhQU0pDzlOZLQjM9rx9/cj/kGS662MGgTb6kYu6azM2y7E6X3tIOtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jS7y90J3; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jS7y90J3"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c149c5722so6807721cf.0
        for <damon@lists.linux.dev>; Tue, 07 Jul 2026 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783441159; x=1784045959; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=shTm78OzX8lamx3AIG2aka+O0fr6RJu853HQxce+7Rc=;
        b=jS7y90J3d5C1onMSiN+Akc0kejPsTlA4SSejdc769oSBgsRhDaSx/lBinDA1V0n33r
         mfZDR8S8+DNVb8CeqrnsNCfPMmk1MbWX2v5c3+b9HD37I5fn7xcCQLTecIzwoZjO93T+
         aWvybosuOs9TNStvnN3MyzT4/b3BBum5gr5eRSYMwFQsyGsv037/PNTvCLJbdIok++UK
         CA7Gu8zlZMmLbM1XuWDvkfD8M831E1Eu634cySVnD22PPJB/70ca00sdK10mcZBFd7Re
         x1lYbFdrkZMOkBSsOBIGA4l24DHQIwUcrWdWKx49pW97oeYueJsUQ6omxpQB9+44P1hk
         PKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441159; x=1784045959;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shTm78OzX8lamx3AIG2aka+O0fr6RJu853HQxce+7Rc=;
        b=Vg4qMYnCvVYs8FuqzqkfD2RmIg7uZmoU0e3DGp7erRSRy4QSeF2JeRQju6p4yR0zpv
         M3cjBPmcZemu1yzQhDa78b/XBqe9HsBZGGMo/xhZZ7qbt57ooa5rA3I2X6qJwvbPUxbg
         U+gjrFmOsGMopZa3IKpKxKNMXDDKOgJSZ9WOn6v2S+2wQXzWmkZyuAji2FxVUnh0FDGd
         gZwRJiNYpZk3y9UNXbU8HkcVwATXpjRTBT4Zj9qQ8pby3GHcTDnjUGBfBwYL9cIPC/xH
         GDK/aMWvUkfJK4l8z7dwGFwt52ceSOtfc67/BWNyRER8CDOJXYF40hx2S27ZAzL0IG/A
         mdSg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1ljqK6jC8CMX2f8qe0ks80xroQcY4WFWnPIEfI48UGDCcHos6RBPmSoNYTHatjs6US+7m7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhQtJtdq0aQR2e7hp/ijaPmUX8dVIzG0bN5B20+BptVu2Z2Qnv
	YwF9wib8sFs9qUVqLW2eH3jcE2rb78ttlke5zLuiQ+E4a3VTqbLaJekE1qwpC/3f0cg=
X-Gm-Gg: AfdE7ckAOW+XM4r7bYsLMr/G95UxIvG3C8xY3OFxduIeTUcaDx8XN4vimSbPlgkXeCq
	aGqGVMwxMunz47VzY+zDb6uZNm7n80tDcZTm0R0Qj9q8GT83QvshIKVaKzWPML9gw4AKabd0OtZ
	FgLIQdRHnuTuICNas/P0vCpVDUamRZpOj0PQoNC2NxvKFC6ma8k7qR1sFsqp6U2B8sXvgWE9HXD
	jYP6sY+O5l3ioBl7jIlVOdCgp4HyTWCb2se4qIMQ8SnwBhpx5X8YTRJlVmyxjXLS1HwuZh5pHMH
	Bhs+FB978+0WkfjiswDDr8C5gJ1QeYlfGMt2DIktgP2U8aPv6Bzs2HUuIGRybyeUF11HIGIn/hf
	u+lMTiVYaK6MYnAvzxM32AvtAZa3UrN8qTjYuSKUHlfDjRi+KA0iZ0ibpxE+ndCKkrNC25odJRF
	lMKqAHPozSJfa/VSe8WJUI39c6hfYlI1P0nssGeGer9T0l5PQsn17qWyzh2FNigwbrEboH
X-Received: by 2002:a05:622a:124e:b0:51c:1f35:4638 with SMTP id d75a77b69052e-51c7a7515famr34037661cf.21.1783441158809;
        Tue, 07 Jul 2026 09:19:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41da510dsm114014641cf.22.2026.07.07.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:19:18 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:19:13 -0400
From: Gregory Price <gourry@gourry.net>
To: wangtao <tao.wangtao@honor.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"sj@kernel.org" <sj@kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"luizcap@redhat.com" <luizcap@redhat.com>,
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"ljs@kernel.org" <ljs@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"liam@infradead.org" <liam@infradead.org>,
	"vbabka@kernel.org" <vbabka@kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>,
	"mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>,
	"riel@surriel.com" <riel@surriel.com>,
	"harry@kernel.org" <harry@kernel.org>,
	"jannh@google.com" <jannh@google.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"ziy@nvidia.com" <ziy@nvidia.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"npache@redhat.com" <npache@redhat.com>,
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"dev.jain@arm.com" <dev.jain@arm.com>,
	"baohua@kernel.org" <baohua@kernel.org>,
	"lance.yang@linux.dev" <lance.yang@linux.dev>,
	"xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>,
	"baoquan.he@linux.dev" <baoquan.he@linux.dev>,
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"matthew.brost@intel.com" <matthew.brost@intel.com>,
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>,
	"rakie.kim@sk.com" <rakie.kim@sk.com>,
	"byungchul@sk.com" <byungchul@sk.com>,
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
	"apopple@nvidia.com" <apopple@nvidia.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"ryncsn@gmail.com" <ryncsn@gmail.com>,
	"jparsana@google.com" <jparsana@google.com>,
	"dvander@google.com" <dvander@google.com>,
	zhangji <zhangji1@honor.com>, wangzicheng <wangzicheng@honor.com>
Subject: Re: [RFC PATCH v2 00/13] mm: rework anon_vma and remove
 anon_vma_chain
Message-ID: <ak0nAXzlwnQ-zPkN@gourry-fedora-PF4VCD3F>
References: <20260707063308.29176-1-tao.wangtao@honor.com>
 <08c001ab-320f-4676-830b-8e4ba6a05dee@kernel.org>
 <b00a03d62c53430ca22b3f3c5e5327b5@honor.com>
 <0e8e5a28-1111-4b81-b04f-b81e749eb3dd@kernel.org>
 <f640c89d9722462098bf1b7a0a6854c2@honor.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f640c89d9722462098bf1b7a0a6854c2@honor.com>

On Tue, Jul 07, 2026 at 09:20:24AM +0000, wangtao wrote:
> > >
> > > If there are technical issues, please point them out directly.
> > > Or is this simply how technical discussions are usually conducted in the
> > Linux community or the mm subsystem?
> > 
> > I suggest you go back and read my email.
> 
> At first, I thought I was the only one who found anon_vma hard to understand. After reading your earlier email,
> I realized that many people also consider it difficult to follow. So I tried a different approach and implemented
> anon_vma rmap using a simpler doubly linked list plus depth mechanism.
> 

The in-flight was discussed at LSF and then reported on by lwn

https://lwn.net/Articles/1072378/

https://git.kernel.org/pub/scm/linux/kernel/git/ljs/linux.git/log/?h=project/cow-context

If you have issues with the in-flight work and think there's a better
way, it would be good to engage on that front - rather than posting
competing work and expecting maintainers to have to context switch
between two solutions for an objectively hard to understand problem
(which carries significant risk of regressions).

No one is saying you can't engage, just trying to avoid doing the same
work twice for negative value.

~Gregory
