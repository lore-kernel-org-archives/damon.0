Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A901DAD5C
	for <damon@lists.linux.dev>; Fri, 28 Jul 2023 06:59:08 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-40694b191cfso11432031cf.3
        for <damon@lists.linux.dev>; Thu, 27 Jul 2023 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690527547; x=1691132347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBrLltNK/fDQgPKGFScyH1SDUmmIH86PwWRaDh569qE=;
        b=SnpBnY2otihuHHHYSDjHJOPZT9jkR75uqSrm0wLVx0ID2esJ6KaK3gH47A6BardiPh
         y29FLCa+aFMSDSoaUNavqOQDEQ4F8MecDEJmBQCil06OOb+UF1EfrFvv8x0Jlr/USQLC
         R+iWvdAiHDPucg1tPytbsDytFtFnF9wHhFY+c9WqR0gMU+obe4ooJR6RCw+Q3uD5LX1y
         TOYz/rt4XK591cUqd3r+4mx/18Hksnq5G2uErJNFszqIavTiCv7lVdUunVVZhB2NMeju
         ZYyYMb9MVt8KJWYlpmETvumOoKKK7+YPGkJ6Xtv3Fm+xFgJJQz7Av3qBzrLo0lE0JCLP
         RuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690527547; x=1691132347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBrLltNK/fDQgPKGFScyH1SDUmmIH86PwWRaDh569qE=;
        b=RzrJ8tnmNrIKpZMxk46eygUo9a9UnZauBHf+jklVLhQbKjfpwa9WIfK+xAMOzxZ7r7
         dGPabyAs8vk/uoxs8ocMvPBnQ7w8FAazdhlslT+mHkZwKqGtbM9b2f+pZSML8iZsOGVr
         SdwMf2kHQW/htasTgiieUDIOzy9Z7tE9oenhY1psf/HW1v9FLnxKPTVRCvDxYZtaLhEb
         +/S5FWoS3ebR0v6gcNei/bKsoa4gRqHKARshXIaXmSWuKSUThpuvN3YHn2MEI/qdNNRm
         Q41bTfdUDKyACVtT0k+qdMJlgT4dN9leWYyt4XarKdVOqCNc1uQ/jIA600/UuFxcgdLU
         jKyA==
X-Gm-Message-State: ABy/qLZ+xsu/quWJFmvRFVpcb7YFZ3tR1aQwCkJZE/4e3lJe86asdEYU
	NAMBwvzTuJ/aMEiYN7DbXiuKqk7OLKxH3d+ZFxw=
X-Google-Smtp-Source: APBJJlHg75yjSFYybiZyNX0p1R660gZtMx4uxNZHQamf2phdSTVEpDTI3nzSY6Fpzgt1B0Epe+/OspI3XwT96qzAg0s=
X-Received: by 2002:a05:622a:11cc:b0:403:9be1:c969 with SMTP id
 n12-20020a05622a11cc00b004039be1c969mr2270692qtk.62.1690527547226; Thu, 27
 Jul 2023 23:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230727212157.2985025-1-ppbuk5246@gmail.com> <20230727215318.43455-1-sj@kernel.org>
In-Reply-To: <20230727215318.43455-1-sj@kernel.org>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Fri, 28 Jul 2023 07:58:56 +0100
Message-ID: <CAM7-yPQEnppWQ4j7mc4WG3POKbjzOLynkFXsSw47GRhSUaTawg@mail.gmail.com>
Subject: Re: [PATCH v2] damon: Use pmdp_get instead of drectly dereferencing pmd.
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 10:53=E2=80=AFPM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Hi Levi,
>
>
> Thank you for quick respin.
>
> I still hope the subject to drop the ending period, and start the subject=
 with
> lowercase, like other mm/damon/ commits.
>

Sorry to bother you, I should find why the ending period inserted..

> > As ptep_get, Use the pmdp_get wrapper when we accessing pmdval
> > instead of directly dereferencing pmd.
>
> Based on the usual git commit message line length recommendation (72
> characters), there is nothing really wrong, but putting 'instead' at the =
first
> line may look more consistent with other messages.

> Since this is the good place to put additional comments not suitable for =
the
> changelog[2], it would be helpful if you could put changes of this patch =
that
> made after the v1 here, from next time.
>
> Above comments are only my trivial and personal preferences, so I wouldn'=
t ask
> you to respin, unless you really want to.
>
> [1] https://github.com/torvalds/linux/pull/17
> [2] https://docs.kernel.org/process/submitting-patches.html#the-canonical=
-patch-format

Thanks for letting me know some details why I missed :)

Many thanks.

--------
Sincerely,
Levi.
