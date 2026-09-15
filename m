Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA23DB333
	for <damon@lists.linux.dev>; Tue, 15 Sep 2026 02:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439992; cv=pass; b=TczMaCfrqwVMR1mrMXHto0omNwtZWG8w2srtT2GFhwDI+marR9eTL4oBZRui+jJh/18w7n17t/4YwL+ndNjMkEbiNofiavG+ixKJIEMcZpOrSE20M9hEDf9HMQ/RaoaLRZ3McObZfx5cR4UqquQL4wXbNy8UUKTPNR5IHF/iD+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439992; c=relaxed/simple;
	bh=eKLUaFl3MY3wwrqb6j5IuVvJPNafZ/2V9PYh3wKn53U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kV7/s/VDBH7knqV2RREeKLkn70qOfbtP3pvbBC8oqLm/Q0kOceRJowFoFue3KfSTqeUwiEjXvX7hcw5Pr/2mc11zCkpW/PBYUg6nOEvsW7n2p8Ylr+J/xYKwcseEhNya/jP0GXuHKPZKID69uHOZBFCLYbh6rCo9j/tH5Rz43bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvYmBTjc; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvYmBTjc"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso31453305e9.2
        for <damon@lists.linux.dev>; Mon, 14 Sep 2026 19:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789439987; cv=none;
        d=google.com; s=arc-20260327;
        b=KgPzYBhW3wwFRiFXRx0TS24I9dPNAdhg8EkD1QjiNicoTJHftTWslL1C1ZpdYd2caj
         J6xLFPUH/1uD6HmjoC5dMIGCN4Lu8yYuMRyhAeVCXfyB5OG6UjjucTNIEcx4MQXfdmgY
         wH8esNllEUOf7ivUo1N15gbc18bOlHz0i1nxqifv+3Swlvjdt33NpVg/AOckR1gCHWcg
         chpV4ktbmn4le+gOMH+q8ePAMZDtAUy5KsyRtmvqJQ93c6IDJJptbskK5c3f6oq/FJxR
         +E3jNJE+LPBR/ym/lPJyKm6pWDEOO2Q9pl+CFHWxHYItPtT+UngC8BbtU4pY8OJ10PDD
         PYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2jmDylHBt6Z/mwGiXz/nmJJJ0KqybZ3pQ4MP3rJZ7V4=;
        fh=aVl1y3Mt4Svm7Sl+vT96rpqQMEJp9zNCgoaDzkFn+WE=;
        b=k0WWJeN7v3JGo07gd5kLJzoVnQYbTTQhZaac/goSJsc1eK1XYjUSc5toIQyDggz0LT
         wjFY1hYgPTRtikID/crWH4joJ99RgcantOBkaZH+/uNMUkf1yrEFpCebwEPhRybeDE2Z
         OypzGCmxpSiMLBatZhn8pcax8tjiSnM6MU6u4uhwlLfGCC8m0rNB+twuZSlaz8e3R+Ug
         wPL6Z6TqpLjfKzOjpsBQLP1sV/WkESCw7vrWaVYenOnVfzzpJKpJbHOgjiHLluE6Rvbb
         CIknO+bwb3W2gVWrOMcPcn32lUXfanC+vykBIjxGnyZHv4DHfOq05i6bdDb6BefRERBE
         M2pQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789439987; x=1790044787; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2jmDylHBt6Z/mwGiXz/nmJJJ0KqybZ3pQ4MP3rJZ7V4=;
        b=RvYmBTjcvC5PbC+J8+1W61soT/ZZ2YwLtM6jj8AY8Fo45xXVnRQKT8TiHqFHNR5Ebh
         0DFCmAymv5bQILiAepD1yjJQ4V2AbX7zNNUaoqU0T1JMWzg0jR/WL7KSc4y5S6Gti4iw
         OpRTWuiVKmRkVLVS/pk5wsjWpJ5A9MONneeYSBCn8cuqunBnUpdnJT2ET92RGJQzVNfD
         ryKN3vI9kuSjFItJOHYnzOe7gF5qX2TwoBv3Mm4GAtk4qReV8i3O0GPzeWpBZXGmsYd0
         Ygicg8ai+ORzMFIxW6JiHPr7QyHCkUPhPqZBzltAq+tqt1XD+/Lzb9P6NOojWNKGewUp
         Sahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789439987; x=1790044787;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2jmDylHBt6Z/mwGiXz/nmJJJ0KqybZ3pQ4MP3rJZ7V4=;
        b=NVSRvUvSHwZz04L0PVBH6WyQadaAzzlfsQJHBHuXHDyfc7X6rTWMTWEFSXyZOOX/+e
         kPR6GgAT69ujk/G9JPymjyuObahRFhu5C3k6QWnUH+yqugkIe9UAQK7eadqlbEQn0NPB
         SE4yWHkXWpM8VSrgAYWLl4zJsbmm+ES2a9DYFPNgXQiW3APl/SX3jfZQdRX4mm2yMrFe
         vi5+fifD7+pN4iGp3fiJ0+IBXL36rTcoi11zPuzcBXL2pz0LJYFpK95xgfFvIYOfYjpj
         r5W26qFECGyP3oZEwEpqoHSBfpdunlEsLPLy1B77lKl6B05ISVKag34gMRBaVOTcl+2q
         3xYw==
