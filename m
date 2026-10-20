Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792466532;
	b=rUXDyIyvCns0uAm+TTJL+fpC/LwXXmETzponc8y8hw1cy8XTYc3J7f33FPer47mg8ieb
	 bmzQKqk7Ztxxwk/xc4bgBxuOJDV5bQwbkH1VihMT0ox6uAALUZKG8053uRj8Jvn0J7Fyh
	 tSBH6tC9Zc7ueCKqv9RJNq8DwvqswypN00Vqk9pBaUH7CYSlSp4suwe3SlLhtb8ERKrDD
	 He5q/Ye8lwZ+I39CU2+PEqxDDXj7Mh9uwV1HxKGH0g3kQmBJ61J6d0GLJeDYYl9w4A6Cw
	 fRpIsIYG+nAS/h7JmqLSr+j6fVhx+5RPbLE3g1dIGK6cp9mSN+LIDSY0Rq1UtwubEoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792466532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GJ0jzd45ePDV29eKZJ4sBGXJjhUAwze4eIfc7K86wG8=;
	b=O3U9LgxiFzL8UWQkgrvRdGdbGZicL64L21GsN7lP5kUomdOMmr+IHrygSbbgVy59AVq8
	 cqrX46OHPfLqfmUC9HyeMxpx107znYNsqbqh9SGyGCaQ+D3ETvDzK2d/Ihewr93X/aHAF
	 Dogd1RkKtQzqz/eJvpwravo38LjDpCDiNkjQe9XiSmxaqGrk/RqrvoOW0q/UBndIISnwR
	 ALlsK5Zg8F9BMoWaijei0neNJltw8asFee0Z73JVZlT59I5L4HJpvfeQ4XloYj5/gzDhR
	 31i91M4THjDZjSxWwES5NCWUWX6wHrTJNZ8bCF/e4Lyc93kypaPSkrc8qZRwZ39iSYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FwLNgaOG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFE606A319
	for <damon@lists.linux.dev>; Tue, 20 Oct 2026 03:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1CFE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FwLNgaOG
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so2400625e9.0
        for <damon@lists.linux.dev>; Mon, 19 Oct 2026 20:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792466530; cv=none;
        d=google.com; s=arc-20260327;
        b=JAIusRM5jJdeQ65zSwUujlIOrbNHQI9KCxEUCgYIMFa/I5Dhx09+W42BbiPBZ+7pvF
         hCZoXwwKCa/r9d8qo6xQqcgG4GmiIMP9aIzIkRfRru9UNqGTf7CZpJ5Nzd/ShS7Qbbxt
         sh5t0x5jJRPAXIDguTTZQXXdmW5cWyC0Hb3KNxqgk2IyQ5CKRluQnTCv9gFx5pmdO8DC
         qaUGI3nv5BtuJcJrYQ+5BrdUL9cDx27YBvg70hP1eSpGJjAeTAEh0j4/w4EJ763k8mNp
         ZleMgqnCR8ENmMxvxhnKoxa//5bZXuWKyDtoJlhNjQ/2G2jaoLUCugvONS/hzQqXI7KO
         dUKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GJ0jzd45ePDV29eKZJ4sBGXJjhUAwze4eIfc7K86wG8=;
        fh=4W9BZJvYS5vQwEIkVP16JXA5S+Wl2hO71CmQPtUwnxU=;
        b=iTKmI29sI0XlHQ7bDdVg8PZT6PgqRBqu3884PjnT/i4q22Zgojj9VS+af+F41GPNLs
         nbXmzdeWh3ACcOQIzqS4As4YPLzm4eEPwHeRQ6MAn9TXvxKbjFLyLVIJJ6QfLhYq36e4
         vcJwyWXIBKwoW67UwXRZeE1fH325SLJ+xsZHkexhP4aeTLoyiP6WCEaS7zPRxx7RaMqB
         YIiYm5EbgFsHV0SDhefpC9lUizTt0YtTX5JnfKcN3hTV/QD7rVF/KTRddkXzyNvd/imn
         PTQGjNPeo6X+/GPyjvFCLB6U+03g1+/Ia5808cvmK6aXxAcclANCi+lXG1sXkeg6spE0
         Wldg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792466530; x=1793071330; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GJ0jzd45ePDV29eKZJ4sBGXJjhUAwze4eIfc7K86wG8=;
        b=FwLNgaOGQ8zJZ3dJGNUUiaFB8TX+iYGm8wUYMOeJw9kc9LqFJDh+bt9A8RDsiDD0Pz
         diuXBhBJ0dTr0+opoMaWT8h95wwBks5tJDlWR2rw6PFfNlV7xKZQACx52qqKjYQkFjV7
         W+ScM6UbLm2o7wPkfJLo5GmH34veM4IbMTGL36vIKX4cTlIZIHF+so4UJsl8oTqO/1Jx
         lw11nkE6Qoq9f4R6TaYgtxHIgCOwEIYerFRx/ERJGf7TXSxpj+ScBH9MJ2SKg6bnsdo9
         pjTxYibXzW/0fTRk+JTCgQ3vVB8APtxqR4KYcfrxmSS72KA+0HlTkJ2W7s0Lx3o7Jll0
         v3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792466530; x=1793071330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJ0jzd45ePDV29eKZJ4sBGXJjhUAwze4eIfc7K86wG8=;
        b=PTjKJe0zdbcGfTxs4FsG/biDcjB5LzXMa+MEqkdja4R3TuzNp+uXXjx5K0GvlXCQWH
         sV0gPgoHwgmlcbdOKszGnjXKW5hEOrVHBsLd1ceI4oHowgvbVJnR8IGCZVQlNXoTc6bn
         /5TCc4dBI3WHRS2zJGdLQgIUWoNGK5/mwVlPDf4sZ0xxae4vy356EBFwLiBYFAXL3BpQ
         Tc5AmfgJIMvD9eQ+YHwZBAUlXte+d2mbTqhE3auFUv1d+YCc8ZKqGljx0fjXyFyTrCO+
         gNFnS8C6QorV29TP6mt4PkNJzw2SpantkkWqwwam20ZCQ/Cc7WuLIy1kc7cPt3MEKBz2
         oqvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWIzWoH7pXEiUakSAZTbZ6FJcrXjc2bxHSp8UvSlrbO7ZxILlAOO1qLqlpMYbj6xhORXrn+A==@lists.linux.dev
