Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F7DDBF
	for <damon@lists.linux.dev>; Tue,  8 Aug 2023 09:59:25 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99bcf2de59cso799814166b.0
        for <damon@lists.linux.dev>; Tue, 08 Aug 2023 02:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691488764; x=1692093564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj2ai9zvS+9QZOskCM8RXfhgWWD2kjSbmwS4f6JevAw=;
        b=REfFB6xxXyunKIxjea/FR6SFY2a1L7wAPVaHVDbWmFulGyGx+Ri7avf/nbzBosqq7q
         FUmH05AE6N6ARunU/HUohq1g1KLoCqT13s8MvQ8NlbRSfEG8nZzHMHsMiW3tzQ9GG3d3
         LNbp0tZ9h9HF7pzYfUGd0JnFDdFTidwI9FlVFbNPQmmZ5g6/WFN9zXZKf8ApoCA9rEqj
         2Fmv4Ugj8+OPy/LrkVFSFS0v31r7l8ujkK2rmwAqWjdP07XMD8ZI+KHXlgm9yDmIO6PZ
         wJEt+jx/X762tXjSeCzOFN76OZeJqCuRsFUXZdKzBmLQ7AshXmjUO+/jDc5xAytH198K
         aMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691488764; x=1692093564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oj2ai9zvS+9QZOskCM8RXfhgWWD2kjSbmwS4f6JevAw=;
        b=XPnEYBkYsYxdzKibI3L+f5STsroNLgcFJVCzGYKNHFFmWykcog4ME7IaLJJ16hanO/
         tNFk3i7dSMFsD+HmDJrpY23CI9fziukaiFwRGf5kfl64MjqHwauy0/gfPDPbhv0AIZLv
         TYLoAfN4bY+05YYFwE5QW2vON4NNTpauaEwmpXQ+PieU2uP8SGPubWjJSkPSEBMcbdb5
         d5GUfd8M74emzY9h28PgAzorlc4YuQUe1I/joX/ZQHL4dmsg4DocbXX7pBDShaez4ChQ
         plIdO6ZT8rf+zxTokkMRbw/rLzKy0/yowqgFR+6Hoepn4sBmhxMHfOUNMJxavDwgk4ZX
         mHvQ==
X-Gm-Message-State: AOJu0Yy0kkf1eQDLARCgYnpbJhatzdIzB2nskAKHTZ9uhcTevzgGT87p
	H1TRyVBdojhl3lUp7i52hu/bd0Tc2mBxPlsAIu8=
X-Google-Smtp-Source: AGHT+IFfju5o1lWIv3wyfHE+qyETz1vJSnBk2q+GZQ6BY2VK2b4Baqqt+9vLWQ3xkBaRGglOIQJ0QqulvLM+5Af0FWA=
X-Received: by 2002:a17:906:109b:b0:99b:d977:c00c with SMTP id
 u27-20020a170906109b00b0099bd977c00cmr10395304eju.45.1691488763617; Tue, 08
 Aug 2023 02:59:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1691401475-3796-1-git-send-email-hyeongtak.ji@gmail.com> <20230807181409.97310-1-sj@kernel.org>
In-Reply-To: <20230807181409.97310-1-sj@kernel.org>
From: =?UTF-8?B?7KeA7ZiV7YOB?= <hyeongtak.ji@gmail.com>
Date: Tue, 8 Aug 2023 18:59:13 +0900
Message-ID: <CAFY0u4Q32yX+O57D+Eh_x6yVwQv2EcqvuxtQxG1msd8RqQy0zQ@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: Prevent unnecessary age reset for regions
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hyeongtak Ji <hyeongtak.ji@sk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for your review. I really appreciate it.

On Tue, Aug 8, 2023 at 3:14=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Hyeongtak,
>
>
> Thank you for this patch!
>
> On Mon, 7 Aug 2023 18:44:35 +0900 Hyeongtak Ji <hyeongtak.ji@gmail.com> w=
rote:
>
> > DAMON resets the age of each region after applying each scheme,
> > regardless of whether the scheme has been successfully applied.
> >
> > This patch adds a simple condition to prevent the age of regions from
> > being reset when schemes have not been actually applied.
>
> We consider applying the action as making a change to the region, and hen=
ce
> reset the age to zero.  Even if the action was not completely applied,
> that might be enough to make some change to the region.  The behavior is =
also
> to limit a scheme too repeatedly and frequently applied to a region.

This is what I have totally overlooked.

>
> So, this is not a bug but an intended behavior, and I think this change m=
ight
> not what really necessary.

Now I understand that this patch is not necessary.

>
> Is there a specific use case that this change is needed?  If so, I think =
we can
> think about extending the interface to support the case.

Not for now, but if I find any use cases for this situation, I will
let you know.

>
>
> Thanks,
> SJ
>
