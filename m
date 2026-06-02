Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9228B3264F7;
	Tue,  2 Jun 2026 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430233; cv=none; b=LD1B+hyHBXHb8owUfzL1RlgNtA2yra9PidL8Mn+cyvfHgQvlHivSbtg3qTjYEcgPjNyqCA9oP3LMDA3DQKSJtjdHbhBhfrToSkgRXLSSQZ6LoPuSUZo6DAh6GRVTas2wHla63BHDeyQFqrGq+wucfs//92M5/DbUKYWB83+2vBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430233; c=relaxed/simple;
	bh=0vQhc1dbc5LVHsBRrn3VszFfXAXWWO1kVMy2oolTIN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxSanBla4UEz7NMoWDAu9jGUnGLUatz2cVajM6jx1xnYYekDPwOGnETyLtndJBT2rU31kn4/PpZWmUNLz/kG7XlgF46/9BIV4PYuK5qwasXOWJ02ZAc09GKXGwWiM0YTpwMcnL+05rCAOM7ZykZgY5s4N1eSJeS0ukYZhhX/smA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOVI2Ocr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOVI2Ocr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4021F00893;
	Tue,  2 Jun 2026 19:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780430232;
	bh=0vQhc1dbc5LVHsBRrn3VszFfXAXWWO1kVMy2oolTIN8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hOVI2OcruvfTllpcq0jsW7aDFTSL3NcP0W3HNxtTvh9lZ+6HJZe87VAiGFM5ZpVgF
	 vVs4fil66BhU4jNutDHSlKK/hFHWCZrsFTLyG5qoujYRTQSpet4Iob49+SWHx4tzvO
	 1BBPDWzv9nT1gmYEchMPRpHeKH4BqWbg7dDXSz5rydwjOciOQpeXdcXU9qsAsmt7wx
	 t7nN8hUMN5WzSC2Bc6L6g/Y1x/iQyePeVVe06eotXj3k58evUKF76WykeF9zbSoqxY
	 R/wPNnx1sNH0ObNSmUYvzw4T/3fa7V0UYM7puEYChaosOovG4sx7ZUBOlAYHltuxBm
	 st+Q1CEvD9xaQ==
Message-ID: <1fb6a226-2899-497c-abbb-eb49c3a2f306@kernel.org>
Date: Wed, 3 Jun 2026 04:56:56 +0900
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
To: Barry Song <baohua@kernel.org>, wangtao <tao.wangtao@honor.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "david@kernel.org" <david@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>, "sj@kernel.org"
 <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
 "luizcap@redhat.com" <luizcap@redhat.com>,
 "zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>,
 "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "liam@infradead.org" <liam@infradead.org>,
 "vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
 "mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>,
 "riel@surriel.com" <riel@surriel.com>, "jannh@google.com"
 <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ziy@nvidia.com" <ziy@nvidia.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "npache@redhat.com" <npache@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "dev.jain@arm.com" <dev.jain@arm.com>,
 "lance.yang@linux.dev" <lance.yang@linux.dev>,
 "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
 "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>,
 "rakie.kim@sk.com" <rakie.kim@sk.com>, "byungchul@sk.com"
 <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>,
 "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
 "apopple@nvidia.com" <apopple@nvidia.com>,
 "pfalcato@suse.de" <pfalcato@suse.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "damon@lists.linux.dev" <damon@lists.linux.dev>,
 "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
 "ryncsn@gmail.com" <ryncsn@gmail.com>,
 "jparsana@google.com" <jparsana@google.com>,
 "dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>,
 wangzicheng <wangzicheng@honor.com>
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer> <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <99dfc4a50f3643a6bef6deaeccfcf115@honor.com> <ahlzj--3Gm5pD9ge@lucifer>
 <a90bcb0fa3a044588350e92a78258a09@honor.com>
 <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bwW6faxu8TU10uSydRwBrOZz"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bwW6faxu8TU10uSydRwBrOZz
Content-Type: multipart/mixed; boundary="------------YuOxOu3OkEnuies33ChEyi0g";
 protected-headers="v1"
From: Harry Yoo <harry@kernel.org>
To: Barry Song <baohua@kernel.org>, wangtao <tao.wangtao@honor.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "david@kernel.org" <david@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>, "sj@kernel.org"
 <sj@kernel.org>, "kees@kernel.org" <kees@kernel.org>,
 "luizcap@redhat.com" <luizcap@redhat.com>,
 "zhangjiao2@cmss.chinamobile.com" <zhangjiao2@cmss.chinamobile.com>,
 "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "liam@infradead.org" <liam@infradead.org>,
 "vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
 "mhocko@suse.com" <mhocko@suse.com>, "jack@suse.cz" <jack@suse.cz>,
 "riel@surriel.com" <riel@surriel.com>, "jannh@google.com"
 <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ziy@nvidia.com" <ziy@nvidia.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "npache@redhat.com" <npache@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "dev.jain@arm.com" <dev.jain@arm.com>,
 "lance.yang@linux.dev" <lance.yang@linux.dev>,
 "xu.xin16@zte.com.cn" <xu.xin16@zte.com.cn>,
 "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "matthew.brost@intel.com" <matthew.brost@intel.com>,
 "joshua.hahnjy@gmail.com" <joshua.hahnjy@gmail.com>,
 "rakie.kim@sk.com" <rakie.kim@sk.com>, "byungchul@sk.com"
 <byungchul@sk.com>, "gourry@gourry.net" <gourry@gourry.net>,
 "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
 "apopple@nvidia.com" <apopple@nvidia.com>,
 "pfalcato@suse.de" <pfalcato@suse.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "damon@lists.linux.dev" <damon@lists.linux.dev>,
 "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
 "ryncsn@gmail.com" <ryncsn@gmail.com>,
 "jparsana@google.com" <jparsana@google.com>,
 "dvander@google.com" <dvander@google.com>, zhangji <zhangji1@honor.com>,
 wangzicheng <wangzicheng@honor.com>
