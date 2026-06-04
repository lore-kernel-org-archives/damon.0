Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2233DEE1
	for <damon@lists.linux.dev>; Thu,  4 Jun 2026 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546827; cv=pass; b=mQ9wfCdZKAi87bD2fJ+pzUyJsCb++0ivk3ONMxf4lvj4mixHGxb/ZHTQBRvItuTaMQj9+zvTtnkur/uLPea2nfcvcRg9V+xp5kszjDfT5a4l4lb5KvFSZ8n5tNGIJSQrE/DveyQJ//gPHwJZULiTxCZLJ4qSRIWudR7L7EWLr+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546827; c=relaxed/simple;
	bh=fbQ6vfQrwARgrWDKvWJtpQq4FUoOqa91kgga49dPBA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUgiryauE7hiaRyzOdRYMK9sWkWfEnMT363QhGNh4Rb9MnVL7v6N1DssbM8QuIlFBG+veQChZc134rLGg86Nf5/511kt+x7JASyDEoPR7eWGF62mLyvfViFstwQ1+DgtO5Qb0Ey61gZM+rgJRzpHDT1C1Vae9KHGKFwUQq1xRGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CydhcClF; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CydhcClF"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-91550dfc11fso33930485a.1
        for <damon@lists.linux.dev>; Wed, 03 Jun 2026 21:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780546825; cv=none;
        d=google.com; s=arc-20240605;
        b=MJe4ThQSTJ9z3lhX9bDPtJyEfGVwXm3crN+K4fcWrNFKUTv3JGFDMTgLpE4wPVUaBJ
         wu49O1406fRYu6xWAXJJR16f7wfMy0uZmxETREnuHCXhgWPWyW/48tlQsuEuy3FRTBot
         Hgr/wtH4JmPStEWpkIt7atakMBNAWl+nR/Ssm2E+PGocMiSZmVn8cN68cos+KHBFza1d
         opdbm2V31+NBKNZlgCXWllVjI2BSltyDRWj1cTAHYpPr/OJLvv7IO+bjFvFBEZsZ46PK
         e4Kn8/UEQWzyk2bN14QDz3Ah4e+3UHUUnOrsqILjccIAoZs41yCp8Iei48EF1Jw4CIzi
         x0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fbQ6vfQrwARgrWDKvWJtpQq4FUoOqa91kgga49dPBA0=;
        fh=U8b5h808vTk1EQcJ/2Efy8UVpJ8P+XhvmWvujrNcNDg=;
        b=EIiLhur634xArh0AaawR1fBzA3toaiBgXPZOm6MzdZOspgEMxs9OyMsOflVJ5qJPvo
         bnMXHpsq9vmCWg8On22tIxDfB2YgN6+EtMx22s2AzzTPPhwqKDINqROGijUdftK5HXAA
         h9pF6XIc5SlIJEiIfCM57B7U7XOzogllulACjaToNaXnPwHs+dSl3cwi3xi9QkGjCkqY
         t5Z79NC5PbtfiBahl34IN0yp2xmW9F/VHwioBh8DnYpO+i93aJooEeZwIWtJ5YWDGeUl
         3B50l3Tspff9Mfnbqq7TmRV52b629KyV3g9zKtXY/oppiSZUSbxwCx0ZRhv0DzKhYEXS
         YGCA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780546825; x=1781151625; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbQ6vfQrwARgrWDKvWJtpQq4FUoOqa91kgga49dPBA0=;
        b=CydhcClFg1fUzprAVKtqUCdHLEgQTO+DEC4p1k+1SiC8IuSx+vTTkgoOeejO4wXGUa
         e7JDRLM3QP4LAwRHqO3C5Zyj6RudspIwcdmDxcsoog2ATS9buEC2S6ZSE4pHPGIU98dQ
         7GZigSS4vPciKOyljOhSiBOBan4B9mTCZMrdE2GYdJuOPZ7IVI3xNWB0lbBcj3hZLLqc
         MCTjc+BLKkMuPq7uRbHVYQtxJXOavHTqXkhHy2DXqD/hmtSmd2s1gFVnPYULWzUa5LlW
         g5i8jor4V0z4VmqGhT/CckGykAzJtBGeU+q6ccUdwRXuVk6+qhGsWCxVvnyZi8Cf3oaj
         Hq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780546825; x=1781151625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fbQ6vfQrwARgrWDKvWJtpQq4FUoOqa91kgga49dPBA0=;
        b=cdoFoI8xpJAT1XPF0J+xDft8e7H6ijfIyd3uMv8TI1Yxyt2z8jt4F+FaRBrZPUwP9Z
         VSz8FDI2OdMtoo3lLIUylvKH527vJFfJ05KAdoe/ZOGFw8kFE6Rzot1lOQDJ09dBf0dE
         j5pAdnZt1etOcO0dhqrNoRA8VmKL35N20ZuZgmSiT7guX1IqKBfux/gslzn38kl9YTQe
         gF3EMc1qv/Mb6qbPKCPqfkCdaZVs6e6ujcdcCi4P8pXoB1WBbqARF+eiugImcnA5TQAp
         PcI+DCtBGiBXw+H2wR132vzeuvNTnSYQg0TVzoXbX1WK5otGSUSpwCqFv9MhRNouXLU3
         N7/A==
