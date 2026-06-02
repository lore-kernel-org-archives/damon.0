Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2C11FBC8C
	for <damon@lists.linux.dev>; Tue,  2 Jun 2026 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366533; cv=none; b=aVzg+f4XDr14PYfnY+YyAAWjrvpdZrlXZSLXCLL8H04t3MEARLiYOzWC8/Mt9BbyiMwZSD3c6TRa025JhavoaXeO1+uzchUbLHBhdQwN/H2D12pOenD6DNk61XHOwF2PXAZZ2+/jVdybtio2NIFs2ek/i5s221qeP5mG83/9mis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366533; c=relaxed/simple;
	bh=vDNolArekgRosQOyPhKqBidL7MM7+dNKWKcNGsM/o4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcWRbxK3xZi+sVosklzE94+rJgKK+HEInCQ/v0GtHy71sRKwhDMXcScK4yPcnFkguhrQXcDfZSQESWALLlfLNpOQuzl7CYhccvOfWDZSl+g5j8CgOZmVNVUsUS8TZpZ0/WVPxlNoSCbfeE7JkcB+jrNG12KjWCwPCPOs+MVfXp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVPnVtx8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVPnVtx8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6EC1F00A05
	for <damon@lists.linux.dev>; Tue,  2 Jun 2026 02:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780366532;
	bh=vDNolArekgRosQOyPhKqBidL7MM7+dNKWKcNGsM/o4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GVPnVtx88mdLm1WWoKMJNVP52OGVT6hSqHGGU/NMJ2ZYmp1lM4EhG7bBar3rDZ3Zi
	 TcxR6ZPw9T/2gM35LpBRYKZl94OtaE0v9KeakbfZBDag3dMj+cvnK/i/UELlGHpaw4
	 bcrE6Vk7PjxVS662uUJnk5KxxtHPd4+2betlow6/BTSvgaI9DUQu1VWM/iYhUarxJQ
	 q6DAuG49IeAm8A3EP1ny0kmt0Tn4SFFsDNg81XUyYHbtjjYbNtlppOnjCQhMF242J8
	 XaHZv6Zah5JHZMdfugRssA53ppN1fZHnH10PoWAJbGYnDdk3HRNj6nSsLa40P+aqKr
	 EYJJmDXRRaasQ==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91550d518c0so210298485a.0
        for <damon@lists.linux.dev>; Mon, 01 Jun 2026 19:15:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+3OGoc5QW4OtanL92QF3QIWcFbnQVUPovGtlJqMwSHG8dFy7pD5V6Px5Q4UAsWwM21iZCFgA==@lists.linux.dev
X-Gm-Message-State: AOJu0YznHn+mmgwEUn4o8m3qCo7SYYkXVaCGOmBFsTUZ9DDnTp8IoI1M
	y6waxlrpnH1/jPs8qcNMbK1Uh5X1K4/UnWblIGvO1IJAFzIYWoFAUKDFCNkXDdxycskN8Bifxjr
	ZzBaTLubzb15jDVb+NUzEmFe1A9wieGc=
X-Received: by 2002:a05:620a:46ab:b0:914:dc12:60d9 with SMTP id
 af79cd13be357-9153da3c92amr2245294985a.46.1780366531281; Mon, 01 Jun 2026
 19:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260527110147.17815-1-tao.wangtao@honor.com> <ahcANgFDFwfC0v1q@lucifer>
 <b24b4a8198ba412f8b8b42c43dccd058@honor.com> <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <99dfc4a50f3643a6bef6deaeccfcf115@honor.com> <ahlzj--3Gm5pD9ge@lucifer> <a90bcb0fa3a044588350e92a78258a09@honor.com>
In-Reply-To: <a90bcb0fa3a044588350e92a78258a09@honor.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 2 Jun 2026 10:15:19 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
X-Gm-Features: AVHnY4LJPt1t2ZBIxfgvbOEnyfUBTI1uXsLcte0MhxaOkYp5LfKwaoVVIHaTQkk
Message-ID: <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma creation
To: wangtao <tao.wangtao@honor.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"david@kernel.org" <david@kernel.org>, "willy@infradead.org" <willy@infradead.org>, "sj@kernel.org" <sj@kernel.org>, 
	"kees@kernel.org" <kees@kernel.org>, "luizcap@redhat.com" <luizcap@redhat.com>, 
	"zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>, "kas@kernel.org" <kas@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "liam@infradead.org" <liam@infradead.org>, 
	"vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>, 
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>, 
	"riel@surriel.com" <riel@surriel.com>, "harry@kernel.org" <harry@kernel.org>, 
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

On Mon, Jun 1, 2026 at 9:46=E2=80=AFAM wangtao <tao.wangtao@honor.com> wrot=
e:
[...]
>
> You said discussion was welcome, yet when someone offered even a
> small comment, you refused to continue the discussion.
>
> If I had known you would be this inconsistent, I would not have
> replied to you in the first place.
>
> This will be my last reply to you. I will not respond again.
>

Hi Tao,

Please don't walk away from the linux-mm community. I read your
patchset and found it quite valuable. It not only reduces memory
overhead, but also eliminates rmap costs for exclusive folios.

Since I'm not very confident discussing technical topics in English,
I wrote a blog post in Chinese about your patchset:

https://mp.weixin.qq.com/s/k00tzhTl8HbL3k4G6ev4SA

I have to admit that I found the implementation quite complex and
in need of significant improvement. However, I think the underlying
idea is very interesting and worth exploring further.

I'm looking forward to seeing a v2 RFC with a cleaner and simpler
implementation while preserving the core concept.

Regardless of whether it ultimately gets merged, I hope the discussion
can continue.

Best regards,
Barry
