Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB56255F26
	for <damon@lists.linux.dev>; Mon, 23 Jun 2025 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688229; cv=none; b=Kyo2uqCoTRstsxNOASz21nx9N2qc8Yaj2jZYg+l1csgCrJkywMa1aZRmTUazH2zUTeMPyGkDGMj9uPS5YY/BNToB08yNkrZGfVGYsfxBoWx2DBws25gLzr2iZxw7A+ZEM6C7d1Mf3Id+hPu2P/jZ9BZkyiLaJ3olGngUnfgMHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688229; c=relaxed/simple;
	bh=HTKSyNSoON+KdvueDdTsIlHa3RGGeZ+v7jmerZYuiBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5JbFvxfpK8JJghnzNXBv3oKGHqmIPIv69L1RXa75Whhy2V8Xzpp0Xexq5EqKncYPVVNe9rk4Pqp6MhdTY9RuWq3oJcwniA60BwuV5MWyaXmC38hf5rghXu4p6QNPIUGqoYi/PYW5F73HkNGtZ+K0HPIgzMwbXo+gRRXKejPZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzzVGh1G; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzzVGh1G"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad883afdf0cso846139366b.0
        for <damon@lists.linux.dev>; Mon, 23 Jun 2025 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750688225; x=1751293025; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70tNPYqgSSY8XqkTztC+jIspGWzhAYhdeWY6QzJUGrU=;
        b=IzzVGh1GMqkc4hAJugnzDvT378oMYTmLc7X+CfvavIL7htslt3XW7qUE9O2vZucYBA
         1u9R8EXsCWkTKJzDCop7sgcqpgVHEviiYKdJkixFn5ENwwN+TUjqu20FVJIEZzSoLDeJ
         94+IYZYideSRKXh4wbjVyd2+kibvsVo5p2ZerAtVgdgtHiD1siCOtY8MbnNIc+AnHdu6
         QLipbL8xphVZcEKEFaDw6x7Jff0a14LEj3MXUIkiW0rnHhMMxIAmga0Yy1jTG84F7yNQ
         bbtIO4HQlrE53baamXf08cU5ct7y3UZYzmc/YQmviR9dxizSe9YbgbQuiGPdlyECymVT
         Ec7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688225; x=1751293025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70tNPYqgSSY8XqkTztC+jIspGWzhAYhdeWY6QzJUGrU=;
        b=Bi2dV5V3jLjKviYzVjIrWevUAuQD57DeZOmFS/veaYscqPH4qZQJeoRMLcC+PYoIvy
         v+q4R/dqKU2CgnGzAXYxALhaUlukRxnih3uhAO0V9pMVwHooAEc7wKpSkmW69uLlkvXv
         FsL4jsg1/67GC/xHNmWvoCUn6eDmy5RUk5LjQMaJ184SeyhZZ8yCDXp/FS7+FJ8ZNBQz
         kL4RzDMCgBZJGKxxKDEUb6hLdDeYt1uAAhaL/GdqiDgArZS9BPCK1cV+J+C+/SX/4jtL
         y7gvRm0ASlmozPb6Z3KRwgl7RR0fx5ViHp+c7Eraa8vL/8YHEK5MOZo40jFx2UIPUVgp
         ub8g==
X-Gm-Message-State: AOJu0YwDMTk4v2NNEZpzRDVfRwq366z6G9AepiFbg4XkV+H2hpFCB+K6
	b//enZJEntSOiiukWku4E97W6cD6+CPchv+crHWfN9ieFVQoN/ZsaSLzm0i//Oww+K2iKYIMZw5
	lFoQpga8ginjbWrq/s5vKgwADeB3SAkM=
X-Gm-Gg: ASbGncucLrXDbib5l9Z25h67dimB4ze3DJ0/tdzWCuL7270zPtKd3mzsc1FHbvwKbdy
	I5oelLGlUcGaeynINiyiK/LnMoGWhWa3UmFfxTHyvJQJQ3JfIRDsXC7O7W7a5k3P3nJEnp5yFPv
	y8w2nMLmZwRm4a5fsjApmshTmbXp+Aq1IlUt+/cOoitYqiqPCzVRgCVJlb6PgxYbXvVIfLfUvO8
	eBQSVUjcdc7uvfT
X-Google-Smtp-Source: AGHT+IGVXdpuDSD3u1Rcg2xH/siOX+NFS+fNsYQ1G8iqkKsJn6/Ib7Lu5EOX1WPfO/C6zAEddYxGbn3tllx6tvD1qEs=
X-Received: by 2002:a17:907:7e95:b0:ad8:9257:5727 with SMTP id
 a640c23a62f3a-ae057bd5095mr1094933066b.51.1750688225183; Mon, 23 Jun 2025
 07:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250620180458.5041-3-bijan311@gmail.com> <20250621180215.36243-1-sj@kernel.org>
In-Reply-To: <20250621180215.36243-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Mon, 23 Jun 2025 09:16:53 -0500
X-Gm-Features: AX0GCFtADaqGHnbxuGoJ2rP0UQkjTI20aRfoQkXyZ3eOD4JaHNMRaVIa-DTKVX0
Message-ID: <CAMvvPS5JL20OJic0EFKbuY_VgEAjveJoquTReyLjknSZ-6BeVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] mm/damon/paddr: Allow multiple migrate targets
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, bijantabatab@micron.com, venkataravis@micron.com, 
	emirakhur@micron.com, ajayjoshi@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 1:02=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> Hi Bijan,
