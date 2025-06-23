Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6754267733
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689603; cv=none; b=iujLbT0Cowl37H6KAooG5y23PlvhVVS8pK7zmJHmyww7hEeuU6QHU6DMFAbofwK+XjjlfLXEbHe+NR1RcbTZa2ebDlgjc51M1GF+tf1jy9dFk3td6GOuh1CZ0n17XfvLNhU+IuFhotNcXPJti9xbjyZLYDUVL4mKu8gf/GoGoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689603; c=relaxed/simple;
	bh=lHsHchyWhA35ZLt97FqmbFUE1/lGuLeWn/i1lL1eJ44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6kEHzHOeGQSQz3JnGSLh6bUznWSKUu1mdC7IVOLAN528Dl9AAg8c6tgvWLZt66HKW6FRhCAKVrv7FJClrnsHL/EKAHVIroPaeg+DkbrEN2389mmvAqCQKHa1LGDVrvp3iJtv9Y0W5neQMwwLAWAXrM9wWzUpRy5ls36Z9Tuk1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YceoSzp0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YceoSzp0"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb5ec407b1so708221866b.1
        for <damon@lists.linux.dev>; Mon, 23 Jun 2025 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750689600; x=1751294400; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9+0NuJ2HzS3oX9trIsYNygO2Vo4g11wSfp7uWlAzH4=;
        b=YceoSzp0uPP24ZC6/Sop29LAo3CtSz0sS+m2DQ7PQT4ipBFTWH+axCGh+GKvRd8BwT
         WjTB3o0NYHoogR+QYWYE9+grbw5VFZl7IPYHmSSD11SG39kpaPBCq2F8qvdBc/BPmMbU
         eYdpnuN5e6+FWYmop2zoXu2Nq4n1+irAbAVXTMkSQILLtwDLVNYj2nhmqafv5tGEli3Q
         R1MDFjKh9OgMI7dvfWJua72vT33ddZWtnjv2HxpJHckdkbIXRTf30BbQMcYtsXNhHthR
         99muyP48hnkDIWwY1n+rfx3VwOPZPAHxkhLaaD2fAKJiK+NkiqLVqITnEVdFWT1mXSPl
         wp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750689600; x=1751294400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9+0NuJ2HzS3oX9trIsYNygO2Vo4g11wSfp7uWlAzH4=;
        b=EYxNfM/PXnef6y0VC6Et9EorR5zbLEQc8f410psVfeAgU24x14s/1Ztc8FADsOkcKY
         rguoE/PjpicZkTRpzVjiOgqDpg8yvtK5IZzLNml/8S2pV1A3tUqUYWjd9+9XTCB0zWZQ
         0scS7APaWrtei4AIVUrtcf7vfNmjINwNV3iS7n+5WqY+tclffjCZ46Bqo35dA9uJN8G8
         uUA2yWvV5fAYsH5gQY2s9ZMhRyMm3LcptS/+VTx1nYFoWFRBngqGSST5UyYoTwtpSZnh
         Xayg8nhDxi4YeSikYM+WvefdBUxSYpxk9gBhESORJr1kU8KKglNmYGK0aG6RvAMUZb39
         2OOg==
X-Gm-Message-State: AOJu0YzuoftBDZeSwKenmdxSrVXSoruKED1zBdAX+ams2K8aE1fdkSz7
	73zOzFAtSk2q75TnNsKT0LBtYOU6rUjYQOURkmGb9n2kYdSjp8ymLXkQLoUG5R+yym2m+Seb8Ee
	AvgRVPJB9D98hL0yRgZaS8lCBOWChYtU=
X-Gm-Gg: ASbGnctHqNq6b6Zd1tD+nFAVvdKPsbDRx11Qn9Dj3PX9IjLV/+2xzQrvSFfZ8STy3HH
	e/dHcBNRlCNR2pl823iiUFNdyRRcikAYt7wRzGJEm8uJICmjzl2nIjODF1iKWNOxR/aa1/3fe7Q
	ZBdMLZUWrSMXGMHnl01DUcZSnzLUg2aERuWuDVqVmHEB1iype0AYelknFrfB9theCMidLegbSz7
	Zje6YHPGD4dWna0
X-Google-Smtp-Source: AGHT+IGUfp3/ururE5cq94v6XTOMAtl8+WlC/gPk79G9+PbfymbTdmHbzNmhQMSy0z48u3KWdnPgfyPlB02Iw4aF8ms=
X-Received: by 2002:a17:907:94cc:b0:adf:7740:9284 with SMTP id
 a640c23a62f3a-ae057c709c6mr1353653766b.57.1750689599796; Mon, 23 Jun 2025
 07:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250620231324.99607-1-sj@kernel.org> <20250621173639.35906-1-sj@kernel.org>
In-Reply-To: <20250621173639.35906-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Mon, 23 Jun 2025 09:39:48 -0500
X-Gm-Features: AX0GCFt6CknS4SwAMKaZry7XGCRzawldZjC64c_mubZJ1QNsGdLh9DYniVyb5kA
Message-ID: <CAMvvPS6yuosvLxUn8+GnGJdqE2LnfGgur0x0hTM6nqmBpU-q9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] mm/damon/paddr: Allow interleaving in
 migrate_{hot,cold} actions
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, bijantabatab@micron.com, venkataravis@micron.com, 
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:36=E2=80=AFPM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Fri, 20 Jun 2025 16:13:24 -0700 SeongJae Park <sj@kernel.org> wrote:
>
> > On Fri, 20 Jun 2025 16:47:26 -0500 Bijan Tabatabai <bijan311@gmail.com>=
 wrote:
> [...]
> > > That sounds good to me! Having a prototype from you for the sysfs
> > > interface would certainly be helpful, but if you're busy, I can take =
a
> > > pass at it as well.
> >
> > Great.  I will try to do this by this weekend.
>
> I just posted an RFC for this:
> https://lore.kernel.org/20250621173131.23917-1-sj@kernel.org
>
> Note that I didn't run exhaustive tests with it, so it may have silly bug=
s.  I
> believe it could let you knwo what I'm thinking better than my cheap talk=
s,
> though ;)

I only skimmed through it, but this looks good to me, thanks for
throwing this together! I'll probe more when I use these patches for
the next revision.

I'll try to reply in that thread as well, but it was only sent to my
work email. I'll try to set up my work Outlook client to work with the
mailing list format, but in the future, could you also CC my personal
email (bijan311@gmail.com)? Gmail just makes formatting for the
mailing list easier for me.

Thanks,
Bijan

[...]
