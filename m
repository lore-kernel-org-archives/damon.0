Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.199
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795360121;
	b=Ly6TbMmlPNCREydE0XfiUA5Kvf+3n4hA+XtmtXJc4Yb1fxctYrzMghZooLSzbeGBCtDz
	 XYW4qeaZZTAriBc93w5UelGhrfSs+vnlQGU/4yEbP6+RDpPAsgDZZ7PTPNG5k3LtgsMSo
	 u/K7NKo+lUsK8CPZu6ezkt9thysxENhe+yJe3X/EJuSgsoe5yMbY3yZdo//XD82jsyWLQ
	 t5kNYmHNruET77hDjrkxmBdIoD/hFowzMj/YCjI04rfitO5k6lwUYyEPA4K8GCFgNiZ6g
	 HQ69uskLHVEf6MKSt0gQ6W3bPO8UyMgPJrwXgkhHRqiMmoPE246OuIEqA3YHIZjtXTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795360121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IgthaxTJeqjgkIgsu2LWRipxKF3WuNFf5m2ROqkfnrk=;
	b=amSG8F0khz6pMmf078UNMRJvr3hv0Hakd21QGpfR640GpC/wintN6ppDjhh41A2lg+o3
	 M7HQarCSIv3qQ/LtzcBF9zPPxKCzSEBxUBUvdEUlgXYMr/1MEWNNLEF+YN94p3wxr8BzS
	 oMruD4QxqPZd0QbLrL4YNgyr26pje4hqnCnGjEz5phYaqlhwkVz6MC0UNtARooSh4Vzom
	 VgTgC6w+0uOHtUJjAIe1AKWToREDq7+/2PFNijkUMMsmsHSyYaqd5IMnh5sAjWPZMykEM
	 IpOQZrcTQQ+RPjcpbnbH/6ce6fa2YeiqsoEfrdEtvyUy4LG6FMYA+cWKWL/7E0qapbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PrmlQneQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.199
Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EEC606A320
	for <damon@lists.linux.dev>; Sun, 22 Nov 2026 15:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64EEC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PrmlQneQ
Received: by mail-oi2-f7.google.com with SMTP id 5614622812f47-4b39374fab5so884835b6e.1
        for <damon@lists.linux.dev>; Sun, 22 Nov 2026 07:08:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795360120; cv=none;
        d=google.com; s=arc-20260327;
        b=NoY07tJVzQ3/pD2SGTAwdXvu21u7rH7Njba4g3fpr2vaPghefdwo8DG8cSyfgCXqar
         ugSClWTZ4O94iKkDE9yloSMErZ/dD7N4Rk3VEp/zyAfHld4X5emnujVfDbMgEHkknzEI
         +JZAQmc78EIv9Yjizp2acFH5NGR0BX39m270g+lZJabYBmqnKJCeQwzfpCDwz4/ff3LF
         wtDUnZDRF5xu4fIretAjn/+gxJ8WEGopyIyRxZUzApYE3rUKVnMzY+DGSpWfwp14ecS2
         WntO8xcMZUSEy60JUay5Fw34+Lz4x5MAz8RGcWYM3C+QluePBmvQxIzuTF7VYadIqoPm
         wIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IgthaxTJeqjgkIgsu2LWRipxKF3WuNFf5m2ROqkfnrk=;
        fh=InKRwrGOYJa0bywgphCZIr2w64trlUlfj/zYgGVsHS0=;
        b=P3gwLo3TG/NkTINDuYr8BBylya3AQ4zBGfJIF8qJ+tkfRmOsmHhZpMQB/WCxhReef+
         NoHe4TOleIyV5RAml8xhvFvnTnL1T/30Rn4Lb0LtfZZqWQbNxo+XRfPp5PL/wTfJGTvc
         nDx+h8jpcdfQtEO8uxMsxO6l/+GyycI7K1G8UCnqWVx96aEiUO/3L4GACsfLV49/sMo1
         NS7ZlAndHdljdb3d152sEhkJXv6TfNZBaSm02SKdaTYjX7++r7IgDUZl0CFLN4X1RoIy
         k/ZXn4+vwQoifAXN9B17pUwc5z+BlBS24ksao0ei0xHnJdkI/BFjy9DAs/rCoHL58gg8
         dj1Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795360120; x=1795964920; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IgthaxTJeqjgkIgsu2LWRipxKF3WuNFf5m2ROqkfnrk=;
        b=PrmlQneQ0oaNUOW/SZeRLPc0B6867Ckttu+ge1idUlzSUPlC//aCwbv1PWlJsdWKvM
         +RjgSO4He7Bb5bpC7Kg7wfGkL3tuJH5+SKNYTlMzabi6ruKrx/S9jOekYtJ7zuS0ee3X
         ZRL1iDBQLQ/vb46hs9v6Fi0+O91r5O4fm6hxdULVfj6Lpvft7yuQoN28TJzjRoXducDa
         gtNdpev0ddoFftlYtmBxy9njRpeqcMzoj7fCcDRniKqk5GXMhxxGSeHEVkxRc1TvvL8s
         whLkREYcC9093JIzlSNS3qRnJPTdMNU3bdzs4Xv1kIH5ALoah5eXvkFO522Kz266xwxV
         Elmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795360120; x=1795964920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IgthaxTJeqjgkIgsu2LWRipxKF3WuNFf5m2ROqkfnrk=;
        b=kWdDqdbQk0bKXlYtZQY33r+3wlVKzc34Ku0msNwoAXw4hVUuAO8Vnj3miH264+tRJA
         zCCRaUvIo6R7EyvcJEQC9Yb83NFt3ozmupHK/CLsa211ygrcHyzJS+o8e0PHD3hJS6TY
         qvLzKPgcOc2RAQOjvEi6saJVfYB65g/QiutdfEofRAicGmf7Rt1PtG9s/n7IZb3RvTIy
         lL1jhPKaFGJ/8yXUqx0LZMrAox4TVlIkkrFVrZ89Jj2hXJxpDOcCn72xoZ5exCwNW7wr
         xkj10kU461jvbdy9scBsha1luhXH/zkItz+gp67J8BYx8SIm4HqrS/ha2lN04x4c90Rv
         5kSQ==
