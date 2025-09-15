Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D23375CD
	for <damon@lists.linux.dev>; Mon, 15 Sep 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949955; cv=none; b=B4p2UteW/2bsLyYwZIfQSJ8r4YdDu/+9GA3lZahVIQ4Dr/5liCM8v4CukbxdaXhNgYq9oOwhHv54y/z5Jkkeb7DwJG7acq1H91u3XqFH8IDQ3YEbnoJ2ELPSkAW2CazVb+JInHK1FXijWYDPvwu8HSiOOOcU3GryplxTeXHkYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949955; c=relaxed/simple;
	bh=bT79mZWoVpCNSPqKjzxE1zifFi0RNZXBKcyX9tuKui8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcsIafP7IBbUtlLC8wgFDRRWiZGBYtoXdwk4vlh9aBqKCMEq+KfE4xAH/Ui0rQmv2tUrEpWkKfvC3ZP9CV3bBF1YWeDlrl7cwnVD8Gt42ds02ZCWnqhEpx4gGF/+ZFZGK6Lkfsn3x7z1Bz6qZw3PIR9h8sDnrnnBvovwKBHj/OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU62q0D2; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU62q0D2"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b5e35453acso54698311cf.2
        for <damon@lists.linux.dev>; Mon, 15 Sep 2025 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757949952; x=1758554752; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twOjmxypi8F5/wktXXyH6UWMyBziK0bLBGe5jYGqXDA=;
        b=IU62q0D2vfPOm6b4XeX74/TqdKgA8f2/v4XZt9CnCGOy0p0RNT2biS5wvP/Y4CgFWm
         jJGhNEk6/3yWOPONKleSQmi1KfXZnZyezrd7tyEaSd+QG4+DvrFEpRqkIMc5lyuW+dA+
         Qz4RB9TF82YDY1E1R3cvORihwpOdDlzGmWd2/Fr9y8hwb/ScthxHrIDP6TbJXHLJcnOz
         9ZSUnAzniWXsS+8e5DgdC4V88PcL3kgOY0fAGatPoSF1XEhGs99rO8XTp4hEFLowyjCC
         TEzkk5uT04yBOM/WGg8tiALqARIOhHkUGU5Uiq1qpOde+s/S5lb9CZbCgFed8clf0tg8
         jeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757949952; x=1758554752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twOjmxypi8F5/wktXXyH6UWMyBziK0bLBGe5jYGqXDA=;
        b=AfYYc+Sw1Ed3Vam9NZAPLP5c0zd+gQTSP/2sY+KsqXcIYJ6hamNGhtOtsaHTBXTzaC
         Wq4MjprN6lPgyLpFRw9vTP0UyX9lGOCg/402va1VSsYusiQJRUoRciqClrPMVVfOORJ+
         eOm4l340eufYjvlRTzKXiyz0Gqgn4mXRCL0IUgRDxY/YdJFtH3oyeRvoM5iBZZe3S/ri
         RBdez+TOIMMdMu0CdtjtA2fGQ2o2QDRx2eK5lUx4Ow7/cAAEvWneBryKBjG3/k2m4KmF
         mUkI4Dv1rqqsUW+sJ3fR1fQXAhncvcEMu8UFOdnVrH8eDHMGAy6aDSrcfASqbiZrfSn3
         WEsw==
X-Forwarded-Encrypted: i=1; AJvYcCWDa0sHYEjCAnCwGId5tLUlxh9zn+U+YO8L8nFVkhI3+b3iJiXAjgRck4/HnTM8mnF0ZojyGw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy73A8lATgBKtApxeTM/s64odjKDX8WR5di4t2oJr+NP4+K1gIy
	zeHUKs+l3ja54OwZjpYrGkZPqPvPMBhQVAIT2RNDECVk1Mqbr+M62T+Zj5iQgvBoMNv4QCAIwx3
	4WDygAA8nU7GNnsr3v9mZf6YExgtcE+c=
