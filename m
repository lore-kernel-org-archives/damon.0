Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378A7E
	for <damon@lists.linux.dev>; Wed,  7 Sep 2022 04:50:13 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3321c2a8d4cso116026157b3.5
        for <damon@lists.linux.dev>; Tue, 06 Sep 2022 21:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qsj6wBxZM9Q0KnsCDgx0MhS/Vi4o209YpovGEVJMze4=;
        b=NFmBu+i2agZyeGCBWZJIAHlZKxG/VyWtZubrJB03DChP9c4MB7VEhexNI8aTr9uJIw
         OsqV3q2AYR59NMBbZiUQR8RiSdbaQBeEkWVSWKh+5pC/Ok6NP7iw8rOgkxVZ8wlH2c6j
         BJy5tjdcIPq/vtxuuwC2BA4VaUCLKtlflpf/YuHLMou8hd8L8RGiBWctHU9YSt5uo/zd
         B3dADSQdgYv/f5YB65e48lnb3s8o7z3PzhJH0Jgjb+B9VEevD8Z64KISIpKnmVmd92A7
         fffpBg4lviM2wSNHrLpU+t+ULb90QujUDS2i6Bn5vior64iP9noR2IKXse/PEkVMqwu/
         qC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qsj6wBxZM9Q0KnsCDgx0MhS/Vi4o209YpovGEVJMze4=;
        b=ivFnHS1DR6mHoqv+WRahzW8A5/qXUukd7VzrbpoOWHmvrNBjXVym2hlWm/pIrpzYL7
         JDMcf4+XaGH3d77uBUJTv9B1ziRP/CK3VWxKExag5zRkmYc0Vym0cEJJGPo40OKcPB32
         FY8nIJI/XuOA+2a9d3XwD2d2/6At2YC9cFwbs/6qEpuXYtH2KLVXv1rFlZo3N5Oz2RQy
         iTjFMq+GBS1CHI8ln82YUTMCdJCE2b/bhViXRNZPAhfypam0yK3zlui04zXAsUQquTDD
         FmCXB+L1I1FRfE6JAwdrJdUu14/zLIXCsYfYh0O4W76+UMDj6R0/QhnqUdbaoeZZgXbP
         smWg==
X-Gm-Message-State: ACgBeo1seGT/EJkuhXQ+yf1nliNUwQ5N3Ukjet9NwK7xjJA2RubqhoGu
	FrE6xOyrlhT+Zo5HOZghBgGtyEDc/z2sPZeFmQwFOfIReDU=
X-Google-Smtp-Source: AA6agR5mjbwOH7jMNRf/DGJlH26N64tXkVr10KRkjiw2xQvlbUuaY0mLbFs1GvkrEf8q12PaI55hnv7E8UoETzYHncI=
X-Received: by 2002:a0d:d4d3:0:b0:345:90:d31 with SMTP id w202-20020a0dd4d3000000b0034500900d31mr1737548ywd.120.1662526212649;
 Tue, 06 Sep 2022 21:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAM7-yPTjEa0Av8nrqqQ5vmBTg2fv26mzXReLOBFaRxViGXvF+Q@mail.gmail.com>
 <20220906175532.157099-1-sj@kernel.org>
In-Reply-To: <20220906175532.157099-1-sj@kernel.org>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Wed, 7 Sep 2022 13:50:01 +0900
Message-ID: <CAM7-yPSeNe9v4QGRoqXkjcLtio3xiJKha9bRoPiu7v=o3RG2Nw@mail.gmail.com>
Subject: Re: [Question] About damon_set_regions function.
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> This would fix the specific case, but there might be more than 2 regions that
> not contiguous.  I think we should also handle the case?  E.g.,

Thanks for your review! I miss this case.
In that case maybe some of former regions wouldn't be removed!


> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -194,6 +194,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>  {
>         struct damon_region *r, *next;
>         unsigned int i;
> +       bool found;
>
>         /* Remove regions which are not in the new ranges */
>         damon_for_each_region_safe(r, next, t) {
> @@ -235,6 +236,24 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>                         first->ar.start = ALIGN_DOWN(range->start,
>                                         DAMON_MIN_REGION);
>                         last->ar.end = ALIGN(range->end, DAMON_MIN_REGION);
> +
> +                       /* fill the holes between first and last */
> +                       found = false;
> +                       damon_for_each_region(r, t) {
> +                               struct damon_region *next;
> +                               if (r == first)
> +                                       found = true;
> +                               if (!found)
> +                                       continue;
> +                               if (r == last)
> +                                       break;
> +                               next = damon_next_region(r);
> +                               if (next->ar.start != r->ar.end) {
> +                                       newr = damon_new_region(r->ar.end, next->ar.start);
> +                                       damon_insert_region(newr, r, next, t);
> +                               }
> +                       }
> +
>                 }
>         }
>         return 0;
>
> Of course, the code should be cleaned up (e.g., would better to use
> list_for_each_entry_from() and factor out to a separate function).  This is
> only for a PoC.  Is there anything I'm missing?
>

I think it's good.
But, IMHO, I don't know if it would be useful to merge
first <= new_insert_area <= last with new inserted regions as one region.

if merging is meaningless, LGTM.

Thanks.
--

Sincerely,
Levi