X-Gm-Message-State: AFq9FYLpqBzufQ3pXe/MaDHw6LB9BEiKJ3naSWfeGhjT3XgxTXzZvKgJ
	RXZoUgMU/w2oFgzSBJymF49O4B5vJnReHzrXQmJ2YZXdqwKJGeAedPZp7hCXfy5fWkP4ofgdZR4
	weCuf3kMSn5M57CFX2bfrcyFQEkXOqBI=
X-Gm-Gg: AYBFou1CyYQe0+3/JYIye1A05sJ9h2ZYogKmolTV8LMOlJZUbGRzR+YzqNJAyDnj+yR
	f9kCptXmcvJRuO9lJIS0yCGnjB8ATJoBx6l6u+dTsgyMVg1noqDpO70F4bgSKzJ1JAunY9KYZ9W
	O/F4klmxSzPrStJHtq5YMmOnDTbnW0h16AIkO7UhUxCeV1ts5L/mKMJHjMteYrwhSWLvp8STRSP
	mHPiXpKRGGkZisQXMfukTtlOkJ1wQTAWT5LbazH7MOujXHebroHVMjGKV2jG6Os+9O7D88sOXod
	HNPhXL8aIyWeddzz5NlPn7J4m6dy6Q0mcPjjxJSI4HYeFWDDmz195iTIDD38Oqmp/Iu6bHMJxo4
	kEGy24DXiKo13
X-Received: by 2002:a05:600c:4455:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4a1f50a260amr15362205e9.17.1792466529668; Mon, 19 Oct 2026
 20:22:09 -0700 (PDT)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261003-damon-perf-rfc-v3-send-2026-10-03-v3-2-0f00417b41bc@gmail.com>
 <20261004083036.613169-1-kunwu.chan@gmail.com> <CALa+Y17BOR0DBLS9-vns2SQfRhCueT0f82XCVojHhg9uacOX+w@mail.gmail.com>
In-Reply-To: <CALa+Y17BOR0DBLS9-vns2SQfRhCueT0f82XCVojHhg9uacOX+w@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 20 Oct 2026 11:21:58 +0800
X-Gm-Features: AclHuK8qSfFyajdptQhJ0NGpKFtfIDqK4tiHr-fgZMp9gM24ujXx87HbJLiQhf8
Message-ID: <CAN_Opa9=5dqD7CUpczUAz67HjmvUYE5vLMSgSVqzcKLAcjVxng@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/9] mm/damon/core: replace the access report
 buffer with per-context rings
To: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Cc: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Gregory Price <gourry@gourry.net>, David Rientjes <rientjes@google.com>, Wei Xu <weixugc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[...]
>
> So in v4 [1] the drain no longer touches nr_accesses at all; its scale
> stays with the access check primitives, independent of the PMU and its
> sampling settings.  A sample instead raises the region's probe_hits[]

Thanks, Ravi. Separating PMU samples from nr_accesses sounds reasonable.
I haven=E2=80=99t had a chance to review v4 yet, but I=E2=80=99ll take a cl=
oser look when I get
some time.

Thanks,
Kunwu
[...]
