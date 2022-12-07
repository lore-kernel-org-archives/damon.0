Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0954374
	for <damon@lists.linux.dev>; Wed,  7 Dec 2022 02:44:08 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-381662c78a9so172578067b3.7
        for <damon@lists.linux.dev>; Tue, 06 Dec 2022 18:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KbXxDs8qKafWAR7bqMoI00ZpTS2+CW/S/4T/0IodwXQ=;
        b=FzBv8eonOeeQZyfeURr9aLopxT7FxdLDbDtjyt7834bRLjztrdyk7RY71F91+2l+81
         eQlarU87dp3oo39ZemUgu6mxVoqK4m9b7o2xWVYga1nnzgjDqIDmtZ/BjrDDtSjzXqF6
         DHpBi5+La4ZijX2hpvpN7zHEf0mcepIXJVoZHDG5FI5ujCgsq/79szOiNEim5qrm9Be+
         kRfTpHT6LLpQgS9xD4/HNINLlwMtC0HShoMHIf0IzLe/c7tjA0BID+C7jOjD5eWna+TJ
         qJdmYX6S34JJhGGif3AGmQ+n2y+1A+o7U5IQr2R3xxRH1eHladqu6EudTtyS/sSZQOpZ
         ZPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbXxDs8qKafWAR7bqMoI00ZpTS2+CW/S/4T/0IodwXQ=;
        b=zrUqM0uYXZGcw2kkDb3maBcsU7by3RxmMJQVUrukNTqbqBvs8lYrubDCQOJHIWLT/u
         k8fxrK8ByUyQEuSg9Lb0hEn+hrC1E7vAuemYH1HNPV93+prPY4x4CdFxFOMPCpLR9uaV
         JloIEnI6dDFwDrz55kvXKmVe4mnCbrwNAXGTWmuNIZFjjIq76fNQRXifTtOUUeLHDgIq
         ysAwKzorYP09Kb+dHe8BOGRJNgr1Vtqr9INS5Q9OCvLwu+iJqsPtelvlTmerFE5oxh6x
         U6Znig/Rij6hJpVrJNDVTTPchdMgT58FNQz6xip/awtJ/jcZfWpjO9n6GYl68eI4MdcU
         Sbqw==
X-Gm-Message-State: ANoB5plUoRShL63mxUnoK2UVtLPTqGNwj5yafAf9H+ot00mhi+wRGczT
	Xl+QNVqNa1SMyfDzakpdGd9GsDMcF3BmvhghkQY=
X-Google-Smtp-Source: AA0mqf4nu3gyaTzemasNgoy5PmsN4M8Y7wPhavQsBkWj7i7B2+81sTF+qDRAcFC1mOjutUIGU53ODw9WfmNgSMaQIDU=
X-Received: by 2002:a0d:cb93:0:b0:3e4:5d25:d33f with SMTP id
 n141-20020a0dcb93000000b003e45d25d33fmr17233968ywd.190.1670381047765; Tue, 06
 Dec 2022 18:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221207002158.418789-3-vishal.moola@gmail.com> <20221207005624.146281-1-sj@kernel.org>
In-Reply-To: <20221207005624.146281-1-sj@kernel.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Tue, 6 Dec 2022 18:43:57 -0800
Message-ID: <CAOzc2pwexH7Phhg_Dx0_9dg5_3n=uKSwbpWDKBbNQdY0N97U-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] damon: Convert damon_pa_mark_accessed_or_deactivate()
 to use folios
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Dec 6, 2022 at 4:56 PM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Vishal,
>
>
> Thank you for this patch.
>
> Nit pick.  Could we please replace 'damon:' on the subject with 'mm/damon:' to
> look more consistent with other DAMON patches?

Thanks for looking over this patch! I'll make the subject mm/damon in a v2.

> On Tue, 6 Dec 2022 16:21:57 -0800 "Vishal Moola (Oracle)" <vishal.moola@gmail.com> wrote:
>
> > This change replaces 2 calls to compound_head() with one.
>
> I guess you mean _compound_head() calls in page_folio() that called from
> mark_page_accessed() and folio_mark_accessed().  However, deactivate_page()
> calls page_folio() anyway, so this patch doesn't reduce the number of calls to
> one but keep the number, correct?  Am I missing something?  If I'm not, I'd
> like to clean up the wording.

The 2 calls I was referring to were from mark_page_accessed() and put_page().
As you've noticed, deactivate_page() still calls page_folio() here :).

> > This is in preparation for the conversion of deactivate_page() to
> > deactivate_folio().
>
> I think folio_deactivate() might be a more consistent naming.  What do you
> think?

I do like the name folio_deactivate() better than deactivate_folio(), I'll
change that in v2 as well.
