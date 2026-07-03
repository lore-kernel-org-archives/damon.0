Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E58220687
	for <damon@lists.linux.dev>; Fri,  3 Jul 2026 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042548; cv=none; b=U9nPili/h8NKN50tkLWWpBGVxNp9Xlh56DqeXQxWmQ2SscdJYjHu29sVGHxhbl9JwDaXxSGTSKkbCk513gCpEFLjXZrkIR9Jyjhklu0fPI6F1T7IdeorwUhbpew1uVtM4CbGXGoze8d788E15LTzC9UfODKrUywWKc0ydDy6/SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042548; c=relaxed/simple;
	bh=amG2Pw5a0eapyXKEGpyor4/F0ywqco3vS7bWcAF7gHg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=d8vjIhBxs84IJ1rSErV4XtvczRDqE4hS+6kkPZr4ETdD9VIBd2k+RIGBLcs+0Pf3cjm5w8tt8eWY9RHR2KX1Lf4sx9Qr0cP2wKbT1WnsXdFxP7vVGMb0VET9wCqhCb1UmClOmqyeGErQGRmYBaaB9HxpI5FK7fWLw4ZWXlWVUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRmnczCP; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRmnczCP"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9e2489e117so29308a12.0
        for <damon@lists.linux.dev>; Thu, 02 Jul 2026 18:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783042547; x=1783647347; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kSg3nzeojJtGncTC+IVv65TYIvUH3I5uxPnaBH7ssA=;
        b=QRmnczCPCVLPdEONzipmS/qonF5rYYqLVgPs34siVGcAjDOgC4wtTJDXkgjwxOJiOq
         oFtETRLzqVntlZeol8/7sLf2NlkxixEy2mJqXa2yR65Vb7crgvkQpYo/iQvNr6XDTZJa
         TdALe8zTMVzX/ifTFF69MQP5xuLmwevdkZI8s/FF6EVM5VVyZ0y2xQBRpwmvueSsow4k
         s56s9cCKBLlZ8H7p6tI/GkaX28D0sjXiuNcsD3KbRGQlK+qg05+HIn/XQo32Z9hTG9Z1
         XJry456/u+E2HKJ4kb5sQQu9wj/V/Cqzj0NmQbrNT21pn4tsLdZzq5rfaFQ5TMXRlgoR
         fwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783042547; x=1783647347;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8kSg3nzeojJtGncTC+IVv65TYIvUH3I5uxPnaBH7ssA=;
        b=SksgrgYYGRNpA06pTokBkE2r2+lYqS88QhATJusqYMQwSfB0RDZ0meP47TqDJs84fH
         d0YX2t4touwFhuXEfHNn8/GdPjvjm4ZOltdjh6PgzLTg4TD5QZSRXPxhUGzc4PkvXDff
         SSSkYTKQncCRqyVW7z0pwAgT8or38LQXibhZ38QIMlATQvmiB0gy/LPptCO0NIqZkINa
         ZNwGou3F7blxu7fvM5kT49EoJnqPFxmccDWV8F1ek2EsjfFe3feiBTT014YbINAqCGbV
         SehrkcqWiPbxODY9vwGnaE7H1yqkDd5Vjhj/VgGzwSMiWnl7lRjCxsCZk0fF7aJ4hTYl
         hZbw==
X-Forwarded-Encrypted: i=1; AFNElJ/FGQWB5EkwyyUZAC7FkDDqrQE/nYf0efgpxOyH0jSRAeMM/6iEHSxqFKEVSDctSWojbalkVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YydOtrXiYnOqMnjIR0y4fnvBTYf+Mo47NoIVQdYxSx9AuweYicX
	FOXNETOqbRrE09Z5oT5N7Mjz/4rs+2rFIi+qD24DRXe8KPncWffigH04
X-Gm-Gg: AfdE7cnrAOBs5YK7QV24CLw9pRsRUZIXbkqh2i4PFqZhDUxZv1TXh3tVNAPeuux7jrF
	smzA8DDN8HFV9fMGPtASN4BXnTCjPr/HnMx+BM45agfNs8uKCz4ira7MgWqRmAV4o7k7lk/bQ6u
	8p7ZNcQ/dhTQpSmMYhLsw/RyZukBUx5pKhoGp0kQxAfDo/fnll2PS9pFxPBKkM6oshUMa4XiuEH
	c/Wqd2/A3MmmiN7wV43hhcSqpBmDArgqow/lrLialAXXFwTeW4xDGxK68ANpI30hEjRrZ0VAJY2
	hHbtozaXh3ICGrWgUT1uFpafkuWPlqL/gnnVjuVedHTg5iKN4Gf1fUCk7spmND2rYWfAFIC7He/
	R5SwiqqK5xKJ70MwfWy02yNSPsHEN+kw8d+neNB5L5pzEijDLyQnAKVo0lOXBnd0UTN/qsFs=
X-Received: by 2002:a05:6a20:94cf:b0:3b3:1c7b:ff7 with SMTP id adf61e73a8af0-3bfed47e012mr9720045637.46.1783042546577;
        Thu, 02 Jul 2026 18:35:46 -0700 (PDT)
