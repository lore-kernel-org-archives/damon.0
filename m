Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3533711F
	for <damon@lists.linux.dev>; Fri, 17 Oct 2025 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712750; cv=none; b=hY8DgWV7GevaeyV12Rv923AHX60lXFcXaQEB+00ScgMXbhwNsO9JdWFRy4u1BBEVSX9LGUmGwSAskGBtNIaUM9KDA/DquDKPsZQpWasPNS8YHHyeXKDm0N43H46e5XgQI5HaL4z6rZzFlK5yvJIn2LihDR85Q9WiZsNjwUmT4f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712750; c=relaxed/simple;
	bh=FE3YL5OMAr/XibXju0AZDs8aCO5tRUd87j8YEIA+kgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MSf5dmarA2Q4AlTWoP4K7hjXkNGOMdhY+VrUoweeBBlq8j12NH0oYc6LshPFbWpB6lkp+Tixvr8MY+27LgznprrIXI7hfuLMjXb4b9yCy5DXHndI2gZv74K/8FJN1AwjeJMmTkk5DZ0fXQOZjk9aZa6qGC0IlTW9t3Z06JkUBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d04k6AoQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d04k6AoQ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b50645ecfbbso401470366b.1
        for <damon@lists.linux.dev>; Fri, 17 Oct 2025 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760712747; x=1761317547; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40nyfgQShmFtY4cCrB122dpcbOTCXgM1IQYT54zJSJI=;
        b=d04k6AoQKS2W7tJR0d+c4sleMDPbbpRtuhDNifzllSVy/9bbNdEl7sVIDp2Sw0wjpI
         d8AXOTQaB31fIsXkLmFhCBki6F4+jAdAiMrzms0xevJG1qA3jzIkCpS4ijwLWbQAtmvd
         QlQtqcj3S7+Z3KPjSFa+gDI4/1mhvezSSTcGvX8KHZHMgFo/jnK5aLrKGPSFxDBuEH78
         IA8CgolI9fbGzZ9tfkCjngM03+H/q85GF/N+XAB2AC3SBhcJrn9xcQCTQtStfoTUOU0k
         QGnhxQkFa0L5l3n5gMUqq5Vj9MFlHQp6IlfZLeLS44RkX2v4QfQCD3s6SKTjLNvL5sct
         rvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760712747; x=1761317547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40nyfgQShmFtY4cCrB122dpcbOTCXgM1IQYT54zJSJI=;
        b=R/lG73X4s3V/LHhXw6OyYI12/5uX9/TzrY6jwdjQErX9WZWFAb/owXTfmNX/ameKDM
         PzaDVbjaZSyw0lLMdxhCJ63yUAbdrKzBsfqAgeYQNYEXVNgH9zliPQnLRwCA16o8C/dj
         ARYuvAEDCpUOLV79B5UOUkvHfb3D/hhATAfmEajWHonnXQI6IwS4vhmUod6br51jow3l
         l8EeLcjBm3WX5LNvr3SoyAbOmE34bReyYkbrvNVZKkgrDwdDGVINNeZHb/nFJoVqNQca
         hzvI8V8aHEYVsE0VaHzS1ViYnw2gjNeoz2mQ2i/zeRzgxK5TRc7onJkCjC0QVpJQUL1e
         xRZg==
X-Forwarded-Encrypted: i=1; AJvYcCVp/DHTM/ifM37I7BROi2EkPg5livjQnp1GzGMBAISposWNrdEBaiVkGU2wnIyNqK4/p/2OkA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzy2uGflxdZg1P+ie9DvStg1vaz+A/YPdd+JG2gkKgmc5srTR5O
	1C9zTaqP66hbXC5arOxCVJdNFjfah3zaS7LelvBGtwiOEzGAwKNFBu+I/FQbDDN/qYgu6mSv9Z9
	rWJt3qltSGg1ikC9jJOQ9+mq+W8wMHdM=
X-Gm-Gg: ASbGncvgRTQADniuZw2NxcSR6FkNNMrcXidNWrN1k8NV0Hi1wcPto8UG2hhmj5f9z+J
	qOx4FumkpZub/CR7PFBz/gyVDegvVhINw1Vry4ZIWpFWJSC4LwQnw61kVqc7ra7fYJHD1NXmuMd
	dPPl3EpWsbnYt+Vw+1/DbaPPzhgyMP1rGxFotaSmmCylAcHVLHvovzAfB/aO6XJkaZvKZZsWAX1
	9MQE6G0jSQrooL/jq4KM1TVLLvm216PC86l4oXrQ0/mVYluLz2a39NRsWfbrQjUCjcYans1LXcA
	SoQlgWtktmsj/uXeQEx+9sgw89+knyyVB2m9O3iw
