Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B42E11C9
	for <damon@lists.linux.dev>; Fri, 13 Jun 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749832414; cv=none; b=LY1O2mOL6REQ3yAvMO71mQ3JwqewBM9Yg2zNe4GVp5NhyOZDPMws++HEe7NnFlo9c6lrx9sqtvFsVpqvN7utlTooPrdh80WB5hv0Y+TZ9gBWiEkPcxCHO3uK1ndgQkzIbKzgKdknkbzadDbz7k+MHEh3GmGX154olY/bvEAXcrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749832414; c=relaxed/simple;
	bh=1WcSibMacZOYwlTkoDbYGvtq44j+e8sb3UdJnXTKqC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=caTCe1K5/4Nmk5HpMa9Au44H0zN6+cdqDkN103rZCU70sw27Cb+p3IZ/KDIlu0o8MDGwSXcLqjX2y228AhdTrt8XIFmYKwJG5rkG9b+JzYt0l2PeVvmZOEBDKDMfYviv69WisO3LOtlcoJdeU9vUVIWzQkgFr9W+nKkZy4CQy/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db53jpqI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db53jpqI"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad574992fcaso358389466b.1
        for <damon@lists.linux.dev>; Fri, 13 Jun 2025 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749832410; x=1750437210; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va7AE6ZRu0tUcIQ8yzYRsNan45fKyNNXoobCqFtK7Vc=;
        b=Db53jpqIYpRTCbK1hfWUPIoNnh0ft0qiEYzWuHMLoJR7kauOAtakhVgxVRUbHfAfbE
         gD8lhTpyLyvtuV1BIdo8wFLB8aUdvWCxAAKXrhy0Gbnso4zsNqIrpDCTh38AZXOczO7z
         MeiPkfrdBkgHJRoD4hvQhmIy4+XViGpEvU78/9D5j2Wgsik/MajFX1vD5Os04V7ZolZv
         ZFroTztFYn97EA7g74kNF0gqqNdXDsvRwZ0fuPG8UrDOLLvW27K6o4UMYhrsvEQIJMja
         /aOEowiQA7MptTFooDXPr6W/fIvwvuNq5Vt7nZf9eYTlQhT4nsfTyAH+2BqAhHkBqnjR
         jROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749832410; x=1750437210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Va7AE6ZRu0tUcIQ8yzYRsNan45fKyNNXoobCqFtK7Vc=;
        b=cZzCndZdVAg++Hgg34cdx0zyQXbHFUHGYvC4m5nFj3a7kzJaXtzMuqBd7dL/hOw12E
         2yoiNOOqw8meb5J/1JGd8pcKZmBpbNxapluZqeNgUNCP6lEq3wlu24GHFVi8eSlVLmQQ
         wJ8we/nI9X1iRkoSC5Lfc3iRhi9eI19LBqLylAthkaENzc4TDK2dhlhKLXp/AnEpm+zY
         xMOvlApdeSnB5PbAPo3DDiAaOi2BfYi7nHtUBPL26Y3xwl125rlUeJxe25POQ0PWvWJ3
         l7P4Cbt+3DIqzWu5voNz8HZz9n7zVlUByN8DOfNjuHOlEDyyq3VMiXS+3Xpn6bqAw1G/
         MO6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5BNziRYa4OPc5z7FEYBM38VUWY08xpZPhtfnlkmgxUw9y+ZUFBsFxiox4Jv8rpgrvWm5eYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJf/8/oB0pbxgrkW/fxK/Nrc0vposF+uoMuBuRq325dZ0Pf1Ei
	o07XoqdjLI4VR4fNH3aw61MEKo6XNKwut1t+9gOXVsvXOLuasx+cLaab/Da3eewVbbAElPWivQY
	QvjmxDRydwPlNs7Faf0aTR0/8GdjkLLI=
X-Gm-Gg: ASbGncuFzSM4XclGVc9/mlgTWavhRrtkGOzw6LW1O5Nf0URXoj97XOorOBHvuNeDTzu
	a8JBUAfXarq7ziJrzZzvgdWymJQru86OKVC/bshjN9g5Yq32fDwuDahmoNNSkSxRNgDATnnWQbv
	34S/nvVSP0PzwhWuIsHuUDGNit+zrfMHUdYfuEVMZqCHRaWv2HM4AAFCwZljGnlrYpmay4GadDM
	1q2
X-Google-Smtp-Source: AGHT+IG/OBkyK/agG2UVMmJWvTU1QMm4SmGMs9KD3Ezvf+J2tTxEtlceU4dEUBXWyJAHxcNkqh7edre0kjWHg3dWMyQ=
X-Received: by 2002:a17:906:fe0c:b0:ad8:93a3:299c with SMTP id
 a640c23a62f3a-adec5436bc6mr372908166b.10.1749832409926; Fri, 13 Jun 2025
 09:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250612181330.31236-1-bijan311@gmail.com> <20250612181330.31236-2-bijan311@gmail.com>
 <5a50eeba-b26d-4913-8016-45278608a1ee@redhat.com>