Received: from smtpclient.apple ([2607:f130:0:11a::31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm13515735eec.8.2026.07.02.18.35.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2026 18:35:46 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [RESEND RFC PATCH v2 0/5] mm/damon: add mTHP collapse and split
 actions
From: wang lian <lianux.mm@gmail.com>
In-Reply-To: <akY6ZzPnwk-CToMp@lucifer>
Date: Fri, 3 Jul 2026 09:35:28 +0800
Cc: sj@kernel.org,
 damon@lists.linux.dev,
 linux-mm@kvack.org,
 daichaobing@sangfor.com.cn,
 kunwu.chan@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7759CC5-6A63-4A48-B7A6-648742A5BC12@gmail.com>
References: <20260702094633.75658-1-lianux.mm@gmail.com>
 <akY6ZzPnwk-CToMp@lucifer>
To: Lorenzo Stoakes <ljs@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi Lorenzo,

> On Jul 2, 2026, at 18:23, Lorenzo Stoakes <ljs@kernel.org> wrote:
>=20
> +cc all those you missed.
>=20
> I really need to write a bot to do this, because I'm getting a little =
tired of
> pointing this out :))
>=20
> On Thu, Jul 02, 2026 at 05:46:28PM +0800, Lian Wang wrote:
>> include/linux/damon.h      |  10 +++
>> include/linux/khugepaged.h |   9 +++
>> mm/damon/core.c            |   2 +
>> mm/damon/sysfs-schemes.c   |  77 ++++++++++++++++++++++
>> mm/damon/vaddr.c           | 128 =
+++++++++++++++++++++++++++++++++++++
>> mm/khugepaged.c            |  46 +++++++++++++
>> 6 files changed, 272 insertions(+)
>=20
> You are doing damon changes, and that belongs to SJ, sure.
>=20
> But you're also changing core THP code? Please ensure you cc- THP =
people because
> without our approval this cannot be merged:
>=20
> $ scripts/get_maintainer.pl =
20260702094633.75658-1-lianux.mm@gmail.com.mbx
> SJ Park <sj@kernel.org> (maintainer:DAMON)
> Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY =
MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> David Hildenbrand <david@kernel.org> (maintainer:MEMORY MANAGEMENT - =
THP (TRANSPARENT HUGE PAGE))
> Lorenzo Stoakes <ljs@kernel.org> (maintainer:MEMORY MANAGEMENT - THP =
(TRANSPARENT HUGE PAGE))
> Zi Yan <ziy@nvidia.com> (reviewer:MEMORY MANAGEMENT - THP (TRANSPARENT =
HUGE PAGE))
> Baolin Wang <baolin.wang@linux.alibaba.com> (reviewer:MEMORY =
MANAGEMENT - THP (TRANSPARENT HUGE PAGE))
> "Liam R. Howlett" <liam@infradead.org> (reviewer:MEMORY MANAGEMENT - =
THP (TRANSPARENT HUGE PAGE))
> Nico Pache <npache@redhat.com> (reviewer:MEMORY MANAGEMENT - THP =
(TRANSPARENT HUGE PAGE))
> Ryan Roberts <ryan.roberts@arm.com> (reviewer:MEMORY MANAGEMENT - THP =
(TRANSPARENT HUGE PAGE))
> Dev Jain <dev.jain@arm.com> (reviewer:MEMORY MANAGEMENT - THP =
(TRANSPARENT HUGE PAGE))
> Barry Song <baohua@kernel.org> (reviewer:MEMORY MANAGEMENT - THP =
(TRANSPARENT HUGE PAGE))
> Lance Yang <lance.yang@linux.dev> (reviewer:MEMORY MANAGEMENT - THP =
(TRANSPARENT HUGE PAGE))
> damon@lists.linux.dev (open list:DAMON)
> linux-mm@kvack.org (open list:DAMON)
> linux-kernel@vger.kernel.org (open list)
>=20
>>=20
>> --
>> 2.50.1 (Apple Git-155)
>>=20
>=20
Thank you for pointing this out again, and I deeply appreciate
all the tedious work you do as a maintainer to keep the mailing
lists aligned.

As a newcomer trying to transition into complex feature
development, I must admit my initial design is far from perfect.
I leveraged AI tools to assist with certain implementation
paths, and although I extensively self-reviewed, tested, and
reasoned through every single line of code, your and SJ's
feedback clearly shows there are still major architectural
flaws.  Just like my very first kernel patch -- which was
strictly reviewed and guided by you and David H. -- I know that
your sharp feedback is exactly what will help me grow as a
kernel engineer.

I will completely step back and radically rethink the design of
this series, especially regarding the cross-subsystem
encapsulation and locking hazards.

As for that bot you mentioned getting tired of running manually
-- let me write it for you.  An imperfect newcomer who just made
these exact mistakes knows precisely where the traps are.  I can
craft a pre-flight patch check script or a CI bot that
automatically validates the get_maintainer.pl output against the
patch file diffstat before any email is dispatched, throwing a
loud warning if core MM files are touched but their respective
maintainers are missing from the CC line.

What do you think?  I would love to build this tool to save your
and other maintainers' valuable time in the future.

Thanks again for steering me in the right direction!

Best regards,
Wang Lian
> Thanks, Lorenzo