>
> On Fri, 20 Jun 2025 13:04:58 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> >
> > The migrate_{hot,cold} DAMONS actions take a parameter, target_nid, to
> > indicate what node the actions should migrate pages to. In this patch,
> > we allow passing in a list of migration targets into target_nid. When
> > this is done, the mirgate_{hot, cold} actions will migrate pages betwee=
n
> > the specified nodes using the global interleave weights found at
> > /sys/kernel/mm/mempolicy/weighted_interleave/node<N>. This functionalit=
y
> > can be used to dynamically adjust how pages are interleaved in response
> > to changes in bandwidth utilization to improve performance, as discusse=
d
> > in [1]. When only a single migration target is passed to target_nid, th=
e
> > migrate_{hot,cold} actions will act the same as before.
> [...]
> >  include/linux/damon.h    |   8 +--
> >  mm/damon/core.c          |   9 ++--
> >  mm/damon/lru_sort.c      |   2 +-
> >  mm/damon/paddr.c         | 108 +++++++++++++++++++++++++++++++++++++--
> >  mm/damon/reclaim.c       |   2 +-
> >  mm/damon/sysfs-schemes.c |  14 +++--
> >  samples/damon/mtier.c    |   6 ++-
> >  samples/damon/prcl.c     |   2 +-
> >  8 files changed, 131 insertions(+), 20 deletions(-)
>
> If we keep pursuing making DAMON users be able to specify multiple migrat=
ion
> destination nodes and their weights[1], I think we may need only paddr.c =
part
> change of this patch in the final version of this great work.

Sounds good to me.

> [...]
> >  static unsigned long damon_pa_migrate(struct damon_region *r, struct d=
amos *s,
> >               unsigned long *sz_filter_passed)
> >  {
> >       unsigned long addr, applied;
> > -     LIST_HEAD(folio_list);
> > +     struct rmap_walk_control rwc;
> [...]
> >
> >       addr =3D r->ar.start;
> >       while (addr < r->ar.end) {
> > @@ -522,15 +599,38 @@ static unsigned long damon_pa_migrate(struct damo=
n_region *r, struct damos *s,
> >               else
> >                       *sz_filter_passed +=3D folio_size(folio);
> >
> > +             /*
> > +              * If there is only one target node, migrate there. Other=
wise,
> > +              * interleave across the nodes according to the global
> > +              * interleave weights
> > +              */
> > +             if (nr_nodes =3D=3D 1) {
> > +                     target_nid =3D first_node(s->target_nids);
> > +             } else {
> > +                     target_nid =3D NUMA_NO_NODE;
> > +                     /* Updates target_nid */
> > +                     rmap_walk(folio, &rwc);
> > +             }
>
> So we are doing rmap_walk(), which is known to be not very fast, for gett=
ing
> the target node id of this page, in a way very similar to that of weighte=
d
> interleaving, right?  I don't think we really need to behave that same to
> weighted interleaving with the cost.
>
> I'd hence suggest to implement and use a simple weights handling mechanis=
m
> here.  It could be roud-robin way, like weighted interleaving, or probabi=
listic
> way, using damon_rand().
>
> The round-robin way may be simpler in my opinion.  For example,
>
> unsigned int damos_pa_nid_to_migrate(struct damos_migrate_dest *dest)
> {
>         static unsigned int nr_migrated =3D 0;
>         unsigned int total_weight =3D 0;
>         unsigned int weights_to_ignore;
>         size_t i;
>
>         for (i =3D 0; i < dest->nr_dests; i++)
>                 total_weight +=3D dest->weight_arr[i];
>         weights_to_ignore =3D nr_migrate++ % total_weight;
>         total_weight =3D 0;
>         for (i =3D 0; i < dest->nr_dests; i++) {
>                 total_weight +=3D dest->weight_arr[i];
>                 if (total_weight >=3D weights_to_ignore)
>                         return dest->node_id_arr[i];
>         }
>         WARN_ON_ONCE(1, "I don't know what I did wrong");
>         return 0;
> }
>
> Then, we could replace the above rmap_walk() call with this one.  What do=
 you
> think?

I do actually think doing the interleaving based on the VMA offset is
important for a couple of reasons.

1. If also using the weighted interleaving mempolicy, and the DAMON
weights are the same as the mempolicy weights, DAMON won't have to
migrate newly allocated pages. This is relatively minor, but helps
avoid unnecessary work.

2. More importantly, I believe this approach will cause a lot of
needless ping-ponging, where the same folios are being moved around
when they don't need to be. For example, let's say folios A-F are hot,
and just for simplification, if they are on the same node, they will
be in the same DAMON region, and only those folios are in those DAMON
regions. If all the folios start in Node 0 and both nodes have a
weight of 1, we have:

nr_migrated =3D 0
Node 0           Node 1
----------           ----------
A-F                  <empty>

After the scheme is first applied

nr_migrated =3D 6
Node 0           Node 1
----------           ----------
A,C,E              B,D,F

This is fine, but these folios are still hot, so the scheme will be
applied to them again

nr_migrated =3D 12
Node 0           Node 1
----------           ----------
A,E,D             C,D,F

If I am understanding your code sample correctly, this will continue
to happen each time the scheme is applied, causing folios to be
migrated for no reason. Using the VMA offset to determine where a page
should be placed avoids this problem because it gives a folio a single
node it can be in for a given set of interleave weights. This means
that in steady state, no folios will be migrated.

I see what you're saying about rmap_walks being expensive, but since
DAMON operates off the critical path for the workload, I don't think
the cost is that problematic.

[...]

Let me know what you think,
Bijan