In-Reply-To: <5a50eeba-b26d-4913-8016-45278608a1ee@redhat.com>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Fri, 13 Jun 2025 11:33:18 -0500
X-Gm-Features: AX0GCFuazzkdI3MgkIT3-iQtcMQlbIVIrSXGr9CiMXXa7M0L7hQSrqNXvr4KFyU
Message-ID: <CAMvvPS5U8exSvy0fknfhv8ym_dKgMVa7cfMOqn0fGyd+NSjSuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mm/mempolicy: Expose policy_nodemask() in include/linux/mempolicy.h
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj@kernel.org, akpm@linux-foundation.org, 
	corbet@lwn.net, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bijantabatab@micron.com, venkataravis@micron.com, emirakhur@micron.com, 
	ajayjoshi@micron.com, vtavarespetr@micron.com, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 8:45=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 12.06.25 20:13, Bijan Tabatabai wrote:
> > From: Bijan Tabatabai <bijantabatab@micron.com>
> >
> > This patch is to allow DAMON to call policy_nodemask() so it can
> > determine where to place a page for interleaving.
> >
> > Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
> > ---
> >   include/linux/mempolicy.h | 9 +++++++++
> >   mm/mempolicy.c            | 4 +---
> >   2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> > index 0fe96f3ab3ef..e96bf493ff7a 100644
> > --- a/include/linux/mempolicy.h
> > +++ b/include/linux/mempolicy.h
> > @@ -133,6 +133,8 @@ struct mempolicy *__get_vma_policy(struct vm_area_s=
truct *vma,
> >   struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
> >               unsigned long addr, int order, pgoff_t *ilx);
> >   bool vma_policy_mof(struct vm_area_struct *vma);
> > +nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
> > +             pgoff_t ilx, int *nid);
> >
> >   extern void numa_default_policy(void);
> >   extern void numa_policy_init(void);
> > @@ -232,6 +234,13 @@ static inline struct mempolicy *get_vma_policy(str=
uct vm_area_struct *vma,
> >       return NULL;
> >   }
> >
> > +static inline nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy =
*pol,
> > +                             pgoff_t ilx, int *nid)
> > +{
> > +     *nid =3D NUMA_NO_NODE;
> > +     return NULL;
> > +}
> > +
> >   static inline int
> >   vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst=
)
> >   {
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 3b1dfd08338b..54f539497e20 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -596,8 +596,6 @@ static const struct mempolicy_operations mpol_ops[M=
POL_MAX] =3D {
> >
> >   static bool migrate_folio_add(struct folio *folio, struct list_head *=
foliolist,
> >                               unsigned long flags);
> > -static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
> > -                             pgoff_t ilx, int *nid);
> >
> >   static bool strictly_unmovable(unsigned long flags)
> >   {
> > @@ -2195,7 +2193,7 @@ static unsigned int interleave_nid(struct mempoli=
cy *pol, pgoff_t ilx)
> >    * Return a nodemask representing a mempolicy for filtering nodes for
> >    * page allocation, together with preferred node id (or the input nod=
e id).
> >    */
> > -static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
> > +nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
> >                                  pgoff_t ilx, int *nid)
> >   {
> >       nodemask_t *nodemask =3D NULL;
>
> You actually only care about the nid for your use case.
>
> Maybe we should add
>
> get_vma_policy_node() that internally does a get_vma_policy() to then
> give you only the node back.
>
> If get_vma_policy() is not the right thing (see my reply to patch #2),
> of course a get_task_policy_node() could be added.
>
> --
> Cheers,
>
> David / dhildenb

Hi David,

I did not use get_vma_policy or mpol_misplaced, which I believe is the
closest function that exists for what I want in this patch, because
those functions
seem to assume they are called inside of the task that the folio/vma
is mapped to.
More specifically, mpol_misplaced assumes it is being called within a
page fault.
This doesn't work for us, because we call it inside of a kdamond process.

I would be open to adding a new function that takes in a folio, vma,
address, and
task_struct and returns the nid the folio should be placed on. It could pos=
sibly
be implemented as a function internal to mpol_misplaced because the two wou=
ld
be very similar.

How would you propose we handle MPOL_BIND and MPOL_PREFFERED_MANY
in this function? mpol_misplaced chooses a nid based on the node and
cpu the fault
occurred on, which we wouldn't have in a kdamond context. The two options I=
 see
are either:
1. return the nid of the first node in the policy's nodemask
2. return NUMA_NO_NODE
I think I would lean towards the first.

Thanks,
Bijan