X-Gm-Gg: ASbGnct67waOJJ/K1setTyUnMr0So/R3Anq+b1nc4CXu0YTPyUgAnuyg1eA6m1n9BHx
	xQveHUG2kDMh2la6HpF1ewXvyXV5HQd4/OQAKd6wLZ+pnU983JahTe7vbmNadwdTZP7xh5zfhaY
	IArrwme6QUttY5uUabJWq8M80MvbTDsPbeHKimTzOcy0BL+c40DL3tAInXcAjNZ33yb5NfPd534
	OUIIbxx1dKG6/00xhlEbnltY4rEmdeLXP+Ip80JI+f2GUPs7RI=
X-Google-Smtp-Source: AGHT+IG0lj4OHOWbpCyzpHkhetLcDU4pJdQ9spR9svWGOUH3xKPwb7pLVnXSJvywltfC7gPj6m2GvwN33sLw0OSiuQ8=
X-Received: by 2002:a05:622a:a19:b0:4b7:9f68:52d6 with SMTP id
 d75a77b69052e-4b79f686bfbmr58374191cf.9.1757949952122; Mon, 15 Sep 2025
 08:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250915015807.101505-1-sj@kernel.org> <20250915150851.1508878-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20250915150851.1508878-1-joshua.hahnjy@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 15 Sep 2025 08:25:40 -0700
X-Gm-Features: Ac12FXzQhzLPiwahg8l4GbB3zTsY9ipEubXDL1xh87e6emG51matFCCQ0FbehiY
Message-ID: <CAJnrk1ZHdt-sj4n2VigW6u6bnd-gX47WpUfaHDxqN1BH4JGUXw@mail.gmail.com>
Subject: Re: [PATCH 0/6] mm/damon: misc fixups and improvements for 6.18
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, damon@lists.linux.dev, 
	kernel-team@meta.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 8:08=E2=80=AFAM Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>
> On Sun, 14 Sep 2025 18:58:01 -0700 SeongJae Park <sj@kernel.org> wrote:
>
> > Misc fixes and improvements for DAMON that are not critical and
> > therefore aims to be merged into Linux 6.18-rc1.
> >
> > The first patch improves DAMON's age counting for nr_accesses zero
> > to/from non-zero changes.
> >
> > The second patch fixes an initial DAMOS apply interval delay issue that
> > is not realistic but still could happen on an odd setup.
> >
> > The third patch fixes wrongly written code that doesn't cause any real
> > problem but could make code review confusing.
> >
> > The fourth and the fifth patches update DAMON community meetup
> > description and DAMON user-space tool example command for DAMOS usage,
> > respectively.
> >
> > Finally, the sixth patch updates MAINTAINERS section name for DAMON to
> > just DAMON.
>
> Hi SJ,
>
> I was unable to find this sixth patch on the mailing list. Maybe it got d=
ropped
> somewhere? : -)

I'm seeing it show up for me, this is the link I'm looking at
https://lore.kernel.org/all/20250915015807.101505-7-sj@kernel.org/

>
> > Changes from RFC
> > (https://lore.kernel.org/20250909034353.7064-1-sj@kernel.org)
> > - The RFC was only for the first patch
> > - Rebase and wordsmith the first patch
> > - Add a few misc fixes and improvements for 6.18 to the series
> >
> > SeongJae Park (6):
> >   mm/damon/core: reset age if nr_accesses changes between non-zero and
> >     zero
> >   mm/damon/core: set effective quota on first charge window
> >   mm/damon/lru_sort: use param_ctx correctly
> >   Docs/mm/damon/maintainer-profile: update community meetup for
> >     reservation requirements
> >   Docs/admin-guide/mm/damon/start: add --target_pid to DAMOS example
> >     command
> >   MAINTAINERS: rename DAMON section
> >
> >  Documentation/admin-guide/mm/damon/start.rst  |  2 +-
> >  Documentation/mm/damon/maintainer-profile.rst | 17 ++++++-----------
> >  MAINTAINERS                                   |  2 +-
> >  mm/damon/core.c                               |  7 ++++++-
> >  mm/damon/lru_sort.c                           |  2 +-
> >  5 files changed, 15 insertions(+), 15 deletions(-)
> >
> >
> > base-commit: d245e17d619ea0336d50b0a6c914f5701d1b0e53
> > --
> > 2.39.5
>
> Sent using hkml (https://github.com/sjp38/hackermail)