X-Forwarded-Encrypted: i=1; AFNElJ+7v2bDbsGkE332tVQ7WNouqZEOjSFyLQIB+0vN+NDrR0h3ZtN6mpFXE/OpcEIOqScVUdqrIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgTWdD+W0PMuXtAPv4Vcfi+yLnrestmLdnTD6i9YhG7+1cY0rZ
	TnVW/zqFi4NJ/Bs64PBY9RRo0eCpYfsOfEI9+C33+QSIeL7KXqVc0KoZ0LEnvQpF53HOg8+8M+q
	YifQNVCzn9biHknR64MvOyzV1t6+mbgo=
X-Gm-Gg: Acq92OGl2quHrl9+lUBPo7226Da0Xb4Sgr518b1376IcbRJoFvx5Xyxr2sysjkMk4NP
	2v29bwjKSBCkCA567ZMhFoewEyKxmVMQLGDbZF1jcWkIANgwgZv+FSVJQY9wVEyyo2OD/7CqnCy
	4zUZKjDUKQdG36YZ3sxjxEJLYeu8BlzHfOHaVPdhvHasNhxptsq4t8LF5lvy7Ax7FxuOREAxoXq
	WBg2uXfzMm3OiolV4WVRSykKRKeBaESOTVK7N+zwXHRMbOsU9plNNdOSkEycPWlDZ3MdOg3eIRt
	5AuXvpCU2h0SepvSL4jWba13MH1ogt/Zay0mXnhqzG18azOw
X-Received: by 2002:a05:620a:470d:b0:911:69a3:1653 with SMTP id
 af79cd13be357-9158a7fd516mr988560085a.46.1780546824101; Wed, 03 Jun 2026
 21:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260527110147.17815-1-tao.wangtao@honor.com> <70377626-500d-46f2-a3f5-a0d2914ce365@kernel.org>
 <CAGsJ_4zg8+pVDwtsJtxxiC1ahJ9MR56Ue8VXCt_VrQgcXES2uQ@mail.gmail.com> <273d02a1af954b8c9f4da7fb74e6b4cb@honor.com>
In-Reply-To: <273d02a1af954b8c9f4da7fb74e6b4cb@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 4 Jun 2026 12:20:12 +0800
X-Gm-Features: AVHnY4KKmG5AxRaMLljUSifBekek5i7G4Gj54Kx0zUQZahUBQkVCtPOcn71W6Go
Message-ID: <CAGsJ_4xTMsV8fJVfhshDQp4=Ax2f_+b6yR873cEP11bjcEa_5Q@mail.gmail.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma creation
To: wangtao <tao.wangtao@honor.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"willy@infradead.org" <willy@infradead.org>, "sj@kernel.org" <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>, 
	"luizcap@redhat.com" <luizcap@redhat.com>, 
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>, 
	"ljs@kernel.org" <ljs@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"liam@infradead.org" <liam@infradead.org>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"jack@suse.cz" <jack@suse.cz>, "riel@surriel.com" <riel@surriel.com>, "harry@kernel.org" <harry@kernel.org>, 
	"jannh@google.com" <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"ziy@nvidia.com" <ziy@nvidia.com>, 
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, "npache@redhat.com" <npache@redhat.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "dev.jain@arm.com" <dev.jain@arm.com>, 
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>, 
	"matthew.brost@intel.com" <matthew.brost@intel.com>, 
	"joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>, "rakie.kim@sk.com" <rakie.kim@sk.com>, 
	"byungchul@sk.com" <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>, 
	"ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>, "apopple@nvidia.com" <apopple@nvidia.com>, 
	"pfalcato@suse.de" <pfalcato@suse.de>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"damon@lists.linux.dev" <damon@lists.linux.dev>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryncsn@gmail.com" <ryncsn@gmail.com>, "jparsana@google.com" <jparsana@google.com>, 
	"dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>, 
	wangzicheng <wangzicheng@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 12:03=E2=80=AFPM wangtao <tao.wangtao@honor.com> wro=
te:
[...]
> > > I won't echo what has already been said in this thread (and I didn't
> > > manage to read all, unfortunately), but for such big and invasive wor=
k
> > > it's often best to get in touch with the community earlier. Otherwise=
,
> > > you might end up wasting your time.
> > >
> > > Ok, arguably, someone who writes that code learns a lot on the way.
> > > And if this code really was written by one developer only, I tip my
> > > hat! I'd be curious if that code already ran somewhere on some Androi=
d
> > kernel out there?
> >
> > I heard from Zicheng that they have been running this for months and it
> > seems reasonably stable. Please correct me if I'm wrong, Zicheng :-). T=
his
> > really should have been discussed with the community earlier.
> >
> I initially developed and debugged this based on the Android GKI branch
> and did some preliminary testing on an Android phone.
>
> Since GKI generally only accepts features merged from the upstream
> community, and this memory saving could also benefit the community, I
> ported the patch to the Linux master branch.
>
> Because my English is not very good and I rarely participate in the
> community, I am not familiar with the community workflow. I did not send
> an email for discussion in advance with an RFC tag. I apologize again.
>

No worries. I know someone who has worked on the Linux
kernel for many, many years and has excellent kernel
expertise, yet has never submitted a patch throughout his
career for various reasons.

I heard from Zicheng that you are HONOR's key MM expert
and have been guiding them on memory-management related
work. That's really impressive. Personally, I'd love to
see more ideas and contributions from you in the linux-mm
community.

BTW, regarding my earlier suggestion about using GKI
hooks=E2=80=94limiting the optimization to newly created VMAs and
to applications that never call fork()=E2=80=94do you have any
ideas on what the smallest possible hook change would look
like?

Thanks
Barry