X-Forwarded-Encrypted: i=1; AKwUvBwqihbCP+jMpUW36JIQh/4n3pRRdY/kzarl9zYTk8xk20dSoIArvhWDIGm7hVmRLltIWq276w==@lists.linux.dev
X-Gm-Message-State: AFuF++nemz0fv+SCpE9yFvzo/MObt44jbk6szBNxiegZOWDjvUHl2pLb
	TBv6GBCgG6qmbOwIR2wewtzqPobzjWdxbkYXVVE72MNUBWY70T6pj2wuEfbv5/OmTpzPit6fTku
	aXKA4ohtHCegob5Az+G+TcPUE2RkjPo8=
X-Gm-Gg: AYBFou2XGPO926D2yrfYn/8CPw2NVuiP1gdfcLBa+lPzXW1T/fum16H+c9kt2bqPu6+
	KwdzOYBEAiCR3LnZ+jgjfil782kC+mPvCjk/PVSGENly2sP3FsSpbpSeckH2bUjKkG9jd+uHhn5
	0kr8mBNwG+adb1f0RPV0J1zamLTMa/aVGKxMgArb6gseUgOkSUDbjmxRZwFrau+GkiNL0QYrXR3
	yl9pA8F7rImB8oChMyMTpf5StzNxbH30r84T6kwJT4BdMWbgrCrsJuo1f8qyjcXK64Kubvojv3z
	76ofBHylsUWoMUAhtRqAVvJK6T/BdOFWtkBqe7ZzHlrtwiC31/QFc9pqGY1PCy+0sLfPf+oWgsO
	57nUciT25LUbz7OpTbuJYGzBB
X-Received: by 2002:a05:600c:3548:b0:49e:602a:b4ec with SMTP id
 5b1f17b1804b1-49e7a656bf6mr108019915e9.8.1789439986429; Mon, 14 Sep 2026
 19:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260914155729.1518105-1-kunwu.chan@gmail.com> <20260914234924.100335-1-sj@kernel.org>
In-Reply-To: <20260914234924.100335-1-sj@kernel.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 15 Sep 2026 10:39:35 +0800
X-Gm-Features: AcwNN1Uk_DUdhz76I0hRVSRZulITZWPos7_upPjkw2hrucXG5m-I4GLxm605D_A
Message-ID: <CAN_Opa-cJDOOtQo+24kSrO6E9khoJuD3wzHZxcgAWZrrSOOSqw@mail.gmail.com>
Subject: Re: [RFC PATCH 8/8] mm/damon/core-kunit: test invalid damos filter commits
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@davidgow.net>, damon@lists.linux.dev, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, lianux.mm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 7:49=E2=80=AFAM SJ Park <sj@kernel.org> wrote:
>
> Hi Kunwu,
>
> On Mon, 14 Sep 2026 23:57:27 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrot=
e:
>
> > On Sat, 12 Sep 2026 12:18:06 -0700 SJ Park <sj@kernel.org> wrote:
> >
> > > Add test cases for testing the validation of damos filter arguments i=
n
> > > commit time.
> [...]
> > Could we also test an invalid PROBE_HITS_WSUM range here?
> >
> > Patch 4 adds the same max < min validation for
> > DAMOS_FILTER_TYPE_PROBE_HITS_WSUM, but this test only covers
> > ADDR and HUGEPAGE_SIZE.
>
> I agree it is better to add a test.  But not necessarily together with th=
is
> series, in my humble opinion.  I am separately working on the test.

Thanks, SJ. Sounds good to me.

>
>
> Thanks,
> SJ
>
> [...]