X-Google-Smtp-Source: AGHT+IHPzDupjD0Il6mQHY689RSKcqmRwHuLVog9TXEikEgPhZiar0EVjUFWzMXKGPxBV3Id5cUnWwGA2ivTsIhmnlU=
X-Received: by 2002:a17:906:6a0a:b0:b4b:e419:9af9 with SMTP id
 a640c23a62f3a-b647314722dmr428460066b.23.1760712747066; Fri, 17 Oct 2025
 07:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251016214736.84286-1-sj@kernel.org> <20251016214736.84286-2-sj@kernel.org>
In-Reply-To: <20251016214736.84286-2-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Fri, 17 Oct 2025 09:52:16 -0500
X-Gm-Features: AS18NWA4XEij6yrkeDg-VPpESDp_j8R5n_TLSBbuEV9pdxP1CdAdhVV-XNND_i0
Message-ID: <CAMvvPS5gjn6J1dF1O+Hj3CmVcPTQG__zRwqqdBMoRNtptQeOyg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm/damon/core: add damon_target->obsolete for
 pin-point removal
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for working on this SJ!

On Thu, Oct 16, 2025 at 4:47=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> DAMON's monitoring targets parameters update function,
> damon_commit_targets(), is not providing a way to remove a target in the
> middle of existing targets list.  Extend the API by adding a field to
> struct damon_target.  If the field of a damon_commit_targets() source
> target is set, it indicates the matcing target on the existing targets
> list is obsolete.  damon_commit_targets() understands that and remove
> those from the list, while respecting the index based matching for other
> non-obsolete targets.
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h |  6 ++++++
>  mm/damon/core.c       | 10 +++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 524dea87cac7..8a7b45b9e40d 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -92,17 +92,23 @@ struct damon_region {
>   * @nr_regions:                Number of monitoring target regions of th=
is target.
>   * @regions_list:      Head of the monitoring target regions of this tar=
get.
>   * @list:              List head for siblings.
> + * @obsolete:          Whether the commit destination target is obsolete=
.
>   *
>   * Each monitoring context could have multiple targets.  For example, a =
context
>   * for virtual memory address spaces could have multiple target processe=
s.  The
>   * @pid should be set for appropriate &struct damon_operations including=
 the
>   * virtual address spaces monitoring operations.
> + *
> + * @obsolte is used only for damon_commit_targets() source targets, to s=
pecify
> + * the matching destination targets are obsolte.  Read damon_commit_targ=
ets()
> + * to see how it is handled.
>   */
Nit: Twice in the above comment you've written "obsolte" instead of "obsole=
te."

With that fixed
Reviewed-by: Bijan Tabatabai <bijan311@gmail.com>
for the entire series.

Thanks,
Bijan

>  struct damon_target {
>         struct pid *pid;
>         unsigned int nr_regions;
>         struct list_head regions_list;
>         struct list_head list;
> +       bool obsolete;
>  };
>
>  /**
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 70e66562a1b3..3242a9573db0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -492,6 +492,7 @@ struct damon_target *damon_new_target(void)
>         t->nr_regions =3D 0;
>         INIT_LIST_HEAD(&t->regions_list);
>         INIT_LIST_HEAD(&t->list);
> +       t->obsolete =3D false;
>
>         return t;
>  }
> @@ -1213,7 +1214,11 @@ static int damon_commit_targets(
>
>         damon_for_each_target_safe(dst_target, next, dst) {
>                 src_target =3D damon_nth_target(i++, src);
> -               if (src_target) {
> +               /*
> +                * If src target is obsolete, do not commit the parameter=
s to
> +                * the dst target, and further remove the dst target.
> +                */
> +               if (src_target && !src_target->obsolete) {
>                         err =3D damon_commit_target(
>                                         dst_target, damon_target_has_pid(=
dst),
>                                         src_target, damon_target_has_pid(=
src),
> @@ -1236,6 +1241,9 @@ static int damon_commit_targets(
>         damon_for_each_target_safe(src_target, next, src) {
>                 if (j++ < i)
>                         continue;
> +               /* target to remove has no matching dst */
> +               if (src_target->obsolete)
> +                       return -EINVAL;
>                 new_target =3D damon_new_target();
>                 if (!new_target)
>                         return -ENOMEM;
> --
> 2.47.3