Message-ID: <1fb6a226-2899-497c-abbb-eb49c3a2f306@kernel.org>
Subject: Re: [PATCH 0/15] mm: introduce ANON_VMA_LAZY for deferred anon_vma
 creation
References: <20260527110147.17815-1-tao.wangtao@honor.com>
 <ahcANgFDFwfC0v1q@lucifer> <b24b4a8198ba412f8b8b42c43dccd058@honor.com>
 <ahf2mJg9OOWvu0jA@lucifer>
 <CAGsJ_4zy=-m5wjm0BC-vQXMHGRkHymC-5S_L9Oi708v339vvPw@mail.gmail.com>
 <99dfc4a50f3643a6bef6deaeccfcf115@honor.com> <ahlzj--3Gm5pD9ge@lucifer>
 <a90bcb0fa3a044588350e92a78258a09@honor.com>
 <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>
In-Reply-To: <CAGsJ_4wFr89M2i8pth79swv3==i8SGSMWrbr+Yp2umwFTuCShg@mail.gmail.com>

--------------YuOxOu3OkEnuies33ChEyi0g
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 6/2/26 11:15 AM, Barry Song wrote:
> On Mon, Jun 1, 2026 at 9:46=E2=80=AFAM wangtao <tao.wangtao@honor.com> =
wrote:
> [...]
>>
>> You said discussion was welcome, yet when someone offered even a
>> small comment, you refused to continue the discussion.
>>
>> If I had known you would be this inconsistent, I would not have
>> replied to you in the first place.
>>
>> This will be my last reply to you. I will not respond again.
>=20
> Hi Tao,
>=20
> Please don't walk away from the linux-mm community. I read your
> patchset and found it quite valuable. It not only reduces memory
> overhead, but also eliminates rmap costs for exclusive folios.
>=20
> Since I'm not very confident discussing technical topics in English,
> I wrote a blog post in Chinese about your patchset:
>=20
> https://mp.weixin.qq.com/s/k00tzhTl8HbL3k4G6ev4SA
The cover letter and commit messages should have been elaborated to a
much greater degree instead of making people guess the design and intent
from the code.

> I have to admit that I found the implementation quite complex and
> in need of significant improvement.

> However, I think the underlying> idea is very interesting and worth
exploring further.

No. What it is trying to achieve is ambitious, but the idea itself is
not worth exploring further as-is unless the correctness and complexity
concerns are addressed.

> I'm looking forward to seeing a v2 RFC with a cleaner and simpler
> implementation while preserving the core concept.

I'm afraid this encouragement would mislead us in the wrong direction,
where all of us end up wasting time.

There isn't much point in posting v2 without addressing fundamental
questions about the design.

> Regardless of whether it ultimately gets merged, I hope the discussion
> can continue.

Regarding the "improving the reverse mapping subsystem" topic, a more
constructive direction would be to carefully revisit the design
decisions and discuss what we can do about them (that's exactly what
Lorenzo has been doing).

But that's not the first thing I would recommend to a relatively new
contributor given that it's really complicated and even the people who
have designed and reworked the reverse mapping subsystem over the past
20+ years haven't come up with a fundamentally better design.

Reverse mapping is a frustratingly complicated subsystem. Without
carefully revisiting the current design, there is not much hope of
improving things at the design level, even slightly.

What I would recommend to new people instead is:

1) starting by reviewing other people's work, so that you have enough
time to learn the historical context and subtleties of the subsystem
without making intrusive changes (which also keeps in touch with the
community), and

2) making progress on smaller tasks with less intrusive changes, to
gradually build trust and be able to do more valuable work.

Unfortunately, looking at how this thread went, I see that the author is
now in a worse position than an entirely new contributor.

--=20
Cheers,
Harry / Hyeonggon

--------------YuOxOu3OkEnuies33ChEyi0g--

--------------bwW6faxu8TU10uSydRwBrOZz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQQQ1ub6gR5ogjaKRmOGXBN6rc5S1gUCah81iAAKCRCGXBN6rc5S
1jxVAQDM4pzeofE4dxdOjh77PA9/N7OslJ1TE4+pZBNAdPvx0AEAwjZ+A6hUR46O
dTxVf76ruthYIxyJpw0aYD6Yrw472QM=
=9zed
-----END PGP SIGNATURE-----

--------------bwW6faxu8TU10uSydRwBrOZz--
