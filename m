Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224B1E50E
	for <damon@lists.linux.dev>; Sun, 10 Aug 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754830631; cv=none; b=HJ8Gh0ngY5XKZ4FFsnUYsbG1BgBleeS1TK9hzFqO+2DGBlKGtLc0ALdhnQyOHGLSM7gmOI9nuVA+vgw4TegaI5nFs7ZLWofKj/AslqKLWjtC/LE6my7YoLdpgSJyCP3Z7H6+4fEcnouunZljAiPJ8uQK8dKU9CjUfgNef/CCimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754830631; c=relaxed/simple;
	bh=ROlzLEeCg00gkMTWYeNV/cvX3Uji6kaCC41uqFQv3Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmjuAAnmWDvN2hImkNIceJPZCfu0W4qLhzFSHR1x3KEbP6EsX1tMotjKhPt97Yi7lwg8rYqQSyOrMZG6aAlhtDl9JrvSeDnZ8Un5Y5fFcqT/oBJJZuWseJXGLGypcAPNkgWb6ICmgSoUoX7GOVvCiB664LfnNGm+hByyeDH2VOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5XtWxmE; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5XtWxmE"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-741a254d4a0so4621898a34.1
        for <damon@lists.linux.dev>; Sun, 10 Aug 2025 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754830629; x=1755435429; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk0vQpEQc96pPsBzVddcY2ri747yVEKfcp+ejDRXV+8=;
        b=H5XtWxmExwpFTv7OhJhEY/3iarO1GRvie/rcd7JPxhh1KcRuAttX9Qb6wq5xtj6ZCy
         8F+rrqIbXEskssrn1POZ+VMKfS3ngp2scPJYtxjGoHYIDr4hLDro1utYj1rvG7vvKQXs
         ihRIq4RdDe5HJRqrJrJ1Zx00xl6HpSDOrOQVQ+vtajNpedQ+3oDKrb6VTqCDDwAG8Uut
         7rxmg+V8r4VkRotYIwap0/d0OHg0ATMpRBJlwtGbiYfHHC2ny2Jx+dg489vOQbz/OcfZ
         ixBxFPRPQC9JTS+RRQ9RicUrb2CFL++avJP1ajs40ZRovaoKiZLtdFo3LG59VgYfiFGc
         ew6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754830629; x=1755435429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk0vQpEQc96pPsBzVddcY2ri747yVEKfcp+ejDRXV+8=;
        b=Omoe6UJlFHN/pLdZllER7pXky5bx0jKMkbTXrYJp9G89BDaQm4XQesaSOgolK8rWrH
         +ESw7Dq7CJ8+McWTMnQ4NGSPXnw/m6wv9u1RPGdW1hN0jRU3ZP5vjVBatdpclovB2/a2
         PBQUmc2Itktw6kG39E2GwV2FTJEnrwZDYrdbvgFqVYztS8RQ8J65RVHRRjBNguuVC9/V
         ZBvaJD3FViWFUHZIwqSSt1atbAy0TEzPxfBq5/1OTLYkiIzYVI0LJCBGckVTfzRWJRdN
         NIqRdF+czQSseikmbFQaUDilGFuAzfbi77mNwFe8ydmBfovQ40MOzib82ObYLOpIvIr4
         Zy7w==
X-Gm-Message-State: AOJu0Yxgc9coFTAxtwptYodxeDwZXk4JXPTdCDRpNSFXfAHmeEQ4xkEO
	sWayvswNkSEdAu3d1SuGHxqnb+GnZaYlUUwUB/jAY7L0s4Cm6iQzxpliwMaZN5qJaiv93F8FmbS
	c5KVkg3gW83iqb2r4TIoSOPscQeweFjQ=
X-Gm-Gg: ASbGnct4MC9SZX5XU/3Mo4yql/C3p2NJhjBu3R5vdDNgNM5XJbVheKnGbWjKY0gTwMt
	Sfzjw7O7t581qBvDGv/s/tTFlf4eSs36MIHG9DYbOv87DsMZHG3iPehe41Gr2LNPD+K6aabBWe2
	m9mQVlyPAK+lHgzytupDixUUDvlaThfPfdBnCyP+ddvAq4fjV2QAa1AymtCtXKIoOaDSYZ9y1Eu
	Yzf
X-Google-Smtp-Source: AGHT+IEHY5r6Gce1oZK2OIKAsnl5ILZ147Y/o1PNH7xhcU6UAD3tqVBOQ1FMnzzZRxl24LGN1z+AQ/cYR3zDsNhaclg=
X-Received: by 2002:a05:6830:6c88:b0:73e:5540:730e with SMTP id
 46e09a7af769-74318ee5b56mr7154681a34.4.1754830629127; Sun, 10 Aug 2025
 05:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250810124201.15743-1-ekffu200098@gmail.com>
In-Reply-To: <20250810124201.15743-1-ekffu200098@gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sun, 10 Aug 2025 21:56:56 +0900
X-Gm-Features: Ac12FXwymO9fVmgHrw4TsFCYnXlG-bVN2vqISj3bUbiPHnM0Tf9frR-EF_q3LEk
Message-ID: <CABFDxMGw6usfYmccAAvu7HRO6xCz708=9tTx-Ln-HgQ6GN49Mw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/damon/core: fix commit_ops_filters by using correct
 nth function
To: sj@kernel.org, honggyu.kim@sk.com
Cc: damon@lists.linux.dev, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 9:42=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
> iterates core_filters. As a result, performing a commit unintentionally
> corrupts ops_filters.
>
> Add damos_nth_ops_filter() which iterates ops_filters. Use this function
> to fix issues caused by wrong iteration.
>
> Fixes: 3607cc590f18 ("mm/damon/core: support committing ops_filters") # 6=
.15.x
> Cc: stable@vger.kernel.org
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---

I just forgot to add change logs.

Changes from v1 [1]:
1. Fix code and commit message style.
2. Merge patch set into one patch.
3. Add fixes and cc section for backporting.

Changes from v2 [2]:
1. Separate the patch into two parts(code modifications and tests) And
this is part of code

[1] https://lore.kernel.org/damon/20250808195518.563053-1-ekffu200098@gmail=
.com/
[2] https://lore.kernel.org/damon/20250809130756.637304-1-ekffu200098@gmail=
.com/

>  mm/damon/core.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 883d791a10e5..19c8f01fc81a 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -862,6 +862,18 @@ static struct damos_filter *damos_nth_filter(int n, =
struct damos *s)
>         return NULL;
>  }
>
> +static struct damos_filter *damos_nth_ops_filter(int n, struct damos *s)
> +{
> +       struct damos_filter *filter;
> +       int i =3D 0;
> +
> +       damos_for_each_ops_filter(filter, s) {
> +               if (i++ =3D=3D n)
> +                       return filter;
> +       }
> +       return NULL;
> +}
> +
>  static void damos_commit_filter_arg(
>                 struct damos_filter *dst, struct damos_filter *src)
>  {
> @@ -925,7 +937,7 @@ static int damos_commit_ops_filters(struct damos *dst=
, struct damos *src)
>         int i =3D 0, j =3D 0;
>
>         damos_for_each_ops_filter_safe(dst_filter, next, dst) {
> -               src_filter =3D damos_nth_filter(i++, src);
> +               src_filter =3D damos_nth_ops_filter(i++, src);
>                 if (src_filter)
>                         damos_commit_filter(dst_filter, src_filter);
>                 else
> --
> 2.43.0
>