X-Forwarded-Encrypted: i=1; AL+hErHUen6n6l7NLjKr0XKfukm5qJq+dRmkKO5gDWqB+wK5yqt/8l2d7TTfcCD5RgcLpps9yIgL5Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z8lkXvorJqBVkPu3tXJaCzwtJVyn5tZsWsvNQx1aFsUR8UI95/T
	dB9MO6j4QsOFwu32boLQbMFDuL5G9o93FeTVXSl06jKaB48mzo3Tca/4W88EaHmx9qVUNZDiuxT
	FkxVuu6tg/bBbxy/5bKlKTkZ/KCXsF5bFYwUnfQHJmN4s
X-Gm-Gg: AZFdTZfd6xG2z/SYNjf5EiTYJ47t3RMIpsHQ9DUkkD+g+99tFWM7egNy2d5nPxVl6gv
	fVESdmWL5/ycEPlNr51I7kpvPdPWTGU67bVKXcgcpDn9Ww0BGjPOlqZXd/LOpa8NrQ7Ss6UU2/0
	uy1q+E/gTtu316ws2KD74t7WkLgUH9Y+iA7wHZdoZoKw01jn7he7PhVoz28Xsjw517jDBbFiDev
	xHitHVWMrxbV3HFcNag+g+CIGT03PIcCzWLBrHLGzHd5mq62KnGNHKg/mYZpqbNwHnoyIhH4XsF
	FE1hUtd3iLTB/GSaxahdYozYSky6DChIZIpFrL8+0uPvMzs4ytLAe87Mze56mjYwKuon095I2LP
	qQIUQxAB05s2FbNaQCXjvgQe4EoP2VbfXfYFzdWq5Ra9rmDpGxRLrkSPPiVL4Oqwa4lN2Q5mxq0
	HhMT1zOk5L2yNWNgS4aUR6nRm+C8P5
X-Received: by 2002:a05:6808:6404:b0:55c:836:5955 with SMTP id
 5614622812f47-57a0bb6ee75mr8984155b6e.44.1795360120208; Sun, 22 Nov 2026
 07:08:40 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-2-sj@kernel.org>
In-Reply-To: <20261121210013.130397-2-sj@kernel.org>
From: Aveline Noir <jm5905938@gmail.com>
Date: Mon, 23 Nov 2026 02:08:27 +1100
X-Gm-Features: Aa3M54pWq4nvTo_Vd5jmEckUB6yZoob1KXNjUOEmdWFeILaYTD3zwarplSlMKK0
Message-ID: <CANOyQmFJz37C9dvnAiNzpbt652iNbLE-mLnBWPBoS6efm7zn2g@mail.gmail.com>
Subject: Re: [PATCH 01/27] mm/damon/api: introduce struct damon_report
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	lianux.mm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SJ,

On Sun, Nov 22, 2026 at 8:00=E2=80=AFAM SJ Park <sj@kernel.org> wrote:
> Define a struct for data attribute report.  The struct provides public
> fields for the type and the memory address range.  The type field
> represents the type of the report itself.  The address range is for the
> memory of the reporting data.  Data attribute producers can format their
> report using those fields.

LGTM so:

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
