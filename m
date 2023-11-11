Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC81855
	for <damon@lists.linux.dev>; Sat, 11 Nov 2023 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gajzC/mr"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-66d76904928so16198676d6.2
        for <damon@lists.linux.dev>; Fri, 10 Nov 2023 16:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699662874; x=1700267674; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C7o/f+L7uo4NWltZBaeo9zpZA8oTQ6ntV0FIDWJnuE=;
        b=gajzC/mr5kgE078du4+Me35pepcAHVuTGHI6tWa5a5p9+d/00a+IvQw5hMxFUsZvKn
         aCEo7joHcaIuJ0C63/EFe3PwLqXP4JUMHAqcTCIZwI5q4FxY9ZL3xKfFTKLZWM0uO3bO
         C00UpiJj5aSgofkEyeD2regsCf3oink/zOZiHyCV/iL+XEFCbGb27Q6PIVpLjAM5CaEc
         o556RjuBO4aBaBNhe8JKXxo8U3WASoBcc9BdIVaR7+HPk+ub36YAGj6kfUCbkcCEU4ub
         pAaYNxNIgxaYLYNIP5WH6ibWNzZaNZq+tQNVra+DAryRmz9rOHHOPoUqpMxjjl0ChRwi
         ZDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699662874; x=1700267674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0C7o/f+L7uo4NWltZBaeo9zpZA8oTQ6ntV0FIDWJnuE=;
        b=FwJwLwi10DROXi2DIxUbyagMsELErScOrrL/OCOR8pFM+2eUNuqgCNhf320hUomE3m
         pr2UmznnsCc7GjYsrfGZsqCVMvX3vBEjE1ofCWLsYEJcgJqN59tO3fAjS6XiDCEf8ylb
         14tJzNKkW/Gxp+AEKh6AqKGt3+IIz3gWZF03vqxSre8aXjEFb5zWUZ06jTDE6TvcJrsu
         hukjKeZSnMrKSBaWUaC5d0fccoFuXrw7+C3Qw0fYWQIDOGSfgp6J2M93m07LCWE9tG5b
         IT12UpmhmskL8I0Dhk9v9JkI9o0EwlCrUj4XbMW/Vr5OhyHQkkAtH9cxnypadOecb5+3
         dPhQ==
X-Gm-Message-State: AOJu0Yxr3LOfAakegXUY71Msqoq4iQusFw/Dlk0yB7fda83n4Sh2huOI
	flnJZ2fPAhmwwSqyZ5MCYGiBA04sp+KjQNyDr/k=
X-Google-Smtp-Source: AGHT+IHIh4UqMHAwsou0uBfJPV39V5EK2cOgk5wYssTsPnP1IxmFVRcptuEsKm9ZjEGxa7vIVMqs4/KdSxwhmNe4HUI=
X-Received: by 2002:a0c:e805:0:b0:670:710f:2042 with SMTP id
 y5-20020a0ce805000000b00670710f2042mr939501qvn.15.1699662874672; Fri, 10 Nov
 2023 16:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1699594629-3816-1-git-send-email-hyeongtak.ji@gmail.com>
 <20231110182240.65426-1-sj@kernel.org> <20231110103122.21d5fb5f3d60f1f4f5bd143f@linux-foundation.org>
In-Reply-To: <20231110103122.21d5fb5f3d60f1f4f5bd143f@linux-foundation.org>
From: Hyeongtak Ji <hyeongtak.ji@gmail.com>
Date: Sat, 11 Nov 2023 09:34:24 +0900
Message-ID: <CAFY0u4RTPbx1qYgESignpnLb71oVqLg8xZoqfO8genoOnSJf5A@mail.gmail.com>
Subject: Re: [PATCH] mm/damon/core.c: avoid unintentional filtering out of schemes
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hyeongtak Ji <hyeongtak.ji@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 3:31=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 10 Nov 2023 18:22:40 +0000 SeongJae Park <sj@kernel.org> wrote:
>
> > Hello Hyueongtak,
> >
> > On Fri, 10 Nov 2023 14:37:09 +0900 Hyeongtak Ji <hyeongtak.ji@gmail.com=
> wrote:
> >
> > > The function '__damos_filter_out()' causes DAMON to always filter out
> > > schemes whose filter type is anon or memcg if its matching value is s=
et
> > > to false.
> > >
> > > This commit addresses the issue by ensuring that '__damos_filter_out(=
)'
> > > no longer applies to filters whose type is 'anon' or 'memcg'.
> >
> > Nice catch, thank you!
> >
> > checkpatch.pl shows one warning, though:
> >
> >     WARNING: From:/Signed-off-by: email address mismatch: 'From: Hyeong=
tak Ji <hyeongtak.ji@gmail.com>' !=3D 'Signed-off-by: Hyeongtak Ji <hyeongt=
ak.ji@sk.com>'
>
> This can be addressed by including an explicit From: line at start of
> changelog.  Which should we use?

Please use <hyeongtak.ji@sk.com> if it's possible.

>
> > >
> > > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> >
> > Reviewed-by: SeongJae Park <sj@kernel.org>
>
> I'll add
>
> Fixes: ab9bda001b681 ("mm/damon/core: introduce address range type damos =
filter")
> Cc: <stable@vger.kernel.org>
>
